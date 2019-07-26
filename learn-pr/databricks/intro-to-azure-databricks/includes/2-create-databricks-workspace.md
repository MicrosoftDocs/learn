The first step to using Azure Databricks is to create and deploy a Databricks workspace. You can do this in the Azure portal.

## Deploy an Azure Databricks workspace

1. Open the Azure Portal.
1. Click **Create a Resource** in the top left
1. Search for "Databricks"
1. Select *Azure Databricks*
1. On the Azure Databricks page select *Create*

1. Provide the required values to create your Azure Databricks workspace:

    - **Workspace Name**: Provide a name for your workspace.
   - **Subscription**: Choose the Azure subscription in which to deploy the workspace.
   - **Resource Group**: Use **Create new** and provide a name for the new resource group.
   - **Location**: Select a location near you for deployment. For the list of regions that are supported by Azure Databricks, see [Azure services available by region](https://azure.microsoft.com/regions/services/).  
   - **Pricing Tier**: **Trial (Premium - 14 days Free DBUs)**. If you've already used your trial benefit, that option will be unavailable. In that case you can select **Premium** but you will be charged for your useage.

1. Accept the terms and conditions.
1. Select **Create**.

The workspace creation takes a few minutes. During workspace creation, the **Submitting deployment for Azure Databricks** tile appears on the right side of the portal. You might need to scroll right on your dashboard to see the tile. There's also a progress bar displayed near the top of the screen. You can watch either area for progress.