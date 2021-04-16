<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
TODO: add your topic sentences(s)

## Modern applications require modern databases

On of the core elements of a modern application is the ability to easily scale up or out in order to correctly respond to workload usage. Ability to easily update and evolve the solution, along with deterministic, automatic deployment are also foundational pillars of modern application development.

Azure SQL database provides strong support to all these required features. If you need a future-proof, scalable, secure and high-performance database, [Azure SQL Hyperscale](https://docs.microsoft.com/azure/azure-sql/database/service-tier-hyperscale) provide all of that, and more. It can scale up to 100 TB and its distributed architecture make it very easy to scale up and out. It's the ideal database for transactional and hybrid transactional-analytics workload.

To support development and developers, you can use [Azure SQL Serverless](https://azure.microsoft.com/solutions/serverless/), that can automatically scale up and down with a defined range and can also auto-pause when not used, to give you the most cost-effective way to develop and test your solution. Given that the engine behind Azure SQL is always the same, moving to Azure SQL Serverless to Azure SQL Hyperscale will require no code changes and no additional effort.

As the DevOps practice is now ubiquitous, it is very important for a modern solution to properly support and have an healthy CI/CD pipeline. Azure SQL natively support GitHub Actions, that you'll be using to deploy the changes done to your development database to the test and production instances. This time using a "state based" approach. DevOps for Data is an very interesting topic, and you can learn more about it and the different options, starting from this [#DataExposed](https://www.youtube.com/playlist?list=PLlrxD0HtieHieV7Jls72yFPSKyGqycbZR) video: [Using Azure Pipelines for Azure SQL Deployments](https://www.youtube.com/watch?v=G7H6HbzwAfs&list=PLlrxD0HtieHieV7Jls72yFPSKyGqycbZR&index=26).

## Azure SQL Database as the modern database of choice

Another key point of a modern database is the ability to handle and provide support to latest development trends and innovations. Azure SQL provides a huge amount of features, all working nicely together, so that you can use the best technology or model for the best use case. An overview of all the available features - that could be interesting for a developer - is here [10 reasons to use Azure SQL in your next project](https://devblogs.microsoft.com/azure-sql/10-reasons-to-use-azure-sql-in-your-next-project/).

### Native JSON support

Azure SQL allows developer to use JSON for both exchanging data with the database or to store JSON document right into the database if you need to do so. This time you'll be using JSON as a efficient transport mechanism to send set of data - arrays, object - to a stored procedure to be processed. Once you have the JSON document you can easily manipulate it using native JSON functions, like JSON_VALUE, JSON_MODIFY or OPENJSON:

```sql
DECLARE @json NVARCHAR(MAX) = '[{"user":{"id": 1, "name": "Anna"}},{"user":{"id": 2, "name": "Davide"}}]'
SELECT * FROM
    OPENJSON(@json) WITH (
        [Id] INT '$.user.id', 
        [Name] NVARCHAR(100) '$.user.name'
    )
```

More samples on how you can use JSON in Azure SQL are available here: [Azure SQL JSON Support](https://github.com/yorek/azure-sql-db-samples/tree/master/samples/03-json)

### Geospatial Support

Azure SQL has a native [geospatial engine](https://docs.microsoft.com/sql/relational-databases/spatial/spatial-data-sql-server?view=azuresqldb-current) that you can use to perform geospatial queries without the need to install external libraries or to move data outside the database, operation that will be very expensive for big volumes of data. Full support to the Open Geospatial Consortium (OGC) standard is provided, so that exporting data in formats immediately usable by libraries like [OpenLayers](https://openlayers.org/) is really straightforward.

Here's an example of how you can create a polygon - that will act as your geofence - and check if a point - that can represent a person or a bus, for example - is with the defined perimeter:

```sql
-- Microsoft Building 44
declare @bldg44 as geography = geography::STGeomFromText('POLYGON((-122.13403149305233 47.64136608877112,-122.13398769073248 47.64058891712273,-122.13319924946629 47.64011342667547,-122.13285369830483 47.640106868176076,-122.13254221532335 47.640834858789844,-122.13257628383073 47.6410086568205,-122.13334039023833 47.64144150986729,-122.13403149305233 47.64136608877112))', 4326)

-- A point you want to check
declare @p as geography = geography::STPointFromText('POINT(-122.13315058040392 47.64101193601368)', 4326)

-- Is the point within the perimeter?
select @p.STWithin(@bldg44)
```

Since the used text format (the `POINT(-122.13315058040392 47.64101193601368)` for example) is a standard, knows as "Well-Known Text" format, it is possible to see this on a map just by copying and pasting the string. To test it yourself you can use the [OpenStreetMap WKT Playground](https://clydedacruz.github.io/openstreetmap-wkt-playground/).

### Azure SQL is Future Proof

During the lifetime of your application you'll find yourself willing to use different technologies to be as efficient as possible. For example you may want to use a Graph model to easily track and model complex network relationship, like then one that can be found in a social network or in a power grid.

Or maybe you'll need to quickly aggregate vast amout of data, in order to calculate the growth rate of a certain value.

In all these cases, and in many more, Azure SQL has you covered. It supports [Graph models](https://docs.microsoft.com/sql/relational-databases/graphs/sql-graph-overview?view=sql-server-ver15), [Columnstore indexes](https://docs.microsoft.com/sql/relational-databases/indexes/columnstore-indexes-overview?view=sql-server-ver15) and even [lock-free tables](https://docs.microsoft.com/sql/relational-databases/in-memory-oltp/introduction-to-memory-optimized-tables) for the highest throughput (those tables are *literally* compiled data structures that are then loaded in-process for the fastest performance possible).

All these features are available in the Azure SQL engine, so that you don't have to deal with the enormous challenge of data integration and management of different databases, unless you really want to.

## Catching the bus with Azure SQL Database

You after started to learn what are the technologies that are available in Azure SQL to create modern microservices architecture, from JSON to geospatial data, all through scalability and CI/CD pipelines support.

It's now time start to use everything you have just learned!

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->