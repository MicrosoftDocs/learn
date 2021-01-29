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

1. For **Runtime stack**, select **.NET Core**.

1. For **Version**, select **3.1** (or latest version).

1. For **Region**, select a location close to you.

1. Select the **Hosting** tab.

1. To create a new storage account, under **Storage**, enter a name for **Storage account**. You can change the name if you like. It will default to a variation of the App name.

1. Under **Operating system**, select **Windows**.

1. Under **Plan**, for your **Plan type**, select **Consumption (Serverless)**. When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.

1. Select **Review + create**, and then select **Create**. After the function app is deployed, in the Azure portal, go to **All resources**. The function app will be listed with type **Function App** and has the name you gave it. Select it.

## Create a timer-triggered function

Now we're going to create a timer trigger inside our function.

1. In the nav bar for your Function App, select **Functions**, and then select the Add (**+**) button. This action starts the function creation process.

1. In the list of quick start templates, select **Timer trigger**, and then select **Add** at the bottom of the panel. The **TimerTrigger1** page appears.

## Configure the timer trigger

We have an Azure function app with logic to print a message to the log window. We're going to set the schedule of the timer to execute every 20 seconds.

1. From the nav bar, select **Integration**. The **Integration** page appears.

1. In the **Trigger** box, select the **Trigger (myTimer)** link. The **Edit Trigger** panel appears.

1. Enter the following value into the **Schedule** box:

    ```log
    */20 * * * * *
    ```

1. Select **Save**.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

    ![Screenshot of Azure portal menu and Create a resource option.](../media/4-create-a-resource.png)

1. Select **Compute**, and then select **Function App**. You can also optionally use the search bar to locate and create the new resource.

    ![Screenshot of the Azure portal showing the Create a resource pane with the Function App highlighted.](../media/4-click-function-app.png)

1. From the **Basics** tab, under **Project Details**, for **Subscription**, select the **Concierge Subscription**.

1. Select the existing **Resource Group** <rgn>[sandbox resource group name]</rgn>.

1. Under **Instance Details**, enter a globally unique **Function App name**.

1. For **Runtime stack**, select **PowerShell Core**.

1. For **Version**, select **7.0** (or latest version).

1. For **Region**, select a location close to you.

1. Select the **Hosting** tab.

1. To create a new storage account, under **Storage**, enter a name for **Storage account**. You can change the name if you like. It will default to a variation of the App name.

1. Under **Operating system**, select **Windows**.

1. Under **Plan**, for your **Plan type**, select **Consumption (Serverless)**. When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.

1. Select **Review + create**, and then select **Create**. After the function app is deployed, in the Azure portal, go to **All resources**. The function app will be listed with type **App Service** and has the name you gave it. Select it.

## Create a timer-triggered function

Now we're going to create a timer trigger inside our function.

1. In the nav bar for your Function App, select **Functions**, and then select the Add (**+**) button. This action starts the function creation process.

1. In the list of quick start templates, select **Timer trigger**, and then select **Add** at the bottom of the panel. The **TimerTrigger1** page appears.

## Configure the timer trigger

We have an Azure function app with logic to print a message to the log window. We're going to set the schedule of the timer to execute every 20 seconds.

1. From the nav bar, select **Integration**. The **Integration** page appears.

1. In the **Trigger** box, select the **Trigger (myTimer)** link. The **Edit Trigger** panel appears.

1. Enter the following value into the **Schedule** box:

    ```log
    */20 * * * * *
    ```

1. Select **Save**.

::: zone-end

## Test the timer

::: zone pivot="csharp"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. Select **TimerTrigger1**.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. In the left nav bar, under **Developer**, select **Code + Test**. The **Code + Test** page appears.

1. Select **Test/Run**. From the right-hand panel, select **Run**. The **Logs** panel appears at the bottom of the page.

1. Observe new messages arrive every 20 seconds in the log window.

1. To stop the function from running, select **Stop**.

1. To disable the function, in the left nav bar, select **Overview**, and then select **Disable**.

::: zone-end

::: zone pivot="powershell"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. Select **TimerTrigger1**.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. In the left nav bar, under **Developer**, select **Code + Test**. The **Code + Test** page appears.

1. Select **Test/Run**. From the left-hand panel, select **Run**. The **Logs** panel appears at the bottom of the page.

1. Observe new messages arrive every 20 seconds in the log window.

1. To stop the function from running, select **Stop**.

1. To disable the function, in the left nav bar, select **Overview**, and then select **Disable**.

::: zone-end
