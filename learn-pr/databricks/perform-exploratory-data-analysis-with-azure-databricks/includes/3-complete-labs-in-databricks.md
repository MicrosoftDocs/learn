Now it's time to use Azure Databricks notebooks to do basic and advanced EDA on a sample dataset.

To complete analysis of a sample dataset, clone the lab archives that provide sample notebooks with detailed EDA functions.

> [!NOTE]
> To complete the following procedures, you must have already deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch workspace**.
1. In the left pane, select **Workspace**, select **Users**, and then select your username (the entry with the house icon).
1. In the pane that appears, select the downward-pointing chevron next to your name, and then select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. In the **Import Notebooks** pane, select **URL**, and paste in the following URL:

    ```
    https://github.com/MicrosoftDocs/mslearn-exploratory-data-analysis/blob/master/DBC/02-exploratory-data-analysis.dbc?raw=true
    ```

1. Select **Import**.
1. A folder named after the archive should appear. Select that folder. The folder contains one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

- **01 Exploratory Data Analysis**: This notebook contains a brief introduction to the other notebooks in the lab.
- **02 Loading data with Azure Databricks**: This notebook introduces you to loading data with Azure Databricks. You'll learn how to prepare your data environment to start doing EDA.
- **03 Basic EDA with Azure Databricks**: This notebook teaches you basic EDA techniques, such as:

  - Data cleansing
  - Handling of missing values
  - Correlation analysis

- **04 Advanced EDA with Azure Databricks**: This notebook contains exercises for advanced EDA subjects, like:

  - Linear-regression analysis
  - One-hot encoding
  - Feature scaling
  - Dimensionality reduction
  - Feature-importance estimation