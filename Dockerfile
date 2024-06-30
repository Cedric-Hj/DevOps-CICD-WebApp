# Use the official OpenJDK 17 as a parent image
FROM openjdk:17-jdk-slim



# Copy the current directory contents into the container at /app
COPY /var/lib/jenkins/workspace/MultibranchPipeline_main/jarstaging/com/example/simple-cicd-webpage/1.0-SNAPSHOT/simple-cicd-webpage-1.0-20240629.215043-1.jar MyHtmlApp.jar


# Expose port 80 for the web server
EXPOSE 8081

# Command to run your application
CMD ["java", "-jar", "your-app.jar"]


