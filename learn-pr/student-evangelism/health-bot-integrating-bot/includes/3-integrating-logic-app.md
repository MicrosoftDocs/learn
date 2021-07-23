In this unit, we'll use Azure Logic Apps to connect our database to the healthcare bot.

Azure Logic Apps is a cloud-based platform for creating and running automated workflows. These workflows can integrate your apps, data, services, and systems.

To begin, go to the [Azure portal](https://portal.azure.com/#home).

## Create a new scenario

1. On the Azure services page, select **Create a resource**.

1. In the search bar, search for **Logic App** and then select the logic app resource.

   :::image type="content" source="../media/3-logic-app-creation.png" alt-text="Screenshot showing how to create a logic app resource." lightbox="../media/3-logic-app-creation.png":::

1. Select the **Create** button.

1. On the page that appears, fill in the required fields.

   :::image type="content" source="../media/3-provision-logic-app.png" alt-text="Screenshot showing how to provision a logic app." lightbox="../media/3-provision-logic-app.png":::

    - **Subscription**: Select your subscription.

    - **Resource group**: Select **Create new** and enter a unique name for the resource group, such as *Healthbot*. Then select **OK**.

    - **Type**: Select **Standard**.

    - **Logic App name**: Choose a unique name, such as *healthbotlearn*.

    - **Publish**: Select **Workflow**.

    - **Region**: Select any region. We'll use **Central US**.

   > [!Note]
   > Before you select **Review + create** in the next step, you can select **Next: Hosting** to see other details.

1. Select **Review + create** to create and deploy the logic app.  

1. Select **Go to resource**.

   :::image type="content" source="../media/3-navigate-to-resource.png" alt-text="Screenshot showing how to go to a deployed logic app." lightbox="../media/3-navigate-to-resource.png":::

1. On the left, select **Workflows**.

   :::image type="content" source="../media/3-post-worflow.png" alt-text="Screenshot showing the Workflows selection in the menu on the left. The New workflow pane is open on the right." lightbox="../media/3-post-worflow.png":::

1. Select **Add**.

1. Name the workflow. We'll name our workflow *healthbot-post*. Select the state type as **Stateful**. Then select **Create**.

1. Select the workflow name to open it.

1. On the left, select **Designer**.

   :::image type="content" source="../media/3-http-request.png" alt-text="Screenshot showing the workflow designer. The selection on the right is labeled, 'When a HTTP response is received.'" lightbox="../media/3-http-request.png":::

1. Choose an operation. Then, in the search bar, search for and select **When a HTTP request is received**.

1. Select **Method** > **POST**.

   :::image type="content" source="../media/3-http-post-method.png" alt-text="Screenshot showing the selection of the HTTP POST method." lightbox="../media/3-http-post-method.png":::

1. Copy the HTTP POST URL and save it for future reference.

   :::image type="content" source="../media/3-post-url.png" alt-text="Screenshot showing the generated HTTP POST URL." lightbox="../media/3-post-url.png":::

1. For the request body JSON schema, use the following code:

   ```json
   "'{
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

1. In the search bar, search for **Insert row (V2)**. On the **Azure** tab, under **Actions**, select **Insert now (V2) SQL Server**.

   :::image type="content" source="../media/3-install-gateway.png" alt-text="Screenshot showing the selection for Insert now (V2)." lightbox="../media/3-install-gateway.png":::

1. Fill the table by using the following information:

    - **Connection name**: Name your connection. We'll use *healthbot-vitals*.
    - **Authentication Type**: Select **SQL Server Authentication**.
    - **SQL server name**: Paste the name for the SQL server you created. You'll find it listed on the **Essentials** pane.
    - **SQL database name**: Paste your database name, such as *healthbot*.
    - **Username**: Provide the username you used to log in to the query editor. We used *learnbot*.
    - **Password**: Provide the password you used to log in to the query editor. We used *healthbot@123*.

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

   :::image type="content" source="../media/3-http-response.png" alt-text="Screenshot showing how to select the HTTP response." lightbox="../media/3-http-response.png":::

1. Fill in the parameters.

   :::image type="content" source="../media/3-response-config.png" alt-text="Screenshot showing the HTTP response configuration." lightbox="../media/3-response-config.png":::

1. On the left, select **Overview** > **Run with payload**.

   :::image type="content" source="../media/3-run-payload.png" alt-text="Screenshot showing the Run with payload pane." lightbox="../media/3-run-payload.png":::

1. Paste the HTTP POST URL that you copied earlier. Then fill in the remaining fields.

1. Select **Run**. If the workflow runs successfully, you've set up the logic app correctly.

> [!NOTE]
> If the workflow doesn't run, check the POST URL in an API tester to see if it responds.

## Set up the logic app for the GET method

We'll now use the logic app to create a workflow for the GET method. This setup will allow us to retrieve data from the database and display it.

1. On the **Workflows** page, select **Add** to add a new workflow.

   :::image type="content" source="../media/3-get-workflow.png" alt-text="Screenshot showing how to add a new workflow for the GET method." lightbox="../media/3-get-workflow.png":::

1. Name the workflow something like *healthbot-get*. Then select a state type of **Stateful**.

1. Select **Create**.

1. After the workflow is created, on the left, under **Developer**, select **Designer**.

   :::image type="content" source="../media/3-logic-app-designer.png" alt-text="Screenshot showing the logic app designer." lightbox="../media/3-logic-app-designer.png":::

1. Select **Add a new action**. 

1. Search for *HTTP request* and then select **When a HTTP request is received**.

1. Note down the HTTP GET URL. We'll need it later to run the workflow.

   :::image type="content" source="../media/3-get-method.png" alt-text="Selecting GET method" lightbox="../media/3-get-method.png":::

1. Select **Method** > **GET**.

1. Add a new action and then search for *SQL query*.

   :::image type="content" source="../media/3-execute-sql-query.png" alt-text="Screenshot showing how to run a SQL query." lightbox="../media/3-execute-sql-query.png":::

1. Give the connection a unique name. You can copy the connection string from the SQL database.

   :::image type="content" source="../media/3-execute-query-connection.png" alt-text="Screenshot showing how to search for the Execute Query selection." lightbox="../media/3-execute-query-connection.png":::

1. To get the connection string, in the Azure portal, select the SQL database you created.

   :::image type="content" source="../media/3-sql-database.png" alt-text="SQL database" lightbox="../media/3-sql-database.png":::

1. From the left side menu bar, under settings, select **Connection strings**.

1. Under the ADO.NET, copy the string under ADO.NET (SQL authentication).

   :::image type="content" source="../media/3-ado-net.png" alt-text="ADO.net key" lightbox="../media/3-ado-net.png":::

1. Paste the string in the Connection string field of the Execute Query cell and select **create**.

   :::image type="content" source="../media/3-query-parameters.png" alt-text="Query parameters" lightbox="../media/3-query-parameters.png":::

1. In the Query field, enter SQL Query.

1. Under the **Add New Parameter** dropdown, select **Query Parameters**, and select the small tables Icon next to the Query Parameters.

   :::image type="content" source="../media/3-sql-query.png" alt-text="SQL query" lightbox="../media/3-sql-query.png":::

1. After you select the icon, you will be able to see new fields. Fill the new fields in the following way:

   - **Server Name**:  Select the same server's name we used previously from the dropdown menu.

   - **Database name**: Select the name of your database from the dropdown menu.

   - **Query**: Enter the following code in the Query field.

       ```
       SELECT - FROM Vitals WHERE ColumnDateTime=(SELECT MAX(ColumnDateTime) FROM Vitals)
       ```

   :::image type="content" source="../media/3-http-response-block.png" alt-text="http response" lightbox="../media/3-http-response-block.png":::

1. Add a new action to the designer and search for Response. Open the response cell and configure the fields in the following way:

   - **Status Code**: Enter 200.
   - **Body**: Select add dynamic content and add 'Query Results' from the list.

   :::image type="content" source="../media/3-final-get.png" alt-text="Logic App designer" lightbox="../media/3-final-get.png":::

After you have added the three components (HTTP Request, Execute SQL Query, Response) onto the designer, select **Save**. Run the workflow in the same way like you ran the workflow for GET method. If it runs successfully, your logic app is ready to use!
