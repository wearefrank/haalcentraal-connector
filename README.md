# HaalCentraal Connector

Build configuration from template:
`npm install`
`node ./tools/templating/brp-personen-bevragen-client/brp-personen-bevragen-client.js`

## Project Structure

### Configurations

#### **brp-personen-bevragen-outway**

#### **brp-personen-bevragen-rest**

#### **brp-personen-bevragen-soap**

#### **oauth**

#### **subscription-management-and-processing**

- **BuildInfo.properties**  
    Contains build-related information.
  
- **configuration-brp-personen_afnemers_indicatie_processor.xml**  
    Reads the subscription (add/remove) request from the message store and processes it.

- **configuration-brp-personen_afnemers_indicatie_receiver.xml**  
    API endpoint that places the subscription (add/remove) request in the message store.

- **configuration-brp-personen_callback_sender.xml**  
    Notifies the subscribed applications about the changes in the BRP persons' data, via their callback URLs.

- **configuration-brp-personen_notification_processor.xml**  
    Reads the notification request from the message store and processes it.

- **configuration-brp-personen_notification_receiver.xml**  
    API endpoint that places the notification in the message store, receives identifier(s) that specify which person(s) information changed.

- **configuration-brp-personen_notification_retry_scheduler.xml**  
    Schedules the retry of the notification when the retrieved person information has not changed (yet).

- **configuration-brp-personen_query_sender.xml**  
    Sends a query to the BRP to retrieve the specified person information.

- **configuration-brp-personen_update.xml**  
    Updates/enters the person information in the database, if the retrieved person information has changed, or no previous entry was found in the database.

- **Configuration.xml**  
    Imports the configuration files for the subscription management and processing.

- **Configuration_EndpointRouter.xml**  
    Routes the incoming requests to the appropriate receivers.

- **Configuration_ImportFromLocalFS.xml**  
    Custom adapter to read local files. Returns XML data if the file contains XML, otherwise tries to convert the file to XML.

- **DatabaseChangelog.xml**  
    Contains the database liquibase changelog for the subscription management and processing.

- **DeploymentSpecifics.properties**  
  Properties specific to the deployment environment.

- **openapi-haalcentraal-2.1.0.json**  
  OpenAPI specification for the HaalCentraal 2.1.0 API.

- `StageSpecifics_LOC.properties`
  Properties specific to the LOC stage.

- **json/**  
  - `DataChangeNotificationSchema.json`
  - `MappingApplication.json` Contains hardcoded information about applications which are allowed to subscribe to persons.

- **xsd/**  
  This directory holds XSD schema files.

- **xsl/**  
  This directory contains XSL files for XML transformations.