
Let's use some advanced ETL techniques in the Databricks workspace. 

> [!NOTE]
> To complete the following procedures, you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. In the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
2. In the left pane, select **Workspace** > **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the arrow next to your name, and select **Import**.
4. In the **Import Notebooks** dialog box, select the URL and paste in the following URL:

  ```html
       https://github.com/MicrosoftDocs/mslearn-perform-advanced-data-transformation-in-azure-databricks/blob/master/DBC/05.2-Advanced-ETL.dbc?raw=true
  ```

5. Select **Import**.
6. A folder that is named after the archive should appear. Select that folder. The folder contains one or more notebooks that you'll use to complete this lab.

## Complete the notebooks

To complete the labs, continue working in your Azure Databricks workspace and open the new **05.2-Advanced-ETL** folder. You'll find _Python_ and _Scala_ in the folder. Choose the folder for the language you prefer to use, open the corresponding folder, and then open the notebook. Follow the instructions in the notebook until you've completed the entire notebook. Continue with the remaining notebooks in order:

- **01-Course-Overview-and-Setup** -  This notebook gets you started with your Databricks workspace.
- **02-Common-Transformations** - In this notebook, you perform some common data transformation by using Spark built-in functions.
- **03-User-Defined-Functions** - In this notebook, you perform custom transformation by using UDFs.
- **04-Advanced-UDFs** - In this notebook, you use advanced UDFs to perform complex data transformations.
- **05-Joins-and-Lookup-Tables** - In this notebook, you learn how to use standard and broadcast joins for tables.
- **06-Database-Writes** - This notebook contains exercises to write data to target databases in parallel, storing the transformed data from your ETL job.
- **07-Table-Management** - In this notebook, you handle managed and unmanaged tables to optimize your data storage.
- **Custom-Transformations** - This notebook is located in the Optional subfolder and includes a sample project for you to explore later.

> [!Note]
> You'll find corresponding notebooks in the Solutions subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or if you want to see the solution.

After you've completed the notebooks, return to this screen and continue to the next step.
