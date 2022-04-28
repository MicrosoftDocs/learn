You have a Web API called Print Framer API that calculates a cost for a picture frame based on the dimensions you send to it. Developers throughout your company want to use this in their Logic Apps, but there is currently no way to make that connection.

In this exercise, you'll create a custom connector for the Print Framer API and use it to send and receive data from a Logic App to a Web API. First, we need a Logic App.

## Create a Logic App

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Web**, then search for and select **Logic App (Consumption)**. The **Logic App (Consumption)** pane appears.

1. Select **Create**. The **Create a logic app** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | Select *<rgn>Sandbox resource group </rgn>* |
    | **Instance details** |
    | Logic app name | Choose a unique name. Make a note of it, you'll need it later on. |
    | Region | Select a region near you from the following list. |
    | Enable log analytics | Off |
    | | |

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**, then select **Create** after validation succeeds.

1. After your Logic App has been created, select **Go to resource**. The Azure portal opens the designer for the Logic App.

1. Under **Start with a common trigger**, select **When an HTTP request is received**.

1. Select **Add a new parameter**, and then select**Method**.

1. In the **Method** dropdown list, select **GET**.

1. Once again, select **Add a new parameter**, then select **Relative path**, and in the **Relative path** field, enter `{height}/{width}`.

    ![Configure the HTTP request for the Logic App.](../media/5-configure-http-request.png)

1. In the **Logic Apps Designer**, select **Save**.

We now have a basic Logic App. Let's add a custom connector so that we can call our custom PrintFramer API from our workflow.

## Create a new custom Logic Apps connector in the Azure portal

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the search box, search for and select **Logic Apps Custom Connector**. The **Logic Apps Custom Connector** pane appears.

1. Select **Create**. The **Create logic apps custom connector** appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select *Use existing* and choose *<rgn>Sandbox resource group </rgn>* |
    | **Instance details** |
    | Custom connector name | PrintFramerConnector |
    | Region | Select a region near you, that is also in the list of regions supported by the sandbox. |
    | | |

1. Select **Review + create**. After validation succeeds, select **Create**.

1. After deployment completes, select **Go to resource**.

## Import the OpenAPI definition

Now let's use the OpenAPI file we saved early to define custom connector.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) or from the **Home** page, select **All resources**, and then select **PrintFramerConnector**.

1. On the **Overview** page, select **Edit**.

    ![Edit the custom connector.](../media/5-edit-logic-apps-connector.png)

1. In the **Custom connectors** section, select **OpenAPI file**, and then select **Import**. Open the JSON file you saved in the last exercise.

## Configure the custom connector

The OpenAPI file tells the custom connector about the operations that are available in the Web API. There are a few other properties we must set for the custom connector:

1. In the **General Information** section, in the **Description** box, enter **Obtain an estimate for a picture frame**. You might have to scroll down to see this part of the configuration pane.

1. In the **Host** textbox, enter the URL you noted earlier.

1. On the **Security** pane, ensure the **No Authentication** is selected.

    > [!IMPORTANT]
    > For this demonstration, it's OK to allow access to the API without any authentication. For real-world APIs, which contain sensitive data or require a paid subscription, authentication is essential.

1. On the **Definition** pane, in the **Summary** textbox, enter **Estimate the cost of a picture frame**.

1. Under **Visibility**, select **Important**.

1. At the top of the pane, select **Update connector**.

## Add the custom connector to our Logic App

Now, you can add the custom connector to our Logic App.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) or from the **Home** page, under **Azure resources**, select **All resources**, and then select the Logic App that you created in unit 3.

1. In the Logic App resource pane, select **Edit**, and then select **New Step**.

1. In the **Choose an action** box, select the **Custom** tab, and then select **PrintFramerConnector**.

1. Under **Actions**, select **Estimate the cost of a picture frame**.

1. In the **Estimate the cost of a picture frame** box, select the **Height** field, and then select **height** from the **Dynamic content** pane on the right. The following screenshot illustrates this selection.

    ![Bind the height parameter to the custom connector.](../media/5-bind-height-parameter.png)

1. Select the **Width** field, and under **Dynamic content**, select **width**.

The height and width parameters that we receive from each HTTP request that triggers our Logic App are now bound to the height and width parameters we pass to the PrintFramerConnector.

## Complete the Logic App

The final thing to add to the Logic App is something to display the results. Let's use an HTTP response to show the estimate to the user:

1. In the Logic App designer, select **New Step**.

1. In the **Search connectors and actions** textbox, enter **Response**, and then select the **Response** action.

1. In the **Body** textbox, enter **The approximate cost of your frame is:$**.

1. In the **Dynamic content** pane to the right, select **Body** from the **Estimate the cost of a picture frame** section. This selection is illustrated in the following screenshot.

    ![Configure the HTTP response.](../media/5-configure-http-response.png)

1. Save your changes by selecting **Save** at the top of the Logic Apps designer.

## Test the Logic App

The Logic App is now complete, and will call the Web API through the custom connector. All you have to do is make a request to the Logic App, by using the browser:

1. In the Logic Apps designer, expand the **When an HTTP request is received** box.

1. To the right of the **HTTP GET URL** textbox, select **Copy URL**.

1. Open a new browser tab and paste the URL into the address bar.

1. In the pasted URL, replace the **{height}** parameter with **10**, and the **{width}** parameter with **4** and then press <kbd>Enter</kbd>. The pane displays an approximate cost.

1. Try entering other heights and widths.

Congratulations! You've created a Logic Apps workflow that can call your in-house PrintFramerAPi through a custom connector!
