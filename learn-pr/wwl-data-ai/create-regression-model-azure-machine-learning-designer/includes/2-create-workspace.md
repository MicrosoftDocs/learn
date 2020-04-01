Azure Machine Learning is a cloud-based platform for building and operating machine learning solutions in Azure. It includes a wide range of features and capabilities that help data scientists prepare data, train models, publish predictive services, and monitor their usage. One of these features is a visual interface called *designer*, that you can use to train, test, and deploy machine learning models without writing any code.

## Create an Azure Machine Learning workspace

To use Azure Machine Learning, you create a *workspace* in your Azure subscription. You can then use this workspace to manage data, compute resources, code, models, and other artifacts related to your machine learning workloads.

If you do not already have one, follow these steps to create a workspace:

1. Sign into the [Azure portal](https://portal.azure.com) using your Microsoft credentials.
2. Select **&#65291;Create a resource**, search for *Machine Learning*, and create a new **Machine Learning** resource the following settings:
    - **Workspace Name**: *A unique name of your choice*
    - **Subscription**: *Your Azure subscription*
    - **Resource group**: *Create a new resource group with a unique name*
    - **Location**: *Choose any available location*
    - **Workspace edition**: Enterprise
3. Wait for your workspace to be created (it can take a few minutes). Then go to it in the portal.
4. On the **Overview** page for your workspace, launch Azure Machine Learning Studio (or open a new browser tab and navigate to [https://ml.azure.com](https://ml.azure.com)), and sign into Azure Machine Learning studio using your Microsoft account.

You can manage your workspace using the Azure portal, but for data scientists and Machine Learning operations engineers, Azure Machine Learning studio provides a more focused user interface for managing workspace resources.

>[!IMPORTANT] 
>If you intend to use an Azure Machine Learning workspace that you created previously using the **Basic** edition, upgrade it to **Enterprise** edition to make the *designer* interface available.
