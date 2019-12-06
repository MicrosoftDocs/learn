
Taking a first step into building an Azure IoT app, even a short test app, is going to require you to think about your storage options. If you are new to Azure, the range of resources available can be bewildering. This module introduces the architectural concepts of IoT, and how they relate to cloud storage. The most common storage options are described at a high level. You will not be asked to do any coding, nor build an app using the portal. To complete the module you'll have to read the units, and pass a few knowledge checks along the way!

The purpose of this module is to give you enough background info about Azure storage for IoT, that you will be able to make an informed decision when you do build your first IoT app.

## Learning objectives

In this module you will:

- Learn about the hybrid lambda architecture of IoT
- Learn when to use blob storage, and data lake storage
- Learn when to create a Cosmos DB database
- Learn the basics of Time Series Insights

## Prerequisites

- An introductory knowledge of Azure IoT

## Learn the basics of Azure IoT

The concept of the Internet of Things (IoT) is that one or more, could be thousands, of remote sensor devices are pumping out telemetry values. These values are being received by an IoT Hub, an Azure resource designed to handle telemetry readings from all these sources. The IoT Hub routes the data to the storage or analysis processes that you specify.

![Graph illustration of telemetry](../media/lambda-telemetry.png)

There are several distinct purposes of recording telemetry readings:

- To be analyzed for anomalies, for preventive maintenance.
- For visualization by a remote human operator, to help in decision making.
- To be archived, perhaps for later analysis.

These distinct purposes have conflicting storage requirements. This module discusses the storage issues, and gives some introductory advice for newcomers to Azure IoT.
