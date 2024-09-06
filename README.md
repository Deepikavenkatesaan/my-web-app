# Deploying a Web Application to Amazon ECS with GitHub Actions

## Overview

This repository contains a CI/CD pipeline for automating the deployment of a web application to Amazon Elastic Container Service (ECS) using GitHub Actions. The pipeline ensures that the application is automatically built, tested, and deployed to AWS ECS whenever code changes are pushed to the `main` branch. Additionally, rollback functionality is triggered if the deployment fails during integration testing.

## Key Components

1. **Amazon ECS**: A fully managed container orchestration service to run containerized applications.
2. **Amazon ECR**: A Docker container registry that securely stores Docker images for deployment.
3. **GitHub Actions**: A CI/CD tool that automates the pipeline workflow.
4. **Docker**: Used to package the application into containers for deployment.

## CI/CD Pipeline Workflow

### 1. **Trigger**
   - The pipeline is triggered by any push to the `main` branch in the GitHub repository.

### 2. **Checkout Code**
   - The latest code is checked out from the GitHub repository using GitHub Actions.

### 3. **Configure AWS Credentials**
   - AWS credentials are configured using a pre-defined IAM role, allowing GitHub Actions to interact with AWS services like ECS and ECR.

### 4. **Docker Build and Push to ECR**
   - The application is packaged into a Docker image, tagged, and pushed to the Amazon ECR repository for deployment.

### 5. **Render ECS Task Definition**
   - The ECS task definition is updated with the new Docker image tag and other necessary configurations.

### 6. **Deploy to ECS**
   - The updated task definition is deployed to the ECS cluster, where the service ensures that the new container version is running and stable.

### 7. **Integration Testing**
   - Integration tests are performed by checking the health of the deployed application using a health endpoint (e.g., `/health`). If the HTTP response status code is not 200, the deployment is considered a failure.

### 8. **Rollback on Failure**
   - If the integration tests fail, the pipeline automatically triggers a rollback, redeploying the last known stable version of the application to ECS.

## Prerequisites

- **GitHub Repository**: A repository containing the web application code.
- **AWS Account**: AWS services such as ECS, ECR, and IAM roles should be set up.
- **Docker**: Docker should be installed locally for building images.
- **Nginx-based Multi-stage Dockerfile**: A Dockerfile is used for building and serving the application.

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-repo/my-web-app.git
cd my-web-app
```

### Step 2: Push Your Code to GitHub

Ensure your application code is pushed to the `main` branch of your GitHub repository.

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### Step 3: Configure GitHub Actions

The CI/CD workflow is defined in the `.github/workflows/ci-cd.yml` file. It automates the process of building, pushing the Docker image to ECR, and deploying it to ECS.

### Step 4: Configure AWS IAM Role and Credentials

Create an IAM role with sufficient permissions to interact with AWS ECS and ECR services. Store the necessary AWS credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`) as GitHub secrets.

### Step 5: Dockerfile Setup

This repository uses a multi-stage Dockerfile:

```Dockerfile
# Stage 1: Build stage
FROM alpine:3.12 AS builder
WORKDIR /app
COPY ./src ./src

# Stage 2: Nginx server to serve the static files
FROM nginx:alpine
COPY --from=builder /app/src /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Step 6: Deploying the Application

The GitHub Actions pipeline will automatically trigger deployment when a change is pushed to the `main` branch.

## Rollback Functionality

In case of deployment failure, the pipeline will automatically rollback to the last known stable deployment by updating the ECS service with the previous Docker image.


## Contact

For any inquiries, please reach out to:

- **Author**: Deepika Venkatesan
- **Email**: deepika.venkatesaan@gmail.com

