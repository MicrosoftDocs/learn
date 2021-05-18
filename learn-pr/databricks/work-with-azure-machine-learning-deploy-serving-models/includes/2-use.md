In this unit, you need to complete the exercises within a Databricks Notebook. To begin, you need to have access to an Azure Databricks workspace with an interactive cluster. If you do not have a workspace and/or the required cluster, follow the instructions below. Otherwise, you can skip to the bottom of the page to **Install required libraries**.

## Unit prerequisites

**Microsoft Azure Account**: You will need a valid and active Azure account for the Azure labs. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/free/)

- If you are a Visual Studio Active Subscriber, you are entitled to Azure credits per month. You can refer to this [link](https://azure.microsoft.com/pricing/member-offers/credit-for-visual-studio-subscribers/) to find out more including how to activate and start using your monthly Azure credit.

- If you are not a Visual Studio Subscriber, you can sign up for the FREE [Visual Studio Dev Essentials](https://www.visualstudio.com/dev-essentials/) program to create Azure free account.

## Create the required resources

To complete this lab, you will need to deploy an Azure Databricks workspace in your Azure subscription.

### Deploy an Azure Databricks workspace

1. Click the following button to open the Azure Resource Manager template in the Azure portal.
   [Deploy Databricks from the Azure Resource Manager Template](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F101-databricks-workspace%2Fazuredeploy.json)

1. Provide the required values to create your Azure Databricks workspace:

   - **Subscription**: Choose the Azure Subscription in which to deploy the workspace.
   - **Resource Group**: Leave at Create new and provide a name for the new resource group.
   - **Location**: Select a location near you for deployment. For the list of regions supported by Azure Databricks, see [Azure services available by region](https://azure.microsoft.com/regions/services/).
   - **Workspace Name**: Provide a name for your workspace.
   - **Pricing Tier**: Ensure `premium` is selected.

1. Accept the terms and conditions.
1. Select Purchase.
1. The workspace creation takes a few minutes. During workspace creation, the portal displays the Submitting deployment for Azure Databricks tile on the right side. You may need to scroll right on your dashboard to see the tile. There is also a progress bar displayed near the top of the screen. You can watch either area for progress.

### Create a cluster

1. When your Azure Databricks workspace creation is complete, select the link to go to the resource.

1. Select **Launch Workspace** to open your Databricks workspace in a new tab.

1. In the left-hand menu of your Databricks workspace, select **Clusters**.

1. Select **Create Cluster** to add a new cluster.

    ![The create cluster page](../media/create-cluster.png)

1. Enter a name for your cluster. Use your name or initials to easily differentiate your cluster from your coworkers.

1. Select the **Cluster Mode**: **Single Node**

1. Select the **Databricks RuntimeVersion**: **Runtime: 7.3 LTS ML (Scala 2.12, Spark 3.0.1)** (remember to select the **ML** version).

1. Under **Autopilot Options**, leave the box **checked** and in the text box enter `45`.

1. Select the **Node Type**: **Standard_DS3_v2**

1. Select **Create Cluster**.

## Install required libraries

1. From the cluster configuration page, select the **Libraries** link and then select **Install New**.

1. In the `Library Source`, select **PyPi** and in the `Package` text box type `azureml-sdk==1.2.0` and select **Install**.

    ![Install required library](../media/install-lib-2.png)

## Clone the Databricks archive

1. If you do not currently have your Azure Databricks workspace open: in the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
1. In the left pane, select **Workspace** > **Users**, and select your username (the entry with the house icon).
1. In the pane that appears, select the arrow next to your name, and select **Import**.

    ![The menu option to import the archive](../media/import-archive.png)

1. In the **Import Notebooks** dialog box, select the URL and paste in the following URL:

     `https://github.com/MicrosoftDocs/mslearn_databricks/blob/main/azure-ml/1.1.0/Labs.dbc`

1. Select **Import**.
1. Select the **azure-ml** folder that appears.

## Complete the following notebook

Open the **1. Serving Models with Microsoft Azure ML** notebook. Make sure you attach your cluster to the notebook before following the instructions and running the cells within.

Within the notebook, you will:

- Create or load an Azure ML Workspace
- Build an Azure Container Image for model deployment
- Deploy the model to "dev" using ACI
- Query the deployed model in "dev"
- Deploy the model to production using AKS
- Query the deployed model in production
- Update the production deployment
- Clean up the deployments

After you've completed the notebook, return to this screen, and continue to the next step.
