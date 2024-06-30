# Use the official OpenJDK 17 as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from Jenkins workspace to /app inside the container
COPY /var/lib/jenkins/workspace/MultibranchPipeline_main/jarstaging/com/example/simple-cicd-webpage/1.0-SNAPSHOT/*.jar app.jar

# Expose port 8081 for the web server
EXPOSE 8081

# Command to run your application
CMD ["java", "-jar", "app.jar"]


