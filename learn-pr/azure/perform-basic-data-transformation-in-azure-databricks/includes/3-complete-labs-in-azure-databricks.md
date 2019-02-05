Now it's time to switch to the Databricks workspace and get hands-on with some of the basic transformation techniques. 

![NOTE]
To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select Launch Workspace.
2. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the downwards pointing chevron next to your name, and select Import.
4. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
     https://github.com/solliancenet/proj-learning-paths-public/blob/master/modern-data-warehouse/05.1-Basic-ETL.dbc?raw=true
    ```
5. Select Import.
6. A folder named after the archive should appear. Select that folder.
7. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

To complete the labs, continue working within your Azure Databricks workspace and open the new **05.1-Basic-ETL** folder. Within the folder, you'll find _Python_, _Scala_, and _Spark_ sub-folders. Choose the folder for the language you prefer to use, open the corresponding folder and then the  notebook. Follow the instructions within the notebook, until you've completed the entire notebook. Then continue with the remaining notebooks in order:

- **01-Course-Overview-and-Setup** -  This notebook gets you started with your Databricks workspace.
- **02-ETL-Process-Overview** - This notebook contains exercises to help you query, large data files and visualize your results.
- **03-Connecting-to-Azure-Blob-Storage** - You perform basic aggregation and Joins in this notebook.
- **04-Connecting-to-JDBC** - This notebook lists the steps for accessing data from various sources using Databricks.
- **05-Applying-Schemas-to-JSON** - In this notebook you learn how to query JSON & Hierarchical Data with DataFrames
- **06-Corrupt-Record-Handling** - This notebook lists the exercises that help you understand how to create ADLS and use Databricks DataFrames to query and analyze this data.
- **07-Loading-Data-and-Productionalizing** - Here you use Databricks to query and analyze data stores in Azure Data Lake Storage Gen2.
- **08-Capstone-Project** - This notebook includes a sample project for you explore later on in your own time.

> ![Note]
> You'll find corresponding notebooks within the **Solutions** subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, return to this screen and continue to the next step.