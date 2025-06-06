ARG FF_VERSION=9.2.0-20250604.232252

FROM frankframework/frankframework:${FF_VERSION} AS ff-base

# Copy dependencies
COPY --chown=tomcat lib/server/ /usr/local/tomcat/lib/
COPY --chown=tomcat lib/webapp/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

### Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

# Compile custom class
FROM eclipse-temurin:17-jdk-jammy AS custom-code-builder

# Copy dependencies
COPY --from=ff-base /usr/local/tomcat/lib/ /usr/local/tomcat/lib/
COPY --from=ff-base /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT

# Copy custom class
COPY src/main/java /tmp/java
RUN mkdir /tmp/classes && \
    javac \
    /tmp/java/nl/nn/adapterframework/DeploymentSpecificsBeanPostProcessor.java \
    -classpath "/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/usr/local/tomcat/lib/*" \
    -verbose -d /tmp/classes

FROM ff-base

## section: custom-code(end)


# Copy database connection settings
COPY --chown=tomcat src/main/webapp/META-INF/context.xml /usr/local/tomcat/conf/Catalina/localhost/ROOT.xml

# Try to make custom classes work
# COPY --chown=tomcat src/main/webapp/WEB-INF/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Copy Frank!
COPY --chown=tomcat src/main/configurations/ /opt/frank/configurations/
COPY --chown=tomcat src/main/secrets/ /opt/frank/secrets/
COPY --chown=tomcat src/main/resources/ /opt/frank/resources/
COPY --chown=tomcat src/test/testtool/ /opt/frank/testtool/

ADD Staat-der-Nederlanden-Private-Root-CA-G1.pem /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt
ADD DomPrivateServicesCA-G1.pem /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt
ADD QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.pem /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt
USER root
RUN chmod 644 /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt
RUN chmod 644 /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt
RUN chmod 644 /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt
RUN update-ca-certificates

RUN keytool -import -noprompt -trustcacerts -alias privateRoot -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt
RUN keytool -import -noprompt -trustcacerts -alias privateServices -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt
RUN keytool -import -noprompt -trustcacerts -alias privateServicesQuoVadis -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt

### Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

# Copy compiled custom classes
COPY --from=custom-code-builder --chown=tomcat /tmp/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

## section: custom-code(end)

ENV credentialFactory.class=nl.nn.credentialprovider.PropertyFileCredentialFactory
ENV credentialFactory.map.properties=/opt/frank/secrets/credentials.properties
ENV authentication.clientSecret=dummy

# COPY --chown=tomcat entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=60 \
	CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["catalina.sh", "run"]
