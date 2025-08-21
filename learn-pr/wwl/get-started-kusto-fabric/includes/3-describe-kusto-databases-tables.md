Fabric's Real-Time Intelligence solution provides an end-to-end streaming solution for real-time data analysis across the Fabric service.

Real-Time Intelligence delivers high performance for data of various sizes, ranging from a few gigabytes to several petabytes. It can handle data from different sources and in various formats. Fabric's Real-Time Intelligence workload can be used for solutions like IoT and log analytics in many scenarios including manufacturing, oil and gas, and automotive.

 ![Diagram of Fabric Real-Time Intelligence capabilities.](../media/real-time-intelligence-core.png)

Using the Microsoft Fabric Real-Time Intelligence, you can:

- Create an *eventstream* to capture, transform, and ingest real-time data from various streaming sources.
- Store captured real-time data in an *eventhouse*, which includes one or more *KQL databases*.
- Query and analyze data in the eventhouse by using KQL queries, organized in a *KQL queryset*.
- Visualize real-time data in a *real-time dashboard* or by using Power BI.
- Configure alerts that use *Activator* to trigger automated actions.

## The Fabric real-time hub

The Fabric Real-Time hub is a central location where you can discover and manage all of the data-in-motion that you have access to. It gives you a way to ingest streaming data from Azure and from external sources and it lets you subscribe to Azure and Fabric events.

Think of the Real-Time hub as your streaming data catalog where you can see what's happening in near real-time across your organization. There are connectors you can use to ingest data into Microsoft Fabric from a variety of sources. For example, you might connect to IoT sensor streams through Azure Event Hubs, subscribe to Azure Blob Storage events, use Change Data Capture (CDC) to stream database changes, or monitor Fabric workspace events.

Once you have configured a connection to data source or event source, these items become the foundation for event driven decision making and a wide range of real-time analytics solutions, from building dashboards and setting up alerts to triggering automated workflows and analyzing trends in your data.

![Screenshot of Microsoft Fabric Real-Time hub.](../media/real-time-hub.png)

To access the real-time hub, select the **Real-Time** icon in the main Fabric menu bar.

The real-time hub organizes data-in-motion into several main categories:

**Data sources:** Browse and connect to available streaming data sources, such as Microsoft sources, database change data capture feeds, and external sources from other cloud providers
**Azure sources:** Discover and configure Azure streaming data sources such as Azure IoT Hub, Azure Service Bus, Azure Data Explorer DB, and more
**Fabric events:** Subscribe to system-generated events in Fabric that you can access, like job status changes, events produced by action on files or folders in OneLake, and Fabric workspace item changes
**Azure events:** Subscribe to system events from Azure services that can be used to trigger automated responses such as actions on files or folders in Azure blob storage

In the Real-Time hub, you can preview and explore your streaming data by navigating directly to eventstreams or KQL databases in *eventhouses* for deeper analysis and querying. You can also build automated responses using *Activator* rules that trigger actions like notifications, workflows, or data processing when specific patterns are detected.