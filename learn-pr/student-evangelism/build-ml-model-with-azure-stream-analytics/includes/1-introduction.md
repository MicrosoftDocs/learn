You're the leader of a group of climate scientists that's concerned about the dwindling polar bear population in the Arctic. To help address the problem, your team has placed hundreds of motion-activated cameras at strategic locations throughout the region. Rather than manually examine each photograph to determine whether it contains a polar bear, you have been challenged to devise an automated system that processes data from these cameras in real time and displays an alert on a map when a polar bear is photographed. You need a solution that uses artificial intelligence (AI) to determine with a high degree of accuracy whether a photo contains a polar bear. And, you need it fast, because climate change won't wait.

In this module, you'll build this automated system by using Microsoft Azure and Azure Cognitive Services. Specifically, you'll use Azure Blob Storage to store photographs, the Azure Custom Vision service to analyze photographs to determine whether they include polar bears, Azure Functions to pass each photograph uploaded to Blob Storage to the Custom Vision service, Power BI to build a dashboard for visualizing results, and Azure SQL Database as a data source for Power BI. The dashboard will show in green the locations where polar bears are being spotted and show other wildlife activity in red.

![Polar bear map](../media/live-map.png)

## Learning objectives

In the units that follow, you'll deploy several Azure services and integrate them to form an end-to-end solution, culminating in a Power BI report that depicts where polar bears are being spotted. Along the way, you'll learn:

- How to create an Azure Storage account and upload blobs to it
- How to write a function app in Azure Functions that's triggered when a blob is uploaded to storage
- How to use Azure Cognitive Services Custom Vision to train a machine learning model to recognize polar bears
- How to invoke a Custom Vision model from a function app
- How to create a SQL database in Azure SQL Database, and then write records to it
- How to connect Power BI to a SQL database
- How to create a report with informative visuals in Power BI

## Prerequisites

- An Azure subscription
- Basic knowledge of Azure services, the Azure portal, and the Azure CLI
- Familiarity with Node.js
- Power BI Desktop
