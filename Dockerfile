
# Stage 1: Build the application
FROM node:14 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./src ./src
RUN npm run build  # Adjust this if you're using a different build command

# Stage 2: Serve the application with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html  # Copy built files
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
