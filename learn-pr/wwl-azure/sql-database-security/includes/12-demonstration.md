Give these Try-This exercises a test to gain some experience using Azure.

> [!NOTE] 
> These demonstrations requires an Azure SQL database with sample data. In Task 1, there are instructions to install the AdventureWorks sample database. Also, Task 3 requires SQL Server Management Studio. 

## Task 1 - Azure SQL: Advanced Data Security and Auditing

In this task, we will explore vulnerability assessments, data discovery and classification, and auditing.

### Install the AdventureWorks sample database

Skip this section if you already have a database to work with. 

1. In the **Portal**, search for and a select **SQL databases**.
1. On the **Basics** tab, give you database a name, and create a new server.
1. On the **Additional settings** tab, select **Sample** for **Use existing data**. Also, **Enable advanced data security** and **Start free trial**.
1. **Review & create**, and then **Create**.
1. Wait for the database to deploy. 

### Review Vulnerability Assessments

1. Navigate to your SQL database.
1. Under **Security** select **Advanced Data Security**.
1. Select **Vulnerability Assessment**. 
1. Review vulnerability assessments and the risk levels.
1. Click **Scan**.
1. The scan does not need to fully complete for results to show. 
1. Review the **Findings**. 
1. Click any **Security Check** to get more details.
1. Review the **Passed** checks.
1. Notice **Export Scan Results** and **Scan History**

### Review Data Discovery and Classification

1. Return to the **Advanced data security** blade. 
1. Select **Data Discovery & Classification**.
1. On the **Classification** tab, select **Add classification**. 
	* Schema name: **SalesLT**
	* Table name: **Customer**
	* Column name: **Phone**
	* Information type: **Contact Info**
	* Sensitivity label: **Confidential**
1. When finished click **Add classification**.
1. Click the blue bar **columns with classification recommendations**. 
1. Notice the data that has been recommended for classification.
1. Select the data of interest and then click **Accept selected recommendations**. 
1. **Save** your changes.

### Review Auditing

1. Return to your SQL database.
1. Under **Security** select **Auditing**.
    * Select **On** for auditing. 
    * Click **Storage** for the destination.
    * Select on the Storage account for logs.
    * Set Retention day to **45** days.
    * Set storage access key to Primary.
1. **Save** your changes.
1. Discuss **Server level auditing** and when how it could be used. 

## Task 2 - Azure SQL: Diagnostics

> [!NOTE] 
> This demonstration requires an Azure SQL database.

In this task, we will review and configure SQL database diagnostics. 

1. In the **Portal**, search for and launch **SQL databases**.
1. From the **Overview** blade, review the **Compute utilization** data graphic. Data is available for different time frames (1 hour, 24 hours, 7 days). 
1. Under **Monitoring** select **Diagnostic settings**.
1. Click **Add diagnostic setting**. 
1. Give your setting a name.
1. Under **Destination details** select **Send to Log Analytics**. Make a note of the Log Analytics workspace that will be used. 
1. Under **Destination details** select **Archive to Storage Account**.
    * Select the **Errors** log.
    * Select the **Automatic tuning** log.
    * Select the **Basic** metric.
    * Give each item a **retention time** of 45 days. Retention only applies to storage account. 
1. **Save** your diagnostic setting.
1. In the **Portal**, search for and launch the **Log Analytics workspace**. 
1. Select the workspace that is being using for your database diagnostics.
1. Under **General** select **Usage and estimated costs**. 
1. Click **Data retention**. Use the slider to show how to increase the data retention time. Discuss how additional charges can incur, depending on the pricing plan.
1. Under **General** select **Workspace summary**.
1. Click **Add** and then search the Marketplace for **Azure SQL**. This feature may be in Preview. Explain the benefits of using this product. 
1. Select and then create **Azure SQL Analytics**. 
1. It will take few minutes for the product to deploy. 
1. Click **Go to resource** once the deployment is completed. 
1. Click **Azure SQL databases**.
1. Review the additional metrics that are provided by this product. 
1. You can drill into any graphic for additional details.

## Task 3 - Azure SQL: AAD Authentication

> [!NOTE] 
> This task requires an Azure SQL database that has not had AAD configured. This task also requires SQL Server Management Studio. 

In this task, we will configure Azure AD authentication. 

1. In the **Portal**.
1. Navigate to your SQL database.
1. On the **Overview** page, there is an **Active Directory admin** box that shows the current status, configured or not configured.
1. Under **Settings** select **Active Directory admin**.
1. Click **Set admin**.
1. Search for and **Select** the new Active Directory admin. Remember this user you will need in following steps.
1. Be sure to **Save** your changes.
1. In **SQL Server Management Studio** connect to the database server using your credentials.
1. Select the SQL database you configured with a new Active Directory admin.
1. Construct a query to create a new user. Insert the admin user and domain. For example, user@contoso.com
	* Create user [user@contoso.com] from external provider;
1. Run the query and ensure it completes successfully.
1. In the **Object Explorer** navigate your database and **Security** and **Users** folder.
1. Verify that the new admin user is shown.
1. **Connect** to the new database with the new admin credentials.
1. Verify that you can successfully access the database.
 
