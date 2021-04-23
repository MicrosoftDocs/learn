One of the core elements of a modern application is the ability to easily scale up or down in order to correctly respond to workload usage. Ability to easily update and evolve the solution, along with deterministic, automatic deployment are also foundational pillars of modern application development.

## Modern applications require modern databases

Azure SQL Database provides strong support to all these required features. If you need a future-proof, scalable, secure, and high-performance database, [Azure SQL Hyperscale](https://docs.microsoft.com/azure/azure-sql/database/service-tier-hyperscale) provides everything you need, and more. It can scale up to 100 TB and its distributed architecture make it easy to scale up and out. It's the ideal database for transactional and hybrid transactional-analytics workloads.

To support development and developers, you can use [Azure SQL Serverless](https://azure.microsoft.com/solutions/serverless/), that can automatically scale up and down within a defined range and can autopause when not used, to give you the most cost-effective way to develop and test your solution. Given that the engine behind Azure SQL is the same, moving to Azure SQL Serverless and Azure SQL Hyperscale will require no code changes and no extra effort.

As the DevOps practice is now ubiquitous, it is important for a modern solution to properly support and have a healthy CI/CD pipeline. Azure SQL natively supports GitHub Actions, that you can use to deploy changes to your development database to test and production databases. Azure SQL actions use a "state based" approach. DevOps for Data is an interesting topic, and you can learn more about it in the Data Exposed episodes referenced at the end of the module.

## Azure SQL Database as the modern database of choice

Another key requirement of a modern database is the ability to handle and support the latest development trends and innovations. Azure SQL provides a huge number of features, all working nicely together, so that you can use the best technology or model for the best use case. An overview of all the available features is provided in a blog post at the end of the module.

### Native JSON support

Azure SQL allows developers to use JSON for both exchanging data with the database and storing JSON document right into the database. This way, you can use JSON as an efficient transport mechanism to send set of data, like arrays and objects, to a stored procedure to be processed. Once you have the JSON document, you can easily manipulate it using native JSON functions, like JSON_VALUE, JSON_MODIFY or OPENJSON:

```sql
DECLARE @json NVARCHAR(MAX) = '[{"user":{"id": 1, "name": "Anna"}},{"user":{"id": 2, "name": "Davide"}}]'
SELECT * FROM
    OPENJSON(@json) WITH (
        [Id] INT '$.user.id', 
        [Name] NVARCHAR(100) '$.user.name'
    )
```

More samples on how you can use JSON in Azure SQL are available here at the end of the module.

### Geospatial Support

Azure SQL has a native geospatial engine that you can use to perform geospatial queries without the need to install external libraries or move data outside the database, which would be expensive for significant volumes of data. Full support to the Open Geospatial Consortium (OGC) standard is provided, so that exporting data in formats immediately usable by libraries like OpenLayers is straightforward.

Here's an example of how you can create a polygon - that will act as your geofence - and check if a point - that can represent a person or a bus, for example - is with the defined perimeter:

```sql
-- Microsoft Building 44
declare @bldg44 as geography = geography::STGeomFromText('POLYGON((-122.13403149305233 47.64136608877112,-122.13398769073248 47.64058891712273,-122.13319924946629 47.64011342667547,-122.13285369830483 47.640106868176076,-122.13254221532335 47.640834858789844,-122.13257628383073 47.6410086568205,-122.13334039023833 47.64144150986729,-122.13403149305233 47.64136608877112))', 4326)

-- A point you want to check
declare @p as geography = geography::STPointFromText('POINT(-122.13315058040392 47.64101193601368)', 4326)

-- Is the point within the perimeter?
select @p.STWithin(@bldg44)
```

Since the used text format (the `POINT(-122.13315058040392 47.64101193601368)` for example) is a standard, knows as "Well-Known Text" format, it is possible to see the shape projected on a map just by copying and pasting the string. To test it yourself, you can use the [OpenStreetMap WKT Playground](https://clydedacruz.github.io/openstreetmap-wkt-playground/).

### Azure SQL is future-proof

During the lifetime of your application, you'll want to use different technologies to be as efficient as possible. For example, you may want to use a Graph model to easily track and model a complex network relationship, like in a social network or in a power grid.

Or, maybe you'll need to quickly aggregate a vast amount of data to calculate the growth rate of a certain value.

In all these cases, and in many more, Azure SQL has you covered. It supports Graph models], Columnstore indexes, and even lock-free tables for the highest throughput (those tables are literally compiled data structures that are then loaded in-process for the fastest performance possible).

All these features are available in the Azure SQL engine, so you don't have to deal with the enormous challenge of data integration and management of different databases.
