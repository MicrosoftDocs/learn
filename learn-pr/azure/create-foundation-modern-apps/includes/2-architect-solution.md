Catching the bus can be a frustrating task. You might find yourself running to catch it (and missing it) or waiting for a long time.

Modern day challenges make opportunities for modern applications. Let's dive deeper into this scenario and how you might architect a solution using various Azure services.

## Challenges with catching the bus

Many cities provide public transportation data via [General Transit Feed Specification (GTFS)](https://gtfs.org/), that also supports a real-time feed [GTFS real-time Reference v2 (GTFS-RT)](https://gtfs.org/reference/realtime/v2/). The feed is JSON document that looks like the following sample (from [King County Metro](https://kingcounty.gov/depts/transportation/metro/travel-options/bus/app-center/developer-resources.aspx) feed):

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

Knowing that such feed is available, the other thing to do is to figure out how to be notified when a bus is close enough to you so you know that you have to start to walk to the bus station to catch the bus on time. One option to do that is to create a [geofence](https://en.wikipedia.org/wiki/Geo-fence) around a couple of bus stops before yours, for example, so that you can be notified when the bus is entering or exiting it. If you can get a notification when that happens, you don't even have to keep checking on a map where the bus is. When you get the notification, you'll know it's time to leave.

## Architecture and Solution components

Based on the scenario and the ideal solution, here's a possible architecture:

:::image type="content" source="../media/1-catch-the-bus.svg" alt-text="Catch the bus microservices architecture diagram" border="false":::

The architecture uses several different services to minimize the amount of code you need to write, and to take advantage as much as possible of the scalability and infrastructure benefits provided by Azure.

There is a complete learning path dedicated to exploring each piece of the architecture. in this module, you'll focus on the database service.

### Database service

[Azure SQL Database](https://azure.microsoft.com/services/azure-sql/) provides support to many of the required technologies already.

Azure SQL Database has [native JSON](https://docs.microsoft.com/sql/relational-databases/json/json-data-sql-server) support, that will help in reducing the amount of code needed to manipulate data sent and received to and from the database. It will also help to make the solution more agile and easy to be improved thanks to JSON's flexible nature. And, it will help to make sure that you can efficiently pass arrays of data to Azure SQL, optimize round-trips, and reduce latency.

Azure SQL also provides complete [geospatial](https://docs.microsoft.com/sql/relational-databases/spatial/spatial-data-sql-server) support, which is a great feature as manipulating geospatial data is not the easiest of tasks. By having a fully featured geospatial engine within the database, you can avoid the complexity of integrating with external libraries, and you don't have to move data around to figure out, for example, if a bus is within a defined geofence. Since Azure SQL adheres to the Open Geospatial Consortium standards, it is easy to integrate data stored in Azure SQL with visualization libraries like [OpenLayers](https://openlayers.org/).

The aforementioned features are built on the rock-solid foundations of the relational model, evolved through years of improvement to be ready to meet the requirement of modern applications. Azure SQL Database is scalable up to 100 TB with the [Hyperscale tier](https://docs.microsoft.com/azure/azure-sql/database/service-tier-hyperscale) or cost-effective with the [Serverless tier](https://docs.microsoft.com/azure/azure-sql/database/serverless-tier-overview) (supports autoscaling and pause-and-resume). Azure SQL also supports [columnstore indexes](https://docs.microsoft.com/sql/relational-databases/indexes/columnstore-indexes-design-guidance) for blazing fast analytical queries, [graph models](https://docs.microsoft.com/sql/relational-databases/graphs/sql-graph-overview) to simplify complex object relationship management, and a state-of-the-art query optimizer that is continuously improved and can handle even the most demanding workload, like the one required by today's [massive multiplayer online gaming](https://developer.microsoft.com/games/customer-stories/pearl-abyss-helps-ensure-a-lag-free-game-launch-with-azure/).

With Azure SQL it is also easy to access static data, like the route information provided by the GTFS standard, that can be stored in an Azure Blob Storage account. By using the [OPENROWSET](https://docs.microsoft.com/sql/t-sql/functions/openrowset-transact-sql) function, importing data from a text file can be done without any other service, keeping solution complexity to a minimum.

<!--
### API service

An API is needed to access and consume the GTFS feed, to notify a user if a bus has entered a geofence, and to serve data to a web application.  [Azure Functions](https://azure.microsoft.com/services/functions/) has been selected as the service of choice. Azure Functions is a great service as its serverless nature allows you to focus on the code, leaving almost all infrastructural aspects to Azure Functions. Azure Functions provides support for different languages, so you can choose your preferred one or the most suitable one for the task you are working on, which follows a pure microservices approach.

### Notification service

To get a notification that a bus is within the geofence and you need to start to walk to the bus station, one option in Azure is to use [Azure Logic Apps](https://docs.microsoft.com/azure/logic-apps/logic-apps-overview). Azure Logic Apps has a large number of connectors so you can integrate with other services. For example, you can use Azure Logic Apps to send an SMS message or send an email from your Outlook or Gmail account. If you want, you can also easily integrate with other external services like the well-known service, IFTTT.

### Web application hosting

To visualize geospatial data and project geofences and bus positions on a map, you'll be creating a static HTML page, using the well-known [Vue.js](https://vuejs.org/) framework and the [OpenLayers](https://openlayers.org/) library. The static page will need to fetch data from a server-side REST API provided by another Azure Function. As both the client and the back-end parts are needed to make the visualization page work, you'll be taking advantage of [Azure Static Web Apps](https://azure.microsoft.com/services/app-service/static/) that make it easy to develop and deploy the entire visualization solution as a whole.

### Automation of deployment

As you've seen, the complete solution is made up of several moving parts: the back-end service to pull data from the real-time feed, the database to store, process, and serve data, and the front-end visualization solution, which is composed of a static HTML file and a REST API endpoint. By using a CI/CD pipeline through [GitHub Actions](https://github.com/features/actions), you'll be able to manage the deployment of all the pieces, via GitHub and Visual Studio Code, as soon as you have finished committing your changes. Database changes, if there are any, along with Azure Functions and Azure Static Web Apps will be deployed in a fully automated and orchestrated way. -->
