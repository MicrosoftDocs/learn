## Lab: Deploying Azure SQL Database

## Overview

You will configure basic resources needed to deploy an Azure SQL Database with a Virtual Network Endpoint. Connectivity to the SQL Database will be validated using Azure Data Studio from the lab VM.

## Objectives

At the end of these exercises, you will be able to:

1. Configure basic resources

2. Deploy an Azure SQL Database

3. Connect to Azure SQL Database with Azure Data Studio

## Scenario

As a database administrator for AdventureWorks, you will set up a new SQL Database, including a Virtual Network Endpoint to increase and simplify the security of the deployment. Azure Data Studio will be used to evaluate the use of a SQL Notebook for data querying and results retention.

Finally, an Azure Database for PostgreSQL will be deployed to support additional data system needs.

## Exercise 1: Configure Basic Resources

### Task 1: Create a Resource Group

1. Start a browser, and open the Azure Portal at [http://portal.azure.com](http://portal.azure.com/), logging in with the appropriate credentials

2. From the Home screen, click on the **Resource Groups** button  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-01.png" alt-text="Resource Groups":::


3. Review your existing Resource Groups and then click on the **Add** button to create a new Resource Group.  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-02.png" alt-text="Add button":::


4. Complete the Create a Resource Group wizard with the required information to create the RG.

	- Ensure Subscription is set to the desired subscription

	- Enter **DP-300-Lab02** for the name of the Resource Group

	- For the purposes of this lab, select the Region nearest to your physical location

	- Click the **Review + create** button  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-03.png" alt-text="Create Button":::
	



### Task 2: Create a Virtual Network

1. In the left navigation pane, click **Virtual Networks**  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-04.png" alt-text="Virtual networks":::


2. Complete the Basics page with the following information:

	- Subscription: **Select the lab subscription**

	- Resource Group: Select the **DP-300-Lab02** Resource Group

	- Name: **Lab02-vnet**

	- Region: Select the same region when the Resource Group was created (the region nearest to your location)  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-05.png" alt-text="Resource group":::


	- Click the **Next: IP Addresses** button  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-06.png" alt-text="IP Adresses button":::


3. Configure the virtual network’s IP range and prep for the Azure SQL database endpoint

	- On the IP Addresses page, leave the defaults for the IPv4 address space.

	- Click on the **default** subnet  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-07.png" alt-text="default subnet":::

	- In the Edit subnet flyout on the right, expand the Services drop-down, and tick **Microsoft.Sql**  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-08.png" alt-text="Microsoft.Sql":::

	- Click **Save**

	- Click the **Review + Create** button, review the settings for the new virtual network, and then click **Create**

## Exercise 2: Deploy an Azure SQL Database

### Task 1: Deploy an Azure SQL Database

1. From the Azure Portal, click on **+ Create a Resource** at the top of the left side navigation bar  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-09.png" alt-text="Create a resource":::

2. Search for “SQL databases” in the search box at the top, then click **SQL Database** from the list of options  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-10.png" alt-text="SQL Database":::


3. Click the **Create** button

4. Complete the Create SQL Database Basics screen with the following inputs and then click **Next: Networking**

	- Subscription: Select the lab subscription

	- Resource Group: **DP-300-Lab02** (the RG created in Exercise 1)

	- Database Name: **AdventureWorksLT**
	
	- Server: click **Create new.** In the New Server sidebar, complete the form as follows:

		- Server name: **dp300-lab-&lt;your initials (lower case)&gt;** (server name must be globally unique)

		- Server admin login: **dp300admin**

		- Password: **dp300P@ssword!**

		- Confirm password: **dp300P@ssword!**

		- Location: Select the Region nearest to you (same as in Exercise 1)

		- Your New server sidebar should look as shown below. Click **OK**


    :::image type="content" source="../media/dp-3300-module-22-lab-11.png" alt-text="New server sidebar":::


    -  Want to use Elastic Pool: **No**

    -  Compute + Storage: Click **Configure database**

		- On the Configure screen, click **Looking for basic, standard, premium?**
		


    :::image type="content" source="../media/dp-3300-module-22-lab-12.png" alt-text="Configure screen":::


		- Click **Basic**

		- Click the **Apply** button


**Note: Make note of this server name, and your login information. You will use it in subsequent labs.**

5. Review settings and then click **Next: Networking**  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-13.png" alt-text="Basics settings":::


6. On the Networking screen, for Connectivity method, click the **Private endpoint** radio button  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-14.png" alt-text="Private endpoint button":::


7. Then click the **Add private endpoint** link under Private Endpoints  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-15.png" alt-text="Add private endpoint":::


8. Complete the Create private endpoint flyout as follows:

	- Subscription: Ensure the lab subscription is selected

	- Resource group: **DP-300-Lab02**

	- Location: The same Region that was selected for previous parts of this lab

	- Name: **DP-300-SQL-Endpoint**

	- Target sub-resource: **SqlServer**

	- Virtual network: **Lab02-vnet**

	- Subnet: **default (10.x.0.0/24)**

	- The Private DNS integration options can remain at the default

	- Review settings before clicking **OK**  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-16.png" alt-text="Create private endpoint settings":::


9. Confirm the endpoint appears on the Networking page, and then click the **Next: Additional settings** button.  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-17.png" alt-text="Networking page":::


10. On the Additional Settings page, select the following options:

	- Set Use existing data to **Sample**

	- Ensure enable advanced data security is set to **Not now**  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-18.png" alt-text="Additional settings page":::


11. Click **Review + Create**

12. Review the settings before clicking **Create**

13. Once the deployment is complete, click the **Go to resource** button  
‎

### Task 2: Enable All Azure Services access to new SQL Server

1. From the SQL Database blade, click on the link for the SQL Server name in the top section  
‎

    :::image type="content" source="../media/dp-3300-module-22-lab-19.png" alt-text="SQL Database blade":::


2. On the SQL Server object’s navigation blade, click **Firewalls and virtual networks** under Security


    :::image type="content" source="../media/dp-3300-module-22-lab-20.png" alt-text="Firewalls and virtual networks":::


3. Set Allow Azure services and resources to access this server to **Yes**  
‎


    :::image type="content" source="../media/dp-3300-module-22-lab-21.png" alt-text="Firewalls and virtual networks":::

4. Click **Save**

 

## Exercise 3: Connect to Azure SQL Database

### Task 1: Register Azure SQL DB Instance in Azure Data Studio

1. Launch Azure Data Studio (ADS) from the lab VM

	- You may see this pop-up at initial launch of Azure Data Studio. If you receive it, click **Yes** 
	

    :::image type="content" source="../media/dp-3300-module-22-lab-22.png" alt-text="Preview features pop-up":::

 
2. When Azure Data Studio opens, click on the extensions button on the menu on the left hand side as shown below.

 
    :::image type="content" source="../media/dp-3300-module-22-lab-23.png" alt-text="":::
 

3. In the extensions search box, type Postgres. The Microsoft PostgreSQL extension will appear. Click the install button as highlighted below.

    :::image type="content" source="../media/dp-3300-module-22-lab-24.png" alt-text="Install button":::
 

4. Click the **Connections** button in ADS’s left sidebar, then the **Add a Connection** button
	
   
    :::image type="content" source="../media/dp-3300-module-22-lab-25.png" alt-text="Connections button":::


5. In the Connections sidebar, fill out the Connection Details section with connection information to connect to the SQL database created in the previous Exercise

	- Connection Type: **Microsoft SQL Server**

	- Server: Enter the name of the SQL Server created in Exercise 2, Task 1. For example: **dp300-lab-xx.database.windows.net**  
	‎[Note that you were asked to create a server name with your initials, instead of ‘xx’]

	- Authentication Type: **SQL Login**

	- User name: **dp300admin**

	- Password: **dp300P@ssword!**

	- Expand the Database drop-down to select **AdventureWorksLT.** If you are asked to add firewall rule to add your client IP to this server, click on Add account and login to your Azure account. On Create new firewall screen, click **OK**.
		
	    
        :::image type="content" source="../media/dp-3300-module-22-lab-26.png" alt-text="Add Azure account":::


	- Server group will remain on **&lt;default&gt;**

	- Name (optional) can be populated with a friendly name of the database, if desired

	- Review settings and click **Connect**  
	‎

   
       :::image type="content" source="../media/dp-3300-module-22-lab-27.png" alt-text="Connect button":::


6. ADS will connect to the database and show some basic information about the DB, plus a partial list of objects  
‎
    
    
     :::image type="content" source="../media/dp-3300-module-22-lab-28.png" alt-text="XXXXXXXX":::


### Task 2: Query Azure SQL Database with a SQL Notebook

1. In Azure Data Studio, connected to this lab’s AdventureWorksLT database, click the **New Notebook** button  

‎
     
   
    :::image type="content" source="../media/dp-3300-module-22-lab-29.png" alt-text="New notebook button":::


2. Click the **+Text** button to add a new text box in the notebook 

‎	
     
    :::image type="content" source="../media/dp-3300-module-22-lab-30.png" alt-text="Text button":::


**Note:** Within the notebook you can embed plain text to explain queries or result sets.


3. Enter the text **Top Ten Customers by Order SubTotal**, making it Bold if desired 
 
‎
     
:::image type="content" source="../media/dp-3300-module-22-lab-31.png" alt-text="XXXX":::



4. Click the **+ Code** button to add a new cell at the end of the notebook to put a query in  

‎
   
:::image type="content" source="../media/dp-3300-module-22-lab-32.png" alt-text="Code button":::



5. Paste the following SQL statement into the new cell

```sql
select top 10 cust.[CustomerID], cust.[CompanyName], sum(sohead.[SubTotal]) as OverallOrderSubTotal

  from [SalesLT].[Customer] cust

    inner join [SalesLT].[SalesOrderHeader] sohead

        on sohead.[CustomerID] = cust.[CustomerID]

   group by cust.[CustomerID], cust.[CompanyName]

   order by [OverallOrderSubTotal] desc
   ```

6. Click on the blue circle with the arrow to execute the query. Note how the results are included within the cell with the query.

7. Click the **+ Text** button to add a new text cell.

8. Enter the text **Top Ten Ordered Product Categories**, making it Bold if desired

9. Click the **+ Code** button again to add a new cell, and paste the following SQL statement into the cell

```sql
select top 10 cat.[Name] as ProductCategory, sum(detail.[OrderQty]) as OrderedQuantity

	from salesLT.[ProductCategory] cat

	   inner join saleslt.[Product] prod
      
	      on prod.[ProductCategoryID] = cat.[ProductCategoryID]

	   inner join salesLT.[SalesOrderDetail] detail

	      on detail.[ProductID] = prod.[ProductID]

	group by cat.[name]

	order by [OrderedQuantity] desc
```
10.  Click on the blue circle with the arrow to execute the query 

11. To run all cells in the notebook and present results, click the **Run Cells** button in the toolbar 

‎   
 
    :::image type="content" source="../media/dp-3300-module-22-lab-33.png" alt-text="Run Cells button":::


12. Within Azure Data Studio save the notebook from File menu to the D:\Labfiles\Deploy Azure SQL Database (this folder already exists on the VM) directory. Close the tab for the Notebook from inside of Azure Data Studio. From the File Menu, select Open Notebook, and open the notebook you just saved. Observe that query results were saved along with the queries in the notebook.
