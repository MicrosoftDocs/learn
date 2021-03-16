<!--
1. Create a module file and move the App Service plan and app across.
2. Refactor to fix the variables and parameters.
3. Use the Azure CLI to deploy the template.
-->

> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you update the Bicep template that you previously created so that it uses a module for the App Service resources. This helps to keep the intention of the main template clearer. It also means that we can reuse the App Service module in other templates if we want.

During the process, you:

> [!div class="checklist"]
> * Add a new module and move the App Service resources into it.
> * Reference the module from the main Bicep template.
> * Add an output for the App Service app's host name, and emit it from the module and template deployments.
> * Test the deployment to ensure the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

> [!IMPORTANT]
> To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). Get started for free.
