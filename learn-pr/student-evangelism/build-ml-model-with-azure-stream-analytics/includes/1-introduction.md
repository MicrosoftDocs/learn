Imagine you are the leader of a group of climate scientists who are concerned about the polar-bear population in the Arctic. As such, your team has placed hundreds of motion-activated cameras at strategic locations throughout the region. 

![Picture of a polar bear in the arctic](../media/1-polar-bear.png)

Rather than manually examine each photograph to determine if it contains a polar bear, you have been challenged to devise an automated system that processes data from these cameras in real time and displays an alert on a map when a polar bear is photographed. You need a solution that incorporates real-time stream processing to analyze raw data for potential sightings, and one that incorporates artificial intelligence (AI) and machine learning to determine with a high degree of accuracy whether a photo contains a polar bear. And you need it fast, because climate change won't wait.

Azure provides all the services and features you need to build a solution for this problem including storage capabilities for photographs, live stream analytics, image classifications with Microsoft Cognitive services, and data visualization with Power BI.

[!INCLUDE[](../../../includes/azure-free-trial-note.md)]

## Learning Objectives

In this module, you will:

- Create an Azure Storage account and an IoT hub and use a Node.js app to connect them to a simulated camera
- Use Azure Stream Analytics to run queries on live streams to analyze input and an Azure Function to return output
- Use Microsoft Cognitive Services to train an image classification model and call the model from an app or service
- Connect Power BI to an Azure SQL database and visualize data from the database

> [!IMPORTANT]
> This module is highly interactive - you will be performing steps in the Azure portal and Azure Cloud Shell in every unit. It's also longer than most Microsoft Learn modules as it's intended to walk you through building a full end-to-end solution using several Azure services together. You will need an Azure subscription to complete this module.
>
> To get more focused learning on each of the components used in this module, make sure to check out other modules which cover independent services and provide more depth about creating and using them.

## Prerequisites

- An Azure subscription
- A basic knowledge of Azure services, the Azure portal, and the Azure CLI tools
- Familiarity with Node.js
- [Power BI Desktop](https://powerbi.microsoft.com/desktop/)