FROM openjdk:8-jre-alpine
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
COPY ./tomcat /usr/local/tomcat
EXPOSE 8080
RUN catalina.sh version
CMD ["catalina.sh", "run"]
