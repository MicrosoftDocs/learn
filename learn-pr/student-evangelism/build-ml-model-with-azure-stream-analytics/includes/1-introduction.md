You're the leader of a group of climate scientists who are concerned about the dwindling polar bear population in the Arctic. To help address the problem, your team has placed hundreds of motion-activated cameras at strategic locations throughout the region. Instead of manually examining each photo that's taken to determine whether it contains a polar bear, your challenge is to devise an automated system that processes data from these cameras in real time and displays an alert on a map when one of your cameras photographs a polar bear. You need a solution that uses AI to determine with a high degree of accuracy whether a photo contains a polar bear. And, you need it fast, because climate change won't wait.

In this module, you'll use Microsoft Azure AI services to build your automated system. Specifically, you'll use:

- Azure Blob Storage to store photos
- The Azure AI Custom Vision service to analyze photos to determine whether they include polar bears
- Azure Functions to pass each photograph that's uploaded to Blob Storage to the Custom Vision service
- Azure SQL Database as a data source
- Power BI to build a dashboard to visualize results

The dashboard will show in green the locations where your cameras capture polar bears and other wildlife activity in red.

:::image type="content" source="../media/live-map.png" alt-text="Screenshot of a live map of Cornwallis Island with camera activity data listed.":::

## Learning objectives

In the following units, you'll deploy several Azure services and integrate them to form an end-to-end solution. The final result will be a Power BI report that depicts where an array of virtual cameras is photographing polar bears. Along the way, you'll learn:

- How to create an Azure Storage account and upload blobs to it
- How to write a function app in Azure Functions that's triggered when a blob is uploaded to storage
- How to use Azure AI Custom Vision to train a machine learning model to recognize polar bears in a dataset of images
- How to invoke a Custom Vision model from a function app
- How to create a SQL database in Azure SQL Database, and then write records to it
- How to connect Power BI to a SQL database
- How to create a report that has informative visuals in Power BI

## Prerequisites

- An [Azure subscription](https://azure.microsoft.com/free/students/?azure-portal=true)
- Basic knowledge of Azure services, the Azure portal, and the Azure CLI
- Familiarity with [Node.js](https://nodejs.org/?azure-portal=true)
- [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Power BI Desktop](https://powerbi.microsoft.com/desktop/?azure-portal=true) and a work or school Microsoft account
