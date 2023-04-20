# Start with the Java image
FROM openjdk:8-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Copy the Java program into the container
COPY FarmerWolfCabbageSheep.java /app

# Compile the Java program
RUN javac FarmerWolfCabbageSheep.java

# Set the entry point to the Java program
ENTRYPOINT ["java", "FarmerWolfCabbageSheep"]