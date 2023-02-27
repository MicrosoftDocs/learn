Azure Event Hubs is a big-data streaming platform and event ingestion service. It can ingest data from various sources and distribute it to multiple systems and Azure services.

You can think of Event Hubs as an *event ingestor* and a *front door for event pipelines*. It provides a unified streaming platform to take data from wherever it’s created, to where you need it go – whether that’s for analytics, transaction processes, archiving data, or more. To get the most out of your data, you can seamlessly integrate Event Hubs with other Azure and Microsoft services, such as Stream Analytics, Power BI, and Event Grids. Or, you can use Event Hubs along with outside services like Apache Spark.

As an example use-case scenario, consider a home security company that monitors 100,000 homes. Each home has various sensors – such as a motion-detectors, door/window open sensors, and glass break detectors. These devices report back to a common server. The server logs events, sounds an alarm if a threshold number of events occurs, and allows customers to monitor their home from a user-friendly web page. You could implement this system with direct communication between devices and the server, though the server may be prone to overloading at certain times of day and any downtime can result in lost sensor messages. A direct integration may also lead to a non-modular design that impedes future attempts to improve the platform. Consider this example scenario throughout our discussion of Event Hubs.

## Prerequisites

- A basic familiarity with Azure.

## Learning objectives

In this module, you will:

- Describe what Event Hubs is.
- Assess the benefits of Event Hubs.
- Define scenarios where you can apply Event Hubs.
