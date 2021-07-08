Azure Event Hubs is a big-data streaming platform and event ingestion service. Data can be ingested from a variety of sources and distributed to multiple systems and Azure services.

Event Hubs is often called an ‘event ingestor’ and a ‘front door for event pipelines.’ Event Hubs provides a unified streaming platform to take data from wherever it’s created, to where you need it go – whether that’s for analytics, transaction processes, archiving data, or more. Event Hubs can be seamlessly integrated with other Azure and Microsoft services, such as Stream Analytics, Power BI and Event Grids, along with outside services like Apache Spark, to get the most out of your data.

As an example use-case scenario, consider a home security company that monitors 100,000 homes. Each home has a variety of sensors – such as a motion-detectors, door/window open sensors, and glass break detectors. These devices report back to a common server, which logs events, sounds an alarm if a threshold number of events occurs, and allows customers to monitor their home from a user-friendly web page. This system could be implemented with direct communication between devices and the server, though the server may be prone to overloading at certain times of day and any downtime can result in lost sensor messages. A direct integration may also lead to a non-modular design that impedes future attempts to improve the platform. As an example, we'll refer to this scenario throughout our discussions of Event Hubs.


## Prerequisites

* A basic familiarity with Azure

## Learning objectives

In this module, you will:

* Assess the benefits of Event Hubs
* Describe what Event Hubs is
* Define scenarios where Event Hubs can be applied
