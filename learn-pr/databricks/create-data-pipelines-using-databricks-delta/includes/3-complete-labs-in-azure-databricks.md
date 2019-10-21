Now, let's jump into the Azure Databricks workspace and perform some basic Databricks Delta functions on a sample dataset.

> [!NOTE]
> To complete the following procedures, you must already have deployed your Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch Workspace**.
2. Within the workspace, use the command bar on the left to select **Workspace** > **Users**, and then select your user name (the entry with the house icon).
3. In the blade that appears, select the arrow next to your name, and then select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

4. In the **Import Notebooks** dialog box, select **URL** and paste in the following URL:

    ```html
    https://github.com/MicrosoftDocs/mslearn-create-data-pipelines-using-databricks-delta/blob/master/DBC/06-Databricks-Delta.dbc?raw=true

    ```

5. Select **Import**. A folder named after the archive appears.
6. Select that folder. It contains the notebooks that you'll use in completing this exercise.

## Complete the notebooks

Next, you'll complete the following notebooks:

- **01-Introducing-Delta**: Get a brief overview of Databricks Delta and instructions for setting up your Databricks workspace for doing exercises.
- **02-Create**: Look into the problems with traditional data pipelines, and then resolve those issues by using Databricks Delta.
- **03-Append**: Add new records to your sample dataset in a Databricks Delta table.
- **04-Upsert**:  Updated or insert records in an existing Databricks Delta table.
- **05-Streaming**: Get instructions about how to read and write streaming data by using Databricks Delta.
- **06-Optimization**: Apply Databricks Delta operations to optimize your data pipeline.
- **07-Architecture**: Work on your Databricks Delta architecture.
- **Data-Lake-Insights** (located in the Optional subfolder): Find a sample project for you to explore later.

> [!NOTE]
> You'll find corresponding notebooks in the **Solutions** subfolder. These contain completed cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

After you've completed the notebooks, come back here and continue to the next unit.
