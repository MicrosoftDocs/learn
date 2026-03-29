This guided project consists of the following exercises:

 - Create the Function App
 - Deploy an HTTP-trigger function
 - **Test endpoint and review logs**

In this exercise, you test your function endpoint, enable monitoring, secure the function with an access key, and review invocation logs. This walks you through the full lifecycle of deploying, securing, and monitoring a serverless function.

This exercise includes the following tasks:

 - Test the HTTP endpoint in a browser
 - Verify the function in the portal
 - Enable Application Insights
 - Restrict access to the function
 - Test restricted access
 - Review invocation logs

**Outcome:** Endpoint tested successfully and execution logs confirmed in the portal.

## Task 1: Test the HTTP endpoint in a browser

Call your function endpoint to verify it responds correctly. This validates that your serverless function is deployed, running, and reachable from the public internet.

1.  Open a new browser tab.
2.  Paste the **Invoke url** you copied from the deployment output in the previous exercise into the address bar and press **Enter**.
3.  Confirm the browser displays **Hello, world!** (or a similar greeting). This is the default response from the HTTP trigger template.
4.  Open an incognito or private browser window, paste the same URL, and press **Enter**.
5.  Confirm the function responds without requiring any sign-in. This works because you set the authorization level to **Anonymous** when you created the function.

> [!NOTE]
> **Validation step:** Confirm the public endpoint responds correctly with and without query parameters, and works in an incognito window without credentials.

## Task 2: Verify the function in the portal

Confirm the deployed function appears in the Azure portal alongside the Function App you created earlier.

1.  In the Azure portal, in the portal search bar, search for **Function App** and select **Function App**.
2.  Select the Function App you created in the previous exercise.
3.  In the **Overview** page, under **Functions**, confirm **GetStatus** appears in the list with a trigger type of **HTTP**.

> [!NOTE]
> **Validation step:** Confirm the **GetStatus** function appears in the Function App's function list in the portal.

## Task 3: Enable Application Insights

When you created the Function App, you skipped past the Monitoring tab and accepted the defaults. Now that you want to track invocations, you need to enable Application Insights. This is a common pattern in Azure—you can add monitoring after the fact without recreating your resources.

1.  Select **GetStatus** from the function list.
2.  In the top menu, select **Invocations**.
3.  The page displays a message that Application Insights is not configured. Select the **Configure Application Insights** button.
4.  On the Application Insights configuration page, select **Turn on Application Insights**.
5.  Before selecting **Apply**, note the **Log Analytics Workspace** name and location shown on the page. Write down the last four characters of the workspace name and the location—you need this information during cleanup.
6.  Select **Apply**. When the **Apply monitoring settings** dialog appears noting the site will be restarted, select **Yes**. Wait for the configuration to complete.
7.  Refresh the portal page (press **F5**) so the portal picks up the new Application Insights configuration.

> [!NOTE]
> Azure creates the Log Analytics workspace in a resource group named **DefaultResourceGroup-{region}**. This is separate from your project resource group and must be cleaned up separately.

> [!NOTE]
> **Validation step:** Confirm Application Insights is now enabled. The Invocations page should no longer show the configuration prompt.

## Task 4: Restrict access to the function

Now that monitoring is capturing data, change the authorization level so the function requires a key. This demonstrates how to secure a serverless endpoint.

1.  In the Azure portal, select the **Cloud Shell** icon in the top toolbar to reopen Cloud Shell.
2.  Navigate back to the project folder:

    ```bash
    cd func-gp-endpoint
    ```

3.  Run the following command to change the authorization level from **anonymous** to **function**:

    ```bash
    sed -i "s/authLevel: 'anonymous'/authLevel: 'function'/" src/functions/GetStatus.js
    ```

4.  Verify the change by running:

    ```bash
    grep authLevel src/functions/GetStatus.js
    ```

    Confirm the output shows `authLevel: 'function'`.

5.  Redeploy the function:

    ```bash
    FUNC_APP_NAME=$(az functionapp list --resource-group rg-gp-functions-endpoint --query "[0].name" -o tsv)
    func azure functionapp publish $FUNC_APP_NAME
    ```

7.  Wait for the deployment to complete.

> [!NOTE]
> **Validation step:** Confirm the deployment output shows the **GetStatus** function published successfully.

## Task 5: Test restricted access

Verify that the function now rejects all unauthenticated requests, then use a function key to regain access.

1.  Go back to the browser tab where you previously tested the function URL and refresh the page.
2.  Confirm you receive a **401 Unauthorized** response. The function now requires a key for every request because you changed the authorization level from **anonymous** to **function**.
3.  Return to the Azure portal. In the portal search bar, search for **Function App** and select **Function App**.
4.  Select your Function App, then select **GetStatus** from the function list.
5.  In the top menu, select **Function Keys**.
6.  Copy the **default** key value.
7.  Return to the browser tab with the function URL. Add **?code=** followed by the key you copied to the end of the URL and press **Enter**.
8.  Confirm the function now responds with **Hello, world!** again. The key in the URL proves you are authorized to call the function.

> [!NOTE]
> **Validation step:** Confirm the function returns 401 without a key and succeeds with the key appended.

## Task 6: Review invocation logs

Check Application Insights for records of your function invocations. The time spent in the previous tasks gave Application Insights time to process the data.

1.  In the portal search bar, search for **Function App** and select **Function App**.
2.  Select your Function App, then select **GetStatus** from the function list.
3.  In the top menu, select **Invocations**.
4.  Confirm the log shows your successful invocations (status **200**), including both the anonymous calls from Task 1 and the key-authenticated call from Task 5.
5.  Select an invocation entry to view details such as the status code, duration, and timestamp.

> [!NOTE]
> The 401 Unauthorized responses may not appear in the function Invocations tab. Azure rejects unauthorized requests at the host level before invocating the function, so they are not recorded as function executions.

> [!NOTE]
> **Validation step:** Confirm the invocation logs show your successful requests, demonstrating that Application Insights captures function activity.

> [!TIP]
> If invocation logs don't appear immediately, wait up to five minutes and select **Refresh**. Application Insights can take time to process new data.

> [!NOTE]
