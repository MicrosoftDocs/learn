(Bonus) Activity 7: Data classification, Dynamic data masking, and SQL Audit

In this activity, you will learn how to audit users trying to view columns that were marked for data classification. This activity will combine several of the things you've already learned about in the module, and take those learnings to the next level.

### Steps

#### Step 1 - Add new data classification manually  

In the Azure portal, navigate to your Azure SQL Database (not logical server!). In the left-hand menu, under Security, select **Advanced data security** and then select the **Data Discovery & Classification** box.  

![ADS Dashboard](../media/adsdashboard4.png)  

Next, select the **Classification** tab and then select **+ Add classification**.  

![Add a new classification](../media/addddc.png)  

In a previous activity, you added all the recommended column classifications. In this step, you will *manually* add a potentially sensitive column to the list of classified columns.  

In the SalesLT Customer table, DD&C identified FirstName and LastName to be classified, but not MiddleName. Using the drop-downs, add it now. Then, select **Add classification**.  

![Add Name-related classification for MiddleName](../media/addddc2.png)  

Select **Save**.  

![Select Save](../media/save.png)  

You can confirm that this was successful by viewing the **Overview** tab and confirming that MiddleName is now present in the list of classified columns under the SalesLT schema. Select **X**.  

#### Step 2 - Apply Dynamic Data Masking over the Name columns  

Dynamic Data Masking (DDM) is something available in Azure SQL as well as in SQL Server. It limits data exposure by masking sensitive data to non-privileged users at SQL Server vs the application having to code those type of rules. Azure SQL will recommend things for you to mask, or you can add masks manually. You'll mask the FirstName, MiddleName, and LastName columns which you reviewed in the previous step.  

In the Azure portal, navigate to your Azure SQL Database. In the left-hand menu, under Security, select **Dynamic Data Masking** and then select **+ Add mask**.  

![Create new mask](../media/addmask.png)  

First, select the **SalesLT** schema, **Customer** table, and **FirstName** column. Then, you can review the options for masking, but the default is good for this scenario. Select **Add** to add the masking rule.  

![Add FirstName mask](../media/addmask2.png)  

Repeat this for both **MiddleName** and **LastName** in that table.  

After, you should have three masking rules, similar to below.  

![Review all masking rules](../media/addmask3.png)  

Select **Save**.  

![Select Save](../media/save.png)  

Finally, select **Overview** in the left hand menu to navigate back to the overview of your database.

#### Step 3 - Query classified and masked columns  

Next, you will simulate someone querying the classified columns and explore dynamic data masking in action. Navigate to SSMS and create a new query in your AdventureWorks database.  

> Note: You should be connected to this logical server using Azure AD authentication. If you are connected as `cloudadmin`, create a new connection and connect using Azure AD authentication.  

![Create a new query](../media/newquery.png)  

Now, run the following query to return the classified (and in some cases columns marked for masked) data.  

```sql
SELECT TOP 10 FirstName, MiddleName, LastName
FROM SalesLT.Customer;
```

You should get a result of the first ten names, with no masking applied. Why? Because you are the admin for this Azure SQL Database logical server.  

![SQL query results with no mask](../media/names.png)  

In the following query, you'll create a new user and run the previous query as that user. You'll also use `EXECUTE AS` to impersonate `Bob`. When an `EXECUTE AS` statement is run, the execution context of the session is switched to the login/user. This means that the permissions will be checked against the login/user instead of the person executing the `EXECUTE AS` command (in this case, you). `REVERT` is then used to stop impersonating the login/user.  

You may notice the first few parts of the commands that follow, since they are a repeat from Activity 2, Step 3. Run the following, and observe the results.  

```sql
-- Create a new SQL user and give them a password
CREATE USER Bob WITH PASSWORD = 'goTitans1!';

-- Until you run the following two lines, Bob has no access to read or write data
ALTER ROLE db_datareader ADD MEMBER Bob;
ALTER ROLE db_datawriter ADD MEMBER Bob;

-- Execute as our new, low-privilege user, Bob
EXECUTE AS USER = 'Bob';
SELECT TOP 10 FirstName, MiddleName, LastName
FROM SalesLT.Customer;
REVERT;
```

Now, you should get a result of the first ten names, but with masking applied. Bob has not been granted access to the unmasked form of this data.  

![SQL query results with mask](../media/names2.png)  

#### Step 4 - Add excluded users from masking  

What if, for some reason, Bob needs access to the names and gets permission to have it?  

You can update excluded users from masking in the Azure portal (in the Dynamic Data Masking pane under Security), but you can also do it using T-SQL. Use the query below to allow Bob to query the names results without masking.  

```sql
GRANT UNMASK TO Bob;  
EXECUTE AS USER = 'Bob';
SELECT TOP 10 FirstName, MiddleName, LastName
FROM SalesLT.Customer;
REVERT;  
```

Your results should include the names in full.  
![SQL query results with no mask](../media/names.png)  

Finally, you can also take away a user's unmasking privileges, and confirm that with the following T-SQL.  

```sql
-- Remove unmasking privilege
REVOKE UNMASK TO Bob;  

-- Execute as Bob
EXECUTE AS USER = 'Bob';
SELECT TOP 10 FirstName, MiddleName, LastName
FROM SalesLT.Customer;
REVERT;  
```

Your results should include the masked names.  
![SQL query results with mask](../media/names2.png)  

#### Step 5 - Analyze audit logs from Azure Blob storage with SSMS  

As an admin, you may want to review and audit who is accessing the databases and specifically the classified data. Next, you'll take a look at the audit files that are being sent to Azure Blob storage. The first thing you have to do is merge the audit files, in case logs span multiple files. You can do this from SSMS. First, select **File** > **Open** > **Merge Audit Files**.  

