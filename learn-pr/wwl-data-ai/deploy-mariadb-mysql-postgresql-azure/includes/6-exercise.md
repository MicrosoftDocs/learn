## Lab: Deploy an Azure Database for PostgreSQL Database

## Overview

You will create an Azure Database for PostgreSQL.

## Objectives

At the end of this exercise, you will be able to:

* Deploy an Azure Database for PostgreSQL

## Scenario

As a database administrator for AdventureWorks, you will deploy an Azure Database for PostgreSQL to support additional data system needs.

### Task 1: Deploy a PostgreSQL Database

1. From the Azure Portal, click on **+ Create a Resource** at the top of the left side navigation bar

    :::image type="content" source="../media/dp-3300-module-22-lab-34.png" alt-text="+ Create a Resource":::


2. Search for “postgresql” in the search box at the top, then click **Azure Database for PostgreSQL** in the results 

‎
    
    :::image type="content" source="../media/dp-3300-module-22-lab-35.png" alt-text="XXXX":::


3. Click the **Create** button

4. Click **Create** for the Single Server option  
‎
   
 :::image type="content" source="../media/dp-3300-module-22-lab-36.png" alt-text="Create button":::


5. Complete the Single Server Basics screen with the following inputs:

	- Subscription: Select the lab subscription

	- Resource Group: **DP-300-Lab02** (the RG created in Exercise 1)

	- Server Name: **dp300-lab02-****&lt;your initials&gt;** (server name must be unique)

	- Data source: **None**

	- Location: Select the Region closest to you, which has been used throughout this lab

	- Version: **10** or **11**

	- Click the **Configure Server** link under Compute + Storage

		- Click the **Basic** tab

		- Slide the vCore slider all the way to the left to select **1 vCore**  
‎

        :::image type="content" source="../media/dp-3300-module-22-lab-37.png" alt-text="1 vCore button":::
		
		 - Click **OK**

	- Admin username: **dp300admin**

	- Password: **dp300P@ssword!**

	- Confirm password: **dp300P@ssword!**  
	
    :::image type="content" source="../media/dp-3300-module-22-lab-38.png" alt-text="XXXX":::


6. Click **Review + Create**

7. Review the settings and click **Create**

8. When the deployment is complete, click **Go to resource**

### Task 2: Enable All Azure Services Access to PostgreSQL Database

1. Click on the **Connection security** button under Settings in the database’s sidebar  
‎
   
 :::image type="content" source="../media/dp-3300-module-22-lab-39.png" alt-text="Connection security button":::


2. Slide the Allow access to Azure services setting to **Yes**  
‎
   
 :::image type="content" source="../media/dp-3300-module-22-lab-40.png" alt-text="Allow access to Azure services":::

3. Click **Save** at the top left.

### Task 3: Connect to the PostgreSQL Database with Azure Data Studio

**Note:** With the PostgreSQL extension installed to ADS, PostgreSQL can be queried. This extension is pre-installed on the lab VM.


1. In Azure Data Studio on the lab VM, ensure the Connections sidebar is expanded—Click the **Connections** button in the left nav bar, if not.

2. Click the **New Connection** button  
‎
      
    :::image type="content" source="../media/dp-3300-module-22-lab-41.png" alt-text="New Connection button":::    


3. In the Connection Details sidebar, enter the following information to connect to the previous Task’s PostgreSQL database:

	- Connection Type: **PostgreSQL**

	- Server: Enter the name of the PostgreSQL Server you created in Task 1. For example: **dp300-lab02-doc.database.windows.net** (You can find the full name of the server in the Overview pane in the Portal.)

	- Authentication Type: **Password**

	- User name: **dp300admin@dp300-lab02-doc** (note that the user name must include the hostname) 

	- Password: **dp300P@ssword!**

	- Database Name will remain on **&lt;default&gt;**

	- Server group will remain on **&lt;default&gt;**

	- Name (optional) can be populated with a friendly name of the database, if desired

4. Review settings  
‎
  
  :::image type="content" source="../media/dp-3300-module-22-lab-42.png" alt-text="Connection Details":::

5. Click **Connect**

6. Note ADS’s connection to the PostgreSQL database  
‎
 :::image type="content" source="../media/dp-3300-module-22-lab-43.png" alt-text="XXXX":::
