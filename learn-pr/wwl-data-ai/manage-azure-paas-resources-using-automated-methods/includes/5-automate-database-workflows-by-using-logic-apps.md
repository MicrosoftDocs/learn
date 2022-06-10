Azure Logic Apps is a cloud-based platform for creating and running automated workflows that integrate your apps, data, services, and systems. With this platform, you can quickly develop highly scalable integration solutions for your enterprise and business-to-business (B2B) scenarios. As a member of Azure Integration Services, Azure Logic Apps simplifies the way that you connect legacy, modern, and cutting-edge systems across cloud, on premises, and hybrid environments.

The following list describes just a few example tasks, business processes, and workloads that you can automate using the Azure Logic Apps service:

- Schedule and send email notifications using Office 365 when a specific event happens, for example, a new file is uploaded.

- Route and process customer orders across on-premises systems and cloud services.

- Move uploaded files from an SFTP or FTP server to Azure Storage.

- Monitor tweets, analyze the sentiment, and create alerts or tasks for items that need review.

## Why use Azure Logic Apps?

The Azure Logic Apps integration platform provides prebuilt Microsoft-managed API connectors and built-in operations so you can connect and integrate apps, data, services, and systems more easily and quickly, where you can focus on designing and implementing your solution's business logic and functionality, not on figuring out how to access your resources.

You usually won't have to write any code. However, if you do need to write code, you can create code snippets using Azure Functions and run that code from your workflow. You can also create code snippets that run in your workflow by using the Inline Code action. If your workflow needs to interact with events from Azure services, custom apps, or other solutions, you can monitor, route, and publish events using Azure Event Grid.

Logic Apps is fully managed by Microsoft Azure, which frees you from worrying about hosting, scaling, managing, monitoring, and maintaining solutions built with these services. When you use these capabilities to create "serverless" apps and solutions, you can just focus on the business logic and functionality. These services automatically scale to meet your needs, make integrations faster, and help you build robust cloud apps using little to no code.

## SQL Server connector

The SQL Server connector allows you to access your SQL database with the SQL Server connector in Azure Logic Apps. You can then create automated workflows that are triggered by events in your SQL database or other systems and manage your SQL data and resources.

For example, you can use actions that get, insert, and delete data along with running SQL queries and stored procedures. You can create workflow that checks for new records in a non-SQL database, does some processing work, creates new records in your SQL database using the results, and sends email alerts about the new records in your SQL database.

The SQL Server connector supports the following SQL editions:

- SQL Server
- Azure SQL Database
- Azure SQL Managed Instance

The SQL Server connector requires that your tables contain data so that SQL connector operations can return results when called. For example, if you use Azure SQL Database, you can use the included sample databases to try the SQL connector operations.

For a SQL database in Azure, the connection string has the following format:

```
Server=tcp:{server-name}.database.windows.net,1433;Initial Catalog={database-name};Persist Security Info=False;User ID={user-name};Password={password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

Alternatively, you can also check the connection string for your Azure SQL Database in the Azure portal. On the **Overview** section for your database, select **Show database connection strings** for **Connection strings** property.

If you want to start your workflow with a SQL Server trigger operation, you have to start with a blank workflow.

The SQL Server connector  is available for logic app workflows in multi-tenant Azure Logic Apps, integration service environment (ISE), and single-tenant Azure Logic Apps:

- **Consumption workflows in multi-tenant Azure Logic Apps –** this connector is available only as a managed connector. For more information, review the [managed SQL Server connector operations](/connectors/sql/).

- **Consumption workflows in an integration service environment –** this connector is available as a managed connector and as an ISE connector that's designed to run in an ISE. For more information, review the [managed SQL Server connector operations](/connectors/sql/).

- **Standard workflows in single-tenant Azure Logic Apps –** this connector is available as a managed connector and as a built-in connector that's designed to run in the same process as the single-tenant Azure Logic Apps runtime. However, the built-in version differs in the following ways:

    - The built-in SQL Server connector has no triggers.
    - The built-in SQL Server connector has only one operation: Execute Query

## Create a logic app workflow

The following steps use the Azure portal to create logic app workflows:

### Add a SQL Server trigger

The following steps use the Azure portal, but with the appropriate Azure Logic Apps extension, you can also use Visual Studio Code to create logic app workflows:

1. In the Azure portal, open your blank logic app workflow in the designer.

1. Find and select the managed SQL Server connector trigger that you want to use. Under the designer search box, select **All**.

1. In the designer search box, enter *sql server*.

1. From the triggers list, select the SQL trigger that you want. This example uses the trigger named **When an item is created**.

    :::image type="content" source="../media/module-66-automation-final-39.png" alt-text="Screenshot showing the Azure portal, workflow designer for Consumption logic app.":::

1. If you're connecting to your SQL database for the first time, you're prompted to create your SQL database connection now. After you create this connection, you can continue with the next step.

1. In the trigger properties, specify the interval and frequency for how often the trigger checks the table.

1. To add other properties available for this trigger, open the **Add new parameter** list and select those properties.

	>[!NOTE]
    > This trigger returns only one row from the selected table, and nothing else. To perform other tasks, continue by adding either a SQL Server connector action or >another action that performs the next task that you want in your logic app workflow.
    > 
    >For example, to view the data in this row, you can add other actions that create a file that includes the fields from the returned row, and then send email alerts. To learn about other available actions for this connector, see the connector's reference page.

1. On the designer toolbar, select **Save**. this step automatically enables and publishes your logic app live in Azure

### Add a SQL Server action

The following steps use the Azure portal. In this example, the logic app workflow starts with the Recurrence trigger, and calls an action that gets a row from a SQL database.

1. In the Azure portal, open your logic app workflow in the designer.

1. Find and select the managed SQL Server connector action that you want to use. This example uses the action named **Get row**.

1. Under the trigger or action where you want to add the SQL action, select **New step**.

1. In the **Choose an operation** box, under the designer search box, select **All**.

1. In the designer search box, enter *sql server*.

1. From the actions list, select the SQL Server action that you want. This example uses the **Get row** action, which gets a single record.

    :::image type="content" source="../media/module-66-automation-final-40.png" alt-text="Screenshot showing the Azure portal, workflow designer for Consumption logic app, the search box with sql server, and Get row selected in the Actions list.":::

1. If you haven't already provided the SQL server name and database name, provide those values. Otherwise, from the Table name list, select the table that you want to use. In the *Row ID* property, enter the ID for the record that you want. In this example, the table name is *SalesLT.Product*.

    :::image type="content" source="../media/module-66-automation-final-41.png" alt-text="Screenshot showing Consumption workflow designer and the Get row action with the example Table name property value and empty row ID.":::

	>[!NOTE] 
    >This action returns only one row from the selected table, and nothing else. 

1. When you're done, on the designer toolbar, select **Save**.

### Connect to Azure SQL Database

In the workflow designer, you must create a connection the first time you add a trigger or action for the first time. This information varies depending on the connection, for example:

- The name that you want to use for the new connection

- The name for the system or server

- Your user or account credentials

- The authentication type to use
