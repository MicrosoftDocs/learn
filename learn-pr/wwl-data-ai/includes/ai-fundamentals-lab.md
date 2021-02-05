To complete this exercise, you'll need the following:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free](https://azure.microsoft.com/free?azure-portal=true).
- A Python environment in which you can run the Jupyter notebooks in the **MicrosoftDocs/ai-fundamentals** GitHub repository. You can clone the lab files from GitHub into your own Python environment if you have one, or you can follow the instructions below to create an Azure Machine Learning workspace in your Azure subscription.

> [!NOTE]
> This module is one of many that make use of an Azure Machine Learning workspace. If you are completing this module in preparation for the [Azure AI Fundamentals](https://docs.microsoft.com/learn/certifications/azure-ai-fundamentals?azure-portal=true) certification, you can create the workspace once, and reuse it for all of the modules for that certification track. After completing the exercise, be sure to follow the **Clean Up** instructions to stop compute resources between modules.

### Create an Azure Machine Learning workspace

If you already have an Azure Machine Learning workspace in your Azure subscription, in a new browser tab, navigate to [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true) and sign into Azure Machine Learning studio using your Microsoft account. Otherwise, follow these steps to create a new workspace:

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the Microsoft account associated with your Azure subscription.
2. Select **＋Create a resource**, search for *Machine Learning*, and create a new **Machine Learning** resource with the following settings:
    - **Workspace Name**: *enter a unique name of your choice*
    - **Subscription**: *your Azure subscription*
    - **Resource group**: *create a new resource group with a unique name*
    - **Location**: *choose any available location*
3. Wait for your workspace resource to be created (it can take a few minutes). Then go to it in the portal, and on the **Overview** page for your workspace, launch Azure Machine Learning studio (or open a new browser tab and navigate to [https://ml.azure.com](https://ml.azure.com?azure-portal=true)), and sign into Azure Machine Learning studio using your Microsoft account.
4. In Azure Machine Learning studio, toggle the  **&#9776;** icon at the top left to view the various pages in the interface. You can use these pages to manage the resources in your workspace.

### Create a compute instance

To run the notebook used in this exercise, you will need a compute instance in your Azure Machine Learning workspace. If you already have one, start it; otherwise, follow these instructions to create one:

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true) , view the **Compute** page (under **Manage**).
2. On the **Compute Instances** tab, create a new compute instance with the following settings:
    - **Region**: *choose any available location*
    - **Virtual Machine type**: CPU
    - **Virtual Machine size**: Standard_DS11_v2
    - **Compute name**: *enter a unique name*
3. Wait for the compute instance to start (this may take a minute or so)

### Download the exercise files

The files used in this module (and other related modules) are published in a GitHub repository, which you need to clone to your Python environment. If you haven't already cloned the **ai-fundamentals** repository in a previous module, use the following steps to clone it to your Azure Machine Learning workspace:

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Notebooks** page (under **Author**). This page contains a notebook editor that you can use to run notebooks.
2. Under **My files**, use the **&#128459;** button to create a new file with the following settings:
    - **File location**: Users/*your user name*
    - **File name**: Get-Files
    - **File type**: Notebook
    - **Overwrite if already exists**: Selected

3. When the new notebook has been created, ensure that the compute instance you created previously is selected in the **Compute** box, and that it has a status of **Running**. Then, in the rectangular cell that has been created in the notebook, paste the following code:

    ```
    !git clone https://github.com/MicrosoftDocs/ai-fundamentals
    ```

4. Use the **&#9655;** button next to the cell to run the code it contains. This will clone the exercise files from GitHub.
5. When the code has finished running and the checkout of the file is done, use the **&#8635;** button under **My files** to refresh the folder view, and verify that a folder named **ai-fundamentals** has been created. This folder contains notebooks and other files used in the exercise.
6. Close the **Get-Files.ipynb** notebook tab.
