As a database administrator, you'll set up a new SQL Database, including a Virtual Network Endpoint to increase and simplify the security of the deployment. Azure Data Studio will be used to evaluate the use of a SQL Notebook for data querying and reviewing the results.

## Create a Virtual Network

1. When the VM lab environment opens sign in using the password on the **Resources** tab for the Student account.

1. Select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password**.

1. Open the the left navigation pane, then select **Virtual Networks**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-04.png" alt-text="Screenshot of the navigation pane with Virtual Networks selected.":::

1. Select **+ Add** and then complete the Basics page with the following information:

    :::image type="content" source="../media/dp-3300-module-22-lab-05.png" alt-text="Screenshot of the Create virtual network pane with information entered.":::

    - Resource Group: **DP-300-Lab02**
    - Name: **Lab02-vnet**
    - Region: Select the same region when the Resource Group was created (the region nearest to your location)  
    - Select **Next: IP Addresses**  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-06.png" alt-text="Screenshot of selecting the Next: IP Addresses link.":::

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

1. From the Azure Portal, select on **+ Create a Resource** in the left side navigation bar.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-09.png" alt-text="Screenshot of selecting the Create a resource link.":::

1. Search for **SQL databases** in the search box at the top, then select **SQL Database** from the list of options. 
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-10.png" alt-text="Screenshot of the marketplace search results.":::

1. Select **Create**.

1. Complete the Create SQL Database Basics screen with the following inputs and then select **Next: Networking**.

    - Subscription: Select the lab subscription
    - Resource Group: **DP-300-Lab02**
    - Database Name: **AdventureWorksLT**
    - Server: select **Create new**

1. In the New Server sidebar, enter the following information:

    :::image type="content" source="../media/dp-3300-module-22-lab-11.png" alt-text="Screenshot of the New server sidebar.":::

    - Server name: **dp300-lab-&lt;your initials (lower case)&gt;** (server name must be globally unique)
    - Server admin login: **dp300admin**
    - Password: enter a strong password
    - Confirm password: enter the same strong password
    - Location: Select the Region you selected in the previous steps
    - Select **Allow Azure services to access server**
    - Select **OK**

1. On the next page enter the following:

    - Want to use Elastic Pool: **No**
    - Compute + Storage: Select **Configure database**
        - On the Configure screen, select **Looking for basic, standard, premium?**

        :::image type="content" source="../media/dp-3300-module-22-lab-12.png" alt-text="Screenshot of selecting the Looking for basic, standard, premium? link.":::

        - Select **Basic**
        - Select the **Apply** button

    > [!NOTE]
    > Make note of this server name, and your login information. You will use it in subsequent steps.

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

    - Subscription: Ensure the lab subscription is selected
    - Resource group: **DP-300-Lab02**
    - Location: The same Region that was selected for previous parts of this lab
    - Name: **DP-300-SQL-Endpoint**
    - Target sub-resource: **SqlServer**
    - Virtual network: **Lab02-vnet**
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

1. From the SQL Database blade, select on the link for the SQL Server name in the top section.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-19.png" alt-text="Screenshot of selecting the SQL Server name.":::

1. On the SQL Server object's navigation blade, select **Firewalls and virtual networks** under Security.

    ‎:::image type="content" source="../media/dp-3300-module-22-lab-20.png" alt-text="Screenshot of selecting the Firewalls and virtual networks link.":::

1. Select **+ Add client IP**. 

1. Set Allow Azure services and resources to access this server to **Yes**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-21.png" alt-text="Screenshot of selecting yes for the Allow Azure services and resources to access this server.":::

1. Select **Save**.

## Register Azure SQL DB Instance in Azure Data Studio (ADS)

1. Launch ADS from the lab VM toolbar.

1. Select **Connections** in ADS's left sidebar, then the **Add a Connection** button

    :::image type="content" source="../media/dp-3300-module-22-lab-25.png" alt-text="Screenshot of selecting the Add a connection icon in ADS.":::

1. In the Connections sidebar, fill out the Connection Details section with connection information to connect to the SQL database created in the previous Exercise.

    - Connection Type: **Microsoft SQL Server**
    - Server: Enter the name of the SQL Server created earlier. For example: **dp300-lab-xx.database.windows.net**  

    > [!NOTE]
    > You were asked to create a server name with your initials, instead of 'xx'

    - Authentication Type: **SQL Login**
    - User name: **dp300admin**
    - Password: Enter your strong password
    - Expand the Database drop-down to select **AdventureWorksLT**
    - Server group will remain on **&lt;default&gt;**.
    - Name (optional) can be populated with a friendly name of the database, if desired.
    - Review settings and select **Connect**.
    ‎
    :::image type="content" source="../media/dp-3300-module-22-lab-27.png" alt-text="Screenshot of the connection details.":::

1. ADS will connect to the database and show some basic information about the DB, plus a partial list of objects.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-28.png" alt-text="Screenshot of ADS showing basic database information.":::

## Query Azure SQL Database with a SQL Notebook

1. In ADS, connected to this lab's AdventureWorksLT database, select **New Notebook**.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-29.png" alt-text="Screenshot of selecting the New Notebook button.":::

1. Select the **+Text** button to add a new text box in the notebook.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-30.png" alt-text="Screenshot of selecting the Text button.":::

    > [!NOTE]
    > Within the notebook you can embed plain text to explain queries or result sets.

1. Enter the text **\*\*Top Ten Customers by Order SubTotal\*\***.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-31.png" alt-text="Screenshot of adding markdown text to a notebook.":::

1. Select the **+ Code** button to add a new cell at the end of the notebook to put a query in  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-32.png" alt-text="Screenshot of selecting the code button.":::

1. Paste the following SQL statement into the new cell

    ```sql
    SELECT TOP 10 cust.[CustomerID], cust.[CompanyName], SUM(sohead.[SubTotal]) AS OverallOrderSubTotal
    FROM [SalesLT].[Customer] cust
    INNER JOIN [SalesLT].[SalesOrderHeader] sohead
        ON sohead.[CustomerID] = cust.[CustomerID]
    GROUP BY cust.[CustomerID], cust.[CompanyName]
    ORDER BY [OverallOrderSubTotal] DESC
    ```

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
    :::image type="content" source="../media/dp-3300-module-22-lab-33.png" alt-text="Screenshot of selecting the Run cells button.":::

1. Within ADS save the notebook from File menu to the D:\Labfiles\Deploy Azure SQL Database (this folder already exists on the VM) directory. Close the tab for the Notebook from inside of ADS.

1. From the File Menu, select Open Notebook, and open the notebook you just saved. Observe that query results were saved along with the queries in the notebook.
