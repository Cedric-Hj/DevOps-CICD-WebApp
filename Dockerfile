# Stage 1: Build Java application
FROM openjdk:17-jdk-slim AS build
WORKDIR /app

# Copy your Java application JAR to the image
COPY jarstaging/com/example/simple-cicd-webpage/1.0-SNAPSHOT/*.jar app.jar

# Stage 2: Serve static content with nginx
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy your static content (index.html) to nginx's default public directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to outside the container
EXPOSE 8081

# Command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]



