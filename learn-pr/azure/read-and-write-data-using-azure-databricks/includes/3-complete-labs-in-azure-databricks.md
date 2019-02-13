You learned about the data reading and writing capabilities of Databricks. Now let's use some of the Databricks functions in the actual Databricks workspace.

![NOTE]
To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select Launch Workspace.
2. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the downwards pointing chevron next to your name, and select Import.
4. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
    https://github.com/MicrosoftDocs/mslearn-read-and-write-data-using-azure-databricks/blob/master/DBC/04-Reading-Writing-Data.dbc?raw=true
    ```
5. Select Import.
6. A folder named after the archive should appear. Select that folder.
7. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

To complete the labs, continue working within your Azure Databricks workspace and open the new **04-Reading-Writing-Data** folder. Within the folder, you'll find _Python_, _Scala_, and _Spark_ sub-folders. Choose the folder for the language you prefer to use, open the corresponding folder and then the  notebook. Follow the instructions within the notebook, until you've completed the entire notebook. Then continue with the remaining notebooks in order.

- **01-Getting-Started** -  This notebook gets you started with your Databricks workspace.
- **02-Querying-Files** - This notebook contains exercises to help you query, large data files and visualize your results.
- **03-Joins-Aggregations** - You perform basic aggregation and Joins in this notebook.
- **04-Accessing-Data** - This notebook lists the steps for accessing data from various sources using Databricks.
- **05-Querying-JSON** - In this notebook you learn how to query JSON & Hierarchical Data with DataFrames
- **06-Data-Lakes** - This notebook lists the exercises that help you understand how to create ADLS and use Databricks DataFrames to query and analyze this data.
- **07-Azure-Data-Lake-Gen2** - Here you use Databricks to query and analyze data stores in Azure Data Lake Storage Gen2.
- **08-Key-Vault-backed-secret-scopes** - This notebook lists the steps for configuring a Key Vault-backed secret scope. You'll create a Key Vault-backed secret scope  and securely store in it usernames and passwords for a sample SQL Database and Cosmos DB to be used in the following notebooks.
- **09-SQL-Database-Connect-Using-Key-Vault** - Here you'll connect to a SQL Database using your Azure SQL username and password that you created and securely stored in the Key Vault-backed secret scope in the previous notebook.
- **10-Cosmos-DB-Connect-Using-Key-Vault** - Here you'll connect to a Cosmos DB using your Azure Cosmos DB username and password that you previously created and securely stored in the Key Vault-backed secret scope.
- **Exploratory-Data-Analysis** - This notebook is located in the `Optional` subfolder, and includes a sample project for you explore later on in your own time.

> Note: You'll find corresponding notebooks within the **Solutions** subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, return to this screen and continue to the next step.
