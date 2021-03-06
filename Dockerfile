FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn clean install -Dmaven.test.skip=true
 
FROM openjdk:8-jre-alpine
WORKDIR /app/
COPY --from=MAVEN_TOOL_CHAIN /tmp/target/product*.jar  /app/app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]