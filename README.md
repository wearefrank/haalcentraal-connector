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

- **Configuration_BrpPersonenAfnemersIndicatieReceiver.xml**  
    API endpoint that processes the subscription (add/remove) request.

- **Configuration_BrpPersonenCallbackSender.xml**  
    Notifies the subscribed applications about the changes in the BRP persons' data, via their callback URLs.

- **Configuration_BrpPersonenNotificationProcessor.xml**  
    Reads the notification request from the message store and processes it.

- **Configuration_BrpPersonenNotificationReceiver.xml**  
    API endpoint that places the notification in the message store, receives identifier(s) that specify which person(s) information changed.

- **Configuration_BrpPersonenNotificationRetryScheduler.xml**  
    Schedules the retry of the notification when the retrieved person information has not changed (yet).

- **Configuration_BrpPersonenQuerySender.xml**  
    Sends a query to the BRP to retrieve the specified person information.

- **Configuration_BrpPersonenSynchronizePersoon.xml**
    Synchronizes the person information with the BRP.

- **Configuration_BrpPersonenUpdateAndNotify**  
    Updates/enters the person information in the database, if the retrieved person information has changed, or no previous entry was found in the database.

- **Configuration.xml**  
    Imports the configuration files for the subscription management and processing.

- **Configuration_EndpointRouter.xml**  
    Routes the incoming requests to the appropriate receivers.

- **Configuration_XmlFileAdapter.xml**  
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

- **jsonnet**
  - `ApplicationsFilter.jsonnet` Used for extracting the application ids from the database.
  - `ExtractBody.jsonnet` Removes siblings from the body of a javascript response.
  - `ExtractDatabaseRows.jsonnet` Extracts the data from the rows from a database query.
  - `ExtractUpdateBody.jsonnet` Extracts the updated body from a javascript response.
  - `FilterApplicationsById.jsonnet` Retrieve config information for a list of application ids.

- **xsd/**  
  This directory holds XSD schema files.

- **xsl/**  
  This directory contains XSL files for XML transformations.