As organizations generate increasing volumes of event-driven data, the ability to process, analyze, and act on data in motion becomes essential for competitive advantage. Real-Time Intelligence provides comprehensive capabilities for working with streaming data with minimal latency.

## Real-Time Intelligence use cases

Unlike batch systems that process data on scheduled intervals, Real-Time Intelligence helps you respond to events as they happen, delivering near real-time insights.

Here are some common types of event data and examples of how Real-Time Intelligence can support downstream actions and business responsiveness:  

- **Vehicle location data**: Monitor location streams and detect route deviations to enable delivery optimization systems
- **Equipment sensor data**: Analyze temperature, pressure, and vibration patterns to support predictive maintenance programs  
- **Transaction data**: Process spending patterns in real-time to feed fraud detection and account security systems
- **Application performance metrics**: Track response times and error rates to inform autoscaling and system management decisions
- **Infrastructure monitoring data**: Monitor health metrics to support automated system management and resource provisioning

## Real-Time Intelligence Components

Microsoft Fabric's Real-Time Intelligence is an integrated set of components that work together to handle streaming data from capture through automated response.

![Diagram of Fabric Real-Time Intelligence capabilities.](../media/real-time-intelligence-core.png)

The diagram shows how Real-Time Intelligence components work together for end-to-end processing. Each component handles a specific stage of the real-time analytics process:

## Ingest and process data in motion with Eventstreams

Data ingestion and processing happen through Eventstreams, which capture streaming data from various sources and apply real-time transformations as data flows through the system. The Real-Time Hub acts as the central catalog where you can discover available data sources and configure connections without writing code. Eventstreams provide comprehensive data processing capabilities including filtering to remove unwanted events, enrichment to add contextual information, format conversion between different data structures, and content-based routing to send processed data to different destinations based on business rules.

## Store real-time data in an Eventhouse

Storage in Real-Time Intelligence centers on Eventhouses, which contain KQL (Kusto Query Language) databases optimized for time-series data and high-velocity ingestion. These databases automatically index incoming data by ingestion time and partition it for optimal query performance across massive datasets. The storage layer integrates with OneLake, making the data available to other Fabric workloads and ensuring consistency across the analytics platform.

## Analyze data with KQL Queryset or T-SQL

Analysis capabilities come through direct querying of KQL databases using the Kusto Query Language, which excels at time-based analytics and pattern detection in streaming data. You can build complex analytical queries that process large volumes of events in seconds, enabling both ad-hoc exploration and systematic analysis of streaming patterns. KQL databases also support T-SQL queries within the KQL Queryset interface, allowing you to use familiar SQL syntax alongside KQL for data analysis.

## Visualize insights with Real-Time Dashboards

Visualization occurs through Real-Time Dashboards, which connect directly to KQL databases and refresh automatically as new data arrives. These dashboards support interactive exploration with parameters and drill-down capabilities, allowing you to monitor current conditions and explore historical trends within the same interface.

## Act on data with Activator

Automated actions are handled by Activator, which continuously monitors streaming data against user-defined rules and thresholds. When conditions are met, Activator can send notifications, trigger workflows in Power Automate, call webhooks, or execute other Fabric jobs, creating event-driven automation that responds to real-time conditions without human intervention.

## Discover streaming data with the Real-Time Hub

The Fabric Real-Time hub is a central location where you can discover and manage all of the data-in-motion that you have access to. It gives you a way to ingest streaming data from Azure and from external sources and it lets you subscribe to Azure and Fabric events.

Think of the Real-Time hub as your streaming data catalog where you can see what's happening in near real-time across your organization. There are connectors you can use to ingest data into Microsoft Fabric from various sources. For example, you might connect to IoT sensor streams through Azure Event Hubs, subscribe to Azure Blob Storage events, use Change Data Capture (CDC) to stream database changes, or monitor Fabric workspace events.

Once you have configured a connection to data source or event source, these items become the foundation for event driven decision making and a wide range of real-time analytics solutions, from building dashboards and setting up alerts to triggering automated workflows and analyzing trends in your data.

![Screenshot of Microsoft Fabric Real-Time hub.](../media/real-time-hub.png)

To access the real-time hub, select the **Real-Time** icon in the main Fabric menu bar.

The real-time hub organizes data-in-motion into several main categories:

- **Data sources**: Browse and connect to available streaming data sources, such as Microsoft sources, database change data capture feeds, and external sources from other cloud providers
- **Azure sources**: Discover and configure Azure streaming data sources such as Azure IoT Hub, Azure Service Bus, Azure Data Explorer DB, and more
- **Fabric events**: Subscribe to system-generated events in Fabric that you can access, like job status changes, events produced by action on files or folders in OneLake, and Fabric workspace item changes
- **Azure events**: Subscribe to system events from Azure services that can be used to trigger automated responses such as actions on files or folders in Azure blob storage

In the Real-Time hub, you can preview and explore your streaming data by navigating directly to eventstreams or KQL databases in eventhouses for deeper analysis and querying. You can also build automated responses using *Activator* rules that trigger actions like notifications, workflows, or data processing when specific patterns are detected.