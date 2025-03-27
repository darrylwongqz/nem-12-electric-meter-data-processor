# Flo Energy - Energy Data Processing Platform

[![Demo Video](https://drive.google.com/file/d/1x4wemNMrXktGJ4DKU48oIMNzukOAcDT0/view?usp=sharing) *(Placeholder)*

## 1. Introduction

Flo Energy is a comprehensive platform for processing and analyzing NEM12 energy consumption data. The platform enables efficient upload, parsing, and analysis of energy meter readings, providing valuable insights into consumption patterns.

### Tech Stack

#### Backend
- **Python & FastAPI**: Modern, high-performance API framework
- **Celery**: Distributed task queue for async processing
- **PostgreSQL**: Relational database for storing meter readings
- **Firebase**: Authentication, storage, and real-time updates
- **pytest**: Comprehensive test suite with unit and integration tests

#### Frontend
- **Next.js**: React framework for server-side rendering
- **React**: Frontend UI library
- **TypeScript**: Type safety across the codebase
- **Tailwind CSS**: Utility-first CSS framework
- **Jest & React Testing Library**: Frontend testing

#### DevOps
- **Docker & Docker Compose**: Containerization and service orchestration
- **Redis**: Message broker for Celery tasks

## 2. Flow of Data

The application handles data processing through the following sequence:

### Upload Flow
1. **File Upload**:
   - User uploads a NEM12 file through the frontend interface
   - The file is stored in Firebase Storage
   - A unique reference is generated for the file

2. **Upload Notification**:
   - Frontend sends upload notification to Backend API
   - Backend creates a record in the database with status "pending"
   - Backend updates Firestore with the file metadata

3. **Asynchronous Processing**:
   - A Celery task is enqueued for background processing
   - Processing status is tracked in both PostgreSQL and Firestore
   - Real-time updates are pushed to the frontend via Firestore

### Processing Flow
1. **File Download**:
   - Worker retrieves the file from Firebase Storage
   - File is saved to a temporary location

2. **NEM12 Parsing**:
   - The file is validated for NEM12 format compliance
   - Header records (100, 200) are processed for metadata
   - Data records (300) are parsed for interval readings
   - Data is normalized and validated (NMI, timestamps, values)

3. **Data Storage**:
   - Parsed readings are converted to SQL statements
   - SQL is generated in batches to optimize performance
   - SQL file is uploaded back to Firebase Storage
   - Database is updated with batch inserts

4. **Completion**:
   - Firestore is updated with completion status
   - Frontend receives real-time update
   - Temporary files are cleaned up

### Query Flow
1. **Data Retrieval**:
   - Frontend requests specific meter readings via API
   - Backend queries the database with optimized filters
   - Data is paginated and formatted for display

2. **Analytics**:
   - Statistical calculations are performed on server-side
   - Results are cached for repeated queries
   - Visualizations are rendered on the client-side

## 3. Performance Optimizations

The platform implements numerous optimizations to handle large datasets efficiently:

### File Processing
- **Streaming Parser**: Files are processed in streaming mode to minimize memory usage
- **Chunked Reading**: Large files are read in chunks rather than loaded entirely in memory
- **Batch Processing**: NEM12 records are processed in batches (configurable batch size)
- **Background Workers**: Processing is offloaded to Celery workers to free up web server resources
- **Task Queue**: Distributed task queue allows horizontal scaling of workers

### Database Optimizations
- **Batched Inserts**: Readings are inserted in optimized batch sizes
- **SQL Generation**: SQL statements are generated and executed in chunks
- **Transaction Management**: Database operations use transactions for atomicity
- **Indexes**: Strategic indexes on frequently queried fields (NMI, timestamp)
- **Query Optimization**: Queries are designed to leverage database indexes

### Frontend Optimizations
- **Virtualized Lists**: Rendering only visible rows for large datasets
- **Data Pagination**: Server-side pagination to limit data transfer
- **Lazy Loading**: Components and resources are loaded on demand
- **Cached Queries**: Repeated queries use client-side caching
- **Optimistic UI Updates**: UI updates immediately while backend confirms changes

### Storage Optimizations
- **Temporary Storage**: Processing uses ephemeral storage to minimize persistence costs
- **Compression**: Stored files are compressed when appropriate
- **Cleanup Jobs**: Automatic cleanup of temporary files

### Scalability Features
- **Stateless Design**: Backend services designed to scale horizontally
- **Worker Pool Scaling**: Celery workers can scale based on queue size
- **Database Connection Pooling**: Efficient reuse of database connections

## 4. Running in Production

### Prerequisites
- Docker and Docker Compose
- Firebase account with Storage and Firestore enabled
- PostgreSQL database (can be containerized or external service)

### Environment Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/flo-energy.git
   cd flo-energy
   ```

2. Create environment files:
   ```bash
   # Backend environment variables
   cp backend/.env.example backend/.env
   
   # Frontend environment variables
   cp frontend/.env.example frontend/.env.local
   ```

3. Configure environment variables:
   - Database connection strings
   - Firebase credentials
   - API endpoints
   - Storage bucket names

### Deployment
1. Build and start the containers:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d
   ```

2. Run database migrations:
   ```bash
   docker-compose -f docker-compose.prod.yml exec backend alembic upgrade head
   ```

3. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000/docs

### Scaling
- Increase Celery workers:
  ```bash
  docker-compose -f docker-compose.prod.yml up -d --scale worker=3
  ```

## 5. Running Tests

### Backend Tests
```bash
# Run all tests
cd backend && PYTHONPATH=backend pytest

# Run unit tests only
cd backend && PYTHONPATH=backend python -m unittest discover -s backend/tests/unit -p "*.py"

# Run integration tests only
cd backend && PYTHONPATH=backend pytest backend/tests/integration
```

### Frontend Tests
```bash
# Run all tests
cd frontend && npm test

# Run tests in watch mode
cd frontend && npm run test:watch

# Run specific test files
cd frontend && npm test -- __tests__/components/UploadForm.test.tsx
```

### Code Coverage
```bash
# Backend coverage
cd backend && PYTHONPATH=backend pytest --cov=backend

# Frontend coverage
cd frontend && npm test -- --coverage
```

## 6. Development Setup

### Backend Development
1. Set up a Python virtual environment:
   ```bash
   cd backend
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your local configuration
   ```

3. Run the development server:
   ```bash
   PYTHONPATH=backend uvicorn app.main:app --reload
   ```

4. Run Celery worker (in a separate terminal):
   ```bash
   cd backend
   PYTHONPATH=backend celery -A app.tasks.worker worker --loglevel=info
   ```

### Frontend Development
1. Install dependencies:
   ```bash
   cd frontend
   npm install
   ```

2. Set up environment variables:
   ```bash
   cp .env.example .env.local
   # Edit .env.local with your local configuration
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

4. Access the frontend at http://localhost:3000

### Using Docker for Development
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
