Now it's time to use the text analytics algorithms to develop your machine learning model. 

Clone the lab archives that provide sample notebooks with detailed steps for basic and advanced regression and classification.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
1. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
    https://github.com/MicrosoftDocs/mslearn-text-analytics/blob/master/DBC/05-text-analytics.dbc?raw=true
    ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Text Analytics** - This notebook contains a brief introduction of the other notebooks in the lab.
1. **02 Movie classification with Azure Databricks** - This notebook lists the steps to perform text analytics concepts to create a classifier for movies.
1. **03 Claim classification with Azure Databricks** - This notebook contains steps to train a classification model for claim predictions.