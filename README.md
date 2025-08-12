# HaalCentraal Connector

## Background
For many years the municipalities in Netherlands depended on system called DDS (data distributie systeem) for querying and delivering Persoons Gegevens (from BRP). Now the shift to Haalcentraal API's retreiving this data from a central location, requires a migration path. This component is meant to deliver a seamless migration path. It offers STuff endpoints for 'legacy' system to query persoons data, but also the native REST api is served. So regardless of the application that is used on a department, it can connect trhough this component to request HaalCentraal BRP data. No more need for a local copy onprem.
Additionally, it provides a mechanisme for 'afnemersindicatie', transformed to a subscription model that will deliver the same feauture as DDS did. The only dependancy for that, is that the used BRP application itself can nofitify this component on which BSN has changed data. It only needs the BSN as event, the component will handle the rest.
The current implementation serves a webhook endpoint for that event, but its possible to get the bsn (list) in other ways too (txt file, DB transactions). THe best results are achieved when the events can be synchronised with the procudere of delivering BSN data changes to the "landelijke voorziening". Other timings are also fine, but not as fast.
For implementing this component, there is also a feature to run in 'shadow' mode. This will help ensuring the produced 'afnemersindicatie' callback message to be in line with the DDS produced ones.

Build configuration from template:
`npm install`
`node ./tools/templating/brp-personen-bevragen-client/brp-personen-bevragen-client.js`

## Project Structure

### Configurations

#### **brp-personen-bevragen-outway**
This configuration is used to query persons. Requests are routed through this configuration to abstract the underlying SOAP or REST API calls.

#### **brp-personen-bevragen-rest**
This configuration handles REST API requests for querying persons. It forwards the requests to the brp-personen-bevragen-outway configuration, which in turn communicates with the BRP API.

#### **brp-personen-bevragen-soap**
This configuration handles SOAP API requests for querying persons. It forwards the requests to the brp-personen-bevragen-outway configuration, which in turn communicates with the BRP API.

#### **oauth**
This configuration handles the retrieval of OAuth tokens for authentication with the BRP API.

#### **subscription-management-and-processing**

- **BuildInfo.properties**  
    Contains build-related information.

- **Configuration_BrpPersonenAfnemersIndicatieReceiver.xml**  
    API endpoint that processes the subscription (add/remove) request.

- **Configuration_BrpPersonenCallbackSender.xml**  
    Notifies the subscribed applications about the changes in the BRP persons' data, via their callback URLs.

- **Configuration_BrpPersonenNotificationProcessor.xml**  
    Reads the notification request from the message store and processes it.
    ```mermaid
    flowchart TD
        A[Receive indication to track BSN] --> B[Wait for 1 hour]
        B --> C[Check data related to BSN]
        C -->|Data changed| D[Notify subscribers]
        C -->|Data not changed| E{Days since start}

        E -->|More than 3 weekdays| I
        E -->|Less than 3 weekdays| G[Schedule check in 24 hours] --> C

        D --> I[End]
    ```

Database structure for tasks:

| **Column Name**     | **Data Type** | **Default Value**          | **Description**                                                                 |
|---------------------|---------------|----------------------------|---------------------------------------------------------------------------------|
| `task_id`           | `SERIAL`      | N/A                        | Auto-incrementing identifier for the task (Primary Key part 1).                 |
| `created_at`        | `TIMESTAMP`   | `CURRENT_TIMESTAMP`        | The timestamp when the task was created.                                         |
| `scheduled_start`   | `TIMESTAMP`   | `CURRENT_TIMESTAMP`        | The timestamp when the task is scheduled to start (default 1 hour after insert). |
| `status`            | `CHAR(1)`     | `'P'`                      | The current status of the task. ('P' = Pending, other values as needed).        |
| `is_retry`          | `BOOLEAN`     | `FALSE`                    | Indicates whether the task is a retry (Boolean value).                          |
| `message`           | `TEXT`        | N/A                        | The message associated with the task, storing the data in JSON or plain text.    |

- **Configuration_BrpPersonenNotificationReceiver.xml**  
    API endpoint that places the notification in the message store, receives identifier(s) that specify which person(s) information changed.
    
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
  ## Directory Structure
    
    ```plaintext
    brp-personen-bevragen-soap/xsl/
    ├── mappingStufToJson.xslt
    ├── mappingJsonToStuf.xslt
    ├── GetInputValues.xslt
    └── fields.xml
    ```
    `mappingStufToJson.xslt`
    This XSLT file converts **Stuf (npsLv01) messages** into JSON format for calling the **BRP API Personen**. The transformation determines the type of search based on the message content. There are five basic search types:
    
    1. **Raadpleeg met burgerservicenummer** (Query by citizen service number)
    2. **Zoek met geslachtsnaam en geboortedatum** (Search by surname and date of birth)
    3. **Zoek met geslachtsnaam, voornamen en gemeente van inschrijving** (Search by surname, first names, and registered municipality)
    4. **Zoek met postcode en huisnummer** (Search by postal code and house number)
    5. **Zoek met straat, huisnummer en gemeente van inschrijving** (Search by street, house number, and registered municipality)
    
    #### Additional Notes:
    - For **search options i, ii, and iv**, sending only the **Stuf (npsLv01) message** is sufficient.
    - For **search options iii and v**, the value of `gemeenteVanInschrijving` must be added to the headers. By default, this value is set to `0518` for testing purposes. If provided in the headers, the default value is overridden.
    - The required fields for each application are determined using the `fields.xml` file.
    - Based on the type of search, the necessary fields are extracted from the **Stuf (npsLv01) message**.
    
    `mappingJsonToStuf.xslt`
    This XSLT file converts the **JSON response** received from the **BRP API Personen** back into the **Stuf (npsLa01) message format**. 
    
    #### Transformation Steps:
    1. **Identify Necessary Values**: 
       - Extract input values using `GetInputValues.xslt`.
       - These values are used in the **stuurgegevens** (header data) and to determine the sending application.
    2. **Verify Required Fields**:
       - Check which fields from **Stuf (npsLa01)** are present in the input message.
       - Populate the response message using the corresponding fields from the **BRP API Personen**.
    3. **Handling Empty Fields**:
       - If a field exists but has no value or the field is not present in the response message, the attribute `xsi:nil="true"` is set.
       - The attribute `StUF:noValue` is assigned the value `geenWaarde` (no value).
       - If the field is not present in the response message, the attribute StUF:noValue is added, taking the value waardeOnbekend (unknown value).
    
    
    ## Directory Structure
    
    ```plaintext
    subscription-management-and-processing/xsl/
    ├── mappingJsonToStuf.xslt
    ├── npsLk01.xml
    ├── ControlDataToContext.xslt
    ├── BuildError.xsl
    ├── BackEndError.xsl
    ├── ParseNegativeHttpResult.xsl    
    ```
     `mappingStufToJson.xslt`
    This XSLT file is used to create a Stuf (npsLk01) message by placing person information into the appropriate fields based on the message format in npsLk01.xml.
    - If a field exists but has no value or is not present in the response message, the attribute xsi:nil="true" is set.
    - The attribute StUF:noValue is assigned the value geenWaarde (no value).
    - If the field is not present in the response message, the attribute StUF:noValue is added with the value waardeOnbekend (unknown value).
  
    **Error Handling**
  
  The following XSL files are used to generate error messages in case of errors:
- BuildError.xsl
- BackEndError.xsl
- ParseNegativeHttpResult.xsl
