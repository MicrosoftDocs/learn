Monitoring is the process of collecting system data and metrics that determine if a system is healthy and operating as expected. Monitoring exposes errors that occurred and when they happened. To investigate issues and remediate errors, historical data is analyzed to get a picture of the health of a system or process. 

## Monitoring Fabric activities
In Fabric, you schedule activities and jobs that perform tasks like data movement, and transformation. Activities have dependencies on one another. You need to make sure that data arrives in its expected location on time and that system errors or delays don't affect users or downstream activities. End-to-end processes need to be managed to ensure they're reliable, performant, and resilient. One aspect of this monitoring is identifying and handling long-running operations and errors effectively. By doing this, you can minimize downtime and quickly address any underlying issues.  

The following activities in Fabric allow you to perform tasks that deliver data to users. These activities should be monitored:

- **Data pipeline activity** - A data pipeline is a group of activities that together perform a data ingestion task. Pipelines allow you to manage, extract, transform, and load (ETL) activities together instead of individually. Monitor the success or failure of jobs and pipeline activities. Look for errors if the pipeline failed. View job history to compare current activity performance to past job execution performance to gain insight into when errors were first introduced into a process. 

- **Dataflows** - A dataflow is a tool for ingesting, loading, and transforming data using a low-code interface. Dataflows can be run manually or scheduled or run as part of pipeline orchestration. Monitor start and end times, status, duration, and table load activities. To investigate issues, drill down into activities and view information about errors.  

- **Semantic model refreshes** - A semantic model is a visual representation of a data model that's ready for reporting and visualization. It contains transformations, calculations, and data relationships. Changes to the data model require the semantic model to be refreshed. Semantic models can be refreshed from data pipelines using the *semantic model refresh* activity. Monitor for refresh retries to help identify transient issues, before classifying an issue as a failure.

- **Spark jobs, notebooks and lakehouses** - Notebooks are an interface for developing Apache Spark jobs. Data can be loaded, or transformed for lakehouses using Spark and notebooks.  Monitor Spark job progress, task execution, resource usage, and review Spark logs. 

- **Microsoft Fabric Eventstreams** - Events are observations about the state of an object, like a timestamp for weather sensors. Eventstreams in Fabric are set up to run perpetually to ingest real-time or streaming events into Fabric and transform them for analytics needs, and then route them to various destinations.  Monitor streaming event data, ingestion status, and ingestion performance.

## Monitoring best practices
Continuously monitor the data ingestion, transformation, and load processes to ensure they're running smoothly. Monitoring best practices include:

- **Identifying what to monitor** and tracking metrics.
- **Collecting and analyzing data on a regular basis** to identify normal behavior so you can spot anomalies when they occur.
- **Reviewing logs and metrics regularly** to identify and establish parameters for normal system behavior.
- **Taking action** to resolve problems when metrics and logs show deviations from normal behavior.
- **Optimizing performance** by using monitoring data to identify bottlenecks or performance issues.  
