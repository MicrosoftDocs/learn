---
title: include file
description: include file
services: functions
author: tdykstra
manager: jeconnoc
ms.service: multiple
ms.topic: include
ms.date: 06/21/2018
ms.author: tdykstra
ms.custom: include file
---

In this tutorial, you deploy a simple web application that presents an HTML-based user interface. A serverless backend enables the application to upload images and automatically get captions describing them.

![Running web app](media/functions-first-serverless-web-app/0-app-screenshot-finished.png)

The following diagram shows the Azure services used by the application:

1. Blob Storage serves static web content (HTML, CSS, JS) and stores images.
2. Azure Functions manages image uploads, resizing, and metadata storage.
3. Cosmos DB stores image metadata.
4. Logic Apps gets image captions from Computer Vision API.
5. Azure Active Directory manages user authentication.

![Solution architecture diagram](media/functions-first-serverless-web-app/0-architecture.jpg)

In this tutorial, you learn how to:
> [!div class="checklist"]
> * Configure Azure Blob storage to host a static website and uploaded images.
> * Upload images to Azure Blob storage using Azure Functions.
> * Resize images using Azure Functions.
> * Store image metadata in Azure Cosmos DB.
> * Use Cognitive Services Vision API to auto-generate image captions.
> * Use Azure Active Directory to secure the web app by authenticating users.