In the Azure Portal, there is a rich and customizable set of tools that display metrics from Azure Monitor. If you are using Binary Large Objects (blobs) in an Azure Storage account, these tools can display that data. However, sometimes you might wish to display that data outside of Azure.

Suppose, for example, that you work for a video analysis company that carries out color grading and processing of video commercials. You have migrated the storage of daily rushes to Azure Blob Storage, and you have a well-established set of displays and dashboards that show administrators how the Azure Storage account is responding to users.

Administrators have a custom mobile app that they use to configure aspects of your system, including video processing web services and Azure functions. This tool does not display blob storage metrics so, if administrators want to investigate performance, they must access the Azure Portal.

You want to add code to the mobile app to display storage metrics on the mobile devices. In this module, you will learn how to access such data from C# code in a client application, such as a mobile app.

## Learning Objectives

At the end of this module, you will be able to:

- Access storage metrics in Azure Monitor by using the REST API.
- Use the .NET SDK for Azure Monitor to access Blob metrics and data programmatically.

## Prerequisites

- Knowledge of Azure Portal
- Knowledge of Azure Blob Storage Containers
- Ability to write and understand C# code and .NET framework classes