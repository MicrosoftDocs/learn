In this unit, we will be using Azure Logic Apps to connect our database to the healthcare bot.

Azure Logic Apps is a cloud-based platform for creating and running automated workflows that integrate your apps, data, services, and systems.

To start with, go to the [Azure portal](https://portal.azure.com/#home).

:::image type="content" source="../media/3-logic-app-creation.png" alt-text="Creating logic app resource" lightbox="../media/3-logic-app-creation.png":::

## Creating a new scenario

1. In the Azure services page, select **Create a Resource**.

1. In the search bar, search for **Logic App**, and select the Logic App resource.

1. Select the **Create** button.

   :::image type="content" source="../media/3-provision-logic-app.png" alt-text="Provision a logic app" lightbox="../media/3-provision-logic-app.png":::

1. Fill in the required fields:

    - **Subscription:** Select your subscription.

    - **Resource group:** Select create new and enter a unique name for the resource group. In our case we use the name as 'Healthbot' and select **OK**.

    - **Type:** Select 'Standard' type

    - **Logic App Name:** The Logic App name may be a unique name of your choosing. We have given 'healthbotlearn'.

    - **Publish:** Select 'workflow'

    - **Region:** Select any region from the dropdown.Here we use "Central US".

1. Select the **Review + create** button to create and deploy the logic app.  

   > [!Note]
   > You may also select **Next: Hosting** to look at the other details before **Review + create**.

   :::image type="content" source="../media/3-navigate-to-resource.png" alt-text="Navigating to the logic app resource" lightbox="../media/3-navigate-to-resource.png":::

1. After deploying the logic app, select **Go to resource**.

1. Select workflows from the left column.

   :::image type="content" source="../media/3-post-worflow.png" alt-text="POST workflow creation" lightbox="../media/3-post-worflow.png":::

1. Select **Add**.

1. Type a Workflow Name (in this case we have given it as 'healthbot-post). Select the state type as **Stateful**, then select the **Create** button at the bottom.

1. After its creation, select the name ('healthbot-post' in this instance).

1. After it opens, select **Designer** from the left column.

   :::image type="content" source="../media/3-http-request.png" alt-text="when http response is recieved" lightbox="../media/3-http-request.png":::

1. Select choose an operation, and in the search bar, search for 'When a HTTP request is received', and then select it.

   :::image type="content" source="../media/3-http-post-method.png" alt-text="HTTP POST method" lightbox="../media/3-http-post-method.png":::

1. Select **Method**, and from the drop down, select POST.

   :::image type="content" source="../media/3-post-url.png" alt-text="HTTP POST URL" lightbox="../media/3-post-url.png":::

1. Copy the HTTP POST URL that is generated above, and save it for future reference.

1. For the request body JSON Schema, use the following code:

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

1. Select the **+** to add another action.

   :::image type="content" source="../media/3-insert-sql-row.png" alt-text="Insert sql row" lightbox="../media/3-insert-sql-row.png":::

1. Search for 'insert row(v2)' in the search bar and under the Azure tab, under actions, select the 'Insert now(v2)' SQL Server.

   :::image type="content" source="../media/3-install-gateway.png" alt-text="Install gateway" lightbox="../media/3-install-gateway.png":::

1. Fill the table as:

    - **Connection name:** Give a name for your connection. We have used 'healthbot-vitals'.
    - **Authentication Type:** Select 'SQL Server Authentication'.
    - **SQL Server name:** Go to the SQL server which you  have created previously, and note the SQL Server name from the essentials. Paste it in the field.
    - **SQL Database name:** Use the same database name as used in the the previous unit. We have used 'healthbot'.
    - **Username:** Provide the same username used for logging into the Query editor. We have used 'learnbot'.
    - **Password::** Provide the same password used for logging into the Query editor. We have used 'healthbot@123'.

1. Select the gateway if you already have one, else select [install gateway](/azure/logic-apps/logic-apps-gateway-install).

1. Select the **Create** button.

   :::image type="content" source="../media/3-parameters-sql-row.png" alt-text="Parameters for SQL insert Row" lightbox="../media/3-parameters-sql-row.png":::

1. Fill the required fields with the server and database name from the previous unit.

1. Select your table name from the drop down menu.

   :::image type="content" source="../media/3-sql-table-columns.png" alt-text="SQL table columns selection" lightbox="../media/3-sql-table-columns.png":::

1. Select the required parameters, which in this case will be: name, Age, Height, Weight and ColumnDateTime.

   :::image type="content" source="../media/3-dynamic-content.png" alt-text="Dynamic content selection" lightbox="../media/3-dynamic-content.png":::

1. Add name, Age, Height, Weight and ColumnDateTime, by clicking on 'Add dynamic content'.

   :::image type="content" source="../media/3-getfuturetime-function.png" alt-text="Function - getfuturetime for timestamp" lightbox="../media/3-getfuturetime-function.png":::

1. Add the expression 'getFutureTime(0, 'Day')'. The fields should now look like this:

   :::image type="content" source="../media/3-insert-row-final.png" alt-text="Insert row final configurations" lightbox="../media/3-insert-row-final.png":::

1. Select the **+** in the designer, search for 'response' under actions, and select it.

   :::image type="content" source="../media/3-http-response.png" alt-text="https response" lightbox="../media/3-http-response.png":::

1. Fill out the parameters as shown.

   :::image type="content" source="../media/3-response-config.png" alt-text="https response configuration" lightbox="../media/3-response-config.png":::

1. On the left column, select **Overview**, and click **Run with payload**.

   :::image type="content" source="../media/3-run-payload.png" alt-text="Test with payload" lightbox="../media/3-run-payload.png":::

1. Copy, paste the URL from step 14, and fill out the rest of the fields as shown.

1. Select **Run**. If the workflow runs successfully, it means that it's working perfectly.

> [!NOTE]
> If the workflow doesn't run, use the POST url in any API tester, and check for the response.

## Integrating Logic App for GET method

Using the same logic app that we created earlier, we will continue to create a new workflow for the GET method to retrieve the data from the database and to display it on to the screen.

:::image type="content" source="../media/3-get-workflow.png" alt-text="Worflow fo GET method" lightbox="../media/3-get-workflow.png":::

1. Select 'Add' in the workflows page to add a new workflow.

1. Give a name for the workflow. We have given it as 'healthbot-get' and select state type as 'Stateful'.

1. Select 'Create'.

   :::image type="content" source="../media/3-logic-app-designer.png" alt-text="Logic app designer" lightbox="../media/3-logic-app-designer.png":::

1. After the workflow is created, select **Designer** from the menu on the left side of the page under developer.

1. On the designer page, select **Add a new action**, search for HTTP Request, and then select **When a HTTP request is received**.

   :::image type="content" source="../media/3-get-method.png" alt-text="Selecting GET method" lightbox="../media/3-get-method.png":::

1. Note down the HTTP Get URL which we will later require to run the workflow.

1. In HTTP Request, select **Method** and choose the GET method.

1. Add a new action and search for SQL Query.

   :::image type="content" source="../media/3-execute-sql-query.png" alt-text="Executing SQL query" lightbox="../media/3-execute-sql-query.png":::

1. Give any unique name for the connection name. The connection string can be copied from the SQL Database.

   :::image type="content" source="../media/3-execute-query-connection.png" alt-text="Connecting execute query" lightbox="../media/3-execute-query-connection.png":::

1. To get the connection string, go to the main portal and click on the SQL Database that you have created.

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

   - **Server Name:**  Select the same server's name we used previously from the dropdown menu.

   - **Database name:** Select the name of your database from the dropdown menu.

   - **Query:** Enter the following code in the Query field.

       ```
       SELECT - FROM Vitals WHERE ColumnDateTime=(SELECT MAX(ColumnDateTime) FROM Vitals)
       ```

   :::image type="content" source="../media/3-http-response-block.png" alt-text="http response" lightbox="../media/3-http-response-block.png":::

1. Add a new action to the designer and search for Response. Open the response cell and configure the fields in the following way:

   - **Status Code:** Enter 200.
   - **Body:** Select add dynamic content and add 'Query Results' from the list.

   :::image type="content" source="../media/3-final-get.png" alt-text="Logic App designer" lightbox="../media/3-final-get.png":::

After you have added the three components (HTTP Request, Execute SQL Query, Response) onto the designer, select **Save**. Run the workflow in the same way like you ran the workflow for GET method. If it runs successfully, your logic app is ready to use!
