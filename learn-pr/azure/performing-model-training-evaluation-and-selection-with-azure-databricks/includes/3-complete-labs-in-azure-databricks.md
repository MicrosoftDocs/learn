You've learned about various techniques supported by Azure Databricks to train and evaluate a machine learning model. Let's now use some of these techniques to create and train our own model using some sample data set. We will use Databricks notebooks for training and evaluating the model.

Clone the lab archives that provide sample notebooks with detailed steps for basic and advanced regression and classification.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
2. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
    https://github.com/MicrosoftDocs/mslearn-model-training-selection-evaluation/blob/master/DBC/03-model-training-selection-evaluation.dbc?raw=true
    ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Model Training Selection Evaluation**- This notebook contains instruction on how to prepare your data set. you'll import a sample data set and perform some basic function to clean the data.
1. **02 Basic Regression with Azure Databricks** - This notebook contains techniques for basic regression. you'll use the data set you imported in the first notebook and perform basic regression on it.
1. **03 Classification with Azure Databricks** - This notebook details the instructions for resolving classification problems. you'll use the scenarios from the sample data set to use different classification models.
1. **04 Advanced Regression with Azure Databricks** - In this notebook, you'll go through some of the advanced regression techniques and use them to further train and evaluate you machine learning model.