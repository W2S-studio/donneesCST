# ---------- builder stage ----------
FROM maven:3.9.4-eclipse-temurin-21 AS builder
WORKDIR /workspace

# copy pom and sources
COPY pom.xml ./
COPY src ./src

# build the app (produces target/{artifactId}.jar)
RUN mvn clean package -DskipTests -B

# ---------- runtime stage ----------
FROM eclipse-temurin:21-jre
WORKDIR /app

# copy only your app jar into the image
COPY --from=builder /workspace/target/*.jar ./app.jar

ENTRYPOINT ["java","-jar","/app/app.jar"]
