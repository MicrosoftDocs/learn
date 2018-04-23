## Cleanup and Test

In this unit we built out a serverless web application. All of your static content (pictures, html, and javascript) was hosted in Azure Blob Storage.  Then you setup a number of Azure functions to provide an API and process events triggered by Event Grid. The Computer Vision API was integrated into your Azure functions to gather metadata about the pictures.  Finally, all of your non-static data (picture location & picture metadata) was stored in Azure Cosmos DB.

When you upload a picture to the web application and reload it, the application will rotate through the uploaded pictures and display metadata retrieved from the Computer Vision API.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-6-final.png
