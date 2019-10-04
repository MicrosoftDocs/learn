Now it's time to switch to the Databricks workspace and get hands-on with some basic transformation techniques. 

> [!NOTE]
> To complete the following procedures, you must have already deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch workspace**.
1. In the left pane, select **Workspace**, select **Users**, and then select your username (the entry with the house icon).
1. In the pane that appears, select the downward-pointing chevron next to your name, and then select **Import**.
1. In the **Import Notebooks** pane, select **URL**, and paste in the following URL:

    ```
     https://github.com/MicrosoftDocs/mslearn-perform-basic-data-transformation-in-azure-databricks/blob/master/DBC/05.1-Basic-ETL.dbc?raw=true
    ```

1. Select **Import**.
1. A folder named after the archive should appear. Select that *05.1-Basic-ETL* folder. The folder contains one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. To complete the labs, continue working within your Azure Databricks workspace and open the new *05.1-Basic-ETL* folder. Within the folder, you'll find _Python_, _Scala_, and _Spark_ subfolders. 
1. Choose the folder for the language you prefer to use, open the corresponding folder, and then open the notebook. 
1. Follow the instructions within the notebook until you've completed the entire notebook. Then continue with the remaining notebooks in order:

   - **01-Course-Overview-and-Setup**: This notebook gets you started with your Databricks workspace.
   - **02-ETL-Process-Overview**: This notebook contains exercises to help you query large data files and visualize your results.
   - **03-Connecting-to-Azure-Blob-Storage**: You do basic data aggregation and joins in this notebook.
   - **04-Connecting-to-JDBC**: This notebook lists the steps for accessing data from various sources by using Databricks.
   - **05-Applying-Schemas-to-JSON**: In this notebook, you learn how to query JSON and hierarchical data with DataFrames.
   - **06-Corrupt-Record-Handling**: This notebook lists exercises that help you create an Azure Data Lake Storage Gen2 storage account and use Databricks DataFrames to query and analyze this data.
   - **07-Loading-Data-and-Productionalizing**: Here you use Databricks to query and analyze data stores in Azure Data Lake Storage Gen2.
   - **Parsing-Nested-Data**: This notebook is in the *Optional* subfolder. It includes a sample project you can explore later.

> [!NOTE]
> You'll find corresponding notebooks within the *Solutions* subfolder. These notebooks contain finished cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, return to this screen, and continue to the next step.