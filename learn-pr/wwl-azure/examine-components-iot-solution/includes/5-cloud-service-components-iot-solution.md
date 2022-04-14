Cloud services are an essential component of your IoT solution. The sections below identify four service categories and describe where each fits within an overall IoT solution architecture.

## Cloud gateways

A cloud gateway enables you to manage your IoT devices and brokers the communication with other cloud services. Cloud gateways can provide workloads such as (among others):

 -  Authentication and authorization.
 -  Message brokering.
 -  Data storage and filtering.
 -  Data analytics.
 -  Functions (discrete code blocks that perform specific tasks).

:::image type="content" source="../media/m01-l03-cloud-gateway-6a9bb3cb.png" alt-text="Diagram that shows a Cloud Gateway as the central hub within a communication workflow that includes devices and other business services.":::


## Data storage options

Given the centrality of data in an IoT solution, figuring out the right cloud-based data storage and retrieval options ranks high on the list in terms of importance. IoT devices can generate enormous amounts of data quickly and storing high volumes of data in the cloud cannot become expensive but also unwieldy--you have to be able to do something with the data and too much of it can make analytics and decision-making harder.

Cloud service providers are continually updating their data services to make it easier and more cost-effective for organizations to store, manage, and analyze data. Even so, a thorough analysis of cloud storage technical options and prices should be a fundamental part of any IoT architecture. For example, some architectures may demand a multi-tiered approach with some data being stored on the device, other stored in on-premise databases and other data stored in the cloud. Depending on the needed architecture, you should be sure the cloud services you choose supports your need.

Here are some other concepts to be aware of when considering cloud storage.

Data is often time-series data that must be stored where it can be used in visualization and reporting, in addition to being accessed at a later time for more processing. It is common to have data split into “warm” and "cold" data stores. The **warm data store** holds recent data that needs to be accessed with low latency. Data stored in **cold storage** is typically historical data. Most often the cold storage database solution chosen will be cheaper in cost but offer fewer query and reporting features than the warm database solution.

> [!NOTE]
> The Lambda architecture for data storage going to warm and cold storage is introduced later in this course.

A common implementation for storage is to keep a recent range (for example, the last day, week, or month) of telemetry data in warm storage and to store historical data in cold storage. With this implementation, the application has access to the most recent data and can quickly observe recent telemetry data and trends. Retrieving historical information for devices can be accomplished using cold storage, generally with higher latency than if the data were in warm storage.

:::image type="content" source="../media/m01-l03-warm-cold-storage-68f98297.png" alt-text="Diagram that shows warm and cold storage options for an IoT solution.":::


Cloud service providers may provide services to support both types of storage and make managing data across these types easier.

You can read more about the warm and cold storage technologies that Microsoft Azure provides in section 3.5 of the [Azure Reference Architecture document](https://aka.ms/iotrefarchitecture).

## Analytics services and data visualization

Data analytics services are often supported with data visualizations. Visualizations can be included in reports and placed on dashboards. A good visualization can communicate important information quickly.

### Analytics

Data that is captured and stored only becomes useful when it provides insights into the world where that data came from. The need to generate insights is where analytic services come into play.

Analysis services enable architects to use advanced mashup and modeling features to combine data from multiple data sources, define metrics, and secure data in a single, trusted tabular semantic data model. The data model provides an easier and faster way for users to browse massive amounts of data for ad-hoc data analysis.

Without analytics, data collected from IoT would be too voluminous and unstructured to visualize or gain insights. Analytic services enable architects to build meaningful relationships between sets of data in order to make it easier to manage. For example, Azure Stream Analytics can take stream data from IoT devices and engineers can specify a transformation query that defines how to look for data, patterns, or relationships. The transformation query uses a SQL-like query language that is used to filter, sort, aggregate, and join streaming data over a period of time.

:::image type="content" source="../media/m01-l03-stream-analytics-6fbeccae.png" alt-text="Diagram that shows Azure Stream Analytics communicating with various services in an IoT solution.":::


### Data visualization

Stream analytics can help condition data so it's easier to manage and provides models that give insight into what you need to understand or learn. Once the data is conditioned and you've created the right models, the data can be visualized using tools like Microsoft's Time Series Insights or Power BI so that it can be acted upon.

Data visualization tools can take input from various data streams and combine them into "dashboards" that can be used to tell a story about the data that was collected. Ultimately, getting more out of your data is the goal of IoT.

:::image type="content" source="../media/m01-l03-data-visualization-59248749.png" alt-text="Diagram that shows various data sources connecting to Power BI for data visualizations.":::


## Machine learning

Machine learning (ML) is one of the more exiting developments in modern computer science. It's a complex field but one that is producing significant positive results with large datasets. IoT devices produce large volumes of data. Analytic systems help engineers to model the existing data in meaningful ways. Machine learning takes this process a step further and can actually make predictions about what new data will show and provide insights that would not be possible without the machine learning algorithms.

As the name states, the technology gives computers the ability to "learn" (predict) from data by expressing trends or a direction future data will take. This technology can provide engineers with a powerful mechanism for enabling a wide variety of scenarios.

Using big data and machine learning to predict purchasing decisions is one simple example. Suppose a retailer has warehouse space in various cities and needs to determine which items to stock in those cities in order to be able to get products to customers in the most efficient and timely way. Using machine learning the retailer can predict, for example, that a given set of users that purchase a specific television tend to buy a particular type of cable and other accessories like tv stands and audio equipment. This would allow the retailer to keep those items in the warehouse near where those television sales are popular so that if a customer orders the cable or other accessory, the item can be shipped more and get to the customer more quickly.

Can you think of other, IoT-specific scenarios where machine learning would help enabling various scenarios that can make the IoT architecture more effective?

Because of the tremendous amount of computer power needed to perform the calculations needed to do this type of analysis, cloud-based ML technology tends to be the most effective at providing the type of insights machine learning promises.
