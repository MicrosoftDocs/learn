In this module, you refactored your Node.js Express application to Azure Functions. Now you can think about servers less (get it, because we are using serverless?).

Node and Express have been incredibly powerful and oft used for serving API endpoints. Now with serverless you could shift your APIs and not worry about server setup or maintenance, possibly reduce cost of an always on server, and replace the Express server with Azure Functions service. And for your efforts, you get an API that scales well and lets you focus on the code, not the servers.

> If you want to deploy the Azure Functions app to the cloud, you can [deploy it by following this tutorial](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions). All you need is an [Azure account](https://azure.microsoft.com/en-us/free/) and then use the Azure Functions extension for Visual Studio Code to deploy it.

The complete solution for the [sample project is on GitHub here](https://github.com/johnpapa/express-to-functions). The instructions on how to get started are also in the README file. You can explore running the Express app or the Azure Functions app to get a sense of the differences. Then try to apply this same shift to your code.

To verify your implementation, you can reference the _end_ folder or you can [view the code on GitHub](https://github.com/MicrosoftDocs/mslearn-advocates.azure-functions-and-signalr/tree/master/end).

## Additional Resources

Here are several resources where you can learn more about the topics covered in this module.

### VS Code

- Get [VS Code](https://code.visualstudio.com)
- Get the [VS Code Extension for Azure Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack)
- Get the [VS Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)

### Azure Functions

- Learn about the Azure Functions [local.settings.json](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#local-settings-file) file
- Learn how to [Deploy to Azure Using Azure Functions](https://code.visualstudio.com/tutorials/functions-extension/getting-started)
- Learn about [Azure Functions TypeScript Support](https://azure.microsoft.com/en-us/blog/improving-the-typescript-support-in-azure-functions/)
- Sign up for a [Free Trial of Azure](https://azure.microsoft.com/en-us/free/)

### Debugging Resources

- [Debugging Angular in VS Code](https://code.visualstudio.com/docs/nodejs/angular-tutorial)
- [Debugging React in VS Code](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial)
- [Debugging Vue in VS Code](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial)
- [Tasks in VS Code](https://code.visualstudio.com/Docs/editor/tasks)
