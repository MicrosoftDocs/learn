Tailwind Traders has chosen Azure SQL Database for part of its migration. You've been tasked with creating the database.

In this exercise, you'll create a SQL database in Azure and then query the data in that database.

## Task 1: Create the database

In this task, you create a SQL database based on the *AdventureWorksLT* sample database.
 
1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
 
1. Select **Create a resource** &gt; **Databases** &gt; **SQL database**. The **Create SQL Database** pane appears.
  
1. Enter the following values for each setting.

     | Setting | Value |
     | ----- | ----- |
     | **Project details** |
     | Subscription | Concierge Subscription |
     | Resource group | \[sandbox resource group name\] | 
     | **Database details** |
     | Database name | db1 |
     | Server | Select **Create new** |

    The **Create SQL Database Server** pane appears. 
  
1. Enter the following values for each setting.

     | Setting | Value |
     | ----- | ----- | 
     | **Server details** |
     | Server name | sqlservernnnn (replace **nnnn** with letters and digits for a globally unique name) |
     | Location | (US) East US | 
     | **Authentication** |
     |	Authentication method |	Use SQL Authentication |
     |	Server admin login | sqluser |
     |	Password |	Pa$$w0rd1234 |

1. Select **OK**. 

1. Complete the remaining fields for **Create SQL Database** using the following values.

     | Setting | Value |
     | ----- | ----- | 
     | Want to use SQL elastic pool? | No (default) | 
     | Compute + storage  | General Purpose (default) | 
     | **Backup storage redundancy** |
     | Backup storage redundancy | Geo-redundant backup storage |

    :::image type="content" source="../media/server-pane-df80b536.png" alt-text="Screenshot of create SQL database with fields filled in." lightbox="../media/server-pane-df80b536.png" :::

1. Select **Next : Networking**, and configure the following settings (accept defaults for fields not specified).

    | Setting | Value |
    | ----- | ----- |
    | **Network connectivity** |
    | Connectivity method | Public endpoint |

    :::image type="content" source="../media/tab-8a36cd61.png" alt-text="Screenshot of the Create SQL Database Networking tab with settings configured.":::
    
1. Select **Next : Security**, and for **Enable Azure Defender for SQL**, choose **Not now**. Leave the remaining settings as default (not configured).
  
    :::image type="content" source="../media/security-tab-a15c3422.png" alt-text="Screenshot of the Create SQL Database Security tab showing the first configured setting.":::
    
1. Select **Next : Additional settings**, and configure the following settings.

    | Setting | Value |
    | ----- | ----- |
    | **Data source** |
    | Use existing data | Sample |
    | **Database collation** |
    | Collation | SQL_Latin1_General_CP1_CI_AS (default) |

     :::image type="content" source="../media/additional-settings-tab-5e601100.png" alt-text="Screenshot of the Additional settings tab of the Create SQL Database pane with settings selected.":::
    
1. Select **Review + create** to validate configuration entries.
  
1. Select **Create** to deploy the server and database. It can take approximately two to five minutes to create the server and deploy the sample database. The deployment pane shows the status, with updates for each resource that is created.

1. When deployment is complete, select **Go to resource**. The db1 SQL database Overview pane shows the essentials of the newly deployed database

1. In the command bar, select **Set server firewall**. The **Firewall settings** page appears.
 
1. Set **Allow Azure services and resources to access this server** to **Yes**, leaving other settings as default.

1. In the command bar, select **Save** to update firewall settings, and then close the Firewall settings pane.

## Task 2: Test the database

In this task, you configure the server and run a SQL query.

1. In Azure resources menu select **All resources**. Search for and select the **SQL database** resource Type, and ensure that your new database was created. You might need to refresh the page. 
  
    :::image type="content" source="../media/sql-database-d2ebb307.png" alt-text="Screenshot of the SQL database Query editor preview.":::
    
1. Select **db1**, the SQL database you created.
  
1. In the SQL database menu, select **Query editor (preview)**. The **Query editor (preview)** pane appears.
  
     :::image type="content" source="../media/query-editor-preview-b6af6d9c.png" alt-text="Screenshot of the SQL database the Query editor preview highlighted.":::
    
1. Sign in as **sqluser**, with the password **Pa$$w0rd1234**.
  
    You will not be able to sign in because your IP address needs to be enabled in a firewall rule.
    
    :::image type="content" source="../media/query-editor-login-2b2dd335.png" alt-text="Screenshot of the Query Editor sign-in page with the IP address error.":::
    
1. In the Query editor menu, select **Overview** (your edits will be lost), and in the command bar, select **Set server firewall**. The **Firewall settings** page appears.

1. In the **Client IP address** section, your IP will be shown (verify that it is the same client IP address from the error you received in the previous step). 

1. In the command bar select **Add client IP**. This will add a **Rule name** that contains your IP address in both the **Start IP** and **End IP** fields.
 
1. In the command bar, select **Save** to save this firewall rule. 
 
    :::image type="content" source="../media/sql-server-firewall-settings-1b917b84.png" alt-text="Screenshot of the SQL Server firewall settings page, with your IP settings and the command bar buttons highlighted." lightbox="../media/sql-server-firewall-settings-1b917b84.png" :::
    
1. Select your db1 database in the breadcrumb at the top of the page to return to your SQL database, and then select **Query editor (preview)** from the menu. sign-in page. 

1. Sign in again as **sqluser**, with the password **Pa$$w0rd1234**. This time you should succeed. It might take a couple of minutes for the new firewall rule to be deployed. If you still get an error, verify the client IP address in the error, and return to **Firewall settings** to add the correct client IP address.
  
1.  After you sign in successfully, the query pane appears. Enter the following SQL query into the editor pane.
    
    ```SQL
    SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
    FROM SalesLT.ProductCategory pc
    JOIN SalesLT.Product p
    ON pc.productcategoryid = p.productcategoryid;
    ```

    :::image type="content" source="../media/query-editor-decc7acc.png" alt-text="Screenshot of the query editor with the query pane, and the commands running successfully.":::
    
1.  Select **Run**, and then review the query results in the **Results** pane. The query should run successfully.
    
    :::image type="content" source="../media/database-query-editor-pane-19d53288.png" alt-text="Screenshot of the database query editor, showing the SQL code ran successfully and the output.":::
    
Congratulations! You've created a SQL database in Azure and successfully queried the data in that database.
