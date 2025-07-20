# ---------- builder stage ----------
FROM maven:3.9.4-eclipse-temurin-21 AS builder
WORKDIR /workspace

ENV TZ=America/Montreal
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY pom.xml ./
COPY src ./src

RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:21-jre
WORKDIR /app

ENV TZ=America/Montreal
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=builder /workspace/target/*.jar ./app.jar

ENTRYPOINT ["java","-Duser.timezone=America/Montreal","-jar","/app/app.jar"]