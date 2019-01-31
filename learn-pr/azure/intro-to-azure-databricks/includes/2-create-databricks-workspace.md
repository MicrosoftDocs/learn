The first step to using Azure Databricks is to create and deploy a Databricks workspace. You can do this using your Azure portal.

## Deploy an Azure Databricks workspace

1. Click the following link to open the Azure Resource Manager template in the Azure portal. [Deploy Databricks from the Azure Resource Manager Template](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F101-databricks-workspace%2Fazuredeploy.json)

2. Provide the required values to create your Azure Databricks workspace:

   - *Subscription*: Choose the Azure Subscription in which to deploy the workspace.
   - *Resource Group*: Leave at Create new and provide a name for the new resource group.
   - *Location*: Select a location near you for deployment. For the list of regions supported by Azure Databricks, see [Azure services available by region](https://azure.microsoft.com/regions/services/).
   - *Workspace Name*: Provide a name for your workspace.
   - *Pricing Tier*: Ensure `premium` is selected.

3. Accept the terms and conditions.
4. Select **Purchase**.
5. The workspace creation takes a few minutes. During workspace creation, the portal displays the **Submitting deployment for Azure Databricks tile** on the right side. You may need to scroll right on your dashboard to see the tile. There's also a progress bar displayed near the top of the screen. You can watch either area for progress.