FROM amazonlinux:latest AS build
RUN yum install -y wget tar git java-1.8.0-openjdk-devel
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz && \
    tar zxf apache-maven-3.9.11-bin.tar.gz && \
    mv apache-maven-3.9.11  /opt/maven
RUN git clone https://bitbucket.org/dptrealtime/java-login-app.git /opt/app
WORKDIR /opt/app
RUN /opt/maven/bin/mvn package

FROM amazonlinux:latest
RUN yum install -y wget tar git java-1.8.0-openjdk-devel
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz && \
    tar zxf apache-tomcat-9.0.113.tar.gz && \
    mv apache-tomcat-9.0.113 /opt/tomcat
COPY --from=build /opt/app/target/dptweb-1.0.war /opt/tomcat/webapps/
CMD ["/opt/tomcat/bin/catalina.sh","run"]

#AI Generated Code:
    # ----------------------------
# Stage 1: Build Stage
# ----------------------------
#FROM amazonlinux:latest AS build

RUN yum install -y wget tar git java-1.8.0-openjdk-devel

RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz && \
    tar zxf apache-maven-3.9.11-bin.tar.gz && \
    mv apache-maven-3.9.11 /opt/maven && \
    rm -f apache-maven-3.9.11-bin.tar.gz

RUN git clone https://bitbucket.org/dptrealtime/java-login-app.git /opt/app

WORKDIR /opt/app
RUN /opt/maven/bin/mvn package -DskipTests

# ----------------------------
# Stage 2: Runtime Stage
# ----------------------------
FROM amazonlinux:latest

RUN yum install -y wget tar java-1.8.0-openjdk-devel

RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz && \
    tar zxf apache-tomcat-9.0.113.tar.gz && \
    mv apache-tomcat-9.0.113 /opt/tomcat && \
    rm -f apache-tomcat-9.0.113.tar.gz

COPY --from=build /opt/app/target/dptweb-1.0.war /opt/tomcat/webapps/

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
