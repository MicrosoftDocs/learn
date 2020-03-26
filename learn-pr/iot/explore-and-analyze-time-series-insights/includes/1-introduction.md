Internet of Things (IoT) devices are usually generating a massive volume of data to analyze. 
A decent part of them are time sensitive. Even if you can store them in a traditional SQL
database, time-series databases are better suited for this type of data.

## What is Time Series Insights?

Azure Time Series Insights is a managed service that allows to store, visualize, and query a large amount of time series data.

Time Series Insights has four key jobs:

- It's fully integrated with cloud gateways like Azure IoT Hub and Azure Event Hubs. It easily connects to these event 
sources and parses JSON from messages and structures that have data in clean rows and columns. It joins metadata with 
IoT device-generated data, and then indexes your data in a columnar store.
- Time Series Insights manages the storage of your data. It can store your data in memory for warm data and storage account for cold data. You can interactively query billions of events in seconds–on demand.
- Time Series Insights provides integrated visualization through the Time Series Insights explorer. 
- Time Series Insights provides a query service, both in the Time Series Insights explorer and by using APIs that are 
easy to integrate to embed your time series data into custom applications.

## Learning objectives

In this module, you will:

- Create an IoT Hub and generating data from simulated devices
- Create a Time Series Insights (TSI) Environment
- Connect to IoT Hub with Time Series Insights (TSI)
- Use Ad Hoc queries to gain insights
- Configure a data model

## Prerequisites

- An introductory knowledge of Azure IoT
- Basic understanding of the Azure CLI tool from the **Control Azure services with the CLI** module.
- Ability to use C#, at the beginner level (all the code will be written).

## Learn the scenario

Suppose you work for Contoso, now offering a solution to maintain and monitor cheese caves' temperature and humidity at optimal levels. You have been working with gourmet cheese making companies for a long time and established long-term trust with these customers who value the quality of your product.
You've rolled out their "Asset Condition Tracking System" that monitors the environmental conditions of cheese containers during shipment.

Your team decides that further improvements to the monitoring system will require near real-time data exploration and root-cause analysis.

## What you will do in this module

In the following units you'll go through these steps:

- Set up an Azure IoT environment and execute code simulating the devices.
- Set up a Time Series Insights environment and collect data from IoT Hub.
- Create ad-hoc queries to explore data available

> [!NOTE]
> This module is targeting _Azure Time Series Insights Preview_. We will closely monitor 
> the release of this version and update the content of this module accordingly.
> Meanwhile, do not hesitate to report an issue with the link at the bottom of the page.
