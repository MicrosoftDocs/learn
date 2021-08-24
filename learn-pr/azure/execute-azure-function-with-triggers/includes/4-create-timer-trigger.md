In this unit, we create an Azure Function app that's invoked every 20 seconds using a timer trigger.

## Create an Azure Function App

Let’s start by creating an Azure Function App in the portal.

::: zone pivot="csharp"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    ![Screenshot of Azure portal menu and Create a resource option.](../media/4-create-a-resource.png)

    The **Create a resource** pane appears.

1. In the left menu pane, under **Categories**, select **Compute**, and then under *Popular offers*, select **Function App**. Optionally, you can enter **Function App** in the search bar, and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**. The **Create Function App** pane appears.

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
    | Storage account |  You can change the name if you like. It will default to a variation of the App name. |
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless). When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.|

1. Select **Review + create** > **Create**. Deployment may take a while to complete.

1. After the function app is deployed, select **Go to resource**. Your *Function App* pane appears.

## Create a timer-triggered function

Now, we're going to create a timer trigger inside our function.

1. In the left menu pane, under **Functions**, select **Functions**. The **Functions** pane for your Function App appears.

1. On the top menu bar, select **Create**. This action starts the function creation process. The **Create function** pane appears.

1. Under the **Select a template** section, select **Timer trigger**, and then select **Create**. The **TimerTrigger1** pane appears for your function.

## Configure the timer trigger

We have an Azure function app with logic to print a message to the log window. We're going to set the schedule of the timer to execute every 20 seconds.

1. In the left menu pane, under **Developer**, select **Integration**. The **Integration** pane appears for your function.

1. In the **Trigger** box, select the **Trigger (myTimer)** link. The **Edit Trigger** pane appears.

1. Enter the following value into the **Schedule** box.

    ```log
    */20 * * * * *
    ```

1. In the top menu bar of this pane, select **Save**.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **Create a resource**.

    ![Screenshot of Azure portal menu and Create a resource option.](../media/4-create-a-resource.png)

    The **Create a resource** pane appears.

1. In the left menu pane, under **Categories**, select **Compute**, and then under **Popular offers**, select **Function App**. Optionally, you can enter **Function App** in the search bar, and press <kbd>Enter</kbd>. On the **Function App** pane that appears, select **Create**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project Details** |
    | Subscription | Select the Azure subscription you'd like to use for this exercise  |
    | Resource Group | Select the existing **Resource Group** <rgn>[sandbox resource group name]</rgn> |
    | **Instance Details** |
    | Function App name | *\<your-webapp-name\>*. Enter a globally unique name for your function app. |
    | Publish | Code |
    | Runtime stack | PowerShell Core |
    | Version | 7.0 (or latest version) |
    | Region | select a location close to you |

1. Select **Next : Hosting**. Enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Storage** |
    | Storage account |  You can change the name if you like. It will default to a variation of the App name. |
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless). When using the Consumption Plan type, you're charged for each execution of your function, and resources are automatically allocated based on your app workload.|

1. Select **Review + create** > **Create**. After the function app is deployed, in the Azure portal, select **Go to resource**. Your *Function App* pane appears.

## Create a timer-triggered function

Now we're going to create a timer trigger inside our function.

1. In the left menu pane, under **Functions**, select **Functions**. The **Functions** pane for your Function App appears.

1. Under the **Select a template** section, select **Timer trigger**, and then select **Add**. The **TimerTrigger1** pane appears for your Function.

## Configure the timer trigger

We have an Azure function app with logic to print a message to the log pane. We're going to set the schedule of the timer to execute every 20 seconds.

1. In the left menu pane, under **Developer**, select **Integration**. The **Integration** pane appears or your Function.

1. In the **Trigger** box, select the **Trigger (myTimer)** link. The **Edit Trigger** pane appears.

1. Enter the following value into the **Schedule** box.

    ```log
    */20 * * * * *
    ```

1. In the top menu bar of this pane, select **Save**.

::: zone-end

## Test the timer

::: zone pivot="csharp"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. On the **TimerTrigger1** pane, in the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. In the top menu bar, select **Test/Run**. From the adjacent *Test* pane with **Input** and **Output** tabs, select **Run**. The **Logs** pane appears at the bottom of the page.

1. Observe new messages arrive every 20 seconds in the log window.

1. To stop the function from running, in the top menu bar of the *Logs* pane, select **Stop**.

1. To disable the function, in the left menu pane, select **Overview**, and in the top menu bar, select **Disable**.

::: zone-end

::: zone pivot="powershell"

Now that we've configured the timer, it will invoke the function on the interval we defined.

1. On the **TimerTrigger1** pane, in the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears.

    > [!NOTE]
    > **TimerTrigger1** is a default name. It's automatically selected when you create the trigger.

1. In the top menu bar, select **Test/Run**. From the adjacent *Input/Output* pane, select **Run**. The **Logs** pane appears at the bottom of the page.

1. Observe new messages arrive every 20 seconds in the log window.

1. To stop the function from running, in the top menu bar of the *Logs* pane, select **Stop**.

1. To disable the function, in the left menu pane, select **Overview**, and in the top menu bar, select **Disable**.

::: zone-end
