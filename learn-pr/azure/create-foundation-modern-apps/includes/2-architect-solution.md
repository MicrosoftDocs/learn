Creating an application architecture requires you understand the breadth of functional and non-functional requirements, then pair those requirements with tools, technologies, and services that can address those requirements. 

In the bus-catching scenario, there are a few main requirements:

- A website for monitoring real-time bus locations
- Notifications when a bus is close by
- Automated deployment and scaling

Let's dive deeper into this scenario and how you might architect a solution using various Azure services.

## Retrieve real-time bus data

Many cities provide public transportation data via [General Transit Feed Specification (GTFS)](https://gtfs.org/about/), which also supports a real-time feed called GTFS real-time Reference v2 (GTFS-RT). The feed is composed of a JSON document that looks like the following sample (from [King County Metro](https://kingcounty.gov/depts/transportation/metro/travel-options/bus/app-center/developer-resources.aspx) feed):

```json
{
      "id": "1618418866_4318",
      "vehicle": {
        "trip": {
          "trip_id": "49195161",
          "direction_id": 0,
          "route_id": "100001",
          "start_date": "20210414",
          "schedule_relationship": "SCHEDULED"
        },
        "vehicle": {
          "id": "4318",
          "label": "4318"
        },
        "position": {
          "latitude": 47.64524,
          "longitude": -122.370171
        },
        "current_stop_sequence": 228,
        "stop_id": "2010",
        "current_status": "IN_TRANSIT_TO",
        "timestamp": 1618418841
      }
    },
```

Knowing that such a feed is available, you need to next figure out how to be notified when a bus is close enough to you so you know to start walking to the bus station to catch the bus on time. To do that, we can create a [geofence](https://en.wikipedia.org/wiki/Geo-fence) a couple of bus stops before our intended station. This way, you can be notified when the bus is entering or exiting the geofence. If you can get a notification when that happens, you don't even have to keep checking on a map where the bus is. When you get the notification, you'll know it's time to leave.

## Architect a solution with Azure services

Based on the scenario and the ideal solution, here's a possible architecture:

:::image type="content" source="../media/1-catch-the-bus.svg" alt-text="Diagram of the Catch the bus microservices architecture." border="false":::

The architecture uses several different services to minimize the amount of code you need to write, and to take the most possible advantage of the scalability and infrastructure benefits Azure provides.

There's a complete learning path dedicated to exploring each piece of the architecture. Here, you'll get an overview about which solution components are selected and why. Then, in this module, you'll focus on the database service.

### Store and process data with Azure SQL Database

Azure SQL Database is a great fit for this scenario. Let's understand why.

Azure SQL Database has native JSON support, which helps in reducing the amount of code needed to manipulate data sent and received with the database. It also makes the solution more agile and easy to improve thanks to JSON's flexible nature. It also ensures that you can efficiently pass arrays of data to Azure SQL, optimize round trips, and reduce latency.

Azure SQL also provides complete geospatial support, which is a great feature because manipulating geospatial data isn't the easiest of tasks. By having a fully featured geospatial engine within the database, you can avoid the complexity of integrating with external libraries. You also don't have to move data around to figure out, for example, if a bus is within a defined geofence. Because Azure SQL adheres to the [Open Geospatial Consortium standards](http://www.ogc.org.tw/en-US/Standards), it's easy to integrate data stored in Azure SQL with visualization libraries like OpenLayers.

The aforementioned features are built on the rock-solid foundations of the relational model, evolved through years of improvement to meet the requirements of modern applications. Azure SQL Database is scalable up to 100 TB with the [Hyperscale tier](/azure/azure-sql/database/service-tier-hyperscale), or cost-effective with the [Serverless tier](/azure/azure-sql/database/serverless-tier-overview) (supports autoscaling and pause-and-resume). Azure SQL also supports columnstore indexes for blazing fast analytical queries, graph models to simplify complex object relationship management, and a state-of-the-art query optimizer that's continuously improving and can handle even the most demanding workload, like the one required by today's [massive multiplayer online gaming](https://techcommunity.microsoft.com/t5/azure-sql-blog/pearl-abyss-massive-scale-using-azure-sql-database/ba-p/386231).

With Azure SQL, it's also easy to access static data—like the route information provided by the GTFS standard—that can be stored in an Azure Blob Storage account. We can use the `OPENROWSET` function in Azure SQL to import data from a text file without the need for another service. This allows us to minimize solution complexity.

For these reasons, Azure SQL Database is a great fit for applications like the bus-catching app, where you're dealing with JSON and geospatial data, but also want to take advantage of the data access and procedure capabilities built into the engine. Azure SQL Database serverless is a great option to satisfy the autoscaling requirement, enabling the application to handle busy times during the day when more people are trying to catch the bus. Azure SQL Database also supports continuous integration and continuous delivery/continuous deployment (CI/CD) technologies like Azure DevOps and GitHub Actions, which simplify deployment automation.

### Build an API service with Azure Functions

You need an API to access and consume the GTFS feed, to notify a user if a bus has entered a geofence, and to serve data to a web application. You've selected Azure Functions as the service of choice due to its simplicity and serverless architecture. Azure Functions is a great service because its serverless nature autoscales to what you need, leaving almost all infrastructural aspects to Azure Functions. Azure Functions provides support for different languages, so you can choose your preferred one or the most suitable one for the task on which you're working, which follows a pure microservices approach.

### Send notifications with Azure Logic Apps

To get a notification that a bus is within the geofence and you need to start walking to the bus station, one option in Azure is to use Azure Logic Apps. Azure Logic Apps has a large number of connectors so you can integrate with other services. For example, you can use Azure Logic Apps to send an SMS message or send an email from your Outlook or Gmail account. What's great about Azure Logic Apps is that it's a low-code/no code platform, so setting up the notification service for catching the bus is easy, and you can do it with just a few mouse actions.

### Host the web application with Azure Static Web Apps

To visualize geospatial data, which represents the geofences and bus positions on a map, you can create a static HTML page using the well-known jQuery and the OpenLayers libraries. The static page will need to fetch data from a server-side REST API that another Azure Function will provide. As both the client and back-end parts are needed to make the visualization page work, you can take advantage of Azure Static Web Apps. Azure Static Web Apps makes it easy to develop and deploy the solution because it combines the capabilities of Azure Web Apps and Azure Functions, plus it has integration with GitHub Actions built-in.

### Automate deployment with GitHub Actions

As you've seen, the complete solution is made up of several moving parts: the back-end service to pull data from the real-time feed; the database to store, process, and serve data; and the front-end visualization solution, which is composed of a static HTML file and a REST API endpoint. By using a CI/CD pipeline through GitHub Actions, you'll automate the deployment of all the pieces via GitHub and Visual Studio Code whenever you commit changes. Database changes, if there are any, along with Azure Functions and Azure Static Web Apps changes, will be deployed in a fully automated and orchestrated manner.
