ARG FF_VERSION=10.0.0-20260203.042333

FROM maven AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests

FROM frankframework/frankframework:${FF_VERSION}

# Copy Frank!mvn
COPY --chown=tomcat src/main/ /opt/frank/
COPY --from=build --chown=tomcat /app/target/haalcentraal-connector-*.jar /opt/frank/resources/
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


ENV authentication.clientSecret=dummy

# COPY --chown=tomcat entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=60 \
	CMD curl --fail --silent http://localhost:8080/iaf/api/server/health || (curl --silent http://localhost:8080/iaf/api/server/health && exit 1)

# ENTRYPOINT ["/scripts/entrypoint.sh"]
# CMD ["catalina.sh", "run"]
