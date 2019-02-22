Now you've learned about various deep learning techniques supported by Azure Databricks, it's time to use some of those techniques. We'll use Databricks notebooks for further exploring some of the deep learning tool.

To do this, clone the lab archives that provide sample notebooks with detailed steps for deep learning.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
1. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
    https://github.com/MicrosoftDocs/mslearn-deep-learning/blob/master/DBC/04-deep-learning.dbc?raw=true
    ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Deep Learning** - This notebook gives a brief about the other notebooks in this lab.
1. **02 Neural Nets basic concepts** - This notebook demonstrates some basic neural network concepts.
1. **03 Simple Tensorflow classifier with Azure Databricks** - This notebook demonstrates how to use TensorFlow framework to use with Azure Databricks.
1. **04 Image classification with Azure Databricks** - This notebook details the instructions for basic image classification using Azure Databricks deep learning.