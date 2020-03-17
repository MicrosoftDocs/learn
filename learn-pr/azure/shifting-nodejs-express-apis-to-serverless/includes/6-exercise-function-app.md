The Express server runs the API on a server. You can create an Azure Functions project to run the APIs instead. I recommend using the [VS Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions&WT.mc_id=devto-blog-jopapa). Once installed, follow these steps to create the Azure Functions on your computer.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**
1. Choose **Browse** to find the folder to create the functions
1. Create a new folder in your project called _functions_
1. Select **TypeScript**
1. When prompted to create a function, select **Skip for Now**

Congratulations, you just created an Azure Function app!

> The Azure Functions app is what serves our routes.

You created the function app in the _functions_ folder, which separates it from the Angular app in the same project. You certainly have freedom to structure your application to your needs, but for this sample it helps to see them all in one place.
