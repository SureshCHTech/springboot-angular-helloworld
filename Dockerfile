# Use OpenJDK 11 image as base for Spring Boot
FROM openjdk:11-jre-slim as spring

# Set working directory inside the container for Spring Boot
WORKDIR /app

# Copy the Spring Boot JAR file into the container
COPY backend/helloworld/target/helloworld-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the Spring Boot app runs on
EXPOSE 8081

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]

# Use Node.js image as base for Angular
FROM node:14 as angular
# Set working directory inside the container for Angular
WORKDIR /app
# Copy the Angular app source code into the container
COPY frontend/helloworld/package*.json  ./
RUN npm install
COPY frontend/helloworld .
# Build the Angular app

FROM node:14
WORKDIR /build
COPY --from=angular frontend/helloworld .
EXPOSE 3000
CMD ["npm", "start"]
