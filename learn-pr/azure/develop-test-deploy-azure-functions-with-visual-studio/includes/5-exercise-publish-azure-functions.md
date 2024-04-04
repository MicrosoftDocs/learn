The **Publish** wizard in the Azure Functions template provides the most straightforward way to deploy Azure Functions, especially for testing purposes.

In the luxury watch online website scenario, you decided to use Visual Studio 2022 to deploy functions to an Azure Function App in the cloud. First, you create an Azure Function App, and then use the Visual Studio **Publish** wizard to deploy the functions you create.

Here, you use the Azure portal to create an Azure Function App. Then, you deploy the **WatchInfo** function using the Visual Studio project that you created in a previous exercise. Lastly, you verify that your function is correctly deployed by testing it.

## Create an Azure Function App using the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. From the resource menu or the Home page, select **Create a resource**.

    :::image type="content" source="../media/5-create-a-resource.png" alt-text="Screenshot of Azure portal menu and Create a resource option.":::

    The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Compute**, and then search for and select **Function App**. Select **Create**.

    :::image type="content" source="../media/5-compute-function-app.png" alt-text="Screenshot of Compute category and Function App service option.":::

    <!-- [!INCLUDE [](../../includes/functions-classic-workaround.md)] -->

    The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    > [!NOTE]
    > Your function app must have a name unique to Azure. We suggest using something like **\<*your initials*\>watchfunctions**. Use this name wherever you see *\<your-function-app-name\>* in the remainder of the exercise.

    | Setting | Value |
    | ------- | ----- |
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource Group | From the dropdown list, select <rgn>[Sandbox resource group]</rgn>. |
    | **Instance Details** |
    | Function App name | *\<your-function-app-name\>* |
    | Publish | Code |
    | Runtime stack | .NET |
    | Version | 6 |
    | Region  | Accept the default location. |
    | **Operating system** |
    | Operating System | Windows |
    | **Plan** |
    | Plan type | Consumption (Serverless) |

1. Select **Next : Storage**.

1. On the **Storage** tab, enter the following values for each setting.

    | Setting | Value |
    | ------- | ----- |
    | **Storage** |
    | Storage account | Accept the default value. |

1. Select **Review + create**, and then select **Create**. The deployment shows the resources that are created for the Function App.

1. When deployment completes, select **Go to resource**. The Function App pane for *\<your-function-app-name\>* appears.

## Deploy the WatchInfo function to the Azure Function App

1. On your desktop, return to Visual Studio.

1. In the **Solution Explorer** window, right-click the **WatchPortalFunction** project, and then select **Publish**.

    :::image type="content" source="../media/5-start-publish-from-visual-studio.png" alt-text="Screenshot of Visual Studio, showing the Publish option for the WatchPortalFunctions project." loc-scope="vs":::

    The **Publish** pane appears.

1. Select **Azure**, and then select **Next**.

    :::image type="content" source="../media/5-publish-target.png" alt-text="Screenshot of the Publish target window with the Azure option highlighted." loc-scope="vs":::

    The **Publish** pane updates with the new information.

1. Select **Azure Function App (Windows)**, then select **Next**.

    :::image type="content" source="../media/5-publish-specific-target.png" alt-text="Screenshot of the Publish specific target window with the Azure Function App (Windows) option highlighted." loc-scope="vs":::

1. In the **Subscription name** dropdown list, select **Concierge Subscription**. Expand the <rgn>[Sandbox resource group]</rgn> folder, then select your Function App. Select **Finish**.

    :::image type="content" source="../media/5-publish-functions-instance.png" alt-text="Screenshot of the Publish Functions instance window. The user to select Function Apps." loc-scope="vs":::

1. Select **Publish**.

    :::image type="content" source="../media/5-visual-studio-publish.png" alt-text="[Screenshot of Visual Studio highlighting Finish." loc-scope="vs":::

    Wait for your functions to be deployed. The **Output** window in Visual Studio shows the progress of the build and publish processes. If everything works, you should have one successful **Build** and one successful **Publish**.

    :::image type="content" source="../media/5-output-window.png" alt-text="Screenshot of the Output window in Visual Studio. The output messages indicate that the functions were published successfully." loc-scope="vs":::

## Verify the functions are deployed

1. Return to the Azure portal. The **Function App** pane appears with your function app.

1. In the **Function App** menu, under **Functions**, select **Functions**. The **Functions** pane appears for your function app.

1. Verify that the **Function1** and **WatchInfo** functions are listed.

1. In the **Function App** menu, select **Overview** and check that the **Status** of the Azure Function App is listed as **Running**.

    :::image type="content" source="../media/5-functions-app.png" alt-text="Screenshot of the Azure portal Function App pane showing the 'Function1' and 'WatchInfo' functions." loc-scope="other"::: <!-- no-loc -->

    > [!NOTE]
    > The functions are marked as *Read Only*. You cannot modify their settings or configuration from the Azure portal because you published them from Visual Studio. If you need to update either of these functions, make the changes in Visual Studio and publish them again.

1. In the **Function App** pane, select the **URL** (highlighted in the previous image). A browser window opens, and confirms that the function app is up and running.

    :::image type="content" source="../media/5-functions-app-running.png" alt-text="Screenshot of a web browser showing the function app is running.":::

1. Append the URL of the **WatchInfo** function, `/api/watchinfo`, to the URL in the browser to invoke the **WatchInfo** function without a query string. You might need to refresh the browser to see the error message *Please provide a watch model in the query string*.

    :::image type="content" source="../media/5-function-error.png" alt-text="Screenshot of web browser window showing the error message." loc-scope="other"::: <!-- no-loc -->

1. Add the query string `?model=abc` to the URL and refresh the browser window. This time, you see the details of the watch model returned by the function.

    :::image type="content" source="../media/5-function-success.png" alt-text="Screenshot of web browser showing the details of the watch model." loc-scope="other"::: <!-- no-loc -->

In this exercise, you created an Azure Function App in the cloud, and published your functions to this app from Visual Studio.
