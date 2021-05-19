Tailwind Traders has chosen Azure SQL Database for part of its migration. You've been tasked with creating the database.

In this exercise, you'll create a SQL database in Azure and then query the data in that database.

## Task 1: Create the database

In this task, you create a SQL database based on the *AdventureWorksLT* sample database.

1.  Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
2.  Select **Create a resource** &gt; **Databases** &gt; **SQL database**. Fill in the following information.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        On the **Basics** tab, under **Project details** section:
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        **Concierge Subscription**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
         **\[sandbox resource group name\]** 
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Under **Database details** section:
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Database name
      :::column-end:::
      :::column:::
        **db1**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Server
      :::column-end:::
      :::column:::
        Select **Create new**.
      :::column-end:::
    :::row-end:::
    
3.  The **New server** panel appears. Enter the following information (replace **nnnn** in the name of the server with letters and digits, such that the name is globally unique).
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Server name
      :::column-end:::
      :::column:::
        **sqlservernnnn** (must be unique)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Server admin login
      :::column-end:::
      :::column:::
        **sqluser**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Password
      :::column-end:::
      :::column:::
        **Pa$$w0rd1234**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/server-pane-df80b536.png" alt-text="Screenshot of the Server pane and the New Server pane with fields filled in.":::
    
4.  Select **OK** when you have finished.
5.  Select **Next : Networking**, and configure the following settings (leave defaults for remainder of fields).
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Under **Network connectivity** section:
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Connectivity method
      :::column-end:::
      :::column:::
        **Public endpoint**
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/tab-8a36cd61.png" alt-text="Screenshot of the Networking tab of the Create SQL Database pane with settings selected.":::
    
6.  Select **Next : Security**, and next to **Enable Azure Defender for SQL**, choose **Not now**. :::image type="content" source="../media/security-tab-a15c3422.png" alt-text="Screenshot of the Security tab of the Create SQL Database pane with settings selected.":::
    
7.  Select **Next : Additional settings**, and configure the following settings.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Under **Data source** section:
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Use existing data
      :::column-end:::
      :::column:::
        **Sample** (this will create the *AdventureWorksLT* sample database)
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Under **Database collation** section:
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Collation
      :::column-end:::
      :::column:::
        *default*
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/additional-settings-tab-5e601100.png" alt-text="Screenshot of the Additional settings tab of the Create SQL Database pane with settings selected.":::
    
8.  Select **Review + create**.
9.  After validation success, on the **Create SQL Database** window, select **Create** to deploy the server and database. It can take approximately two to five minutes to create the server and deploy the sample database.
10. Select **Go to resource**.
11. Select **Set server firewall**, and then select **Yes** to **Allow Azure services and resources to access this server**.
12. Select **Save**.
13. Select **OK**.

## Task 2: Test the database

In this task, you configure the server and run a SQL query.

1.  From the **All resources** pane, search and select **SQL databases** and ensure that your new database was created. You might need to refresh the page. :::image type="content" source="../media/sql-database-d2ebb307.png" alt-text="Screenshot of the SQL database Query editor preview.":::
    
2.  Select the **db1** entry representing the SQL database you created, and then select **Query editor (preview)** in the nav bar. :::image type="content" source="../media/query-editor-preview-b6af6d9c.png" alt-text="Screenshot of the SQL database the Query editor preview highlighted.":::
    
3.  Sign in as **sqluser**, with the password **Pa$$w0rd1234**.
4.  You will not be able to sign in.
    
    > [!NOTE]
    > Read the error closely and make note of the IP address that needs to be allowed through the firewall. :::image type="content" source="../media/query-editor-login-2b2dd335.png" alt-text="Screenshot of the Query Editor sign-in page with the IP address error.":::
5.  Select **Overview** &gt; **Set server firewall**.
6.  In the **Client IP address** section, your IP will be shown (verify that it is the same client IP address from the error above). Click on **+ Add client IP**, which will add a **Rule name** and put your IP in both the **Start IP** and **End IP** fields, and then select **Save**. :::image type="content" source="../media/sql-server-firewall-settings-1b917b84.png" alt-text="Screenshot of the SQL Server firewall settings page, with the Add client IP and Save button highlighted.":::
    
7.  Return to your SQL database and the Query Editor sign-in page. Try to sign in again as **sqluser**, with the password **Pa$$w0rd1234**. This time you should succeed. It might take a couple of minutes for the new firewall rule to be deployed. If you wait and still get an error, verify the client IP address in the error, and try selecting **Firewall settings &gt;** and adding the correct client IP address again.
8.  After you sign in successfully, the query pane appears. Enter the following query into the editor pane.
    
    ```SQL
    SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
    FROM SalesLT.ProductCategory pc
    JOIN SalesLT.Product p
    ON pc.productcategoryid = p.productcategoryid;
    ```
    
    :::image type="content" source="../media/query-editor-decc7acc.png" alt-text="Screenshot of the query editor with the query pane, and the commands running successfully.":::
    
9.  Select **Run**, and then review the query results in the **Results** pane. The query should run successfully.:::image type="content" source="../media/database-query-editor-pane-19d53288.png" alt-text="Screenshot of the database query editor pane, with the SQL code having been run successfully and the output visible in the results pane.":::
    

Congratulations! You've created a SQL database in Azure and successfully queried the data in that database.
