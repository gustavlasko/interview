# Build stage
FROM maven:3.8-eclipse-temurin-8 AS build
WORKDIR /build

COPY backend/pom.xml .
RUN mvn dependency:go-offline -B

COPY backend/src ./src
RUN mvn clean package -B

# Runtime stage
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app

COPY --from=build /build/target/*.jar app.jar

RUN addgroup -S spring && adduser -S spring -G spring

RUN chown spring:spring app.jar

USER spring:spring

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
