As a database administrator, you'll set up a new SQL Database, including a Virtual Network Endpoint to increase and simplify the security of the deployment. Azure Data Studio will be used to evaluate the use of a SQL Notebook for data querying and reviewing the results.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Create a Virtual Network

1. Open the left navigation pane, then select **Virtual Networks**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-04.png" alt-text="Screenshot of the navigation pane with Virtual Networks selected.":::

1. Select **+ Add** and then complete the Basics page with the following information:

    :::image type="content" source="../media/dp-3300-module-22-lab-05.png" alt-text="Screenshot of the Create virtual network pane with information entered.":::

    - Resource Group: **DeploySQLAzure**
    - Name: **AzureSQL-vnet**
    - Region: Select the same region when the Resource Group was created (the region nearest to your location)  
    - Select **Next: IP Addresses**  


1. Configure the virtual network's IP range and prepare for the Azure SQL database endpoint:

    - On the IP Addresses page, leave the defaults for the IPv4 address space.
    - Select the **default** subnet link, and then select the checkbox.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-07.png" alt-text="Screenshot of IP Addresses options.":::

    - In the Edit subnet flyout on the right, expand the Services drop-down, and tick **Microsoft.Sql**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-08.png" alt-text="Screenshot of Edit subnet flyout.":::

    - Select **Save**.
    - Select **Review + Create**, review the settings for the new virtual network

1. Select **Create**.

## Deploy an Azure SQL Database

1. From the Azure portal, select on **+ Create a Resource** in the left side navigation bar.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-09.png" alt-text="Screenshot of selecting the Create a resource link.":::

1. Search for **SQL database** in the search box at the top, then select **SQL Database** from the list of options.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-10.png" alt-text="Screenshot of the marketplace search results.":::

1. Select **Create**.

1. Complete the Create SQL Database Basics screen with the following inputs.

    - Resource Group: **DeploySQLAzure**
    - Database Name: **AdventureWorksLT**
    - Server: select **Create new**

1. In the **New server** sidebar, enter the following information:

    :::image type="content" source="../media/dp-3300-module-22-lab-11.png" alt-text="Screenshot of the New server sidebar.":::

    - Server name: **azuresql-server-&lt;your initials (lower case)&gt;** (a server name must be unique globally)
    - Server admin login: **labadmin**
    - Password: **Azur3Pa$$**
    - Confirm password: **Azur3Pa$$**
    - Location: Select the Region you selected in the previous steps
    - Select **OK**

1. Scroll down on the Create SQL Database Basics page, and enter the following:

    - Want to use Elastic Pool: **No**
    - Compute + Storage: Select **Configure database**
        - On the Configure screen, select **Looking for basic, standard, premium?**

        :::image type="content" source="../media/dp-3300-module-22-lab-12.png" alt-text="Screenshot of selecting the Looking for basic, standard, premium? link.":::

        - Select **Basic**
        - Select the **Apply** button

    > [!NOTE]
    > Make note of this server name. You will use it in subsequent steps.

1. Review settings and then select **Next: Networking**  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-13.png" alt-text="Screenshot of the Create SQL database options.":::

1. On the Networking screen, for Connectivity method, select the **Private endpoint** radio button  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-14.png" alt-text="Screenshot of selecting the private endpoint connectivity method.":::

1. Then select the **Add private endpoint** link under Private Endpoints  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-15.png" alt-text="Screenshot of selecting the add private endpoint link.":::

1. Complete the Create private endpoint flyout as follows:
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-16.png" alt-text="Screenshot of the create private endpoint options.":::

    - Resource group: **DeploySQLAzure**
    - Location: The same Region that was selected for previous parts of this lab
    - Name: **AzureSQL-Endpoint**
    - Target sub-resource: **SqlServer**
    - Virtual network: **AzureSQL-vnet**
    - Subnet: **default (10.x.0.0/24)**
    - The Private DNS integration options can remain at the default
    - Review settings before selecting **OK**  

1. Confirm the endpoint appears on the Networking page, and then select **Next: Additional settings**.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-17.png" alt-text="Screenshot of showing the newly created endpoint.":::

1. On the Additional Settings page, select the following options:

    - Set Use existing data to **Sample**
    - Ensure **Enable Azure Defender for SQL** is set to **Not now**  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-18.png" alt-text="Screenshot of the additional settings options.":::

1. Select **Review + Create**.

1. Review the settings before selecting **Create**.

1. Once the deployment is complete, select **Go to resource**.
‎

## Enable All Azure Services access to new SQL Server

1. On the AdventureWorksLT overview page, select on the link for the **Server name** in the top section.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-19.png" alt-text="Screenshot of selecting the SQL Server name.":::

1. On the SQL Server object's navigation blade, scroll down and select **Firewalls and virtual networks** in the **Security** section.

    ‎:::image type="content" source="../media/dp-3300-module-22-lab-20.png" alt-text="Screenshot of selecting the Firewalls and virtual networks link.":::

