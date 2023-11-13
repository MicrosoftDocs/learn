In this module, you refactored your Node.js Express application to Azure Functions. Now you can think less about servers, because you're using serverless!

Node.js and Express are powerful solutions for serving API endpoints. With Functions, you can shift your APIs to serverless architecture and not worry about server setup or maintenance.

You might also be able to reduce the cost of an always-on server and improve scalability by replacing the Node.js Express server with the Functions app. Ultimately, with Functions you focus on the code, not the servers.

> [!NOTE]
> To deploy the Functions app to the cloud, see the tutorial [Manage Azure resource groups with TypeScript Function API](/azure/developer/javascript/how-to/with-web-app/azure-function-resource-group-management/deploy-azure-function-with-visual-studio-code). You can use a [free Azure account](https://azure.microsoft.com/free/) and the Azure Functions extension for Visual Studio Code to deploy the application.

The solution for the current sample project is in the [solution branch](https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless/tree/solution) of the GitHub project. Follow the instructions in the README file to get started. You can explore running the Express app or the Functions app to get a sense of the differences. Then try to apply this same shift to your code.

## Other resources

To learn more about Functions, Visual Studio Code, and debugging, see the following resources:

### Visual Studio Code

- Get [Visual Studio Code](https://code.visualstudio.com).
- Get the [Visual Studio Code Extension for Azure Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack).
- Get the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

### Functions

- Learn about the Functions [local.settings.json](/azure/azure-functions/functions-run-local#local-settings-file) file.
- [Deploy a Functions app to Azure](/azure/developer/javascript/how-to/with-web-app/azure-function-resource-group-management?branch=main#5-deploy-resource-manager-function-app).
- Learn about [Functions TypeScript support](https://azure.microsoft.com/blog/improving-the-typescript-support-in-azure-functions/).
- Sign up for an [Azure free trial](https://azure.microsoft.com/free/).

### Debugging resources

- [Debug Angular.js in Visual Studio Code](https://code.visualstudio.com/docs/nodejs/angular-tutorial).
- [Debug React.js in Visual Studio Code](https://code.visualstudio.com/docs/nodejs/reactjs-tutorial).
- [Debug Vue.js in Visual Studio Code](https://code.visualstudio.com/docs/nodejs/vuejs-tutorial).
- [Integrate with external tools via Tasks in Visual Studio Code](https://code.visualstudio.com/Docs/editor/tasks).
