
Let's now use some advanced ETL techniques in the Databricks workspace. 

![NOTE]
To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select Launch Workspace.
2. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the downwards pointing chevron next to your name, and select Import.
4. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
     https://github.com/solliancenet/proj-learning-paths-public/blob/master/modern-data-warehouse/05.2-Advanced-ETL.dbc?raw=true
    ```
5. Select Import.
6. A folder named after the archive should appear. Select that folder.
7. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

To complete the labs, continue working within your Azure Databricks workspace and open the new **05.2-Advanced-ETL** folder. Within the folder, you'll find _Python_ and _Scala_. Choose the folder for the language you prefer to use, open the corresponding folder and then the  notebook. Follow the instructions within the notebook, until you've completed the entire notebook. Then continue with the remaining notebooks in order:

- **01-Course-Overview-and-Setup** -  This notebook gets you started with your Databricks workspace.
- **02-Common-Transformations** - In this notebook you perform some common data transformation using Spark built-in functions.
- **03-User-Defined-Functions** - In this notebook you perform custom transformation using user-defined functions.
- **04-Advanced-UDFs** - In this notebook you use advanced user-defined functions to perform some complex data transformations.
- **05-Joins-and-Lookup-Tables** - In this notebook you learn how to use standard and broadcast join for tables.
- **06-Database-Writes** - This notebook contains exercises to write data to a number of target databases in parallel, storing the transformed data from your ETL job.
- **07-Table-Management** - Here you handle managed and unmanaged tables to optimize your data storage.
- **08-Capstone-Project** - This notebook includes a sample project for you explore later on in your own time.

> ![Note]
> You'll find corresponding notebooks within the **Solutions** subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, return to this screen and continue to the next step.