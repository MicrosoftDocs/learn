## Exercise - Azure Functions

> [!NOTE]
> A sandbox is provide to aid in your completion of this lab.  Otherwise, this Lab requires an Azure subscription.

---

## Lab - Implement Azure Functions

In this walkthrough, we will create a Function App to display a Hello message when there is an HTTP request. 

### Task 1: Create a Function app

In this task, we will create a Function app.

1. Sign in to the [Azure portal (https://portal.azure.com)](https://portal.azure.com?azure-portal=true).

2. From the **All services** blade, search for and select **Function App** and then click **+ Add**.

3. On the **Basic** tab of the **Function App** blade, fill in the Azure Function App settings fields (replace **xxxx** in the name of the function with letters and digits such that the name is globally unique). Leave the defaults for everything else. 

    | Settings | Value |
    | -- | --|
    | Subscription | Ensure the **Concierge Subscription** |
    | Resource group | Choose **<rgn>[sandbox resource group name]</rgn>** (Create new) |
    | Function App name | **function-xxxx** |
    | Publish | **Code** |
    | Runtime stack | **.NET Core** |
    | Region | **East US** |
    | | |	

4. Click **Review + Create** and, after verification, click **Create** to begin provisioning and deploying your new Azure Function App.

5. Wait for the Notification that the resource has been created.

6. Open All Services and open the Function App page.  Then click the **Refresh** to verify your new resource is *running*. 

    :::image type="content" source="../media/0701.png" alt-text="Screenshot of the Function App page with the new Function app.":::

### Task 2: Create an HTTP triggered function and test

In this task, we will use the Webhook + API function to display a message when there is an HTTP request. 

1. Click on the newly created Function App in Azure portal. 

2. Click Functions.  Then "**+**" button next to Add near the top of the page. Notice all the choices for functions you could build. Then click **HTTP trigger**. 

    :::image type="content" source="../media/function-lab-select-function.png" alt-text="Screenshot of the choose a function step in the Azure functions for dot net getting started pane inside Azure portal. The display elements for creating a new in-portal function are highlighted. The highlighted elements expand the function app, add new function, and New Function page.":::

3. Review the default values of Function name = **HttpTrigger1** and Authorization Level = **Function**. Then click **Create Function**. This will run a function whenever the app receives an HTTP request. Review other templates that you can choose from.

    :::image type="content" source="../media/function-lab-select-function-name.png" alt-text="Screenshot of the create a function step in the Azure functions for dot net getting started pane inside Azure portal. The HTTP Trigger button was chosen previously and now you need to enter the function name.  You will accept the defualt and click Create Function.":::

4. Your new **HttpTrigger1** function has been created, the overview page is opened. 

    :::image type="content" source="../media/function-lab-select-function-created.png" alt-text="Screenshot of the Function with your newly created HttpTrigger showing the overview page.":::

5. Click on the **Code + Text** entry in the menu.  Notice the code is designed to run an HTTP request and log information. Also, notice the function returns a Hello message with a name. 

    :::image type="content" source="../media/function-lab-select-function-code.png" alt-text="Screenshot of the function code. The Hello message is highlighted.":::

6. Click **Get function URL** from the top section of function editor. 

7. Ensure that the value in the **Key** drop-down list is set to **default**. Then, click **Copy to clipboard** to copy the function URL. 

    :::image type="content" source="../media/function-lab-select-function-get-link.png" alt-text="Screenshot of the get function URL pane inside the function editor in Azure portal. The display elements get function URL button, set key dropdown, and copy URL button are highlighted to indicate how to obtain and copy the function URL from the function editor.":::

8. Open a new browser tab and paste the copied function URL into your web browser's address bar. When the page is requested the function will run. Notice the returned message stating that the function requires a name in the request body.

    :::image type="content" source="../media/0706.png" alt-text="Screenshot of the please provide a name message.":::

9. Append **&name=yourname** to the end of the URL.

    > [!NOTE]
    > Replace **yourname** with your first name. For example, if your name is Cindy, the final URL will resemble the following `https://azfuncxxx.azurewebsites.net/api/HttpTrigger1?code=X9xx9999xXXXXX9x9xxxXX==&name=cindy`

    :::image type="content" source="../media/0707.png" alt-text="Screenshot of a highlighted function URL and an appended example user name in the address bar of a web browser. The hello message and user name are also highlighted to illustrate the output of the function in the main browser window.":::

10. When your function runs, trace information is written to log files in Azure. To view the logs in Azure portal, return to the function editor and, at the bottom of the page, click **Logs**.

    :::image type="content" source="../media/function-lab-select-function-logs.png" alt-text="Screenshot of a trace information log, resulting from running the function inside the function editor in Azure portal.":::

    > [!NOTE]
    > If no log information was collected, try waiting about 20 seconds.  If still no results show, retun to the browser tab where you pasted the function app URL, refresh the page and then return to the Logs view.

Congratulations! You have created a Function App to display a Hello message when there is an HTTP request. 

> [!NOTE]
> To avoid additional costs, you can remove this resource group. Search for resource groups, click your resource group, and then click **Delete resource group**. Verify the name of the resource group and then click **Delete**. Monitor the **Notifications** to see how the delete is proceeding.
