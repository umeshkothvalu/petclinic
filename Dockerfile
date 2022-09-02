From tomcat:9.0.65-jre8-openjdk-slim-buster
COPY /var/jenkins_home/tomcat/tomcat-users.xml /usr/local/tomcat/conf/
COPY /var/jenkins_home/tomcatcontext.xml /usr/local/tomcat/webapps.dist/manager/META-INF/context.xml
RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
COPY /var/jenkins_home/workspace/spring-application/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
