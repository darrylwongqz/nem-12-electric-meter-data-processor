import asyncpg
from contextlib import asynccontextmanager
from typing import AsyncGenerator, Optional, List, Dict, Any

from app.config import get_settings
from app.logging_config import get_logger

logger = get_logger(__name__)
_pool: Optional[asyncpg.Pool] = None

async def get_db_pool() -> asyncpg.Pool:
    """Get or create a connection pool to the database."""
    global _pool
    if _pool is None:
        settings = get_settings()
        logger.info("Creating database connection pool", database_url=settings.database_url)
        try:
            _pool = await asyncpg.create_pool(
                dsn=settings.database_url,
                min_size=2,
                max_size=10,
            )
            logger.info("Database connection pool created successfully")
            # Test the connection
            async with _pool.acquire() as conn:
                version = await conn.fetchval("SELECT version()")
                logger.info("Connected to PostgreSQL", version=version)
        except Exception as e:
            logger.error("Failed to create database connection pool", error=str(e))
            raise
    return _pool

@asynccontextmanager
async def get_db_conn() -> AsyncGenerator[asyncpg.Connection, None]:
    """Get a database connection from the pool."""
    pool = await get_db_pool()
    conn = await pool.acquire()
    try:
        yield conn
    finally:
        await pool.release(conn)

async def execute_query(query: str, *args) -> Any:
    """
    Execute a database query and return the result.
    
    Args:
        query: The SQL query to execute, can include parameter placeholders ($1, $2, etc.)
        *args: Values for the parameterized query
        
    Returns:
        The result of the query execution. For INSERT ... RETURNING queries,
        returns the first row as a dictionary.
    """
    async with get_db_conn() as conn:
        try:
            logger.debug("Executing database query", query=query, params=args if args else "none")
            
            # If the query has RETURNING clause, use fetchrow
            if "RETURNING" in query.upper():
                result = await conn.fetchrow(query, *args)
                if result:
                    return dict(result)
                return None
            
            # Otherwise use execute
            result = await conn.execute(query, *args)
            logger.debug("Query executed successfully", result=result)
            return result
        except Exception as e:
            logger.exception("Database query failed", query=query, params=args if args else "none", error=str(e))
            raise

def execute_query_sync(query: str, *args) -> str:
    """
    Synchronous version of execute_query.
    This should only be used when you need to run a query in a sync context.
    
    Args:
        query: The SQL query to execute, can include parameter placeholders ($1, $2, etc.)
        *args: Values for the parameterized query
        
    Returns:
        The result of the query execution
    """
    # Create a completely separate connection for sync operations
    # to avoid event loop issues
    settings = get_settings()
    
    try:
        # Run a separate process to execute the query
        import subprocess
        import sys
        import json
        
        # Simple script to execute query and return result
        script = f"""
import asyncio
import asyncpg
import sys
import json

async def run_query():
    try:
        conn = await asyncpg.connect('{settings.database_url}')
        try:
            result = await conn.execute({json.dumps(query)})
            return {{"success": True, "result": result}}
        except Exception as e:
            return {{"success": False, "error": str(e)}}
        finally:
            await conn.close()
    except Exception as e:
        return {{"success": False, "error": str(e)}}

if __name__ == "__main__":
    print(json.dumps(asyncio.run(run_query())))
        """
        
        # Write script to temporary file
        import tempfile
        with tempfile.NamedTemporaryFile(suffix='.py', mode='w', delete=False) as f:
            f.write(script)
            script_path = f.name
        
        # Execute the script as a separate process
        result = subprocess.run([sys.executable, script_path], 
                               capture_output=True, text=True, check=True)
        
        # Clean up the temporary file
        import os
        os.unlink(script_path)
        
        # Parse and return the result
        output = json.loads(result.stdout.strip())
        if output.get("success"):
            logger.debug("Query executed successfully via subprocess", result=output["result"])
            return output["result"]
        else:
            error = output.get("error", "Unknown error")
            logger.error("Database query failed via subprocess", error=error)
            raise Exception(f"Database query failed: {error}")
            
    except Exception as e:
        logger.exception("Failed to execute query via subprocess", error=str(e))
        raise Exception(f"Failed to execute query: {str(e)}")

