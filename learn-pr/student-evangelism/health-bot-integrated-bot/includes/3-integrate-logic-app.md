In this unit, we use Azure Logic Apps to connect our database to the healthcare bot.

Azure Logic Apps is a cloud-based platform for creating and running automated workflows. These workflows can integrate your apps, data, services, and systems.

To begin, go to the [Azure portal](https://portal.azure.com/#home).

## Create a new scenario

1. On the Azure services page, select **Create a resource**.

1. In the search bar, search for **Logic App** and then select the logic app resource.

   :::image type="content" source="../media/3-logic-app-creation.png" alt-text="Screenshot showing how to create a logic app resource." lightbox="../media/3-logic-app-creation.png":::

1. Select the **Create** button.

1. On the page that appears, fill in the required fields. All other fields can be left as the default.

   :::image type="content" source="../media/3-provision-logic-app.png" alt-text="Screenshot showing how to create a logic app." lightbox="../media/3-provision-logic-app.png":::

    - **Subscription**: Select your subscription.

    - **Resource group**: Select **Create new** and enter a unique name for the resource group, such as *Healthbot*. Then select **OK**.

    - **Plan type**: Select **Standard**.

    - **Logic App name**: Choose a unique name, such as *healthbotlearn*.

    - **Publish**: Select **Workflow**.

    - **Region**: Select any region. We used **Central US**.

   > [!Note]
   > Before you select **Review + create** in the next step, you can select **Next: Hosting** to see other details.

1. Select **Review + create**, and then **Create** to deploy the logic app.  

1. Select **Go to resource**.

   :::image type="content" source="../media/3-navigate-to-resource.png" alt-text="Screenshot showing how to go to a deployed logic app." lightbox="../media/3-navigate-to-resource.png":::

1. On the left, select **Workflows**.

   :::image type="content" source="../media/3-post-workflow.png" alt-text="Screenshot showing the Workflows selection in the menu on the left. The New workflow pane is open on the right." lightbox="../media/3-post-workflow.png":::

1. Select **Add**.

1. Name the workflow. We named our workflow *healthbot-post*. Select the state type as **Stateful**. Then select **Create**.

1. Select the workflow name to open it.

1. On the left, select **Designer**.

   :::image type="content" source="../media/3-http-request.png" alt-text="Screenshot showing the workflow designer. The selection on the right is labeled, 'When a H T T P response is received.'" lightbox="../media/3-http-request.png":::

1. In the search bar, search for and select **When a HTTP request is received**.

1. In the **Add new parameter** drop-down, select **Method**, and then select **POST**.

   :::image type="content" source="../media/3-http-post-method.png" alt-text="Screenshot showing the selection of the H T T P POST method." lightbox="../media/3-http-post-method.png":::

1. Select **Save**, and then copy the HTTP POST URL and save it for future reference.

   :::image type="content" source="../media/3-post-url.png" alt-text="Screenshot showing the generated H T T P POST U R L." lightbox="../media/3-post-url.png":::

1. For the request body JSON schema, use the following code:

   ```json
   {
    "properties": {
        "Age": {
            "type": "string"
        },
        "Height": {
            "type": "string"
        },
        "Weight": {
            "type": "string"
        },
        "name": {
            "type": "string"
        }
    },
    "type": "object"
   }
   ```

1. Select the plus sign (**+**) to add an action.

   :::image type="content" source="../media/3-insert-sql-row.png" alt-text="Screenshot showing how to add an action." lightbox="../media/3-insert-sql-row.png":::

1. In the search bar, search for **Insert row (V2)**. On the **Azure** tab, under **Actions**, select **Insert row (V2) SQL Server**.

   :::image type="content" source="../media/3-install-gateway.png" alt-text="Screenshot showing the selection for Insert row." lightbox="../media/3-install-gateway.png":::

1. Fill the table by using the following information:

    - **Connection name**: Name your connection. We used *healthbot-vitals*.
    - **Authentication Type**: Select **SQL Server Authentication**.
    - **SQL server name**: Paste the name for the SQL server you created. You can find it listed on the **Essentials** pane.
    - **SQL database name**: Paste your database name, such as *healthbot*.
    - **Username**: Provide the username you used to sign in to the query editor. We used *learnbot*.
    - **Password**: Provide the password you used to sign in to the query editor. We used *healthbot@123*.

1. Select the gateway if you already have one. Otherwise, select [**Install gateway**](/azure/logic-apps/logic-apps-gateway-install).

1. Select **Create**.

1. Provide the server name and database name you created in the previous unit.

   :::image type="content" source="../media/3-parameters-sql-row.png" alt-text="Screenshot showing the parameters for the SQL insert row." lightbox="../media/3-parameters-sql-row.png":::

1. Select your table name.

1. Select the required parameters. In this case, the parameters are **Name**, **Age**, **Height**, **Weight**, and **ColumnDateTime**.

   :::image type="content" source="../media/3-sql-table-columns.png" alt-text="Screenshot showing the selected columns for the SQL table." lightbox="../media/3-sql-table-columns.png":::

1. Add the parameters by selecting **Add dynamic content**.

   :::image type="content" source="../media/3-dynamic-content.png" alt-text="Screenshot showing how to add dynamic content." lightbox="../media/3-dynamic-content.png":::

1. Add the expression *getFutureTime(0, 'Day')*. 

   :::image type="content" source="../media/3-getfuturetime-function.png" alt-text="Screenshot showing the function get future time for timestamp." lightbox="../media/3-getfuturetime-function.png":::

   The fields should now look like this:

   :::image type="content" source="../media/3-insert-row-final.png" alt-text="Screenshot showing the final configuration for insert row." lightbox="../media/3-insert-row-final.png":::

1. In the designer, select the plus sign (**+**). Then under **Actions**, search for and select **Response**.

   :::image type="content" source="../media/3-http-response.png" alt-text="Screenshot showing how to select the H T T P response." lightbox="../media/3-http-response.png":::

1. Fill in the parameters.

   :::image type="content" source="../media/3-response-config.png" alt-text="Screenshot showing the H T T P response configuration." lightbox="../media/3-response-config.png":::

1. On the left, select **Overview** > **Run Trigger** > **Run with payload**.

   :::image type="content" source="../media/3-run-payload.png" alt-text="Screenshot showing the Run with payload pane." lightbox="../media/3-run-payload.png":::

1. Paste the HTTP POST URL that you copied earlier. Then fill in the remaining fields.

1. Select **Run**. If the workflow runs successfully, you've set up the parameters correctly.

> [!NOTE]
> If the workflow doesn't run, check the POST URL in an API tester to see if it responds.

## Set up the logic app for the GET method

Now we use the logic app to create a workflow for the GET method. This setup allows us to retrieve data from the database and display it.

1. On the **Workflows** page, select **Add** to add a new workflow.

   :::image type="content" source="../media/3-get-workflow.png" alt-text="Screenshot showing how to add a new workflow for the GET method." lightbox="../media/3-get-workflow.png":::

1. Name the workflow something like *healthbot-get*. Then select a state type of **Stateful**.

1. Select **Create**.

1. After the workflow is created, under **Developer**, select **Designer**.

   :::image type="content" source="../media/3-logic-app-designer.png" alt-text="Screenshot showing the logic app designer." lightbox="../media/3-logic-app-designer.png":::

1. Select **Add a new action**.

1. Search for *HTTP request* and then select **When a HTTP request is received**.

1. In the **Add new parameter** drop-down, select **Method**, and then select **GET**.

   :::image type="content" source="../media/3-get-method.png" alt-text="Screenshot showing how to add the GET method." lightbox="../media/3-get-method.png":::

1. Select **Save**. Note the HTTP GET URL. We're going to need it later to run the workflow.

1. Add a new action, select the **Azure** tab, search for and then select **Execute a SQL Query (V2)**.

   :::image type="content" source="../media/3-sql-query.png" alt-text="Screenshot showing parameter selections for the SQL query." lightbox="../media/3-sql-query.png":::

1. In the new fields, add the following settings:

   - **Server name**:  Select the server name we used earlier.

   - **Database name**: Select the name of your database.

   - **Query**: Enter the following code:

       ```sql
       SELECT * FROM Vitals WHERE ColumnDateTime=(SELECT MAX(ColumnDateTime) FROM Vitals)
       ```

1. Add a new action to the designer and search for *response*. Then open the response pane and fill in the fields:

   - **Status Code**: Enter *200*.
   - **Body**: Select **Add dynamic content** and then select **Query Results**.

   :::image type="content" source="../media/3-http-response-block.png" alt-text="Screenshot showing parameters for the H T T P response." lightbox="../media/3-http-response-block.png":::

After you've added the three components (HTTP request, Execute SQL query, and Response), select **Save**.

:::image type="content" source="../media/3-final-get.png" alt-text="Screenshot showing the three added components in the logic app designer." lightbox="../media/3-final-get.png":::

Run the workflow like you did for the GET method workflow. If it runs successfully, your logic app is ready to use!
