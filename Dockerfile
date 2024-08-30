# Stage 1: Build the Java application
FROM openjdk:21-jdk-slim AS build

# Copy the Java application JAR to the image
COPY target/*.jar app.jar

# Create a temporary directory for extraction
RUN mkdir /extracted
WORKDIR /extracted

# Extract index.html from the JAR file
RUN jar -xf /app.jar index.html

# Stage 2: Serve extracted index.html with nginx
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy index.html extracted from the previous stage to nginx's default public directory
COPY --from=build /extracted/index.html /usr/share/nginx/html/

# Expose port 80 to outside the container
EXPOSE 80

# Command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
