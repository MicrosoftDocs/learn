A function app provides an execution context in Azure in which your functions run. As such, it's the unit of deployment and management for your functions. A function app is composed of one or more individual functions that are managed, deployed, and scaled together. All of the functions in a function app share the same pricing plan, deployment method, and runtime version. Think of a function app as a way to organize and collectively manage your functions.

> [!NOTE]
> In Functions 2.x all functions in a function app must be authored in the same language. In previous versions of the Azure Functions runtime, this wasn't required.

## Develop and test Azure Functions locally

Functions make it easy to use your favorite code editor and development tools to create and test functions on your local computer. Your local functions can connect to live Azure services, and you can debug them on your local computer using the full Functions runtime.

The way in which you develop functions on your local computer depends on your language and tooling preferences. For more information, see [Code and test Azure Functions locally](/azure/azure-functions/functions-develop-local).

> [!NOTE]
> Because of limitations on editing function code in the Azure portal, you should develop your functions locally and publish your code project to a function app in Azure. For more information, see [Development limitations in the Azure portal](/azure/azure-functions/functions-how-to-use-azure-function-app-settings#development-limitations-in-the-azure-portal)

### Local project files

A Functions project directory contains the following files in the project root folder, regardless of language:

* `host.json`
* `local.settings.json`
* Other files in the project depend on your language and specific functions.

The `host.json` metadata file contains configuration options that affect all functions in a function app instance. Other function app configuration options are managed depending on where the function app runs:

* **Deployed to Azure:** in your application settings
* **On your local computer:** in the local.settings.json file.

Configurations in `host.json` related to bindings are applied equally to each function in the function app. You can also override or apply settings per environment using application settings. To learn more, see the [host.json reference](/azure/azure-functions/functions-host-json). 

The `local.settings.json` file stores app settings, and settings used by local development tools. Settings in the `local.settings.json` file are used only when you're running your project locally. When you publish your project to Azure, be sure to also add any required settings to the app settings for the function app.

> [!IMPORTANT]
> Because the `local.settings.json` may contain secrets, such as connection strings, you should never store it in a remote repository.

### Synchronize settings

When you develop your functions locally, any local settings required by your app must also be present in the app settings of the deployed function app. You can also download current settings from the function app to your local project.

