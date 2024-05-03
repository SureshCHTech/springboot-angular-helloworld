# Use OpenJDK 11 image as base for Spring Boot
FROM openjdk:11-jre-slim as spring

# Set working directory inside the container for Spring Boot
WORKDIR /app

# Copy the Spring Boot JAR file into the container
COPY backend/helloworld/target/my-spring-boot-app.jar app.jar

# Expose the port that the Spring Boot app runs on
EXPOSE 8081

# Run the Spring Boot application
CMD ["java", "-jar", "app.jar"]

# Use Node.js image as base for Angular
FROM node:14 as angular

# Set working directory inside the container for Angular
WORKDIR /usr/src/app

# Copy the Angular app source code into the container
COPY frontend/helloworld/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend/helloworld/ .

# Build the Angular app
RUN npm run build --prod

# Use Nginx image as base for serving Angular app
FROM nginx:alpine

# Copy the built Angular app into the Nginx HTML directory
COPY --from=angular /usr/src/app/dist/frontend/helloworld /usr/share/nginx/html
