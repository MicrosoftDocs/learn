# Lab : Configure an Azure SQL Database Firewall

# Overview

The students will take the information gained in the lessons and from the case study to configure and subsequently implement security in the Azure Portal and within the AdventureWorks database.

# Objectives

After completing this exercise, you will be able to:

1. Configure a server-based firewall rule using the Azure Portal

2. Authorize Access to Azure SQL Database with Azure Active Directory


# Scenario

You have been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database.


## Task 1:    Configure a server-based firewall rule using the Azure Portal

1. From the lab virtual machine, start a browser session and navigate to [https://portal.azure.com](https://portal.azure.com/). Provide appropriate credentials.

:::image type="content" source="../media/dp-3300-module-33-lab-01.png" alt-text="Sign in":::

2. In the search bar at the top of the Azure Portal, type SQL. The SQL servers icon will appear. Click on SQL servers. Click on the server name to be taken to the detail page for the server.

:::image type="content" source="../media/dp-3300-module-33-lab-02.png" alt-text="SQL Servers":::

3. In the detail screen for your SQL server, move your mouse to right of the server name, and click copy to clipboard button.

4. Click on Show Firewall Setting above the server name that you clicked on copy to clipboard. Click on + Client IP as highlighted below and then click Save.

:::image type="content" source="../media/dp-3300-module-33-lab-04.png" alt-text="Add Client IP":::

This will allow you to connect to your Azure SQL Database server using SQL Server Management Studio or any other client tools. Make note of your client IP address, you will use it later in this task.

5. Open SQL Server Management Studio on the lab VM, by navigating to Microsoft SQL Server Tools 18 > SQL Server Management Studio from the Start menu. Paste in the name of your Azure SQL database server and login with the credentials you created in Lab 2:

	- Server admin login: **dp300admin**

	- Password: **dp300P@ssword!**


:::image type="content" source="../media/dp-3300-module-33-lab-05.png" alt-text="Connect to Server":::

Click Connect.

6. In Object Explorer expand the server node, and right click on databases. Click Import a Data-tier Application.

:::image type="content" source="../media/dp-3300-module-33-lab-06.png" alt-text="Import a Data-tier Application":::

7. In the Import Data Tier Application dialog, click Next on the first screen. 

:::image type="content" source="../media/dp-3300-module-33-lab-07.png" alt-text="Import Data Tier Application dialog":::

8. In the Import Settings screen, click Browse and navigate to D:\Labfiles\Secure Environment folder and click on the AdventureWorks.bacpac file and click open. Then in the Import Data-tier application screen click **Next**.

:::image type="content" source="../media/dp-3300-module-33-lab-08.png" alt-text="Import Data-tier application":::

:::image type="content" source="../media/dp-3300-module-33-lab-09.png" alt-text="Import settings":::

9. On the database settings screen, change the edition of Azure SQL Database to General Purpose. Change the Service Objective to GP_Gen4_2 and click next.

:::image type="content" source="../media/dp-3300-module-33-lab-10.png" alt-text="Database settings"::: 

10.  Click **Next** and then on the Summary screen click **Finish**. When your import completes you will see the below results.

:::image type="content" source="../media/dp-3300-module-33-lab-11.png" alt-text="Results":::

11. In Object Explorer right-click on AdventureWorks and then click on new query. 

:::image type="content" source="../media/dp-3300-module-33-lab-12.png" alt-text="New query":::

12. Execute the following T-SQL query by pasting the text into your query window and clicking execute or pressing F5.

	```sql
	EXECUTE sp_set_database_firewall_rule @name = N'ContosoFirewallRule',

	@start_ip_address = '192.168.1.1', @end_ip_address = '192.168.1.1'
	```
	

	Replace 192.168.1.1. with your client IP address from Step 4. Next you will create a contained user in the AdventureWorks database. Click New Query and execute the following T-SQL. Ensure that you are using the AdventureWorks database. If you see master in the highlighted box below, you can pull down and switch to AdventureWorks.

:::image type="content" source="../media/dp-3300-module-33-lab-13.png" alt-text="SQL query":::

13. Click execute to run this command. This command creates a contained user within the AdventureWorks database. You will login using the username and password in the next step.

	```sql
	CREATE USER containeddemo WITH PASSWORD = 'P@ssw0rd!'
	```


14. Navigate to Object Explorer in SSMS and click on connect and then Database Engine

:::image type="content" source="../media/dp-3300-module-33-lab-14.png" alt-text="Connect to database":::

15. Attempt to connect with the credentials you created in step 13. You will see the following error.

:::image type="content" source="../media/dp-3300-module-33-lab-15.png" alt-text="Connection error":::

This is because the connection attempted to login to the master database and not AdventureWorks where the user was created. Change the connection context by clicking ok, to exit the error message and then clicking on options in the Connect to Server dialog box as shown below.

:::image type="content" source="../media/dp-3300-module-33-lab-16.png" alt-text="Connect to Server dialog box":::

16. On the connection options tab, type the database name AdventureWorks.

:::image type="content" source="../media/dp-3300-module-33-lab-17.png" alt-text="Connection options tab":::

17. Click connect from that screen. This connection bypasses the master database and logs you directly into AdventureWorks, which is the only database to which the newly created user has access.

:::image type="content" source="../media/dp-3300-module-33-lab-18.png" alt-text="Adventureworks":::

## Task 2: Authorize Access to Azure SQL Database with Azure Active Directory

1. Navigate to the Azure Portal, and click on your user name in the top right corner of the screen.

:::image type="content" source="../media/dp-3300-module-33-lab-19.png" alt-text="User":::

Make note of the user name. 

2. In the Azure Portal navigate to your Azure SQL Database server dp300-lab-xx and click on Not Configured next to Active Directory Admin.

:::image type="content" source="../media/dp-3300-module-33-lab-20.png" alt-text="Not Configured":::

On the next screen, click Set admin.

:::image type="content" source="../media/dp-3300-module-33-lab-20.png" alt-text="Set admin":::

In the Set admin screen, search for your username. When you have found it, click on it to highlight the username, and then click Select. You will be returned to the above Active Directory Admin screen. Click save to complete the process. This will make your username the Azure Active Directory admin for the server as shown below:

:::image type="content" source="../media/dp-3300-module-33-lab-22.png" alt-text="Active Directory admin":::

3. Open SQL Server Management Studio and click Connect > Database Engine. In the server name enter the name of your server. Change the authentication type to Azure Active Directory Universal with MFA.

:::image type="content" source="../media/dp-3300-module-33-lab-23.png" alt-text="Connect to Server":::

You will be prompted to enter your Azure Active Directory password, and then logged in to your database. 
