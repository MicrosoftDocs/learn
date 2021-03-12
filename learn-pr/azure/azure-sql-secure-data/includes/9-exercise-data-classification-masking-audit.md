In this exercise, you'll combine your learnings from the module to walk through a scenario. You'll learn how to add new data classifications and dynamic data masks, and then you'll see various methods for auditing users who try to view columns that were marked for data classification. This exercise combines several of the things you've already learned about in the module: data protection, auditing, and Azure Defender.

## Configure data classification and masking

1. In the Azure portal, go to your Azure SQL Database instance (not logical server).

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. On the left pane, under **Security**, select **Data Discovery & Classification**.  

1. Select the **Classification** tab, and then select **Add classification**.  

    :::image type="content" source="../media/9-add-classification.png" alt-text="Screenshot of how to add a new classification.":::  

    In a previous exercise, you added all the recommended column classifications. In this step, you *manually* add a potentially sensitive column to the list of classified columns.  

1. In the SalesLT Customer table, Data Discovery & Classification identified FirstName and LastName to be classified, but not MiddleName. Use the drop-down lists to add it now, and then select **Add classification**.  

    :::image type="content" source="../media/9-add-classification-2.png" alt-text="Screenshot of how to add a name-related classification for MiddleName.":::  

1. Select **Save**.

1. Confirm that the classification was successfully added by viewing the **Overview** tab, and confirm that MiddleName is now displayed in the list of classified columns under the SalesLT schema. 

1. On the left pane, select **Overview** to go back to the overview of your database.  

   Dynamic Data Masking (DDM) is available in both Azure SQL and SQL Server. DDM limits data exposure by masking sensitive data to nonprivileged users at the SQL Server level instead of at the application level where you have to code those types of rules. Azure SQL recommends items for you to mask, or you can add masks manually. 
   
   In the next steps, you'll mask the FirstName, MiddleName, and LastName columns, which you reviewed in the previous step.  

1. In the Azure portal, go to your Azure SQL Database instance. On the left pane, under **Security**, select **Dynamic Data Masking**, and then select **Add mask**.  

1. In the drop-down lists, select the **SalesLT** schema, **Customer** table, and **FirstName** column. You can review the options for masking, but the default option is good for this scenario. Select **Add** to add the masking rule.  

    :::image type="content" source="../media/9-add-mask-2.png" alt-text="Screenshot of how to add First Name mask.":::  

1. Repeat the previous steps for both **MiddleName** and **LastName** in that table.  

    You now have three masking rules similar to those shown here:  

    :::image type="content" source="../media/9-add-mask-3.png" alt-text="Screenshot of how to review all masking rules.":::  

1. Select **Save**.  

1. On the left pane, select **Overview** to go back to the overview of your database.

## Retrieve data that is classified and masked

Next, you simulate someone querying the classified columns and explore Dynamic Data Masking in action. 

1. Go to SQL Server Management Studio (SSMS),

1. To create a new query in your AdventureWorks database, right-click the database, and then select **New Query**.  

1. Run the following query to return the classified data and, in some cases, columns marked for masked data.  

    ```sql
    SELECT TOP 10 FirstName, MiddleName, LastName
    FROM SalesLT.Customer;
    ```

    Your result should display the first 10 names, with no masking applied. Why? Because you're the admin for this Azure SQL Database logical server.  

    :::image type="content" source="../media/9-names.png" alt-text="Screenshot of SQL query results with no mask.":::  

1. In the following query, you create a new user and run the preceding query as that user. You also use `EXECUTE AS` to impersonate `Bob`. When an `EXECUTE AS` statement is run, the execution context of the session is switched to the login/user. This means that the permissions are checked against the login/user instead of the person executing the `EXECUTE AS` command (in this case, you). `REVERT` is then used to stop impersonating the login/user.  

    You might recognize the first few parts of the commands that follow, because they're a repeat from a previous exercise. Run them, and observe the results.  

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

    The result should now display the first 10 names, but with masking applied. Bob hasn't been granted access to the unmasked form of this data.  

    :::image type="content" source="../media/9-names-2.png" alt-text="Screenshot of SQL query results with mask.":::  

    What if, for some reason, Bob needs access to the names and gets permission to have it?  

    You can update excluded users from masking in the Azure portal by going to the **Dynamic Data Masking** pane, under **Security**, but you can also do it by using T-SQL. 
    
1. Use the following query to allow Bob to query the names results without masking.  

    ```sql
    GRANT UNMASK TO Bob;  
    EXECUTE AS USER = 'Bob';
    SELECT TOP 10 FirstName, MiddleName, LastName
    FROM SalesLT.Customer;
    REVERT;  
    ```

    Your results should include the names in full.  

    :::image type="content" source="../media/9-names.png" alt-text="Screenshot of SQL query results with no mask.":::  

1. You can also take away a user's unmasking privileges and confirm that action by running the following T-SQL commands:  

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

As an admin, you might want to review and audit who is accessing the databases and, specifically, the classified data. Next, you can take a look at the audit files that are being sent to Azure Blob storage. The first thing you have to do is merge the audit files, if the logs span multiple files. You can do this from SSMS by doing the following:

