## Cleanup and Test

In this module we built out a server-less web application. All of your static content (pictures, html, and javascript) was hosted in Azure Blob Storage.  Then you setup a number of Azure functions to provide an API and process events triggered by Event Grid. The Computer Vision API was integrated into your Azure functions to gather meta data about the pictures.  Finally, all of your non-static data (picture location & picture meta-data) was stored in Azure Cosmos DB.

When you upload a picture to the web application it and reload, the application will rotate through the various pictures you have uploaded, and display the meta data retrieved from Computer Vision API.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-6-final.png
