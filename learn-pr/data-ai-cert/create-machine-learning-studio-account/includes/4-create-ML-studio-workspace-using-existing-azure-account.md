If you already have a Microsoft Azure account, you can create and manage a Machine Learning Studio Workspace directly from your Azure subscription. To do so, follow these steps:

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).
1. At the Dashboard, click **Create a resource**.

    ![Click Create a resource](../media/4-create-ml-workspace-with-existing-azure-account-create-resource.png)

1. Type "Machine Learning Studio Workspace" into the search bar.

    > [!IMPORTANT]
    > Ensure you choose the Learning Studio Workspace and not Learning Service Workspace!

1. Click **Create** at the bottom of the page.

    ![Create a new workspace](../media/4-create-ml-workspace-with-existing-azure-account-create-workspace.png)

1. Enter your workspace information. An example is shown here:

    ![Complete workspace details](../media/4-create-ml-workspace-with-existing-azure-account-workspace-details.png)

1. The web service plan you choose (or create), along with the associated pricing tier you select, is used if you deploy web services from this workspace

1. Click **Create** and wait for the resource to be created and deployed

1. You can now access your new Azure Machine Learning Studio Workspace in one of two ways:
     1. Go to the resource in your Azure portal
        - On the Overview page, click the Launch Machine Learning Studio button to open the workspace in Microsoft Azure Machine Learning Studio.
     2. Sign into the Azure Machine Learning Studio portal at [https://studio.azureml.net/](https://studio.azureml.net/?azure-portal=true).
        - Select your workspace in the upper-right-hand corner.
        - Click my experiments.