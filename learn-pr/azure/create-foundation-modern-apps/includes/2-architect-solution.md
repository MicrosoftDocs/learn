<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
Catching the bus can be a frustrating task. You might find yourself running to catch it (and missing it) or waiting for a long time. 

Modern day challenges make opportunities for modern applications. Let's dive deeper into this scenario and how you might architect a solution leveraging various Azure services.

## Challenges with catching the bus

TODO: describe how to function will work logically (scenario)

## Architecture and Solution components

Based on the scenario and the ideal solution, here's a possible architecture:

:::image type="content" source="../media/arch-white.png" alt-text="Diagram of enterprise-class security." border="false":::

TODO: comment on architecture

### Database service

[Azure SQL database](https://azure.microsoft.com/services/azure-sql/) provides support to many of the required technologies already.

[Native JSON](https://docs.microsoft.com/sql/relational-databases/json/json-data-sql-server) support, that will help in reducing to the minimum the amount of code needed to manipulate data sent and received to and from the database. It will also help to make the solution more agile and easy to be improved thanks to JSON's flexbile nature. And, last but not least, will help to make sure that you can efficiently pass to Azure SQL arrays of data, optimizing round-trips and reducing latency.

Azure SQL also provide complete [geospatial](https://docs.microsoft.com/sql/relational-databases/spatial/spatial-data-sql-server) support, which is a great feature as manipulating geospatial data is not the easiest of the tasks. By having an fully featured geospatial engine withing the database, you can avoid the complexity of integrating with external libraries, and, most importantly, you don't have to move data around to figure out, for example, if a Bus is within a define geofence. Thanks to support to the Open Geospatial Consortium standards, it is also very easy to integrate data stored in Azure SQL with visualization libraries like [OpenLayers](https://openlayers.org/).

All the aforementioned feature are built on the rock-solid foundations of relational model, evolved through years of improvement to be ready to meet the requirement of modern applications. Scalable up to 100TB with the [Hyperscale tier](https://docs.microsoft.com/azure/azure-sql/database/service-tier-hyperscale) or extremely cost-effective via the [Serverless tier](https://docs.microsoft.com/azure/azure-sql/database/serverless-tier-overview), Azure SQL also supports [columnstore indexes](https://docs.microsoft.com/sql/relational-databases/indexes/columnstore-indexes-design-guidance) for blazing fast analytical queries, [graph models](https://docs.microsoft.com/sql/relational-databases/graphs/sql-graph-overview) to simplify complex object relationship management and state-of-the art query optimizer that is continuously improved and can handle even the most demanding workload, like the one required by today's [massive multiplayer online gaming](https://developer.microsoft.com/games/customer-stories/pearl-abyss-helps-ensure-a-lag-free-game-launch-with-azure/).

### API service

To provide the API needed to get JSON data from buses, to notify if a bus has entered a geofence and to serve the spatial data to the Web App, [Azure Functions](https://azure.microsoft.com/services/functions/) are really a great service as their serverless nature will allow you to focus only on the code, leaving almost all infrastructural aspects to Azure Functions.

Azure Function, support different languages, so you can choose to use your preferred one or the most suitable for the task you are working on, following a pure microservices approach.

### Notification service

To get a notification that a bus is the geofence and thus you need to start to walk to the bus station, one option in Azure is to use [Azure Logic App](https://docs.microsoft.com/azure/logic-apps/logic-apps-overview) that can send an email to your Outlook account. It provides an huge number of connectors so you can integrate with many common services, for example to send SMS, or to send notification to other services. Of course if you want you can also easily integrate with other external services like the well-know IFTTT for example.

### Web application hosting

TODO: Explain how it helps the solution

### Automation of deployment

TODO: Explain how it helps the solution

## Solution architecture

TODO: Show image of solution architecture and explain the pieces.
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
