Here, we discuss how you can decide whether Azure Data Explorer is the right choice for your big data analytics needs. By assessing the following criteria, you can determine whether Azure Data Explorer meets your performance and functional goals.

- Interactive analytics
- Data variety
- Data velocity
- Data volume
- Data organization
- Query concurrency
- Build vs Buy

## Decision criteria

Azure Data Explorer is a big data interactive analytics platform that empowers people to make data-driven decisions in a highly agile environment. The factors listed here can help you assess if Azure Data Explorer is a good fit for the workload at hand. Ask yourself the following key questions:

### Interactive analytics

*Do I need to analyze data interactively?*

Data analysis includes techniques like aggregation, scoping, assessment, correlation, anomaly detection, forecasting, and general model evaluation that help reduce large amounts of data into actionable conclusions. Conducting such activities interactively is what Azure Data Explorer is about. These activities can happen in Interactive dashboards, analytical custom application or via direct interaction with data via human friendly queries and visualization. Azure Data Explorer may not be the right technology for executing long-running batch jobs over data. Consider using technologies like Microsoft Spark that work well with Azure Data Explorer for long running tasks.

### Data variety

*How varied is my data structure?*

Azure Data Explorer provides scalable high-performance full text index and dynamic schema support. If you need to analyze and process structured, semi structured (json/xml) and textural data it's a good indication that Azure Data Explorer is relevant for your workload.

### Data velocity

*Is real-time data analysis a critical factor?*

Azure Data Explorer can ingest massive amount of data quickly and in low latency. Typical data sets include traces, transaction logs, time series, metrics and in general, activity record streams. Near real-time analytics over fresh data is a common use case. Azure Data Explorer connects well to streaming technologies like Azure Event Hubs, IoT hubs, Kafka to power such workloads. However, in case there's a need for real-time analytics, Azure Data Explorer may not be the best option.

### Data volume

*How much data do I need to ingest?*

Azure Data Explorer is built to provide warm path analytics, interactive and via API, over massive data workloads. For scenarios where total accumulated data size is a few gigabytes, there may be other more cost-efficient solutions.

### Data organization

*How consistently is my data organized?*

Azure Data Explorer is built to apply schema-on-read over raw data. This approach creates flexibility to examine data in different ways and from different viewpoints based on current needs. This capability is valuable for dealing with unexpected challenges in security, operations, and competitive environments among other areas. Azure Data Explorer provides extreme speed, scalability, and cost efficiency for analyzing raw data. Often in data warehousing deployments, an extract, transform, load (ETL) process periodically generates a well curated, highly consistent, and well documented set of entities and attributes. Analytics over these complex star schemas usually involve large fact-to-fact-to-fact joins that Azure Data Explorer isn't optimized for.

### Query concurrency

*How many users need to query/ingest/process data at the same time?*

Azure Data Explorer is broadly used for implementing analytics SaaS offerings. If there's a need to support varying and unique analytics needs from a large number of requests in parallel, Azure Data Explorer should provide a good solution.

### Build vs buy

*How much do I want to customize my data platform?*

Azure Data Explorer is a fully managed platform as a service. However, it doesn't provide a turnkey solution out of the box. It does require customizing, configuring, connecting, and creating experiences on top of it to deliver a solution (build). There are various solutions, from Microsoft and third parties that use Azure Data Explorer to deliver such turnkey solutions in different domains and verticals. For example, Azure Monitor for IT operations. Microsoft Advanced Threat Protection and Microsoft Sentinel in the security domain, and Azure Time Series Insights and Azure IoT Central in the IoT domains.

## Apply the criteria

Azure Data Explorer works best for enabling interactive analytics capabilities to knowledge workers over high velocity, diverse raw data. Let's think about how to apply the criteria we listed earlier to our example processes in the clothing company scenario.

### Should Azure Data Explorer be used for production data?

The production department of our example clothing company needs to make decisions about how to manage inventory and production volumes. They have incoming logs of data for inventory. They also want to use geospatial data from marketing to anticipate product needs by region. This data has a high degree of *variety*, *velocity*, and *volume*. It's not *organized* consistently, and many stakeholders need to *concurrently* query this data. From ingestion to query, they require *low latency*. They need query response times of less than a second and up.
Based on the decision criteria, Azure Data Explorer is a good fit for the production division of the clothing company.

### Should Azure Data Explorer be used for marketing data?

The clothing company marketing department wants to evaluate the effectiveness of their campaign. They have clickstream data from their website and ad campaigns. They also have free text (unstructured) data from social media. This data is highly *varied* and *unorganized*. The department is going to want to do exploratory *interactive analytics*.
Based on the decision criteria, Azure Data Explorer is a good fit for the marketing division of the clothing company.

## Guidance summary

The following table shows how to evaluate new use cases. While all use cases aren't covered here, we think it can help you decide whether Azure Data Explorer is the right solution for you.

| **Use case**| **Interactive Analytics** | **Big data (Variety, Velocity, Volume)** | **Data organization** | **Concurrency** | **Build vs Buy** | **Should I use Azure Data Explorer?**|
|---|---|---|---|---|---|---|
| **Implementing a Security Analytics SaaS** | Heavy use of interactive, near real-time analytics. | Security data is diverse, high volume and high velocity. | Varies | The system is often used by multiple analysts from multiple tenants. | Implementing a SaaS offering is a **Build** scenario. | Yes |
| **CDN log analytics** | Interactive for troubleshooting, QoS monitoring. | CDN logs are diverse, high volume and high velocity. | Separate log records. |A small group of data scientists may use these analytics but it may also power many dashboards. | The value extracted from CDN analytics is scenario-specific and requires custom analytics. | Yes |
| **Time series database for IoT Telemetry** | Interactive for troubleshooting, analyzing trends, usage, and detecting anomalies. | IoT telemetry is high velocity but may be structured only or medium in size. | Related sets of records. | A small group of data scientists may use these analytics but it may also power many dashboards. | The context is typically **Build** when searching for a database. | Yes |

The following flowchart table summarizes the key questions to ask when you're considering using Azure Data Explorer.

:::image type="content" source="../media/when-to-use-adx.png" alt-text="Flowchart showing when to use Azure Data Explorer. Questions include: do you need to read and write a specific record, do you need to perform long running tasks, classic data warehouse, must run on other clouds, and small data.":::
