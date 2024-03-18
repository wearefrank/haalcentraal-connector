ARG FF_VERSION=latest

FROM frankframework/frankframework:${FF_VERSION}

### Uncommend this section if the Frank! contains custom classes.
## Copy dependencies
#COPY --chown=tomcat lib/server/ /usr/local/tomcat/lib/
## COPY --chown=tomcat lib/webapp/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
#
## Compile custom class, this should be changed to a buildstep in the future (lombok.jar added to lib/server for now to be able to compile custom code with Lombo annotations)
#COPY --chown=tomcat java /tmp/java
#RUN javac \
#      /tmp/java/nl/nn/adapterframework/http/HttpSenderBase.java \
#      -classpath "/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/usr/local/tomcat/lib/*" \
#      -verbose -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
#RUN rm -rf /tmp/java

# Copy database connection settings
COPY --chown=tomcat src/main/webapp/META-INF/context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml

# Copy Frank!
COPY --chown=tomcat src/main/configurations/ /opt/frank/configurations/
COPY --chown=tomcat src/main/resources/ /opt/frank/resources/
COPY --chown=tomcat src/test/testtool/ /opt/frank/testtool/

# COPY --chown=tomcat entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=60 \
	CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["catalina.sh", "run"]
