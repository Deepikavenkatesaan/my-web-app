# Stage 1: Build the application
FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./src ./src
RUN npm run build || true  # Continue even if the build fails for debugging
RUN ls -al /app/build  # List the contents of the build directory

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html  # Copy built files
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
