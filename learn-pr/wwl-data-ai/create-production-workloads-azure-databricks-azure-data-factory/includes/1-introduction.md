Imagine you're part of an analytics team that needs to build a new data pipeline that involves copying data from multiple sources into a data lake for processing. You use Azure Databricks to transform the data, and you want to ensure your processing occurs as soon as the data is ready. Processing the data from a notebook is just one step of the data pipeline. Your team conducted research on orchestration platforms and has decided to use Azure Data Factory, given its ability to connect to several services both on-premises and in the cloud, and to easily build data pipelines.

Your supervisor requested that you investigate the ability to execute Azure Databricks jobs from Azure Data Factory, passing in parameters used for data processing, and returning parameters used to continue the pipeline processing.

## Learning objectives 

In this module, you'll:

- Create an Azure Data Factory pipeline with a Databricks activity.
- Execute a Databricks notebook with a parameter.
- Retrieve and log a parameter passed back from the notebook.
- Monitor your Data Factory pipeline.

## Prerequisites

None

You can use Azure Data Factory to ingest data collected from different sources and coordinate processing jobs in Azure Databricks as part of your data pipeline.

## What is Azure Data Factory?

Azure Data Factory is a data ingestion and transformation service that allows you to load raw data from over 70 different on-premises or cloud sources. The ingested data can be cleaned, transformed, restructured, and loaded back into a data warehouse. After the data is in the data warehouse, it's ready to use for several analytical purposes.

Data Factory supports data workflow pipelines. These pipelines are a logical group of tasks and activities that allows end-to-end data-processing scenarios.

## Unit pre-requisites

**Microsoft Azure Account**: You will need a valid and active Azure account for the Azure labs. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/free/)

- If you are a Visual Studio Active Subscriber, you are entitled to Azure credits per month. You can refer to this [link](https://azure.microsoft.com/pricing/member-offers/msdn-benefits-details/) to find out more including how to activate and start using your monthly Azure credit.

- If you are not a Visual Studio Subscriber, you can sign up for the FREE [Visual Studio Dev Essentials](https://www.visualstudio.com/dev-essentials/) program to create Azure free account.

## Create the required resources

To complete this module, you will need to deploy an Azure Data Factory instance and an Azure Databricks workspace in your Azure subscription.

### Create an Azure Data Factory instance

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left menu, select **+ Create a resource**.
1. In the **Search the Marketplace** box, enter **data factory** and press Enter.
1. Select **Data Factory** from the search results, and then select **Create**.

   ![Screenshot of Azure portal with option to add new Azure Data Factory shown](../media/add-resource-data-factory.png)

1. In the **New data factory** pane, use the following settings:

    - **Name:** Enter a globally unique name, as indicated by a green check mark.
    - **Subscription:** Select the subscription you're using for this workshop.
    - **Resource Group:** Choose **Use existing**, and then select the resource group for this workshop.
    - **Version:** Select **V2**.
    - **Location:** Select a region.
    - **Enable Git:** Uncheck this option.

    ![Screenshot of the "New data factory" pane](../media/add-new-data-factory.png)

1. Select **Create** to create your data factory.

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

1. Select the **Cluster Mode**: **Single Node**.

1. Select the **Databricks RuntimeVersion**: **Runtime: 7.3 LTS (Scala 2.12, Spark 3.0.1)**.

1. Under **Autopilot Options**, leave the box **checked** and in the text box enter `45`.

1. Select the **Node Type**: **Standard_DS3_v2**.

1. Select **Create Cluster**.
