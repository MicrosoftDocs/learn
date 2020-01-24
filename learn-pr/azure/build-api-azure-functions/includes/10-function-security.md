HTTP Function can be called by anyone who has the URL. One of the ways that we have to secure those URL's is CORS. Another strategy that we use is Azure Function Authorization. Azure Functions can require that the sender know the right "key" to access your function. They will have to pass that key in order for the function to execute.

## Settings CORS in production

The CORS settings that you configured for development will not be pushed to production. This is to prevent you from overwriting your production CORS settings with your local development settings, which open the API up to anyone. When you publish your application to Azure, you will have to configure CORS via the Azure Portal.

The CORS settings are located in the "Platform Features" section of your Azure Functions project.

![Platform features screen of Azure Functions project](../media/platform-features.png)

## Getting your function key

You can find the keys for your Functions in the "Function Settings"

![The Function Keys section from the Azure Portal](../media/function-keys.png)

There are two keys: a "\_master" and a "default". The "default" key is the one that you want to pass to your function.

This key must be passed with every request. This is done by passing it as an HTTP header called "x-functions-key".

The key will be visible to the user. It is not meant to be secret. In the event that a key is being used malicously, the keys can be easily rotated from the Azure Portal. The key would also need to be updated in the frontend application.

In the next exercise, you'll publish your local API project to Azure. You'll also configure CORS and function keys so that the frontend project can access the published API.
