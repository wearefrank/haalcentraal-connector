ARG FF_VERSION=10.2.0-20260512.042331

FROM maven AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY --link src/main/java ./src/main/java
# Build the application using Maven
RUN --mount=type=cache,target=~/.m2/repository mvn clean package -DskipTests

FROM frankframework/frankframework:${FF_VERSION}
# Copy Frank!mvn
COPY --link --from=build --chown=2000:2000 /app/target/haalcentraal-connector-*.jar /opt/frank/resources/
COPY --link --chown=2000:2000 src/main/ /opt/frank/
COPY --link --chown=2000:2000 src/test/testtool/ /opt/frank/testtool/
ADD --link --chown=2000:2000 --checksum=sha256:cab1cd67cfa25c25de4348e532298028288a877ba01c77d1619fe45416193387 https://github.com/pgjdbc/pgjdbc/releases/download/REL42.7.10/postgresql-42.7.10.jar /opt/frank/drivers/

ADD --link --chmod=644 --chown=2000:2000 Staat-der-Nederlanden-Private-Root-CA-G1.pem /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt
ADD --link --chmod=644 --chown=2000:2000 DomPrivateServicesCA-G1.pem /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt
ADD --link --chmod=644 --chown=2000:2000 QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.pem /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt

USER root
RUN update-ca-certificates && \
	keytool -import -noprompt -trustcacerts -alias privateRoot -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/Staat-der-Nederlanden-Private-Root-CA-G1.crt && \
	keytool -import -noprompt -trustcacerts -alias privateServices -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/DomPrivateServicesCA-G1.crt && \
	keytool -import -noprompt -trustcacerts -alias privateServicesQuoVadis -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /usr/local/share/ca-certificates/QuoVadis-PKIoverheid-Private-Services-CA-G1-PEM.crt

USER tomcat
### Uncomment this section if the Frank! contains custom classes.
## section: custom-code(start)

ENV authentication.clientSecret=dummy

# COPY --chown=tomcat entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=60 \
	CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["catalina.sh", "run"]
