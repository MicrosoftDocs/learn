After you've configured your environment, you're ready to start analyzing and testing certain components of a potential solution architecture. In the bus-catching scenario, and for many other modern applications, you need a modern database to store, process, and serve data. Let's explore how Azure SQL Database meets the needs of modern applications.

## Scale to meet demand with flexible Azure SQL Database options

One of the core elements of a modern application is the ability to easily scale up or down in order to correctly respond to workload usage. The ability to easily update and evolve a solution, along with deterministic, automatic deployment are also foundational pillars of modern application development. This principle also empowers applications to pay only for what's needed, when it's needed.

Azure SQL Database provides strong support to all these required features. If you need a future-proof, scalable, secure, and high-performance database, [Azure SQL Hyperscale](/azure/azure-sql/database/service-tier-hyperscale) provides everything you need and more. It can scale up to 100 TB and its distributed architecture makes it easy to scale up and out. It's the ideal database for transactional and hybrid transactional-analytics workloads.

To support development and developers, you can use [Azure SQL Serverless](https://azure.microsoft.com/solutions/serverless/), which can automatically scale up and down within a defined range and can autopause when not used to give you the most cost-effective way to develop and test your solution. Given that the engine behind Azure SQL is the same, moving to Azure SQL Serverless and Azure SQL Hyperscale will require no code changes and no extra effort.

## Support development workflows with GitHub Actions

As the DevOps practice is now ubiquitous, it's important for a modern solution to properly support and have a healthy continuous integration and continuous delivery/continuous deployment (CI/CD) pipeline. Azure SQL natively supports GitHub Actions, which you can use to deploy changes to your development database to test and production databases when ready. Azure SQL actions use a state-based approach. DevOps for data is an interesting topic, and you can learn more about it in the Data Exposed episodes referenced at the end of the module.

Another key requirement of a modern database is the ability to handle and support the latest development trends and innovations. Azure SQL provides many features so you can use the best technology or model for a given use case. We provide an overview of all the available features in a blog post at the end of the module.

## Future-proof your applications using Azure SQL

During the lifetime of your application, you'll want to use different technologies to be as efficient as possible. For example, you might want to use a Graph model to easily track and model a complex network relationship, like a social network or power grid. Or, maybe you'll need to quickly aggregate a vast amount of data to calculate the growth rate of a certain value. In all these cases, and in many more, Azure SQL has you covered. It supports Graph models, Columnstore indexes, and even lock-free tables for the highest throughput (those tables are compiled data structures that are then loaded in-process to achieve high performance).

For the bus-catching scenario, you'll use Azure SQL Serverless so you only pay for what you need and use, due to autoscaling and autopause support. You'll use GitHub Actions to create a deployment pipeline to update the database as needed. There are a few other capabilities that are required for the scenario. Let's take a closer look at them. In the next exercise, you'll get hands-on with these capabilities.

### Process JSON data with native JSON capabilities

Azure SQL allows developers to use JSON for both exchanging data with the database and storing JSON documents. This way, you can use JSON as an efficient transport mechanism to send sets of data, like arrays and objects, to a stored procedure to be processed. Once you have the JSON document, you can easily manipulate it using native JSON functions, like JSON_VALUE, JSON_MODIFY or OPENJSON. Here's an example:

```sql
DECLARE @json NVARCHAR(MAX) = '[{"user":{"id": 1, "name": "Anna"}},{"user":{"id": 2, "name": "Davide"}}]'
SELECT * FROM
    OPENJSON(@json) WITH (
        [Id] INT '$.user.id', 
        [Name] NVARCHAR(100) '$.user.name'
    )
```

More samples showing how you can use JSON in Azure SQL are available at the end of the module.

### Analyze geospatial data with the native geospatial engine

Azure SQL has a native geospatial engine that you can use to perform geospatial queries without installing external libraries or moving data, which could be expensive for significant volumes of data. Azure SQL fully supports the Open Geospatial Consortium (OGC) standard, so exported data is usable by libraries like OpenLayers.

The following example shows how you can create a polygon that will serve as your geofence in the bus-catching scenario, and check if a point that will serve as your real-time bus data points is within the polygon.

```sql
-- Microsoft Building 44
declare @bldg44 as geography = geography::STGeomFromText('POLYGON((-122.13403149305233 47.64136608877112,-122.13398769073248 47.64058891712273,-122.13319924946629 47.64011342667547,-122.13285369830483 47.640106868176076,-122.13254221532335 47.640834858789844,-122.13257628383073 47.6410086568205,-122.13334039023833 47.64144150986729,-122.13403149305233 47.64136608877112))', 4326)

-- A point you want to check
declare @p as geography = geography::STPointFromText('POINT(-122.13315058040392 47.64101193601368)', 4326)

-- Is the point within the perimeter?
select @p.STWithin(@bldg44)
```

Because text format for the locations (for example, `POINT(-122.13315058040392 47.64101193601368)`) is a standard known as Well-Known Text (WKT) format, it's possible to see the shape projected on a map just by copying and pasting the string. In the next exercise, you'll test it yourself with the [OpenStreetMap WKT Playground](https://clydedacruz.github.io/openstreetmap-wkt-playground/).
