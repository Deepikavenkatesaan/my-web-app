# Stage 1: Build the application
FROM node:14 AS builder
WORKDIR /app
COPY ./src ./src
RUN echo "Building the application"

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY ./src /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
