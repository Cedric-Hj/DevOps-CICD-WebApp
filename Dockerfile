# Use nginx as a base image
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

ADD jarstaging/com/example/simple-cicd-webpage/1.0-SNAPSHOT/*.jar app.jar

# Expose port 80 to outside the container
EXPOSE 8081

# Command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]



