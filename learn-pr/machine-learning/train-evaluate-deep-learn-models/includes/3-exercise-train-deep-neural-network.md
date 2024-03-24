So far in this module, you've learned a lot about the theory and principles of deep learning with neural networks. The best way to learn how to apply this theory is to actually build a deep learning model, and that's what you'll do in this exercise.

There are many frameworks available for training deep neural networks, and in this exercise you can choose to explore either (or both) of two of the most popular deep learning frameworks for Python: *PyTorch* and *TensorFlow*.

## Before you start

To complete the exercise, you'll need:

- A Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free](https://azure.microsoft.com/free?azure-portal=true).
- An Azure Machine Learning workspace with a compute instance and the **ml-basics** repository cloned.

> [!NOTE]
> This module makes use of an Azure Machine Learning workspace. If you are completing this module in preparation for the [Azure Data Scientist](/certifications/azure-data-scientist?azure-portal=true) certification, consider creating the workspace once, and reusing it in other modules. After completing the exercise, be sure to follow the **Clean Up** instructions to stop compute resources, and retain the workspace if you plan to reuse it.

### Create an Azure Machine Learning workspace

If you don't already have an Azure Machine Learning workspace in your Azure subscription, follow these steps to create one:

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using the Microsoft account associated with your Azure subscription.

1. On the Azure **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, search for and select *Machine Learning*. The **Azure Machine Learning** pane appears.

1. Select **Create**. The **Azure Machine Learning** pane appears.

1. On the **Basics** tab, Enter the following values to each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Select the Azure subscription you'd like to use for this exercise. |
    | Resource group | Select the **Create new** link, and name the new resource group with a unique name, and select **OK**. |
    | **Workspace details** |
    | Workspace name | Enter a unique name for your app. For example, you could use *\<yourname\>-machinelearn*. |
    | Region | From the dropdown list, select any available location. |

1. Accept the remaining defaults, and select **Review + create**.

1. After validation passes, select **Create**.

    Wait for your workspace resource to be created as it can take a few minutes.

1. When deployment completes, select **Go to resource**. Your **Machine learning** pane appears.

1. Select **Launch studio**, or go to [https://ml.azure.com](https://ml.azure.com?azure-portal=true), and sign in using your Microsoft account. The **Microsoft Azure Machine Learning studio** page appears.

1. In *Azure Machine Learning studio*, toggle the **&#9776;** icon at the top left to expane/collapse its menu pane. You can use these options to manage the resources in your workspace.

### Create a compute instance

To run the notebook used in this exercise, you will need a compute instance in your Azure Machine Learning workspace.

1. In the left menu pane, under **Manage**, select **Compute**. The **Compute** pane appears.

1. On the **Compute Instances** tab, if you already have a compute instance, start it; otherwise, create a new compute instance by selecting **New**. The **Create compute instance** pane appears.

1. Enter the following values for each setting:

    - **Compute name**: *enter a unique name*
    - **Virtual machine type**: CPU
    - **Virtual machine size**: Select from recommended options: Standard_DS11_v2

1. Select **Create**. The **Compute** pane reappears with your *Compute instance* listed.

1. Wait for the compute instance to start as this may take a couple of minutes. Under the **State** column, your *Compute instance* will change to **Running**.

### Clone the **ml-basics** repository

The files used in this module, and other related modules, are published in the **MicrosoftDocs/ml-basics** GitHub repository. If you haven't already done so, use the following steps to clone the repository to your Azure Machine Learning workspace:

1. Select **Workspaces** in the left-hand menu of Azure Machine Learning studio, then select the workspace you created in the list.

1. Under the **Authoring** heading on the left, select the **Notebooks** link to open Jupyter Notebooks. The **Notebooks** pane appears.

1. Select the **Terminal** button on the right. A terminal shell appears.

1. Run the following commands to change the current directory to the **Users** directory, and clone the **ml-basics** repository, which contains the notebook and files you will use in this exercise.

    ```bash
    cd Users
    git clone https://github.com/microsoftdocs/ml-basics
    ```

1. After the command has completed and the checkout of the files is done, close the terminal tab and view the home page in your Jupyter notebook file explorer.

1. Open the **Users** folder - it should contain an **ml-basics** folder, containing the files you will use in this module.

> [!NOTE]
> We highly recommend using Jupyter in an Azure Machine Learning workspace for this exercise. This setup ensures the correct version of Python and the various packages you will need are installed; and after creating the workspace once, you can reuse it in other modules. If you prefer to complete the exercise in a Python environment on your own computer, you can do so. You'll find details for configuring a local development environment that uses Visual Studio Code at [Running the labs on your own computer](https://github.com/MicrosoftDocs/ml-basics/blob/master/local-setup.md?azure-portal=true). Be aware that if you choose to do this, the instructions in the exercise may not match your notebooks user interface.

## Train a deep neural network model

After you've created a Jupyter environment, and cloned the **ml-basics** repository, you're ready to explore deep learning.

 1. In Jupyter, in the **ml-basics** folder, open *either* the **Deep Neural Networks (PyTorch).ipynb** or **Deep Neural Networks (Tensorflow).ipynb** notebook, depending on your framework preference, and follow the instructions it contains.

 1. When you've finished, close and halt all notebooks.

When you've finished working through the notebook, return to this module and move on to the next unit to learn more.
