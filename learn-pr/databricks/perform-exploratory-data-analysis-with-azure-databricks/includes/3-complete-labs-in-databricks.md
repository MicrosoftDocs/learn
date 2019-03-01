Now it's time to use Azure Databricks notebooks to perform a basic and advanced EDA on a sample data set.

To complete analysis of a sample data set, clone the lab archives that provide sample notebooks with detailed EDA functions.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your Azure Databricks workspace and select **Launch Workspace**.
1. Within the Workspace, using the command bar on the left, select **Workspace**, **Users** and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
    https://github.com/MicrosoftDocs/mslearn-exploratory-data-analysis/blob/master/DBC/02-exploratory-data-analysis.dbc?raw=true
    ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Exploratory Data Analysis** - This notebook contains a brief introduction of the other notebooks in the lab.
1. **02 Loading data with Azure Databricks** - This notebook contains an introduction to data loading with Azure Databricks. You'll learn how to prepare your data environment to start performing EDA.
1. **03 Basic EDA with Azure Databricks** - This notebook teaches you basic EDA techniques such as data cleaning, handling missing values, and correlation analysis.
1. **04 Advanced EDA with Azure Databricks** - This notebook covers exercises for advanced topics like linear regression analysis, one hot encoding, feature scaling, dimensionality reduction, and feature importance estimation.