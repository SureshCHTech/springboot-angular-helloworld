# Use OpenJDK 11 image as base for Spring Boot
FROM openjdk:11-jre-slim AS spring

# Set working directory inside the container for Spring Boot
WORKDIR /app

# Copy the Spring Boot JAR file into the container
COPY backend/helloworld/target/helloworld-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the Spring Boot app runs on
EXPOSE 8081

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]

# Use the latest Node.js image as the base image
FROM node:latest AS angular

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files to the container
COPY frontend/helloworld/package*.json ./

# Install the project dependencies
RUN npm install

# Copy the entire Angular project to the container
COPY . .

# Build the Angular project
RUN npm run build -- --prod

# Expose port 5200
EXPOSE 5200

# Serve the Angular application using the built-in Angular CLI server
CMD ["npm", "start"]
