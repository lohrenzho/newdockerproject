FROM tomcat:9.0
RUN apt-get update
RUN apt install maven -y
COPY ./SampleWebApp .
RUN mvn package
RUN cp **/*.war /usr/local/tomcat/webapps
