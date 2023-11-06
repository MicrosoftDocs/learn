You have a Web API called Print Framer API that calculates a cost for a picture frame based on the dimensions you send to it. Developers throughout your company want to use this API in their Azure Logic Apps workflows, but there's currently no way to make that connection.

In this exercise, you'll create a custom connector for the Print Framer API and use it to send and receive data from a logic app workflow to a Web API. First, we need a logic app workflow.

## Create a logic app workflow

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Integration**, then find and select **Logic App**.

1. On the **Create Logic App** pane, under **Basics**, enter the following values for each setting.

   | Setting | Value |
   | --- | --- |
   | **Project Details** |
   | Subscription | Concierge Subscription |
   | Resource group | Select *<rgn>Sandbox resource group </rgn>* |
   | **Instance Details** |
   | Logic App name | Provide a unique name. Remember the name for later use. |
   | Publish | Workflow |
   | Region | Select a region near you. |
   | Enable log analytics | No |
   | **Plan** |
   | Plan type | Consumption |
   | **Zone redundancy** |
   | Zone redundancy | Leave as default (disables) |
   | | |

   [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create**, then select **Create** after validation succeeds.

1. After the portal creates your logic app resource, select **Go to resource**.

   The Azure portal shows a gallery with frequently used triggers and workflow patterns.

1. Under **Start with a common trigger**, select the Request trigger named **When an HTTP request is received**.

   The workflow designer now displays the trigger you selected.

1. Open the **Add a new parameter** list, and select **Method**.

1. From the **Method** list, select **GET**.

1. Open the **Add a new parameter** list again, and select **Relative path**. In the **Relative path** property, enter `{height}/{width}` as a literal string.

   ![Screenshot showing the Request trigger information.](../media/5-configure-http-request.png)

1. On the designer toolbar, select **Save**.

We now have a basic logic app workflow. Let's add a custom connector so that we can call our custom Print Framer API from our workflow.

## Create a new Azure Logic Apps custom connector in the Azure portal

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the search box, find and select **Logic Apps Custom Connector**.

1. On the **Logic Apps Custom Connector** pane, select **Create**.

1. On the **Create logic apps custom connector** pane, under **Basics**, enter the following values for each setting.

   | Setting | Value |
   | --- | --- |
   | **Project details** |
   | Subscription | Concierge Subscription |
   | Resource group | Select *<rgn>Sandbox resource group </rgn>* |
   | **Instance details** |
   | Custom connector name | PrintFramerConnector |
   | Region | Select a region that's near you and also supported by the sandbox. |
   | Associate with integration service environment | Leave unselected |
   | | |

1. Select **Review + create**. After validation succeeds, select **Create**.

1. After deployment completes, select **Go to resource**.

## Import the OpenAPI definition

Now use the OpenAPI file that you previously saved to define the custom connector.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) or from the **Home** page, select **All resources**, and then select **PrintFramerConnector**.

1. On the **Overview** page, select **Edit**.

   ![Screenshot showing editor for custom connector.](../media/5-edit-logic-apps-connector.png)

1. In the **Custom connectors** section, select **OpenAPI file**, and then select **Import**. Open the JSON file that you saved in the last exercise.

## Configure the custom connector

The OpenAPI file tells the custom connector about the operations that are available in the Web API. There are a few other properties you have to set for the custom connector.

1. In the **General Information** section, in the **Description** box, enter **Obtain an estimate for a picture frame**. You might have to scroll down to see this part of the configuration pane.

1. In the **Host** textbox, enter the Example URL that you noted earlier.

1. On the **Security** pane, make sure that **No Authentication** is selected.

   > [!IMPORTANT]
   > For this demonstration, it's OK to allow access to the API without any authentication. For real-world APIs, 
   > which contain sensitive data or require a paid subscription, authentication is essential.

1. On the **Definition** pane, in the **Summary** textbox, enter **Estimate the cost of a picture frame**.

1. Under **Visibility**, select **Important**.

1. At the top of the pane, select **Update connector**.

## Add the custom connector to your logic app workflow

Now, you can use the custom connector in your logic app workflow.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) or from the **Home** page, under **Azure resources**, select **All resources**, and then select the logic app resource that you created in unit 3.

1. In the logic app resource menu, select **Overview**. On the **Overview** pane toolbar, select **Edit**.

1. On the designer, select **New step**.

1. Under the **Choose an operation** search box, select **Custom**, and then select **PrintFramerConnector**.

1. Under **Actions**, select **Estimate the cost of a picture frame**.

1. In the **Estimate the cost of a picture frame** box, put your cursor in the **Height** field. From the dynamic content list that opens, select **height**.

   The following screenshot illustrates this selection:

   ![Screenshot shows the custom connector and the "height" parameter selected in the dynamic content list.](../media/5-bind-height-parameter.png)

1. Return to the custom connector, and put your cursor in the **Width** field. From the dynamic content list, select **width**.

   The height and width parameters received from each HTTP request that triggers our workflow are now bound to the height and width parameters that pass to the PrintFramerConnector.

## Complete the workflow

Finally, the workflow needs a way to display the results. You can use the Response action to show the estimate:

1. In the workflow designer, select **New step**.

1. In the **Choose an operation** search box, enter **Response**, and then select the action named **Response**.

1. In the **Body** field, enter **The approximate cost of your frame is:$**.

1. In the dynamic content list that opens, select **Body** from the **Estimate the cost of a picture frame** section.

   The following screenshot shows this selection:

   ![Screenshot shows setup for the "Response" action.](../media/5-configure-http-response.png)

1. When you're done, select **Save** to save your workflow.

## Test the workflow

The workflow is now complete and will call the Web API using the custom connector. Now, you just have to send a request that triggers the workflow, which you can do by using the browser.

1. In the workflow designer, expand the **When an HTTP request is received** action.

1. Next to the **HTTP GET URL** field, select **Copy URL**.

1. Open a new browser tab and paste the URL into the address bar.

1. In the pasted URL, replace the **{height}** parameter with **10**. Replace the **{width}** parameter with **4**. Press <kbd>Enter</kbd>.

   The browser pane displays an approximate cost.

1. Try entering other heights and widths.

Congratulations! You've created a logic app workflow that can call your in-house Print Framer API using a custom connector!