1. Select **File** > **Open** > **Merge Audit Files**.  

    :::image type="content" source="../media/9-file-audit.png" alt-text="Screenshot of how to open audit files.":::  

1. Select **Add**.  

    :::image type="content" source="../media/9-file-audit-add.png" alt-text="Add a new file":::  

1. Select **Add from Azure Blob storage**, and then select **Connect**.  

    :::image type="content" source="../media/9-file-audit-connect.png" alt-text="Screenshot of how to add from Azure Blob storage.":::  

1. Sign in to Azure with the account you're using for this module.  

    :::image type="content" source="../media/9-file-audit-signin.png" alt-text="Screenshot of how to sign in to Azure.":::  

1. Select the subscription, storage account, and blob container you configured the audit logs to go to. The storage account should start with `sqlva`. The container will be called `sqldbauditlogs`.  

1. Select your Azure SQL Database logical server and your AdventureWorks database. The container should take everything from the current day up until the time you select the database name. Select **OK**.

1. The confirmation window lets you know how many files are being downloaded and merged. Select **OK**.  

1. Review the files, and then select **OK** one last time.  

   All the audit logs are now displayed. Look for where you were testing with masking with Bob. The listing should be near the bottom. 
   
1. Select the statement, and then review the information on the details pane. For example, for one of the queries where Bob tries to view classified data, under the `data_sensitivity_information` field, you can see the data that's classified.

1. Double-click the value of the **data_sensitivity_information** on the **Details** pane. A pop-up window opens so that you can more easily read the data.

    An example of what you might see under `data_sensitivity_information` is shown here:  

    ```cxel
    <sensitivity_attributes max_rank="20" max_rank_desc="Medium"><sensitivity_attribute label="Confidential - GDPR" label_id="bf91e08c-f4f0-478a-b016-23422b2a65ff" information_type="Name" information_type_id="57845286-7598-22f5-3422-15b24aeb125e" rank="20" rank_desc="Medium"/></sensitivity_attributes>
    ```

    You can then export this merged file to an XEL file, a CSV file, or a table for additional analysis. You can also query the Extended Events files by using Azure PowerShell.  

## Review audit logs in the Azure portal

Analyzing your audit logs will depend on your preference. In this section, you'll be exposed to querying security logs in the Azure portal with Log Analytics.  

1. In the Azure portal, go to your Azure SQL Database instance. On the left pane, under **Security**, select **Auditing** > **View audit logs**.  

    You should now be able to see a query of your event records, options to run in Query Editor (run T-SQL queries through the portal), options for Log Analytics/View dashboard, and more.  

    :::image type="content" source="../media/9-audit-records.png" alt-text="Screenshot of how to view audit records.":::  

    Feel free to click around to understand what some of the options are.  

1. Select **Log Analytics**. If you see a *Get Started* screen, select **OK**. This takes you to a query editor, but it's not a T-SQL editor. In this view, you can query logs by using the Kusto Query Language (KQL), which is meant for SQL professionals to easily use and understand.  

    The default query is querying the category `SQLSecurityAuditEvents`. Although you might use this category now to view security-related incidents, this tool can also be used for querying other Azure logs and categories in Azure Monitor. For this step, you can look for the statements where Bob tried to access sensitive information. To get the same information that you saw in SSMS, expand the details by selecting the **`>`**.  

    It might take a few minutes for the results to show up here. You can refresh the query by selecting **Run** again.  

    In this activity, you won't go deep into KQL querying of logs, but there are many resources in the earlier references if you want more practice later.  

    In the next step, you'll see how SQL Security has built a dashboard based on Log Analytics, so that you can monitor and audit the logs and other SQL activity. To return to the **Audit records** pane, close the Log Analytics query window by selecting the **X** at the upper right.  

1. Select **View dashboard**.  

    :::image type="content" source="../media/9-view-db.png" alt-text="Screenshot of the log analytics dashboard.":::  

   An overview dashboard is displayed. 
   
1. Select **Azure SQL - Access to Sensitive Data** to view more detail.  

   You might need to wait three to five minutes and select **Refresh** for items to show up here.  

    You can use this detailed information to find out:  

    - How many queries are accessing sensitive data.
    - Which types and sensitivities of data are being accessed.
    - Which principals are accessing sensitive data.
    - Which IPs are accessing sensitive data.  

    Review what's available here, and how you can audit usage with this tool. You can even click into each of these and see the related logs in Log Analytics.  

1. When you're done, close the **Azure SQL - Access to Sensitive Data** pane by selecting the **X** at the upper right.  

1. Back on the overview pane, select **Azure SQL - Security Insights**.  

    This dashboard displays more auditing information to help you understand database activity and gain insight into anomalies. Spend a few minutes reviewing and drilling into the options here.  

In addition to viewing these insights for Azure SQL services, being in Azure lets you use Azure Security Center to monitor, manage, and respond to issues that arise across your entire Azure estate. If you want to look around at what is available outside of the Azure SQL Security Center, you can search for and select **Security Center** in the Azure portal. Your access might be limited, depending on your subscription level.
