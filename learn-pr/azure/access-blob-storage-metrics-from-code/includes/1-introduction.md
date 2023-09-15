In the Azure portal, there's a rich and customizable set of tools to display metrics from Azure Monitor. If you're using Binary Large Objects (blobs) in an Azure Storage account, these tools can display an array of metrics for that data. However, sometimes you want to display that data outside of Azure.

Suppose, for example, you work for a video analysis company that carries out color grading and processing of video commercials. You've migrated the storage of daily rushes to Azure Blob Storage, and you have a well-established set of displays and dashboards that show administrators how the Azure Storage account is responding to users.

Administrators have a custom mobile app that they use to configure aspects of your system, including video processing web services and Azure functions. However, this tool can't display blob storage metrics, so if administrators want to investigate performance, they must access the Azure portal.

You want to add code to the mobile app to display storage metrics on mobile devices. In this module, you learn how to access such data from C# code in a client application, such as a mobile app.

## Learning Objectives

By the end of this module, you're able to:

- Access storage metrics in Azure Monitor by using the REST API.
- Use the .NET SDK for Azure Monitor to access Blob metrics and data programmatically.

## Prerequisites

- Knowledge of Azure portal.
- Knowledge of Azure Blob Storage Containers.
- Ability to write and understand C# code and .NET framework classes.

> [!NOTE]
> For this module, you need to use your own subscription to complete the optional exercises. A trial subscription or a subscription that you already have access to will work to follow along.
