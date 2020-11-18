In this unit, we create an Azure function app that's invoked every 20 seconds using a timer trigger.

## Create an Azure function app

Let’s start by creating an Azure Function app in the portal.

::: zone pivot="csharp"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

    ![Screenshot of Azure portal menu and Create a resource option.](../media/4-create-a-resource.png)

1. Select **Compute**, and then select **Function App**. You can also optionally use the search bar to locate and create the new resource. The **Create Function App** page appears.

    ![Screenshot of the Azure portal showing the Create a resource pane with the Function App highlighted.](../media/4-click-function-app.png)

1. From the **Basics** tab, under **Project Details**, for **Subscription**, select the **Concierge Subscription**.

1. Select the existing **Resource Group** <rgn>[sandbox resource group name]</rgn>.

1. Under **Instance Details**, enter a globally unique **Function App name**.

1. For **Runtime stack**, select **.NET Core**, which is the language in which you implement the function examples in this exercise.

1. For **Version**, select **3.1** (or latest version).

1. For **Region**, select a location close to you.

1. Select the **Hosting** tab.

1. Under **Operating system**, select **Windows**.

1. Under **Plan**, for your **Plan type**, select **Consumption (Serverless)**. When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.

1. To create a new storage account, under **Storage**, enter a name for **Storage account**. You can change the name if you like. It will default to a variation of the App name.

1. Select **Review + create**. After the function app is deployed, in the Azure portal, go to **All resources**. The function app will be listed with type **App Service** and has the name you gave it.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

    ![Screenshot of Azure portal menu and Create a resource option.](../media/4-create-a-resource.png)

1. Select **Compute**, and then select **Function App**. You can also optionally use the search bar to locate and create the new resource.

    ![Screenshot of the Azure portal showing the Create a resource pane with the Function App highlighted.](../media/4-click-function-app.png)

1. Enter a globally unique **App name**.

1. Select the **Concierge Subscription**.

1. Select the existing **Resource group** <rgn>[sandbox resource group name]</rgn>.

1. Choose **Windows** as your **OS**.

1. Choose **Consumption Plan** for your **Hosting Plan**. When using the Consumption Plan type you're charged for each execution of your function and resources are automatically allocated based on your application workload.

1. Select a **Location** close to you.

1. For **Runtime Stack**, select **PowerShell Core (Preview)**, which is the language in which we implement the function examples in this exercise.

1. Create a new **Storage** account, you can change the name if you like - it will default to a variation of the App name.

1. Select **Create**. Once the function app is deployed, go to **All resources** in the portal. The function app will be listed with type **App Service** and has the name you gave it.

::: zone-end

## Create a timer-triggered function

Now we're going to create a timer trigger inside our function.

1. Select the Add (**+**) button next to **Functions**. This action starts the function creation process.

1. On the **Azure Functions for PowerShell - getting started** page, select **In-portal** and then select **Continue**.

1. In the list of quick start templates, select **Timer** and then select **Create** at the bottom of the screen.

## Configure the timer trigger

We have an Azure function app with logic to print a message to the log window. We're going to set the schedule of the timer to execute every 20 seconds.

1. Select **Integrate**.

1. Enter the following value into the **Schedule** box:

    ```log
    */20 * * * * *
    ```

1. Select **Save**.

## Test the timer

::: zone pivot="csharp"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. Select **TimerTrigger1**.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. Open the **Logs** panel at the bottom of the screen.

1. Observe new messages arrive every 20 seconds in the log window.

1. To stop the function from running, select **Manage** and then switch **Function State** to *Disabled*.

::: zone-end

::: zone pivot="powershell"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. Select **TimerTrigger1**.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. Open the **Logs** panel at the bottom of the screen.

1. Observe new messages arrive every 20 seconds in the log window. You may not see any log messages for a few minutes as the function app warms up for the first time.

1. To stop the function from running, select **Manage** and then switch **Function State** to *Disabled*.

::: zone-end