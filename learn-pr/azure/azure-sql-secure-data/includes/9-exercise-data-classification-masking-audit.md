In this exercise, you'll combine your learnings from the module to walk through a scenario. You will learn how to add new data classifications and dynamic data masks, and then you'll see various methods for auditing users trying to view columns that were marked for data classification. This exercise will combine several of the things you've already learned about in the module: data protection, auditing, and Advanced data security.

## Configure data classification and masking

1. In the Azure portal, navigate to your Azure SQL Database (not logical server).

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the left-hand menu, under Security, select **Advanced data security** and then select the **Data Discovery & Classification** box.  

1. Select the **Classification** tab and then select **+ Add classification**.  

    :::image type="content" source="../media/9-add-classification.png" alt-text="Screenshot of how to add a new classification.":::  

    In a previous exercise, you added all the recommended column classifications. In this step, you will *manually* add a potentially sensitive column to the list of classified columns.  

    In the SalesLT Customer table, DD&C identified FirstName and LastName to be classified, but not MiddleName. Using the drop-downs, add it now. Then, select **Add classification**.  

    :::image type="content" source="../media/9-add-classification-2.png" alt-text="Screenshot of how to add Name-related classification for Middle Name.":::  

1. Select **Save**.

1. You can confirm the added classification was successful by viewing the **Overview** tab and confirming that MiddleName is now present in the list of classified columns under the SalesLT schema. Select **X**.  

1. Dynamic Data Masking (DDM) is something available in Azure SQL as well as in SQL Server. It limits data exposure by masking sensitive data to non-privileged users at SQL Server vs the application having to code those types of rules. Azure SQL will recommend things for you to mask, or you can add masks manually. You'll mask the FirstName, MiddleName, and LastName columns, which you reviewed in the previous step.  

    In the Azure portal, navigate to your Azure SQL Database. In the left-hand menu, under Security, select **Dynamic Data Masking** and then select **+ Add mask**.  

1. First, select the **SalesLT** schema, **Customer** table, and **FirstName** column. Then, you can review the options for masking, but the default is good for this scenario. Select **Add** to add the masking rule.  

    :::image type="content" source="../media/9-add-mask-2.png" alt-text="Screenshot of how to add First Name mask.":::  

1. Repeat the previous step for both **MiddleName** and **LastName** in that table.  

    Now, you should have three masking rules, similar to below.  

    :::image type="content" source="../media/9-add-mask-3.png" alt-text="Screenshot of how to review all masking rules.":::  

1. Select **Save**.  

1. Select **Overview** in the left hand menu to navigate back to the overview of your database.

## Retrieve data that is classified and masked

1. Next, you will simulate someone querying the classified columns and explore dynamic data masking in action. Navigate to SSMS and create a new query in your AdventureWorks database (right-click on the database and select **New Query**).  

1. Now, run the following query to return the classified (and in some cases columns marked for masked) data.  

    ```sql
    SELECT TOP 10 FirstName, MiddleName, LastName
    FROM SalesLT.Customer;
    ```

    You should get a result of the first 10 names, with no masking applied. Why? Because you are the admin for this Azure SQL Database logical server.  

    :::image type="content" source="../media/9-names.png" alt-text="Screenshot of SQL query results with no mask.":::  

1. In the following query, you'll create a new user and run the previous query as that user. You'll also use `EXECUTE AS` to impersonate `Bob`. When an `EXECUTE AS` statement is run, the execution context of the session is switched to the login/user. This means that the permissions will be checked against the login/user instead of the person executing the `EXECUTE AS` command (in this case, you). `REVERT` is then used to stop impersonating the login/user.  

    You may notice the first few parts of the commands that follow, since they are a repeat from a previous exercise. Run the following, and observe the results.  

    ```sql
    -- Create a new SQL user and give them a password
    CREATE USER Bob WITH PASSWORD = 'c0mpl3xPassword!';

    -- Until you run the following two lines, Bob has no access to read or write data
    ALTER ROLE db_datareader ADD MEMBER Bob;
    ALTER ROLE db_datawriter ADD MEMBER Bob;

    -- Execute as our new, low-privilege user, Bob
    EXECUTE AS USER = 'Bob';
    SELECT TOP 10 FirstName, MiddleName, LastName
    FROM SalesLT.Customer;
    REVERT;
    ```

    Now, you should get a result of the first 10 names, but with masking applied. Bob has not been granted access to the unmasked form of this data.  

    :::image type="content" source="../media/9-names-2.png" alt-text="Screenshot of SQL query results with mask.":::  

1. What if, for some reason, Bob needs access to the names and gets permission to have it?  

    You can update excluded users from masking in the Azure portal (in the Dynamic Data Masking pane under Security), but you can also do it using T-SQL. Use the query below to allow Bob to query the names results without masking.  

    ```sql
    GRANT UNMASK TO Bob;  
    EXECUTE AS USER = 'Bob';
    SELECT TOP 10 FirstName, MiddleName, LastName
    FROM SalesLT.Customer;
    REVERT;  
    ```

    Your results should include the names in full.  

    :::image type="content" source="../media/9-names.png" alt-text="Screenshot of SQL query results with no mask.":::  

1. Finally, you can also take away a user's unmasking privileges, and confirm that with the following T-SQL.  

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

    :::image type="content" source="../media/9-names-2.png" alt-text="Screenshot of SQL query results with mask.":::  

