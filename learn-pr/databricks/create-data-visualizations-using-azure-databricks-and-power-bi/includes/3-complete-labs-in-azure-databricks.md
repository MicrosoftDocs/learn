To do some hands-on exercises for visualizing data by using Databricks, switch to your Databricks workspace. We'll use a sample dataset to run simple queries and data analysis. Then, we'll use some built-in Databricks functions to visualize data. Finally, we'll use Power BI and Matplotlib to see how we can integrate these tools for better visualizations of our data. 

> [!NOTE]
> To complete the following procedures, you must have already deployed your Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch workspace**.
1. In the left pane, select **Workspace**, select **Users**, and then select your username (the entry with the house icon).
1. In the pane that appears, select the downward-pointing chevron next to your name, and then select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. In the **Import Notebooks** pane, select **URL**, and paste in the following URL:

   ```html
   https://github.com/MicrosoftDocs/mslearn-create-data-visualizations-using-azure-databricks-and-power-bi/blob/master/DBC/07-Visualization.dbc?raw=true
   ```

1. Select **Import**.
1. A folder named after the archive should appear. Select that *07-Visualization* folder. The folder contains one or more notebooks that you'll use in completing this lab.

## Open the data-visualization exercises

1. To do the data-visualization exercises, continue working within your Databricks workspace and open the new *07-Visualization* folder. Within the folder, you'll find *Python*, *Scala*, and *Spark* subfolders.
1. Choose the language you prefer to use, open the corresponding folder, and then open the *01-Querying-Files* notebook. 
1. Follow the instructions in the notebook until you've finished the entire notebook.

> [!NOTE]
> You'll find corresponding notebooks within the *Solutions* subfolder. These notebooks contain finished cells for exercises that ask you to complete one or more challenges. Refer to these if you get stuck or simply want to see the solution.

## Complete the following notebooks

- **01-Querying-Files**: This notebook contains some basic visualizations that use built-in Databricks functions and DataFrames.
- **02-Exploratory-Data-Analysis**: In this notebook, you do some basic exploratory analysis on a sample dataset to prepare it for advanced visualization in the next notebooks.
- **03-Power-BI**: In this notebook, you connect your Databricks cluster to Power BI and create visualizations by using Power BI tools.
- **04-Matplotlib**: In this notebook, you use Matplotlib to create custom visualizations for your data.

After you've completed the notebooks, return to this screen, and continue to the next step.