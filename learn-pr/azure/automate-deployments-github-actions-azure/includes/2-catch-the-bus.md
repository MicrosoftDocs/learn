Catching the bus can be a frustrating task. You might find yourself running to catch it (and missing it) or waiting for a long time.

Modern day challenges make opportunities for modern applications. Whether you are seeing this scenario for the first time, or you have completed the other modules in the learning path, let's review the scenario and how the solution was constructed.

## Real-time bus data

Many cities provides public transportation data via General Transit Feed Specification (GTFS), that also supports a real-time feed GTFS Realtime Reference v2 (GTFS-RT). The feed is a JSON document that looks like the following sample (from [King County Metro](https://kingcounty.gov/depts/transportation/metro/travel-options/bus/app-center/developer-resources.aspx) feed):

```JSON
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

Knowing that such feed is available, the next thing to consider is how to be notified when a bus is 'close enough' to you. Then, you know that you have to start walking to the bus stop. One option to do that is to create a geofence around a couple of bus stops before yours. When a bus enters or exits that geofence, it would be ideal to get a notification. Checking a map is convenient to see if buses are on the way, but getting a notification let's you know it's about to arrive.

## Architecture components

Let's review a possible architecture that would support the challenges and goals discussed.

:::image type="content" source="../media/2-catch-the-bus.svg" alt-text="Potential architecture for a solution to the catching the bus scenario.":::

The architecture uses several different services to minimize the amount of code you need to write, and to take advantage of the scalability and infrastructure benefits provided by Azure.

### Database service

Azure SQL database provides support to many of the required technologies already.

Native JSON support will help in reducing the amount of code needed to manipulate data sent and received to and from the database. The JSON support also lends itself for future improvements due to JSON's flexible nature. And, last but not least, will help to make sure that you can efficiently pass to Azure SQL arrays of data, optimizing round-trips and reducing latency.

Azure SQL also provides complete geospatial support, which is a great feature as manipulating geospatial data is not typically an easy task. With a fully featured geospatial engine within the database, you can avoid the complexity of integrating with external libraries, and you don't have to move data around to figure out, for example, if a bus is within a defined geofence. Azure SQL supports the Open Geospatial Consortium standards, so it is also easy to integrate data stored in Azure SQL with visualization libraries like OpenLayers.

All the aforementioned feature are built on the rock-solid foundations of the relational model, which has evolved through years of improvement to meet the requirement of modern applications. Azure SQL Database can be scalable up to 100TB with the Hyperscale tier or extremely cost-effective with the Serverless tier (supports auto-scaling and pause-and-resume). Azure SQL also supports columnstore indexes for blazing fast analytical queries, graph models to simplify complex object relationship management, and a state-of-the art query optimizer that is continuously improving and can handle even the most demanding workload, like the one required by today's massive multiplayer online gaming.

With Azure SQL, it is also easy to access static data, like the route information provided by the GTFS standard, which might be stored in Azure Blob Storage. By using the `OPENROWSET` function, importing data from a text file can be done without the need of other services, keeping the solution complexity at minimum.

### API service

An API is needed to access and consume the GTFS feed, to notify a user if a bus has entered a geofence, and to serve data to a web application. Azure Functions has been selected as the service of choice. Azure Functions is a great service as its serverless nature allows you to focus on the code, leaving almost all infrastructural aspects to Azure Functions. Azure Functions provides support for different languages, so you can choose your preferred one or the most suitable one for the task you are working on, which follows a pure microservices approach.

### Notification service

To get a notification that a bus is within the geofence and you need to start to walk to the bus station, one option in Azure is to use Azure Logic Apps. Azure Logic Apps has a large number of connectors so you can integrate with other services. For example, you can use Azure Logic Apps to send an SMS message or send an email to your Outlook account. Of course, you can also easily integrate with other external services like the well-known service, IFTTT.

### Web application hosting

To visualize geospatial data, which represents the geofences and bus positions on a map, you can create a static HTML page, using the well-known Vue.js framework and the OpenLayers library. The static page will need to fetch data from a server-side REST API that will be provided by another Azure Function. As both the client and the back end parts are needed to make the visualization page work, you can take advantage of Azure Static Web Apps. Azure Static Web Apps make it easy to develop and deploy the solution, since it combines the capabilities of Azure Web Apps and Azure Functions.

### Deployment automation

As you've seen, the complete solution is made up of several moving parts: the back end service to pull data from the real-time feed, the database to store, process and serve data, and the front-end visualization solution which is composed of a static HTML file and a REST API endpoint. By using a CI/CD pipeline through GitHub Actions, you'll be able to manage the deployment of all the pieces, via GitHub and Visual Studio Code, as soon as you have finished committing your changes. Database changes, if there are any, along with Azure Functions and Azure Static Web Apps will be deployed in a fully automated and orchestrated way.
