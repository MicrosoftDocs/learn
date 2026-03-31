As organizations generate increasing volumes of event-driven data, the ability to process, analyze, and act on data in motion becomes essential for competitive advantage. Real-Time Intelligence provides comprehensive capabilities for working with streaming data with minimal latency.

## Explore Real-Time Intelligence use cases

Unlike batch systems that process data on scheduled intervals, Real-Time Intelligence helps you respond to events as they happen, delivering near real-time insights.

Here are some common types of event data and examples of how Real-Time Intelligence can support downstream actions and business responsiveness:  

- **Delivery tracking**: Monitor vehicle locations to alert customers when packages are delayed
- **Equipment monitoring**: Track machine temperature to prevent costly breakdowns  
- **Fraud detection**: Analyze purchase patterns to block suspicious transactions immediately
- **Website performance**: Monitor page load times to improve user experience
- **System health**: Track application errors to maintain service reliability

## Real-Time Intelligence components

Microsoft Fabric's Real-Time Intelligence is an integrated set of components that work together to handle streaming data from capture through automated response.

:::image type="content" source="../media/real-time-intelligence-core.png" alt-text="Diagram of Fabric Real-Time Intelligence capabilities." lightbox="../media/real-time-intelligence-core.png":::

The diagram shows how Real-Time Intelligence components work together for end-to-end processing. Each component handles a specific stage of the real-time analytics process:

## Ingest and process data in motion with Eventstreams

Data ingestion and processing can happen through **Eventstreams**, which capture streaming data from various sources and apply real-time transformations as data flows through the system. Eventstreams can filter, enrich, and transform your data and route it to different destinations.

## Store real-time data in an Eventhouse

Real-Time Intelligence stores data in KQL (Kusto Query Language) databases in **Eventhouses**. These databases are designed for time-series data and fast ingestion of streaming data. The storage integrates with OneLake, making your data available to other Fabric tools.

## Analyze data with KQL Queryset

**KQL Queryset** provides a workspace for running and managing queries against KQL databases. The KQL Queryset allows you to save queries for future use, organize multiple query tabs, and share queries with others for collaboration. The KQL Queryset also supports T-SQL queries, allowing you to use familiar SQL syntax alongside KQL for data analysis.

## Visualize insights with Real-Time Dashboard

**Real-Time Dashboards** connect directly to KQL databases and refresh automatically as new data arrives. These dashboards let you explore data interactively and monitor both current conditions and historical trends.

## Act on data with Activator

Automated actions can be configured with **Activator**, which continuously monitors streaming data against user-defined rules and thresholds. When conditions are met, Activator can send notifications, trigger workflows in Power Automate, execute Fabric data pipelines or notebooks, creating event-driven automation that responds to real-time conditions.

## Discover streaming data with the Real-Time hub

The Fabric **Real-Time hub** is a central location where you can discover and manage all of the data-in-motion that you have access to. It gives you a way to ingest streaming data from Azure and from external sources and it lets you subscribe to Azure and Fabric events.

Think of the Real-Time hub as your streaming data catalog where you can see what's happening in near real-time across your organization. There are connectors you can use to ingest data into Microsoft Fabric from various sources. For example, you might connect to IoT sensor streams through Azure Event Hubs, subscribe to Azure Blob Storage events, use Change Data Capture (CDC) to stream database changes, or monitor Fabric workspace events.

Once you have configured a connection to data source or event source, these items become the foundation for event driven decision making and a wide range of real-time analytics solutions, from building dashboards and setting up alerts to triggering automated workflows and analyzing trends in your data.

:::image type="content" source="../media/real-time-hub.png" alt-text="Screenshot of Microsoft Fabric Real-Time hub." lightbox="../media/real-time-hub.png":::

To access the real-time hub, select the **Real-Time** icon in the main Fabric menu bar.

The real-time hub organizes data-in-motion into several main categories:

- **Data sources**: Browse and connect to available streaming data sources, such as Microsoft sources, database change data capture feeds, and external sources from other cloud providers
- **Azure sources**: Discover and configure Azure streaming data sources such as Azure IoT Hub, Azure Service Bus, Azure Data Explorer DB, and more
- **Fabric events**: Subscribe to system-generated events in Fabric that you can access, like job status changes, events produced by action on files or folders in OneLake, and Fabric workspace item changes
- **Azure events**: Subscribe to system events from Azure services that can be used to trigger automated responses such as actions on files or folders in Azure blob storage

In the Real-Time hub, you can preview and explore your streaming data by navigating directly to eventstreams or KQL databases in eventhouses for deeper analysis and querying. You can also build automated responses using *Activator* rules that trigger actions like notifications, workflows, or data processing when specific patterns are detected.