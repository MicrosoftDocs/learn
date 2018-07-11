---
title: include file
description: include file
services: functions
author: tdykstra
manager: jeconnoc
ms.service: multiple
ms.topic: include
ms.date: 06/25/2018
ms.author: tdykstra
ms.custom: include file
---

You've successfully created a full-featured, serverless application using Azure services.

## Clean up resources

When you are done working with this application, you can use the following command to delete all resources created during the tutorial:

```azurecli
az group delete --name first-serverless-app
```

Type `y` when prompted.  

## Next steps

In this tutorial, you learned how to:
> [!div class="checklist"]
> * Configure Azure Blob storage to host a static website and uploaded images.
> * Upload images to Azure Blob storage using Azure Functions.
> * Resize images using Azure Functions.
> * Store image metadata in Azure Cosmos DB.
> * Use Cognitive Services Vision API to auto-generate image captions.
> * Use Azure Active Directory to secure the web app by authenticating users.

To learn how to connect even more services to Functions, continue to the Logic Apps tutorial. 

> [!div class="nextstepaction"]
> [Functions with Logic Apps](https://docs.microsoft.com/azure/azure-functions/functions-twitter-email)