def execute_many_sync(queries: List[str]) -> None:
    """
    Synchronous version of execute_many.
    Execute multiple SQL queries in a transaction.
    
    Args:
        queries: List of SQL queries to execute in a transaction
    """
    # Implementation similar to execute_query_sync but for multiple queries
    settings = get_settings()
    
    try:
        # Run a separate process to execute the queries
        import subprocess
        import sys
        import json
        
        # Simple script to execute queries in a transaction
        script = f"""
import asyncio
import asyncpg
import sys
import json

async def run_queries():
    try:
        conn = await asyncpg.connect('{settings.database_url}')
        try:
            async with conn.transaction():
                results = []
                for query in {json.dumps(queries)}:
                    result = await conn.execute(query)
                    results.append(result)
                return {{"success": True, "results": results}}
        except Exception as e:
            return {{"success": False, "error": str(e)}}
        finally:
            await conn.close()
    except Exception as e:
        return {{"success": False, "error": str(e)}}

if __name__ == "__main__":
    print(json.dumps(asyncio.run(run_queries())))
        """
        
        # Write script to temporary file
        import tempfile
        with tempfile.NamedTemporaryFile(suffix='.py', mode='w', delete=False) as f:
            f.write(script)
            script_path = f.name
        
        # Execute the script as a separate process
        result = subprocess.run([sys.executable, script_path], 
                               capture_output=True, text=True, check=True)
        
        # Clean up the temporary file
        import os
        os.unlink(script_path)
        
        # Parse and return the result
        output = json.loads(result.stdout.strip())
        if output.get("success"):
            logger.debug("Queries executed successfully via subprocess")
            return output.get("results", [])
        else:
            error = output.get("error", "Unknown error")
            logger.error("Database queries failed via subprocess", error=error)
            raise Exception(f"Database queries failed: {error}")
            
    except Exception as e:
        logger.exception("Failed to execute queries via subprocess", error=str(e))
        raise Exception(f"Failed to execute queries: {str(e)}")

async def fetch_all(query: str, *args) -> List[Dict[str, Any]]:
    """Execute a database query and return all rows as dictionaries."""
    async with get_db_conn() as conn:
        try:
            records = await conn.fetch(query, *args)
            return [dict(record) for record in records]
        except Exception as e:
            logger.exception("Database fetch failed", query=query, error=str(e))
            raise

# Extend setup_db to also run migrations
async def setup_db():
    """Set up the database schema if needed and run migrations."""
    logger.info("Setting up database schema")
    try:
        async with get_db_conn() as conn:
            # Create meter_metadata table
            await conn.execute("""
                CREATE TABLE IF NOT EXISTS meter_metadata (
                    nmi VARCHAR(10) PRIMARY KEY,
                    interval_length INTEGER NOT NULL,
                    start_date TIMESTAMP NOT NULL
                )
            """)
            logger.info("Created meter_metadata table")
            
            # Create meter_readings table
            await conn.execute("""
                CREATE TABLE IF NOT EXISTS meter_readings (
                    id UUID DEFAULT gen_random_uuid() NOT NULL,
                    nmi VARCHAR(10) NOT NULL REFERENCES meter_metadata(nmi),
                    timestamp TIMESTAMP NOT NULL,
                    consumption NUMERIC NOT NULL,
                    is_flagged BOOLEAN DEFAULT FALSE,
                    quality_method VARCHAR(10),
                    CONSTRAINT meter_readings_pk PRIMARY KEY (id),
                    CONSTRAINT meter_readings_unique_consumption UNIQUE (nmi, timestamp)
                )
            """)
            logger.info("Created meter_readings table")
            
            # Create file_uploads table
            await conn.execute("""
                CREATE TABLE IF NOT EXISTS file_uploads (
                    id SERIAL PRIMARY KEY,
                    original_filename VARCHAR(255) NOT NULL,
                    storage_filename VARCHAR(255) NOT NULL,
                    upload_time TIMESTAMP NOT NULL DEFAULT NOW(),
                    status VARCHAR(50) NOT NULL DEFAULT 'pending',
                    error_message TEXT,
                    storage_path TEXT NOT NULL,
                    sql_output_path TEXT
                )
            """)
            logger.info("Created file_uploads table")
            
            # Count tables to verify setup
            table_count = await conn.fetchval("""
                SELECT COUNT(*) FROM information_schema.tables 
                WHERE table_schema = 'public'
            """)
            logger.info("Database setup completed successfully", table_count=table_count)
    except Exception as e:
        logger.error("Database setup failed", error=str(e))
        raise