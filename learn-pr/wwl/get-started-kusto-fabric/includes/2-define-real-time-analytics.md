
Real-time data analytics is commonly based on the ingestion and processing of a data *stream* that consists of a perpetual series of data, typically related to specific point-in-time events. For example, a stream of data might contain details of messages submitted to a social media micro-blogging site, or a series of environmental measurements recorded by an internet-connected weather sensor.

The data in the stream can be used to create real-time visualizations of the data for monitoring purposes or to trigger automated actions if certain conditions occur. For example, a stream of data from an environmental control sensor in an office building might enable heating and air conditioning systems to be controlled dynamically to optimize comfort and cost. The data can also be persisted in a data store and queried later, enabling analysts to better understand change over time. For example, a marketing organization may perform sentiment analysis on social media messages to see if an advertising campaign results in more positive comments about the company or its products, or an agricultural business might monitor trends in temperature and rainfall to optimize irrigation and crop harvesting.

Common goals for real-time analytics include

- Continuously analyzing data to report issues or trends.
- Understanding component or system behavior under various conditions to help plan future enhancements.
- Triggering specific actions or alerts when certain events occur or thresholds are exceeded.

### Characteristics of real-time data analytics solutions

Stream processing solutions for real-time data analytics typically exhibit the following characteristics:

![Diagram showing a stream of data being processed, aggregated by day, and visualized and stored.](../media/stream-processing.png)

1. A data stream is *unbounded* - data is added to the stream perpetually.
2. Data records in the stream typically include *temporal* (time-based) data indicating when the event to which the record relates occurred (or was recorded).
3. Aggregation of streaming data is often performed over temporal *windows* - for example, recording the number of social media posts per minute or the average rainfall per hour.
4. The results of streaming data processing can be used to support real-time (or *near* real-time) automation or visualization, or persisted in an analytical store to be combined with other data for historical analysis. Many solutions combine these approaches to support both real-time and historical analytics.

Microsoft Fabric's Real-Time Intelligence capabilities enable you to implement real-time analytics solutions that include the features described here with minimal (or no) coding effort and integration into the rest of the Microsoft Fabric ecosystem.