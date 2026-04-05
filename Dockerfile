FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY target/java-demo-1.0.jar  app.jar
CMD ["java","-jar","app.jar"]