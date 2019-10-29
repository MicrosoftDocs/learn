The REST API lets you programmatically manage data export definitions in your IoT Central application.

To simplify the job of a store manager, you've been asked to integrate IoT Central data export definition management capabilities into the existing store management application. Store managers want to use the existing store management application to manage data export definitions.

Here, you'll learn how to use the REST API to create and delete data export definitions.

## Data export

IoT Central lets you configure a continuous data export from an application. You can use this feature to send data to other services for analysis or processing, or to send the data to a storage location.

When you set up data export, you choose from **Azure Blob Storage**, **Azure Event Hubs**, or **Azure Service Bus** as the destination for the data. You also choose the data to export. You can export device telemetry, changes to devices including property updates, and device template information.

## Use the REST API to work with data export

The [IoT Central REST API for continuous data exports](https://docs.microsoft.com/rest/api/iotcentral/continuousdataexports) lets you:

- List the existing data export definitions
- View an existing data export definition
- Delete a data export definition
