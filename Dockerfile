ARG FF_VERSION=10.3.0-20261010.042321

FROM frankframework/frankframework:${FF_VERSION} AS ff-base

# Copy dependencies
COPY --chown=tomcat lib/server/ /usr/local/tomcat/lib/
COPY --chown=tomcat lib/webapp/ /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/
# COPY --chown=tomcat src/main/drivers/ /opt/frank/drivers/
ADD --link --chown=2000:2000 --checksum=sha256:cab1cd67cfa25c25de4348e532298028288a877ba01c77d1619fe45416193387 https://github.com/pgjdbc/pgjdbc/releases/download/REL42.7.10/postgresql-42.7.10.jar /opt/frank/drivers/

ADD --link --chmod=644 --chown=2000:2000 Staat-der-Nederlanden-Private-Root-CA-G1.pem /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt
ADD --link --chmod=644 --chown=2000:2000 DomPrivateServicesCA-G1.pem /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt
ADD --link --chmod=644 --chown=2000:2000 QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.pem /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt

## Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

# Compile custom class
FROM eclipse-temurin:25-jdk AS custom-code-builder

# Copy dependencies
COPY --from=ff-base /usr/local/tomcat/lib/ /usr/local/tomcat/lib/
COPY --from=ff-base /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT
ADD --checksum=sha256:3488a4e9994c26596baaceebee58cad36a50e3bdaec5be72b5834d3c3b560306 https://repo.maven.apache.org/maven2/org/projectlombok/lombok/1.18.42/lombok-1.18.42.jar /tmp/lombok.jar

# Copy custom class
COPY src/main/java /tmp/java
RUN mkdir /tmp/classes && \
	find /tmp/java -name "*.java" > sources.txt && \
	javac @sources.txt -proc:full -classpath "/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/usr/local/tomcat/lib/*:/tmp/lombok.jar" -verbose -d /tmp/classes

FROM ff-base

## section: custom-code(end)

# Copy Frank!
COPY --chown=tomcat src/main/configurations/ /opt/frank/configurations/
COPY --chown=tomcat src/main/resources/ /opt/frank/resources/
COPY --chown=tomcat src/main/secrets/ /opt/frank/secrets/
COPY --chown=tomcat src/test/testtool/ /opt/frank/testtool/

# Create h2 folder under 'tomcat' user. QoL addition to avoid Docker creating the h2 folder under 'root' when mounted.
# This would normally cause a permission denied error because the framework running under the 'tomcat' user is not
# allowed to write to a folder owned by 'root'.
RUN mkdir -p /opt/frank/h2/

## Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

# Copy compiled custom classes
COPY --from=custom-code-builder --chown=tomcat /tmp/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

## section: custom-code(end)

ARG TRANSACTION_MANAGER=NARAYANA

USER root
RUN update-ca-certificates && \
	keytool -import -noprompt -trustcacerts -alias privateRoot -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt && \
	keytool -import -noprompt -trustcacerts -alias privateServices -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt && \
	keytool -import -noprompt -trustcacerts -alias privateServicesQuoVadis -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt

USER tomcat
### Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

ENV authentication.clientSecret=dummy \
	application.server.type.custom=${TRANSACTION_MANAGER}

# COPY --chown=tomcat entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=60 \
	CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["catalina.sh", "run"]