1. Select **+ Add client IP**, and then set **Allow Azure services and resources to access this server** to **Yes**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-21.png" alt-text="Screenshot of selecting yes for the Allow Azure services and resources to access this server.":::

1. Select **Save**.

1. Navigate to the Overview page for the server, and then copy the **Server name**.

    :::image type="content" source="../media/dp-3300-module-22-lab-34.png" alt-text="Screenshot of copying the Server name from the Overview page.":::

## Register Azure SQL DB Instance in Azure Data Studio (ADS)

1. Launch Azure Data Studio from the windows toolbar.

1. Select **Connections** in ADS's left sidebar, then the **Add Connection** button.

    :::image type="content" source="../media/dp-3300-module-22-lab-25.png" alt-text="Screenshot of selecting the Add a connection icon in ADS.":::

1. In the **Connection** sidebar, fill out the **Connection Details** section with connection information to connect to the AdventureWorksLT database created in the previous steps.

    - Connection Type: **Microsoft SQL Server**
    - Server: Paste the server name you copied earlier.  
    - Authentication Type: **SQL Login**
    - User name: **labadmin**
    - Password: **Azur3Pa$$**
    - Expand the Database drop-down to select **AdventureWorksLT**
    - Server group will remain on **&lt;default&gt;**.
    - Name (optional) can be populated with a friendly name of the database, if desired.
    - Review settings and select **Connect**.
    ‎

    :::image type="content" source="../media/dp-3300-module-22-lab-27.png" alt-text="Screenshot of the connection details.":::

1. ADS will connect to the database and show some basic information about the database, including a partial list of objects.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-28.png" alt-text="Screenshot of ADS showing basic database information.":::

## Query Azure SQL Database with a SQL Notebook

1. In ADS, connected to this lab's AdventureWorksLT database, select **New Notebook**.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-29.png" alt-text="Screenshot of selecting the New Notebook button.":::

1. Select the **+Text**, either in the toolbar or in the notebook, to add a new text box in the notebook.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-30.png" alt-text="Screenshot of selecting the Text button.":::

    > [!NOTE]
    > Within the notebook you can embed plain text to explain queries or result sets.

1. Enter the text **\*\*Top Ten Customers by Order SubTotal\*\***.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-31.png" alt-text="Screenshot of adding markdown text to a notebook.":::

1. Select **+ Code** in the toolbar, or **Add code** in the notebook, to add a new cell at the end of the notebook to enter a query in.

    :::image type="content" source="../media/dp-3300-module-22-lab-32.png" alt-text="Screenshot of selecting the code button.":::

1. Paste the following SQL statement into the new cell.

    ```sql
    SELECT TOP 10 cust.[CustomerID], cust.[CompanyName], SUM(sohead.[SubTotal]) AS OverallOrderSubTotal
    FROM [SalesLT].[Customer] cust
    INNER JOIN [SalesLT].[SalesOrderHeader] sohead
        ON sohead.[CustomerID] = cust.[CustomerID]
    GROUP BY cust.[CustomerID], cust.[CompanyName]
    ORDER BY [OverallOrderSubTotal] DESC
    ```
    > [!NOTE]
    > If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Deploy Azure SQL Database\Lab Queries Notes.sql** file.

1. Select the blue circle with the arrow to execute the query. Note how the results are included within the cell with the query.

1. Select **+ Text** to add a new text cell.

1. Enter the text **\*\*Top Ten Ordered Product Categories\*\***.

1. Select **+ Code** again to add a new cell, and paste the following SQL statement into the cell

    ```sql
    SELECT TOP 10 cat.[Name] as ProductCategory, SUM(detail.[OrderQty]) AS OrderedQuantity
    FROM salesLT.[ProductCategory] cat
        INNER JOIN saleslt.[Product] prod
          ON prod.[ProductCategoryID] = cat.[ProductCategoryID]
        INNER JOIN salesLT.[SalesOrderDetail] detail
          ON detail.[ProductID] = prod.[ProductID]
    GROUP BY cat.[name]
    ORDER BY [OrderedQuantity] DESC
    ```

1. Select on the blue circle with the arrow to execute the query.

1. To run all cells in the notebook and present results, select the **Run Cells** button in the toolbar.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-33.png" alt-text="Screenshot of selecting Run cells.":::

1. Within ADS, from **File** menu, select **Save** and then browse to the **D:\Labfiles\Deploy Azure SQL Database** directory.

1. Select **Save** and then close the tab for the Notebook from inside of ADS.

1. From the **File** menu, select **Open File**, and open the notebook you just saved. Observe that query results were saved along with the queries in the notebook.

On completing this exercise you've seen how to create a SQL database in Azure and connect to it securely from a client machine.

To finish this exercise select **Done** below.
