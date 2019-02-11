Let's now jump onto the Databricks workspace and perform some basic Databricks Delta functions on a sample dataset.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your Azure Databricks workspace and select **Launch Workspace**.
1. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:

    ```  https://github.com/MicrosoftDocs/mslearn-create-data-pipelines-using-databricks-delta/blob/master/DBC/06-Databricks-Delta.dbc?raw=true

   ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this exercise.

## Complete the following notebooks

- **01-Introducing-Delta** - This notebook gives a brief overview of Databricks Delta and instructions on setting up your Databricks workspace for exercises.
- **02-Create** - In this notebook you look into the problems with the traditional data pipelines and then resolve those issues using Databricks Delta.
- **03-Append** - In this notebook you add new records to your sample dataset in a Databricks Delta table.
- **04-Upsert** -  Here you updated or insert records in an existing Databricks Delta table.
- **05-Streaming** - This notebook has instructions on how to read and write streaming data using Databricks Delta.
- **06-Optimization** - In this notebook you apply Databricks Delta operations to optimize your data pipeline.
- **07-Architecture** - In this notebook you work on your Databricks Delta architecture.
- **08-Capstone-Project** - This notebook includes a sample project for you explore later on in your own time.

> Note: You will find corresponding notebooks within the **Solutions** subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, return to this screen and continue to the next step.