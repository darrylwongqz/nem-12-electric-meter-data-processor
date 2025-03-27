FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies with legacy-peer-deps flag to handle React 19 compatibility
RUN npm ci --legacy-peer-deps

# Copy application code
COPY . .

# Build the Next.js app
RUN npm run build

# Expose port
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"] 