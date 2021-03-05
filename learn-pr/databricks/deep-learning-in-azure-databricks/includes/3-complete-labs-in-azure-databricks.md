You've learned about the various deep-learning techniques supported by Azure Databricks. To further explore some of these deep-learning tools, we'll use Databricks notebooks.

> [!NOTE]
> To complete the following procedures, you must have already deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch workspace**.
1. In the left pane, select **Workspace**, select **Users**, and then select your username (the entry with the house icon).
1. In the pane that appears, select the downward-pointing chevron next to your name, and then select **Import**.

    ![A screenshot of the menu option to import the archive](../media/import-archive.png)

1. In the **Import Notebooks** pane, select **URL**, and paste in the following URL:

    ```
    https://github.com/MicrosoftDocs/mslearn-deep-learning/blob/master/DBC/04-deep-learning.dbc?raw=true
    ```

1. Select **Import**.
1. A folder named after the archive should appear (04 Deep Learning). Select that folder. The folder contains one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

- **01 Deep Learning:** This notebook gives an overview of the other notebooks in this lab.
- **02 Neural Nets basic concepts:** This notebook demonstrates some basic neural network concepts.
- **03 Simple TensorFlow classifier with Azure Databricks:** This notebook demonstrates how to use the TensorFlow framework with Azure Databricks.
- **04 Image classification with Azure Databricks:** This notebook details the instructions for basic image classification by using Azure Databricks deep learning.
