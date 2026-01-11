FROM amazonlinux:latest
RUN yum install wget -y && \ 
    yum install tar -y  && \
    yum install git -y
RUN yum install java-1.8.0-openjdk-devel -y
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz && \
    tar zxf apache-maven-3.9.11-bin.tar.gz && \
    mv apache-maven-3.9.11  /opt/maven
RUN git clone https://bitbucket.org/dptrealtime/java-login-app.git /opt/app
WORKDIR /opt/app
RUN /opt/maven/bin/mvn package
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.113/bin/apache-tomcat-9.0.113.tar.gz && \
    tar zxf apache-tomcat-9.0.113.tar.gz && \
    mv apache-tomcat-9.0.113 /opt/tomcat
RUN cp /opt/app/target/dptweb-1.0.war /opt/tomcat/webapps/ 
CMD ["/opt/tomcat/bin/catalina.sh","run"]