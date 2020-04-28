# Introduction

You are the leader of a group of climate scientists who are concerned about the dwindling polar-bear population in the Arctic. As such, your team has placed hundreds of motion-activated cameras at strategic locations throughout the region. Rather than manually examine each photograph to determine whether it contains a polar bear, you have been challenged to devise an automated system that processes data from these cameras in real time and displays an alert on a map when a polar bear is photographed. You need a solution that incorporates artificial intelligence (AI) to determine with a high degree of accuracy whether a photo contains a polar bear. And you need it fast, because climate change won't wait.

In this module, you will build such a system using [Microsoft Azure](https://azure.microsoft.com/) and [Azure Cognitive Services](https://azure.microsoft.com/services/cognitive-services/). Specifically, you will use [Azure Blob Storage](https://azure.microsoft.com/services/storage/blobs/) to store photographs, Azure's [Custom Vision Service](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/) to analyze photographs for polar bears, [Azure Functions](https://azure.microsoft.com/services/functions/) to pass each photograph uploaded to blob storage to the Custom Vision Service, [Microsoft Power BI](https://powerbi.microsoft.com/) to build a dashboard for visualizing results, and [Azure SQL Database](https://azure.microsoft.com/services/sql-database/) as a data source for Power BI. The dashboard will show where polar bears are being spotted in green, and other wildlife activity in red.

![](media/live-map.png)

## Learning objectives

In the units that follow, you will deploy several Azure services and integrate them to form an end-to-end solution, culminating in a Power BI report that depicts where polar bears are being spotted. Along the way, you will learn:

- How to create an Azure Storage account and upload blobs to it
- How to write an Azure Function that is triggered when a blob is uploaded to storage
- How to use Azure's Custom Vision Service to train a machine-learning model to recognize polar bears
- How to invoke a Custom Vision Service model from an Azure Function
- How to create an Azure SQL Database and write records to it
- How to connect Power BI to an Azure SQL Database
- How to create a report with informative visuals in Power BI

Sound like fun? Then let's get started.