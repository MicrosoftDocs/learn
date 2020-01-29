The great thing about API's that are on the web is that you can access them from anywhere. The bad thing is that _anyone_ can access them from anywhere. There is no reason for anyone who is **not** the Product Manager application to be calling the API.

One of the ways that we have to stop other unwanted calls to the API is CORS. When this app gets pushed to Azure, we'll need to adjust the CORS in Azure Functions to allow access from the URL of the frontend. Any application that makes a request that is not from that specifically allowed URL will get a swift 404 error.

## Settings CORS in production

The CORS settings that you configured for development will not be pushed to production. That is to prevent you from accidentally pushing "\*" to production since that's a common development setting. When you publish your application to Azure, you will have to configure CORS via the Azure Portal.

The CORS settings are located in the "Platform Features" section of your Azure Functions project.

![Platform features screen of Azure Functions project](../media/platform-features.png)

Once there, you can define which URL's can and cannot access your Functions project in Azure.

![The Allowed Origins configuraiton screen under the CORS option in the Azure Portal](../media/allowed-origins.png)

> [!TIP]
> Using "http://localhost:PORT" is a valid entry in the CORS settings for a Function project in Azure. Just remember that everyone has a "localhost", so you'll want to make sure you don't leave that setting in after you are finished testing."

Another strategy that we use is Azure Function Authorization. Azure Functions can require that the requestor know the right "key" to access your function. The requestor will have to pass that key in order for the function to execute.

When you created the functions in the first part of this module, you select "Function" level authorization. This is what tells Azure Functions to assign your functions a key, and to require that key be used in order to access them.

## Getting your function key

You can find the keys for your Functions in the "Function Settings"

![The Function Keys section from the Azure Portal](../media/function-keys.png)

There are two keys: a "\_master" and a "default". The "default" key is the one that you want to pass to your function.

This key must be passed with every request. This is done by passing it as an HTTP header called "x-functions-key".

The key will be visible to the user. It is not meant to be secret. In the event that a key is being used malicously, the keys can be easily rotated from the Azure Portal. The key would also need to be updated in the frontend application.

Between CORS and Function Authorization, your API is _more_ secure than it would be otherwise. It's important to note that it is not 100% secure. It is possible for someone to intercept the key and spoof the domain. To lock a function down completely, you would want users to log-in with credentials. That's out of scope for the tremendous work you're doing here, but is covered in another Learn Module.

Alright, let's get this project to production!
