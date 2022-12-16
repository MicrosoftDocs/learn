Azure Functions provides an easy, scalable way to deploy serverless APIs. In the bus-catching scenario, several lightweight APIs will be required in order to get, process, and react to incoming real-time bus data.

## Identify requirements of serverless APIs

In the bus-catching scenario, real-time data containing information about where buses are located is stored in a JSON document in accordance with the [General Transit Feed Specification (GTFS)](https://gtfs.org/about/). Many cities provide public transportation data via a real-time feed that meets the [GTFS real-time Reference v2 (GTFS-RT)](https://gtfs.org/reference/realtime/v2/) standard.

To retrieve the latest data, you can use an API. Once you have the latest data, it needs to be stored somewhere for processing. Processing the data involves checking for buses within the monitored routes and proximity to the monitored geofence(s). In this scenario, a monitored route is a bus route that a user might want to take, and the geofence represents the area where a user wants to be notified that their bus is nearby. As the data is processed, any buses that are entering or exiting the geofence should result in a notification, for example, an email, stating that the specified bus and route is coming soon or has left. Azure Functions contains the capability to complete this task easily and integrate with other services that are required.

## Build APIs using Azure Functions

Azure Functions accelerates and simplifies application development. Azure Functions is an event-driven, serverless compute platform that can also solve complex orchestration problems. There's great support for building and debugging functions locally in Visual Studio Code. You can also deploy and operate at scale in Azure, and integrate with other services using triggers and bindings.

<!--
> [!VIDEO "TBD - looking for RedTiger available video"]-->

Azure Functions supports using your preferred language as C#, Java, JavaScript, PowerShell, and Python are all supported. There are also custom handlers to enable you to use any other language as needed.

Azure Functions allows you to host a single method or function to respond to an event. An event could be an HTTP request, a new message on a queue, or a timer. Additionally, Azure Functions scales automatically and you're only charged when a function is triggered, so it's truly a serverless service. Azure Functions allows you to focus on the code that's running your service and not the underlying infrastructure. Since they can be granular, Azure Functions is often used to support microservices architectures. This aspect also allows you to build reusable pieces for different applications.

### Integrate Azure Functions with Azure Logic Apps

In this scenario, an Azure Function will be used to do the data collection and processing of real-time bus data. Once the Azure Function detects that there's a bus entering or exiting the geofence, the function calls an Azure Logic App to send notifications in the form of an email. Azure Logic Apps is a low-code/no-code development platform hosted as a serverless cloud service. Since Azure Logic Apps has a connector to be triggered when an HTTP POST request is made, calling them from Azure Functions is easy. More on this service and this piece of the solution will be covered later in the module.

### Integrate Azure Functions with Azure SQL Database

In this scenario, Azure Functions will store the data in Azure SQL Database. Azure SQL Database supports modern capabilities like JSON and geospatial, which makes building the overall solution easier, more efficient, and more performant.

Azure Functions will also call an Azure SQL Database stored procedure that returns the buses that are entering and exiting the geofence. Azure Functions supports many languages as mentioned above and so does Azure SQL, which makes connecting and accessing Azure SQL Database from Azure Functions as simple as obtaining the correct driver for the selected language and formatting your connection strings accordingly.

## Select a method to deploy Azure Functions

Azure Functions provides all the requirements to support the serverless API that's required in the bus-catching scenario. This Azure Function will be used to retrieve the real-time bus data, call Azure SQL Database, and call Azure Logic Apps.

In the following exercise, after setting up some required resources, you'll deploy an Azure Function. You can deploy Azure Functions using the Azure portal, the Cloud Shell, or Visual Studio Code. In the exercise, you'll use the Cloud Shell.
