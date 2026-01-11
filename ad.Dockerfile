FROM eclipse-temurin:21 AS build
WORKDIR  /usr/src/app
COPY . .
COPY ./gradle ./gradle
COPY ./pb ./proto
RUN chmod +x ./gradlew
RUN ./gradlew
RUN ./gradlew installDist -PprotoSourceDir=./proto
FROM eclipse-temurin:21
COPY . .
COPY --from=build /usr/src/app ./
ENV AD_SERVICE_PORT 9099
ENTRYPOINT [ "./build/install/opentelemetry-demo-ad/bin/Ad" ]
