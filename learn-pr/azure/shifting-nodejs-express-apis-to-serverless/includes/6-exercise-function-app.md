The Express server runs the API on a server. You can create an Azure Functions project to run the APIs instead. In this exercise, you'll create the Azure Functions application using the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions&WT.mc_id=devto-blog-jopapa).

Once the extension is installed, follow these steps to create the Azure Functions on your computer.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**
1. Choose **Browse** to find the folder to create the functions
1. Create a new folder in your project called _functions_
1. Select **TypeScript**
1. When prompted to create a function, select **Skip for Now**

Congratulations, you just created an Azure Function app!

> ![NOTE]
> You created the function app in the _functions_ folder, which separates it from the Angular app in the same project. You can decide how to structure your application, but for this sample it helps to see them all in one place.

The Azure Functions app is what serves the applications's API endpoints.

Next you'll create the function that will fetch and return the list of vacations.
