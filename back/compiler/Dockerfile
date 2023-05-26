FROM openjdk:17.0.1-jdk-slim

ARG JAR_FILE=build/libs/*SNAPSHOT.jar

WORKDIR /opt/app

COPY ${JAR_FILE} compiler.jar

RUN apt-get update && apt-get install -y gcc g++ python3.9

ENTRYPOINT ["java","-jar","compiler.jar"]