## Review audit logs in SSMS

1. As an admin, you may want to review and audit who is accessing the databases and specifically the classified data. Next, you'll take a look at the audit files that are being sent to Azure Blob storage. The first thing you have to do is merge the audit files, in case logs span multiple files. You can do this from SSMS. First, select **File** > **Open** > **Merge Audit Files**.  

    :::image type="content" source="../media/9-file-audit.png" alt-text="Screenshot of how to open audit files.":::  

1. Next, select **Add**.  

    :::image type="content" source="../media/9-file-audit-add.png" alt-text="Add a new file":::  

1. Specify to add them from Azure Blob storage and select **Connect**.  

    :::image type="content" source="../media/9-file-audit-connect.png" alt-text="Screenshot of how to add from Azure Blob Storage.":::  

1. Sign into Azure with the account you are using for this module.  

    :::image type="content" source="../media/9-file-audit-signin.png" alt-text="Screenshot of how to sign in to Azure.":::  

1. Select the subscription, storage account, and blob container you configured Audit logs to go to. The storage account should start with `sqlva`. The container will be called `sqldbauditlogs`.  

1. Select your Azure SQL Database logical server and your AdventureWorks database. It should take everything from the current day up until the time you select the Database name. Select **OK**.

1. The confirmation window lets you know how many files are being downloaded and merged. Select **OK**.  

1. Review the files and select **OK** one last time.  

1. You should now be able to see all the audit logs. Look for where you were testing with masking with Bob (should be near the bottom). You can select the statement, and then use the details pane below to review the information. For example, for one of the queries where Bob tries to view classified data, under the `data_sensitivity_information` field, you can see the data that is classified.

1. You can double-click on the value of the data_sensitivity_information in the Details tab. It will display a pop-up where you can more easily read the data.

    And example of what you might see under `data_sensitivty_information` is below.  

    ```cxel
    <sensitivity_attributes max_rank="20" max_rank_desc="Medium"><sensitivity_attribute label="Confidential - GDPR" label_id="bf91e08c-f4f0-478a-b016-23422b2a65ff" information_type="Name" information_type_id="57845286-7598-22f5-3422-15b24aeb125e" rank="20" rank_desc="Medium"/></sensitivity_attributes>
    ```

    This merged file can then be exported to an XEL or CSV file (or to a table) for additional analysis. You can also query the Extended Events files using PowerShell.  

## Review audit logs in the Azure portal

Analyzing your audit logs will depend on your preference. Here, you'll be exposed to querying security logs in the Azure portal with Log Analytics.  

1. In the Azure portal, navigate to your Azure SQL Database. In the left-hand menu, under Security, select **Auditing**. Then select **View audit logs**.  

    You should now be able to see a query of your event records, options to run in Query Editor (run T-SQL queries through the portal), options for Log Analytics/View dashboard, and more.  

    :::image type="content" source="../media/9-audit-records.png" alt-text="Screenshot of how to view audit records.":::  

    Feel free to click around and understand what some of the options are.  

1. Select **Log Analytics**. If you see a *Get Started* screen, select **OK**. This then takes you to a query editor but it is not T-SQL. This view allows you to query logs using Kusto query language or KQL, which is meant to be easy to use and understand by SQL professionals.  

    The default query is querying the category `SQLSecurityAuditEvents`, so while you might use this category now to view security-related incidents, this tool can also be used for querying other Azure logs and categories in Azure Monitor. For this step, you can look for the statements where Bob tried to access sensitive information, and expand the details (click the **`>`**) to get the same information that you saw in SSMS.  

    It may take a few minutes for the results to show up here. You can refresh the query by selecting **Run** again.  

    This activity won't go deep into KQL querying of logs, but there are many resources in the references above if you want more practice later.  

1. In this step, you'll see how SQL Security has built a dashboard based on Log Analytics for you to monitor and audit the logs and other SQL activity. To get back to Audit records, select the **X** in the top-right corner of the Log Analytics query window.  

    Then, select **View dashboard**.  

    :::image type="content" source="../media/9-view-db.png" alt-text="Screenshot of the log analytics dashboard.":::  

1. You should now see an overview dashboard. Drill in to **Azure SQL - Access to Sensitive Data**.  

   You may need to wait 3-5 minutes and select **Refresh** for items to show up here.  

    You can use this drill down to find out:  

    - How many queries are accessing sensitive data
    - Which types and sensitivities of are being accessed
    - Which principals are accessing sensitive data
    - Which IPs are accessing sensitive data  

    Review what's available here, and how you can audit usage with this tool. You can even click into each of these and see the related logs in Log Analytics.  

1. When you're done, select the **X** in the top-right corner of the **Azure SQL - Access to Sensitive Data** tab.  

1. Back in the overview, select **Azure SQL - Security Insights**.  

    This dashboard gives more auditing information to help you understand database activity, and gain insight into anomalies. Spend a few minutes reviewing and drilling into the options here.  

In addition to these insights for Azure SQL services, by being in Azure you can leverage the Azure Security Center to monitor, manage, and respond to issues that arise across your entire Azure estate. If you want to look around (may be limited depending on your subscription level), you can search for **Security Center** in the Azure portal and select it under *Services*.
