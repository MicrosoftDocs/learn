In your video analysis company, you use Azure Blob Storage for storing daily rushes. Performance is a key consideration and you want to ensure administrators can see how the system behaves and whether it responds optimally to users.

To do that, you must understand how your Storage Account sends information to Azure Monitor and how to access that information.

## Overview of Azure Monitor

Azure Monitor is a solution that can gather and store information from many different types of application component. It includes a wide range of tools for analyzing, visualizing, and responding to this data. As such, Azure Monitor is a single tool that you can use to watch and optimize all the components of your system wherever they run.

![Azure Monitor overview](../media/2-azure-monitor-overview.png)

<!-- TODO: This diagram is from MS Docs and should be replaced with an original version -->

Azure Monitor collects two types of data:

- **Metrics.** These are numerical values that describe some aspect of a component at a point in time. For example, an Average Server Response Time metric measures how long a component has taken to respond to users on average over the last few minutes. You can use the **Metrics Explorer** to show how these metrics vary over time.
- **Logs.** These are records of the behavior of a component and they may contain telemetry such as events and traces. In the Azure Portal, you can use the **Log Analytics** page to drill into this data and find individual events that interest you.

By default, you can access 93 days of data in Azure Monitor. If you need to retain data for longer, you can archive it to a Azure Storage account.

As well as using Azure Portal to view and analyze Azure Monitor data, you can also use Application Programming Interfaces (APIs) to examine logs and metrics in code:

- **Azure Monitor REST API.** A REST API is a web service that you can call from your code over HTTP and port 80. The responses are usually in the JSON format.
- **Azure Monitor .NET API.** The .NET API is a set of .NET classes that you can add to any .NET project such as a desktop application, a mobile app, or an ASP.NET web app.

The .NET API is slightly easier to use and requires fewer lines of code for typical operations. However, you can only use this API in .NET projects. If you want to use node.js, for example, you cannot use the .NET API. The REST API can be called from any code that can make HTTP requests. In the next exercise, you'll use the **curl** command-line tool to make REST requests.

## Azure Monitor and Azure Storage

When you create a Storage Account in Azure, it is automatically configured to send storage metrics to Azure Monitor for later display and analysis.

## Storage account metrics and classic storage metrics

Originally, Azure Storage collected metrics and stored them in **$Metric** tables within the same storage account. These are known as old metrics or classic metrics. They included capacity measurements for blob storage and transaction measurements for blob, table, file, and queue storage.

In the Azure Portal, classic storage metrics are shown on pages with **(classic)** appended to the title:

![Classic metrics pages in the Azure Portal](../media/2-classic-metrics-in-portal.png)

Old storage metrics still work but are deprecated and support for them is likely to end. If you're using old metrics, you should migrate them to the new Storage metrics as soon as possible.

For new storage metrics, Azure Storage sends the data to the Azure Monitor backend in order unify metrics from Azure Storage with those of other Azure services. You get the same monitoring experience regardless of the source of your data in Azure Monitor and you can integrate metrics from different sources into the same displays.

This module discusses new Azure Storage metrics but bear in mind, when you read about storage metrics, that both old and new metrics exist: some third party articles may not be entirely clear about which metrics they discuss.

## How to use curl to make queries against the REST API

**curl** is a command-line tool that you can use to make requests through the HTTP protocol. Because a REST API works over port 80, you can use **curl** to make test requests. This is a helpful technique to learn about the REST API you are using and to examine its behavior in order to help you write code against it. **curl** is available in the Azure Cloud Shell.

Many REST APIs, including the Azure Monitor API, require you to authenticate before you can make requests in order to ensure security. To authenticate, you can use the **az** command to obtain an authentication token:

```bash
AUTH_TOKEN="Authorization: Bearer $(az account get-access-token --query accessToken -o tsv)"
```

Now you can use the **curl** tool and pass the authentication token like this:

```bash
curl -s -H $AUTH_TOKEN <url> | jq
```

The above command pipes the response to the **jq** utility, which helps to present the JSON data in a more readable format.

## How to formulate the correct URL for a request to the Azure Monitor REST API

Any request to a REST API requires you to formulate the correct URL and, because functional APIs like the Azure Monitor API are often complex, the URL can be long and complex.

To request the list of Azure Storage metrics from the Azure Monitor, use a URL in this form:

```bash
https://management.azure.com/subscriptions/<Subscription ID>/resourceGroups/<Resource Group Name>/providers/Microsoft.Storage/storageAccounts/<Storage Account Name>/providers/microsoft.insights/metricdefinitions?api-version=2018-01-01
```

You'll need to obtain your subscription ID, resource group name, and storage account name and substitute them for the placeholders in the above URL. All these variables are available in the Azure Portal.

Having obtained a list of the Azure Storage metrics, you can query for the values of a specific metric over a time period. Do this with a URL in this form:

```bash
https://management.azure.com/subscriptions/<Subscription ID>/resourceGroups/<Resource Group Name>/providers/Microsoft.Storage/storageAccounts/<Storage Account Name>/providers/microsoft.insights/metrics?metricnames=Availability&aggregation=Average&interval=PT1H&api-version=2018-01-01
```

You'll execute queries by using this method in the next exercise.