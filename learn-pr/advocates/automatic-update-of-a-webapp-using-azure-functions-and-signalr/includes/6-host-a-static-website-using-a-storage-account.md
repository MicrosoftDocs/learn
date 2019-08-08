![Deploy to static website](../media/serverless-app-static-concept.png)

Now that we've tested the application on your local machine, it's time to publish it to the cloud. There are two aspects of your application that require attention before publishing. First, you need to deploy the local functions into Azure and then you need to make the static HTML and JavaScript files available on the web.

Azure Storage includes a feature where you can place files in a specific storage container, which makes them available for HTTP requests. This feature, known as static website support makes hosting publicly available web pages a simple process.

When you copy files to a storage container named `$web`, those files are available to web browsers via a secure server using the `https://<ACCOUNT_NAME>.<ZONE_NAME>.web.core.windows.net/<FILE_NAME>`  URI scheme.
