In this module, we built a serverless web application. All your static content (pictures, HTML, and JavaScript) was hosted in Azure Blob storage. Azure Functions provided an API and processed events that are triggered by Event Grid. The Computer Vision API was integrated into your Azure Functions to gather metadata about the pictures. Finally, all your non-static data (picture location and picture metadata) was stored in an Azure Cosmos DB instance.

When you upload a picture to the web application and reload it, the application rotates through the uploaded pictures and displays metadata that's retrieved from the Computer Vision API.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-6-final.png

Now, it's time to do one final test and then clean it all up.

>[!NOTE] 
> This guided learning experience is in preview mode. If you encounter problems, report them in the [MicrosoftDocs/learn](https://github.com/MicrosoftDocs/learn/issues) repo.