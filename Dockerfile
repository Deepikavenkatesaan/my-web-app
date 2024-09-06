# Stage 1: Build stage
FROM alpine:3.12 AS builder

# Set working directory in the container
WORKDIR /app

# Copying your web application's source files to the container
COPY ./src ./src

# Stage 2: Nginx server to serve the static files
FROM nginx:alpine

# Copying static files from the builder stage to the Nginx folder
COPY --from=builder /app/src /usr/share/nginx/html

# Expose port 80 for HTTP access
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
