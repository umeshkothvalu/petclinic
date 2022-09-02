From tomcat:9.0.65-jre8-openjdk-slim-buster
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY context.xml /usr/local/tomcat/webapps.dist/manager/META-INF/context.xml
RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
RUN cp target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
