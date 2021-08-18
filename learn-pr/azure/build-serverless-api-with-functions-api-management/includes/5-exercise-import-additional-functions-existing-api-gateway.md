Recall that you want to integrate all of the separate microservices in the Online Store, which are Azure Functions, into a single API. You have already added the Products function to a new instance of API Management. Now you want to add more functions.

In this exercise, you'll add the Orders function app to the API and use the `curl` tool to test the integrated system.

## Test the OrderDetails function

Before we add the Orders function app to the API, let's test the function it hosts - OrderDetails.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, select **All resources**. The **All resources** pane appears.

1. Select the Function App whose name begins with **OrderFunction**. The Function App pane appears for this order function.

1. In the middle menu pane, under **Functions**, select **Functions**. The **Functions** pane appears for your Function App.

1. From the list, select **OrderDetails**. The **OrderDetails** pane appears for function.

1. In the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears for the **OrderDetails** function.

1. In the top menu bar, select **Test/Run**.

    :::image type="content" source="../media/5-test-order-details.png" alt-text="Order details code is displayed.":::

    The *Test* pane appears.

1. On the **Input** tab, in the **HTTP method** dropdown, select **GET**, and then under **Query**, select **Add parameter**.

1. In the **Name** field, enter *name*, and in the **Value** field, enter *Chiba*. The value is case-sensitive.

1. Select **Run**, examine the results on the **Output** tab, and then select **Close**.

    :::image type="content" source="../media/5-order-test-results.png" alt-text="Add a new function option page appears.":::

    The output pane displays the details of an order in JSON format. You can also test the function with the names "Henri" and "Barriclough" for different orders.

1. On the top menu bar of the **Code + Test** pane for your **OrderDetails** function, select **Get function URL**. Notice that the URL is the name of the function within the **azurewebsites.net** domain. Make a note of this URL for later comparison.

## Add another function app to existing API

In this step, we'll add the Order function to the API Management resource that we created in the preceding exercise. In that exercise, we used the API Management interface from within the function app interface. Here, we'll navigate to our API Management instance through the portal main navigation pane, just to demonstrate that both approaches are available.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu, or from the **Home** page, select **All resources**. The **All resources** pane appears.

1. Select the Function App whose name begins with **OrderFunction**. The **OrderFunction** pane appears for the function app.

1. In the middle menu bar, under **API**, select **API Management**. The **API Management** pane appears for the **OrderFunction** function app.

1. Under the **API Management** field, select **Create new**. The **API Management service** pane appears.

1. Enter the following API Management values for each setting.

    | Setting | Value |
    | --- | --- |
    | Name | Use a unique name within the **azure-api.net** domain |
    | Subscription | Concierge Subscription |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Location | Choose one of the following locations that supports the Consumption Plan: **West US**, **North Central US**, **West Europe**, **North Europe**, **Southeast Asia**, **Australia East**  |
    | Organization name | OnlineStore |
    | Administrator email | Accept the default value |
    | Pricing tier | Consumption |

1. Select **Export** to create the API Management instance. This may take several minutes.

1. On the top menu bar, select **Go to API Management**. The **API Management service** pane appears.

1. In the left menu pane, under **APIs**, select **APIs**. In the **APIs** page for your API Management service, in the left menu pane, select **Add API**. The **APIs** pane appears for the API Management service.

1. Under **Create from Azure resource**, select **Function App**.

    ![Screenshot of the Add a New API screen with a callout highlighting the Azure Function App option.](../media/5-import-azure-function-app.png)

    The **Create from Function App** dialog box appears.

1. To select your function, select **Browse**. The **Import Azure Functions** pane appears.

