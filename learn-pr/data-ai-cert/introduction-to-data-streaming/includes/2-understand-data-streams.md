In the context of analytics, data streams are the data pertaining to the occurrence of specific activities that are emitted by applications, IoT devices or sensors, or other sources known as data producers. These perpetually generated data streams typically contain temporal and additional information about the events. The proliferation of connected applications and devices has led to exponential growth in the number of streaming data sources in recent years.

Data streams are most often used to better understand change over time. For example, an organization may perform sentiment analysis on tweets to see if an advertising campaign results in more positive comments about the company or its products.

## Analyzing data streams 

In today's world, data streams are ubiquitous. Analyzing a data stream is typically performed to measure how an event's state changes over time or to capture information on an area of interest. The intent being to:

- Continuously analyze data to detect issues and understand or respond to them
- Understand component or system behavior under various conditions to fuel further enhancements of that component or system
- Trigger specific actions or alerts when certain thresholds are hit

By analyzing data streams and extracting actionable insights, companies can harness latent knowledge to improve efficiencies, further innovation, and respond to irregularities. Examples of use cases that analyze data streams include:

:::row:::
    :::column:::
- Stock market trends
- Monitoring data of water pipelines and electrical transmission and distribution systems by utility companies
- Mechanical component health monitoring data in automotive and automobile industries
- Monitoring data from industrial and manufacturing equipment
    :::column-end:::
    :::column:::
- Sensor data in transportation, such as traffic management and highway toll lanes
- Patient health monitoring data in the healthcare industry
- Satellite data in the space industry
- Fraud detection in the banking and finance industries
- Sentiment analysis of social media posts
    :::column-end:::
:::row-end:::

## Approaches to data stream processing

There are two approaches to processing data streams: live and on-demand.

The most commonly adopted method for processing data streams is to analyze new data continuously as it arrives from an event producer, such as Azure Event Hubs. This "live" approach requires more processing power to run computations but offers the ability to gain near-real-time insights. Using a service like Azure Stream Analytics, you can execute calculations and aggregations against arriving data using temporal analysis. The results of those queries can be sent to a Power BI dashboard for real-time visualization and analysis.

The diagram below depicts an end-to-end "live" data stream processing solution using Event Hubs to ingest streaming data, Azure Stream Analytics to transform data, and Power BI to visualize and analyze it.

![The diagram depicts an end-to-end solution using Event Hubs to ingest streaming data, Azure Stream Analytics to transform the data, and Power BI to visualize and analyze it.](../media/data-stream-processing-live.png "Live data stream processing")

The "on-demand" approach for processing streaming data involves persisting all incoming data in a data store, such as [Azure Data Lake Storage (ADLS) Gen2](/azure/storage/blobs/data-lake-storage-introduction). This method allows you to collect streaming data over time and store it as static data. You can then process the _static_ data in batches when convenient or during times when compute costs are lower.

The following diagram illustrates an on-demand data stream processing solution. Streaming data from Azure Event Hubs and IoT Hub are written as blobs into Azure Data Lake Storage (ADLS) Gen2. The static data are then processed using Azure Stream Analytics and output to a Power BI dashboard for visualization and analysis.

![The diagram illustrates an on-demand data stream processing solution. Streaming data from Azure Event Hubs and IoT Hub are written as blobs into Azure Data Lake Storage (ADLS) Gen2. The static data are then processed using Azure Stream Analytics and output to a Power BI dashboard for visualization and analysis.](../media/data-stream-processing-on-demand.png "On-demand data stream processing")
