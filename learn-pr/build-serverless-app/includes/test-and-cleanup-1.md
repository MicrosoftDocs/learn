In this module, we built a serverless web application. All of your static content (pictures, html, and javascript) was hosted in Azure Blob Storage. Azure Functions provided an API and processed events triggered by Event Grid. The Computer Vision API was integrated into your Azure Functions to gather metadata about the pictures.  Finally, all of your non-static data (picture location & picture metadata) was stored in Azure Cosmos DB.

When you upload a picture to the web application and reload it, the application will rotate through the uploaded pictures and display metadata retrieved from the Computer Vision API.

![Serverless web application][serverless-webapp]

<!-- Images -->
[serverless-webapp]: ../media/lab-6-final.png

Now, it's time to do one final test and then clean it all up!

>[NOTE] This guided learning experience is in preview mode. If you encounter problems, please report them on the [MicrosoftDocs/learn](https://github.com/MicrosoftDocs/learn/issues) repo.