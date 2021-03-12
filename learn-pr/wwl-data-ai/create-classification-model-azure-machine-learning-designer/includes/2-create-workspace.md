Azure Machine Learning is a cloud-based platform for building and operating machine learning solutions in Azure. It includes a wide range of features and capabilities that help data scientists prepare data, train models, publish predictive services, and monitor their usage. One of these features is a visual interface called *designer*, that you can use to train, test, and deploy machine learning models without writing any code.

## Create an Azure Machine Learning workspace

To use Azure Machine Learning, you create a *workspace* in your Azure subscription. You can then use this workspace to manage data, compute resources, code, models, and other artifacts related to your machine learning workloads.

> [!NOTE]
> This module is one of many that make use of an Azure Machine Learning workspace. If you are completing this module in preparation for the [Azure AI Fundamentals](https://docs.microsoft.com/learn/certifications/azure-ai-fundamentals?azure-portal=true) or [Azure Data Scientist](https://docs.microsoft.com/learn/certifications/azure-data-scientist?azure-portal=true) certification, consider creating the workspace once and reusing it in other modules. After completing each module, be sure to follow the **Clean Up** instructions at the end of the module to stop compute resources.

If you do not already have one, follow these steps to create a workspace:

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using your Microsoft credentials.
2. Select **&#65291;Create a resource**, search for *Machine Learning*, and create a new **Machine Learning** resource the following settings:
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *Create or select a resource group*
    - **Workspace name**: *Enter a unique name for your workspace*
    - **Region**: *Select the geographical region closest to you*
    - **Storage account**: *Note the default new storage account that will be created for your workspace*
    - **Key vault**: *Note the default new key vault that will be created for your workspace*
    - **Application insights**: *Note the default new application insights resource that will be created for your workspace*
    - **Container registry**: None (*one will be created automatically the first time you deploy a model to a container*)
3. Wait for your workspace to be created (it can take a few minutes). Then go to it in the portal.
4. On the **Overview** page for your workspace, launch Azure Machine Learning Studio (or open a new browser tab and navigate to [https://ml.azure.com](https://ml.azure.com?azure-portal=true)), and sign into Azure Machine Learning studio using your Microsoft account.
5. In Azure Machine Learning studio, toggle the &#9776; icon at the top left to view the various pages in the interface. You can use these pages to manage the resources in your workspace.

You can manage your workspace using the Azure portal, but for data scientists and Machine Learning operations engineers, Azure Machine Learning studio provides a more focused user interface for managing workspace resources.
