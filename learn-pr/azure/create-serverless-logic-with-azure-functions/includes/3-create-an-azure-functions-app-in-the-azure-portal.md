You're now ready to start implementing the temperature service. In the previous unit, you determined that a serverless solution would best fit your needs. Let's start by creating a function app to hold our Azure Function.

## What is a function app?

Functions are hosted in an execution context called a **function app**. You define function apps to logically group and structure your functions and a compute resource in Azure. In our escalator example, you would create a function app to host the escalator drive gear temperature service. There are a few decisions that need to be made to create the function app; you need to choose a service plan and select a compatible storage account.

### Choose a service plan

Function apps may use one of the following hosting plans:

- Consumption plan
- Premium plan
- Dedicated (App service) plan

When using the Azure serverless application platform, choose the **Consumption plan**. This plan provides automatic scaling and bills you only when your functions are running. The Consumption plan comes with a configurable timeout period for executing a function. By default, it's five (5) minutes, but may be configured to have a timeout as long as 10 minutes.

The **Premium plan** also dynamically scales your resources to meet demand, but you can specify a minimum number of VM instances to keep warm and reduce so called "cold starts." The Premium plan also lets your functions connect to and run inside virtual networks. Like the Dedicated plan, the default timeout for apps in a Premium plan is 30 minutes, but they can essentially run for an unlimited time (depending on server availability). 

The **Dedicated (App service) plan** enables you to avoid timeout periods by having your function run continuously on a VM that you define. An App service plan is technically not a serverless plan, because you're responsible for managing the app resources the function runs on. However, it may be a better choice when you already have excess App Service resources available on which to also run your functions.

### Storage account requirements

When you create a function app, it must be linked to a storage account. You can select an existing account or create a new one. The function app uses this storage account for internal operations, such as logging function executions and managing execution triggers. On the **Consumption plan**, this storage account is also where the function code and configuration file are stored.

## Create a function app

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

Let's create a function app in the Azure portal. Completing this module incurs a small cost of a few USD cents or less in your Azure account.

::: zone pivot="javascript"

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) using your Azure account.

1. Under **Azure services**, select **Create a resource**.

    :::image type="content" source="../media/3-create-function-app-1.png" alt-text="Screenshot of Azure services with Create a resource highlighted." lightbox="../media/3-create-function-app-1.png":::

    The **Create a resource** pane appears.

1. In the menu, search for and select **Function App**. Select the **Create** button. The **Create Function App** pane appears.

1. Select the **Consumption** radio button, then select the **Select** button.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project Details** |
    | Subscription | Your Subscription |
    | Resource Group | Select the **Create new** link and enter a name for your resource group. |
    | **Instance Details** |
    | Function App name  | Enter a globally unique app name, which becomes part of the base URL of your service. For example, you can name it **escalator-functions-xxx**, where you can replace xxx with your initials and a number. Valid characters are a-z, 0-9, and - |
    | Runtime stack | Node.js (which is the language we use to implement the function examples in this exercise). |
    | Version | Accept *default* |
    | Region | Select a geographical location close to you. In a production system, you would want to select a location near your customers or consumers of the function. |
    | **Operating system** |
    | Operating System | Accept *default* |

1. Select **Next : Storage**. On the **Storage** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Storage** |
    | Storage account | Select the **Create new** link, and enter a name for your storage account, and select **OK**. |

1. Select **Review + create**, and then select **Create**. Deployment takes a few minutes. You receive a notification when deployment is completed.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true) using your Azure account.

1. Under **Azure services**, select **Create a resource**.

    [!INCLUDE [](../../includes/functions-classic-workaround.md)]

     :::image type="content" source="../media/3-create-function-app-1.png" alt-text="Screenshot of Azure services with Create a resource highlighted." lightbox="../media/3-create-function-app-1.png":::

    The **Create a resource** pane appears.

1. In the menu, select **Compute**, and then search for and select **Function App**. Select the **Create** button. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project Details** |
    | Subscription | Your Subscription |
    | Resource Group | Select the **Create new** link and enter a name for your resource group. |
    | **Instance Details** |
    | Function App name  | Enter a globally unique app name, which becomes part of the base URL of your service. For example, you can name it **escalator-functions-xxx**, where you can replace xxx with your initials and a number. Valid characters are a-z, 0-9 and - |
    | Do you want to deploy code or container image? | Code |
    | Runtime stack | PowerShell Core |
    | Version | Accept *default* |
    | Region | Select a geographical location close to you. In a production system, you would want to select a location near your customers or consumers of the function. |
    | **Operating system** |
    | Operating System | Accept *default* |
    | **Hosting** |
    | Hosting options and plans | Consumption (Serverless) |

1. Select **Next:Storage**. On the **Storage** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Storage** |
    | Storage account | Select the **Create new** link, and enter a name for your storage account, and select **OK**. |

1. Select **Review + create**, and upon validation, then select **Create**. Deployment takes a few minutes. The Deployment pane displays the resources that are being created, and displays a **Your deployment is complete** notification when deployment is completed.

::: zone-end

## Verify your Azure function app

1. When deployment completes, select **Go to resource**. The Function App pane for your escalator function appears.

1. In the **Essentials** section, select the **URL** link to open it in a browser. A default Azure web page appears with a message that your Functions app is up and running.