![Open audit files](../media/fileaudit.png)  

Next, select **Add**.  

![Add a new file](../media/fileauditadd.png)  

Specify to add then from Azure Blob storage and select **Connect**.  

![Add from Azure Blob Storage](../media/fileauditconnect.png)  

Now sign into Azure with the account you are using for this workshop.  

![Sign in to Azure](../media/fileauditsignin.png)  

Select the subscription, storage account, and blob container you configured Audit logs to go to (refer to your selection in the Azure portal under your Azure SQL Database logical server's Auditing blade). The container will be called `sqldbauditlogs`.  

![Select the blob container](../media/fileauditselect.png)  

Select your Azure SQL Database logical server and your AdventureWorks database. It should take everything from the day up until the second you select the Database name. Select **OK**.  

![Select OK](../media/fileauditok.png)  

The confirmation window lets you know how many files are being downloaded and merged. Select **OK**.  

![Confirm the number of files to be downloaded and merged](../media/downloadconf.png)  

Review the files and select **OK** one last time.  

![Select OK](../media/mergeaudit.png)  

You should now be able to see all the audit logs. Look for where you were testing with masking with Bob (should be near the bottom). You can select the statement, and then use the detail pane below to review the information. For example, for one of the queries where Bob tries to view classified data, under the `data_sensitivity_information` field, you can see the data that is classified. For more information on the naming conventions in audit logs, [see here](https://docs.microsoft.com/azure/sql-database/sql-database-audit-log-format). 

>**TIP**: Double-click on the value of the data_sensitivity_information in the Details tab. It will display a pop-up where you can more easily read the data.

And example of what you might see under `data_sensitivty_information` is below.  

```cxel
<sensitivity_attributes max_rank="20" max_rank_desc="Medium"><sensitivity_attribute label="Confidential - GDPR" label_id="bf91e08c-f4f0-478a-b016-23422b2a65ff" information_type="Name" information_type_id="57845286-7598-22f5-3422-15b24aeb125e" rank="20" rank_desc="Medium"/></sensitivity_attributes>
```

This merged file can then be exported to an XEL or CSV file (or to a table) for additional analysis. You can also query the [Extended Events files using PowerShell](https://sqlscope.wordpress.com/reading-extended-event-files-using-client-side-tools-only/).  

#### Step 6 - Analyze audit logs with Log Analytics  

Analyzing your audit logs will depend on your preference, and the method in Step 5 may be more familiar. In this step, you'll be exposed to querying security logs in the Azure portal with Log Analytics.  

In the Azure portal, navigate to your Azure SQL Database. In the left-hand menu, under Security, select **Auditing**. Then select **View audit logs**.  

![Navigate to view audit logs](../media/viewauditlogs.png)  

You should now be able to see a query of your event records, options to run in Query Editor (run T-SQL queries through the portal), options for Log Analytics/View dashboard, and more.  

![View audit records](../media/auditrecords.png)  

Feel free to click around and understand what some of the options are.  

Then, click on **Log Analytics**. If you see a *Get Started* screen, select **OK**. This then takes you to a query editor but it is not T-SQL. This view allows you to query logs using Kusto query language or KQL, which is meant to be easy to use and understand by SQL professionals. For the KQL documentation, [refer here](https://docs.microsoft.com/azure/kusto/query/).  

The default query is querying the category `SQLSecurityAuditEvents`, so while you might use this category now to view security related incidents, this tool can also be used for querying other Azure logs and categories in [Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/log-query/log-query-overview). For this step, you can look for the statements where Bob tried to access sensitive information, and expand the details (click the **`>`**) to get the same information that you saw in SSMS.  

![Log Analytics security query](../media/laview.png)  

> Note: It may take a few minutes for the results to show up here. You can refresh the query by selecting **Run** again.  

This activity won't go deep into KQL querying of logs, but there are many resources in the references above if you want more practice later.  

#### Step 7 - Analyze audit logs and monitor security with the Log Analytics SQL Security dashboard  

In this step, you'll see how SQL Security has built a dashboard based on Log Analytics for you to monitor and audit the logs and other SQL activity. To get back to Audit records, select the **X** in the top right corner of the Log Analytics query window.  

Then, select **View dashboard**.  

![View the log analytics dashboard](../media/viewdb.png)  

You should now see an overview dashboard. Drill in to **Azure SQL - Access to Sensitive Data**.  

> Note: You may need to wait 3-5 minutes and select **Refresh** for items to show up here.  

![Access to sensitive data dashboard view](../media/securitydb.png)  

You can use this drill down to find out:  

1. How many queries are accessing sensitive data
1. Which types and sensitivities of are being accessed
1. Which principals are accessing sensitive data
1. Which IPs are accessing sensitive data  

Review what's available here, and how you can audit usage with this tool. You can even click into each of these and see the related logs in Log Analytics.  

When you're done, select the **X** in the top right corner of the **Azure SQL - Access to Sensitive Data** tab.  

Back in the overview, select **Azure SQL - Security Insights**.  

![SQL security insights dashboard view](../media/securitydb.png)  

This dashboard gives more auditing information to help you understand database activity, and gain insight into anomalies. Spend a few minutes reviewing and drilling into the options here.  

In addition to these insights for Azure SQL services, by being in Azure you can leverage the Azure Security Center to monitor, manage, and respond to issues that arise across your entire Azure estate. If you want to look around (may be limited depending on your subscription level), you can search for **Security Center** and select under *Services*. To learn more about Azure Security Center, refer to the [documentation](https://docs.microsoft.com/azure/security-center/security-center-intro).

![Azure security center](../media/securitycenter.png)
