In this unit, we create an Azure Function app and a timer trigger that we use to invoke it every 20 seconds.

## Create an Azure Function App

Let’s start by creating an Azure Function App in the portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    :::image type="content" source="../media/4-create-a-resource.png" alt-text="Screenshot of Azure portal menu and Create a resource option.":::

    The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Function App**. If you don't have the Function App option, you can enter **Function App** in the search bar and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**.

1. Select the **Consumption** radio button, then select the **Select** button.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project Details** |
    | Subscription | Select the **Concierge Subscription** for this exercise  |
    | Resource Group | Select the **<rgn>[Sandbox resource group name]</rgn>** resource group from the dropdown list. |
    | **Instance Details** |
    | Function App name | *\<your-webapp-name\>*. Enter a globally unique name for your function app. |
    | Runtime stack | Select one of the languages supported for in-portal development: **.NET**, **Node.js**, or **PowerShell Core**.  |
    | Version | For .NET, select **8 (LTS), in-process model**. For Node.js and PowerShell, use the suggested default version of the language runtime. |
    | Region | Select a location close to you. |
    | **Operating system** |
    | Operating System | Windows |

1. Select **Next : Storage** and enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Storage** |
    | Storage account |  Defaults to (New) and a unique storage account name. You can change the name if you like. |

1. Select **Review + create** to validate your input, and then select **Create**. The deployment progress displays the items that are created. It might take a minute or two for deployment to complete.

1. When deployment is complete, select **Go to resource**. The **Overview** pane for your *Function App* appears.

## Create and configure a timer-triggered function

Let's create a timer trigger in your function.

1. In the **Function App** menu, select the **Functions** tab in the center of the screen. 

1. Select the **Create function** button under **Create in Azure portal**. It might take a few moments for your permissions to propagate to use this service. The **Create function** pane appears.

1. Under **Select a template**, select **Timer trigger**, then select **Next**.

1. Under **Template details**, enter the following value into the **Schedule** field, then select **Create**.

    ```log
    */20 * * * * *
    ```

    The value in this parameter represents the CRON expression with six places for time precision: {second} {minute} {hour} {day} {month} {day-of-week}. The first place value represents every 20 seconds.

## Test the timer

Now that the timer is configured, it invokes the function on the interval we defined.

1. On the **TimerTrigger1** pane, in the taskbar at the top of the screen, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > Azure automatically provides a default name for a new trigger that you create. **TimerTrigger1** is a default value that you can change when you create a new trigger.

1. The **Logs** session pane opens at the bottom of the page. Select the **App Insight Logs** drop-down, and then select **Filesystem Logs**. Select **OK** when the **Switching to filesystem based logs...** message displays.

    :::image type="content" source="../media/4-azure-function-logs.png" alt-text="Screenshot that shows the function Code + Test pane with the Filesystem Log displayed.":::

1. Observe that a new message arrives every 20 seconds in the log pane.

1. To stop the function, select **Stop** in the **Logs** pane command bar.

1. To disable the function, in the **TimerTrigger1** menu, select **Disable** in the command bar.
