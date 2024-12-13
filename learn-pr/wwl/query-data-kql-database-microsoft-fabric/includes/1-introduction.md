An *eventhouse* in Microsoft Fabric provides a data store for large volumes of data. An eventhouse is optimized for data that represents time-based events, as is common in real-time data analytics scenarios. They're designed to handle real-time data streams efficiently, which enables organizations to query and analyze data in near real-time.

It's common in Microsoft Fabric to use an *eventstream* to load a stream of real-time data into an eventhouse. You can then:

- Query the data using Kusto Query Language (KQL) or a subset of Structured query Language (SQL) in a *KQL Queryset*.
- Use *Real-Time Dashboards* to visualize the data.
- Use *Fabric Activator* to automate actions based on the data.

An eventhouse is the Fabric data store at the center of all of these capabilities.

![Diagram of Real-Time Intelligence components in Microsoft Fabric.](../media/real-time-intelligence-core.png)
