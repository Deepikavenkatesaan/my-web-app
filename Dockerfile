# Stage 1: Build the application
FROM node:14 AS builder
WORKDIR /app

# Copy dependency definitions
COPY package*.json ./
RUN npm install

# Copy source code
COPY ./src ./src 

# Build the application
RUN npm run build  # Ensure this command is correct and outputs to /app/build

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy built files from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
