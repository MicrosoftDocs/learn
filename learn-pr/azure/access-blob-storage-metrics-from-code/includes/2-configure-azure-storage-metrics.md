In your video analysis company, you use Azure Blob Storage for storing daily rushes. Performance is a key consideration and you want to ensure administrators can see how the system behaves and whether it responds optimally to users.

To do that, you must understand how your Storage Account sends information to Azure Monitor. The you must configure the blob storage account and Azure Monitor to record relevant information.

# Required info

## Overview of Azure Monitor

Azure Monitor is a solution that can gather and store information from many different types of application component. It includes a wide range of tools for analyzing, visualizing, and responding to this data. As such, Azure Monitor is a single tool that you can use to watch and optimize all the components of your system wherever they run.

![Azure Monitor overview](../media/2-azure-monitor-overview.png)

<!-- TODO: This diagram is from MS Docs and should be replaced with an original version -->

Azure Monitor collects two types of data:

- **Metrics.** These are numerical values that describe some aspect of a component at a point in time. For example, an Average Server Response Time metric measures how long a component has taken to respond to users on average over the last few minutes. You can use the **Metrics Explorer** to show how these metrics vary over time.
- **Logs.** These are records of the behavior of a component and they may contain telemetry such as events and traces. In the Azure Portal, you can use the **Log Analytics** page to drill into this data and find individual events that interest you.

By default, you can access 93 days of data in Azure Monitor. If you need to retain data for longer, you can archive it to a Azure Storage account.

As well as using Azure Portal to view and analyze Azure Monitor data, you can also use Application Programming Interfaces (APIs) to examine logs and metrics in code:

- **Azure Monitor REST API.** A REST API is a web service that you can call from you code over HTTP and port 80. The responses are usually in the JSON format.
- **Azure Monitor .NET API.** The .NET API is a set of .NET classes that you can add to any .NET project such as a desktop application, a mobile app, or an ASP.NET web app.

The .NET API is slightly easier to use and requires fewer lines of code for typical operations. However, you can only use this API in .NET projects. If you want to you node.js, for example, you cannot use the .NET API. The REST API can be called from any code that can make HTTP requests.

## Azure Monitor and Azure Storage



values to configure:

- Metrics level
- Retention Days

## Storage account metrics and classic storage metrics

Originally, Azure Storage collected metrics and stored them in **$Metric** tables within the same storage account. These are known as old metrics or classic metrics. They included capacity measurements for blob storage and transaction measurements for blob, table, file, and queue storage.

Old storage metrics still work but are deprecated and support for them is likely to end. If you're using old metrics, you should migrate them to the new Storage metrics as soon as possible.

For new storage metrics, Azure Storage sends the data to the Azure Monitor backend in order unify metrics from Azure Storage with those of other Azure services. You get the same monitoring experience regardless of the source of your data in Azure Monitor and you can integrate metrics from different sources into the same displays.

This module discusses new Azure Storage metrics but bear in mind, when you read about storage metrics, that both old and new metrics exist: some third party articles may not be entirely clear about which metrics they discuss.

## Metric values and multi-dimensional metric values

# How to do the task

## Configure Storage metrics with the Azure Portal

## Configure Storage metrics with PowerShell

## Configure Storage metrics in code

## View Storage metrics in the Portal