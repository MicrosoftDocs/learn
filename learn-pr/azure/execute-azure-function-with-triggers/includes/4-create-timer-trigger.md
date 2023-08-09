In this unit, we create an Azure Function app that's invoked every 20 seconds using a timer trigger.

## Create an Azure Function App

Let’s start by creating an Azure Function App in the portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    :::image type="content" source="../media/4-create-a-resource.png" alt-text="Screenshot of Azure portal menu and Create a resource option.":::

    The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Web**, and then select **Function App** from the results. Optionally, you can enter **Function App** in the search bar, and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project Details** |
    | Subscription | Select the **Concierge Subscription** for this exercise  |
    | Resource Group | Select '<rgn>[Sandbox resource group name]</rgn>' resource group from the dropdown list. |
    | **Instance Details** |
    | Function App name | *\<your-webapp-name\>*. Enter a globally unique name for your function app. |
    | Publish | Code |
    | Runtime stack | Select one of the languages supported for in-portal development: **.NET**, **Node.js**, or **PowerShell Core**.  |
    | Version | Use the suggested default version of your language runtime. |
    | Region | Select a location close to you. |
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless). When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload. |

1. Select **Next : Storage**, and enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Storage** |
    | Storage account |  Defaults to (New) and a unique storage account name. You can change the name if you like. |

1. Select **Review + create** to validate your input, and then select **Create**. Deployment progress displays the items that are created. It may take a minute or two for deployment to complete.

1. When deployment is complete, select **Go to resource**. The **Overview** pane for your *Function App* appears.

## Create and configure a timer-triggered function

Let's create a timer trigger in your function.

1. In the **Function App** menu, under **Functions**, select **Functions**. The **Functions** pane for your *Function App* appears.

1. On the command bar, select **Create**. It may take a few moments for your permissions to propagate to use this service. The **Create function** pane appears.

1. Under **Select a template**, select **Timer trigger**.

1. Under **Template details**, enter the following value into the **Schedule** field, and then select **Create**.

    ```log
    */20 * * * * *
    ```

    The value in this parameter represents the CRON expression with six places for time precision: {second} {minute} {hour} {day} {month} {day-of-week}. The first place value represents every 20 seconds.

## Test the timer

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. On the **TimerTrigger1** pane, in the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > Azure automatically provides a default name for a new trigger that you create. **TimerTrigger1** is default value that you can change when you create a new trigger.

1. The **Logs** session pane opens at the bottom of the page. Select the **App Insight Logs** drop-down, and then select **Filesystem Logs**. Select **OK** when the **Switching to filesystem based logs...** message displays.

    :::image type="content" source="../media/4-azure-function-logs.png" alt-text="Screenshot that shows the function Code + Test pane with the Filesystem Log displayed.":::

1. Observe that a new message arrives every 20 seconds in the log pane.

1. To stop the function, select **Stop** in the command bar of the *Logs* pane.

1. To disable the function, in the **TimerTrigger1** menu, select **Overview**, and then in the command bar, select **Disable**.
