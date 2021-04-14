<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->

Catching the bus can be a frustrating task. You might find yourself running to catch it (and missing it) or waiting for a long time.

Modern day challenges make opportunities for modern applications. Let's dive deeper into this scenario and how you might architect a solution leveraging various Azure services.

## Challenges with catching the bus

Many cities provides public transportation data via [General Transit Feed Specification (GTFS)](https://gtfs.org/), that also supports a real-time feed [GTFS Realtime Reference v2 (GTFS-RT)](https://gtfs.org/reference/realtime/v2/). The feed is JSON document that look like the following sample (from [King County Metro](https://kingcounty.gov/depts/transportation/metro/travel-options/bus/app-center/developer-resources.aspx) feed):

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

Knowing that such feed is available, the other thing to do is to figure out how to be notified when a bus is close enough to you so that you know that you have to start to walk to the bus station to make sure you'll catch the bus on time. One option to do that is to create a [geofence](https://en.wikipedia.org/wiki/Geo-fence) around a couple of bus stops before yours, for example, so that you can be notified when the bus is leaving it. If you can even get a notification when that happens, you don't even have to keep checking on a map where the bus is. When you'll get the notification you'll now it's time to leave.

## Architecture and Solution components

Based on the scenario and the ideal solution, here's a possible architecture:

:::image type="content" source="../media/arch-white.png" alt-text="Catch the bus microservices architecture diagram" border="false":::

The architecture uses several different services to minimize the amount of code you need to write, and to take advantage as much as possible of the scalability and infrastructure benefits provided by Azure.

### Database service

[Azure SQL database](https://azure.microsoft.com/services/azure-sql/) provides support to many of the required technologies already.

[Native JSON](https://docs.microsoft.com/sql/relational-databases/json/json-data-sql-server) support, that will help in reducing to the minimum the amount of code needed to manipulate data sent and received to and from the database. It will also help to make the solution more agile and easy to be improved thanks to JSON's flexbile nature. And, last but not least, will help to make sure that you can efficiently pass to Azure SQL arrays of data, optimizing round-trips and reducing latency.

Azure SQL also provide complete [geospatial](https://docs.microsoft.com/sql/relational-databases/spatial/spatial-data-sql-server) support, which is a great feature as manipulating geospatial data is not the easiest of the tasks. By having an fully featured geospatial engine withing the database, you can avoid the complexity of integrating with external libraries, and, most importantly, you don't have to move data around to figure out, for example, if a Bus is within a define geofence. Thanks to support to the Open Geospatial Consortium standards, it is also very easy to integrate data stored in Azure SQL with visualization libraries like [OpenLayers](https://openlayers.org/).

All the aforementioned feature are built on the rock-solid foundations of relational model, evolved through years of improvement to be ready to meet the requirement of modern applications. Scalable up to 100TB with the [Hyperscale tier](https://docs.microsoft.com/azure/azure-sql/database/service-tier-hyperscale) or extremely cost-effective via the [Serverless tier](https://docs.microsoft.com/azure/azure-sql/database/serverless-tier-overview), Azure SQL also supports [columnstore indexes](https://docs.microsoft.com/sql/relational-databases/indexes/columnstore-indexes-design-guidance) for blazing fast analytical queries, [graph models](https://docs.microsoft.com/sql/relational-databases/graphs/sql-graph-overview) to simplify complex object relationship management and state-of-the art query optimizer that is continuously improved and can handle even the most demanding workload, like the one required by today's [massive multiplayer online gaming](https://developer.microsoft.com/games/customer-stories/pearl-abyss-helps-ensure-a-lag-free-game-launch-with-azure/).

With Azure SQL is also very easy to access static data, like the route information provided by the GTFS standard, that can be stored in an [Azure Blob Storage](https://azure.microsoft.com/services/storage/blobs/). By using [OPENROWSET](https://docs.microsoft.com/sql/t-sql/functions/openrowset-transact-sql) function importing data from a text file can be done without the need to use any additional service, keeping solution complexity at minimum.

### API service

To provide the API needed to get JSON data from buses, by accessing and consuming the GTFS-RT feed, to notify if a bus has entered a geofence and to serve the spatial data to the Web App you will be using [Azure Functions](https://azure.microsoft.com/services/functions/). Azure Functions are really a great service as their serverless nature will allow you to focus only on the code, leaving almost all infrastructural aspects to Azure Functions. They provide support different languages, so you can choose to use your preferred one or the most suitable for the task you are working on, following a pure microservices approach.

### Notification service

To get a notification that a bus is the geofence and thus that you need to start to walk to the bus station, one option in Azure is to use [Azure Logic App](https://docs.microsoft.com/azure/logic-apps/logic-apps-overview) that can send an email to your Outlook account. It provides an huge number of connectors so you can integrate with many common services, for example to send SMS, or to send notification to other services. Of course if you want you can also easily integrate with other external services like the well-know IFTTT, for example.

### Web application hosting

To visualize geospatial data and project geofences and bus positions on a map you'll creating a static HTML page, using the well-known [Vue.js](https://vuejs.org/) framework and the [OpenLayers](https://openlayers.org/) library. The static page will need to fetch data from a server-side REST API that will be provided by another Azure Function. As both the client and the back-end part are needed to make the visualization page work, you'll be taking advantage of [Azure Static Web Apps](https://azure.microsoft.com/services/app-service/static/) that make it very easy to develop and deploy the entire visualization solution as a whole.

### Automation of deployment

The complete solution is made of several moving parts. The back-end service to pull data from the real-time feed. The database to store, process and serve data. The front-end visualization solution which is itself comprised of a static HTML file and a REST API endpoint. By setting a CI/CD pipeline using [GitHub Actions](https://github.com/features/actions), you'll be able to manage the deployment of all the aforementioned pieces, via GitHub, as soon as you have finished committing your changes. Database changes, if any, will be deployed, along with Azure Functions and Azure Static Web Site, in a fully automated and orchestrated way.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
