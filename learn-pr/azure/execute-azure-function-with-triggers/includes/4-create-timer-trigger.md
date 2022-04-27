In this unit, we create an Azure Function app that's invoked every 20 seconds using a timer trigger.

## Create an Azure Function App

Let’s start by creating an Azure Function App in the portal.

::: zone pivot="csharp"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    :::image type="content" source="../media/4-create-a-resource.png" alt-text="Screenshot of Azure portal menu and Create a resource option.":::

    The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Compute**, and then select **Function App** from the results. Optionally, you can enter **Function App** in the search bar, and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project Details** |
    | Subscription | Select the **Concierge Subscription** for this exercise  |
    | Resource Group | Select '<rgn>[Sandbox resource group name]</rgn>' resource group from the dropdown list. |
    | **Instance Details** |
    | Function App name | *\<your-webapp-name\>*. Enter a globally unique name for your function app. |
    | Publish | Code |
    | Runtime stack | .NET |
    | Version | 3.1 |
    | Region | Select a location close to you. |

1. Select **Next : Hosting**, and enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Storage** |
    | Storage account |  Defaults to (New) and a unique storage account name. You can change the name if you like. |
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless). When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.|

1. Select **Review + create** to validate your input, and then select **Create**. Deployment progress displays the items that are created. It may take a minute or two for deployment to complete.

1. When deployment is complete, select **Go to resource**. The **Overview** pane for your *Function App* appears.

## Create a timer-triggered function

Let's create a timer trigger in your function.

1. In the **Function App** menu, under **Functions**, select **Functions**. The **Functions** pane for your *Function App* appears.

1. On the command bar, select **Create**. It may take a few moments for your permissions to propagate to use this service. The **Create function** pane appears.

1. Under **Select a template**, select **Timer trigger**, and then select **Create**. The **TimerTrigger1** *Function* pane appears.

## Configure the timer trigger

You've created an Azure function app with logic to print a message to the log window. We're going to set the schedule of the timer to run every 20 seconds.

1. In the **TimerTrigger1** menu, select **Integration**. The **Integration** pane for your time function appears.

1. In the **Trigger** box, select the **Timer (myTimer)** link. The **Edit Trigger** pane appears.

1. Enter the following value into the **Schedule** field.

    ```log
    */20 * * * * *
    ```

    The value in this parameter represents the CRON expression with six places for time precision: {second} {minute} {hour} {day} {month} {day-of-week}. The first place value represents every 20 seconds.

1. In the command bar, select **Save** to configure your timer trigger.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    :::image type="content" source="../media/4-create-a-resource.png" alt-text="Screenshot of Azure portal menu with Create a resource highlighted.":::

    The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Compute**, and then in the results pane select **Function App**. Optionally, enter **Function App** in the search bar, and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project Details** |
    | Subscription | Concierge subscription (default).  |
    | Resource Group | Select the existing **Resource Group** <rgn>[sandbox resource group name]</rgn>. |
    | **Instance Details** |
    | Function App name | *\<your-webapp-name\>*. Enter a globally unique name for your function app. |
    | Publish | Code. |
    | Runtime stack | PowerShell Core. |
    | Version | 7.0 (or latest version). |
    | Region | Select a location close to you. |

1. Select **Next : Hosting**. Enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Storage** |
    | Storage account |  Default is a unique storage account name. You can change the name if you like.|
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless). When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.|

1. Select **Review + create** to validate your settings, and then select **Create**. The deployment pane displays the resources that are being created for your function app. 

1. When deployment is complete, select **Go to resource**. The *Function App* pane for your funcitonappears.

## Create a timer-triggered function

Let's create a timer trigger for your function.

1. In the *Function App* menu, select **Functions**. The **Functions** pane appears.

1. Under **Select a template**, select **Timer trigger**, and then select **Add**. The **TimerTrigger1** pane appears.

## Configure the timer trigger

You've created an Azure function app with logic to print a message to the log pane. Let's set the schedule of the timer to run every 20 seconds.

1. In the **TimerTrigger1** menu, select **Integration**. The **Integration** pane appears.

1. In the **Trigger** box, select the **Timer (myTimer)** link. The **Edit Trigger** pane appears.

1. Enter the following value into the **Schedule** box.

    ```log
    */20 * * * * *
    ```

    The value in this parameter represents the CRON expression with six places for time precision: {second} {minute} {hour} {day} {month} {day-of-week}. The first value represents every 20 seconds.

1. In the command bar, select **Save** to configure your timer trigger.

::: zone-end

## Test the timer

::: zone pivot="csharp"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. On the **TimerTrigger1** pane, in the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > Azure automatically provides a default name for a new trigger that you create. **TimerTrigger1** is default value that you can change when you create a new trigger.

1. In the command bar, select **Test/Run**. In the **Input**  **Output** pane, select **Run**. The **Logs** session pane opens at the bottom of the page.

1. Observe that a new message arrives every 20 seconds in the log pane.

1. To stop the function, close the *Input/Output* pane, and then in the command bar of the *Logs* pane, select **Stop**.

1. To disable the function, in the **TimerTrigger1** menu, select **Overview**, and then in the command bar, select **Disable**.

::: zone-end

::: zone pivot="powershell"

Now that we've configured the timer, we can invoke the function to run at the interval we defined.

1. On the **TimerTrigger1** menu, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > Azure automatically provides a default name for a new trigger that you create. **TimerTrigger1** is default value that you can change when you create a new trigger.

1. In the command bar, select **Test/Run**. From the adjacent *Input/Output* pane, select **Run**. The **Logs** pane appears at the bottom of the page.

1. Observe that a new message arrives every 20 seconds in the log pane.

1. To stop the function, close the *Input/Output* pane, and then in the command bar of the *Logs* pane, select **Stop**.

1. To disable the function, in the **TimerTrigger1** menu, select **Overview**, and then in the command bar, select **Disable**.

::: zone-end