1. Select **Select** at the end of the **Configure required settings** field containing the name *Function App*.

    [ ![Screenshot of the Import Azure Functions with the Function App Configure Required Settings option selected.](../media/5-import-azure-function-app-03-inline.png) ](../media/5-import-azure-function-app-03-expanded.png#lightbox)

    The **Select Azure Function App** pane appears.

1. In the list of Function Apps, select the **OrderFunction**, and then select **Select**. The **Import Azure Functions** pane reappears.

1. Ensure that **OrderDetails** is checked, and then select **Select**. The **Create from Function App** dialog box reappears.

1. In the **API URL suffix** field, enter *orders*, and then select **Create**.

    ![Screenshot of the Create from Function App dialog populated with details of the Orders function.](../media/5-complete-function-import.png)

    The **APIs** pane reappears for the API Management service.

## Test the OnlineStore orders endpoint in the portal

Now that we've added OrderDetails to our API, let's test it by using the API Management tools in the Azure portal.

1. In the **APIs** window for your **API Management service** page that appears from the previous section, in the left menu pane, under **All APIs**, ensure that your **OrderFunction** API is selected.

1. In the list of operations, select **GET OrderDetails**, and then select the **Test** tab.

1. Under **OrderDetails**, in the **Query parameters** section, select **Add parameter**.

1. In the **NAME** field, enter *name*, and in the **VALUE** field, enter *Chiba*, and then select **Send**.

1. In the **HTTP response** section, notice that the details of an order have been returned in JSON format. Also, notice the **HTTP request** was sent to a destination within the **azure-api.net** domain. This location is different than the **azurewebsites.net** domain where the original function app is hosted.

## Test the combined API

We can use the `curl` command-line tool to submit requests to our API. It's ideal because we can use it to include the correct subscription key with our requests. To submit requests, we also need the location of the API, which is hosted in Azure API Management and consists of the Products and Orders functions.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources**, and then select your ProductFunction instance (ProductFunction as Function App type). The **ProductFunction** pane appears for the Function App.

1. In the **Essentials** section of the **Overview** pane, select the **Copy to clipboard** icon to the right of the **URL** field.

1. In Cloud Shell, run the following command, paste the **URL** value that you just copied in place of the token, and then press <kbd>Enter</kbd>.

    ```bash
    GATEWAY_URL=<paste the URL here>
    ```

1. In  the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), in the middle menu bar, under **API**, select **API Management**. The **API Management** pane appears for your **ProductFunction** function app.

1. In the top menu bar, select **Go to API Management**. The **API Management service** pane appears.

1. In the left menu pane, under **APIs**, select **Subscriptions**. The **Subscriptions** pane appears for your API Management service instance.

1. To the far right of **Built-in all-access subscription**, select the ellipsis **...**, and then select **Show/hide keys**.

1. To the right of **Primary key** field, select the *Copy to clipboard* icon.

1. In Cloud Shell, run the following command, paste the **PRIMARY KEY** value that you copied in place of the token, and then press <kbd>Enter</kbd>.

    ```bash
    SUB_KEY=<paste the key here>
    ```

1. To request the details of a product, run the following command in Cloud Shell.

    ```bash
    curl -X GET "$GATEWAY_URL/products/ProductDetails?id=2" -H "Ocp-Apim-Subscription-Key: $SUB_KEY"
    ```

    The command returns the details of a product. You can also try the command with IDs 1 and 3 for different results.

1. To request the details of an order, run the following command, and then press <kbd>Enter</kbd>.

    ```bash
    curl -X GET "$GATEWAY_URL/orders/OrderDetails?name=Henri" -H "Ocp-Apim-Subscription-Key: $SUB_KEY"
    ```

    The command returns the details of an order. You can also try the command with the names "Chiba" and "Barriclough" for different results.

Notice that both the functions can now be called through endpoints within the **azure-api.net** domain, which is the domain used by Azure API Management. We can also access them both by using the same subscription key, because that key grants access to the API Management gateway. In other Learn modules, you can learn how to apply policies, security settings, external caches, and other features to all the functions in an API Management Gateway. The gateway provides you with a central control point, where you can manage multiple microservices without altering their code.
