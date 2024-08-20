This exercise walks you through the process of provisioning a data product within a data landing zone in your own Azure subscription.

## Step 1 - Complete Prerequisites

Ensure you've completed the previous exercises in this module and deployed a data-management landing zone and a data landing zone.

## Step 2 - Initiate the workflow to complete the data management landing zone using the portal wizard UI

Use the following template to set up your data product.

<a href="https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-product-batch%2Fmain%2Fdocs%2Freference%2Fportal.dataProduct.json"> ![Deploy Data Product Zone to Azure](../media/deploy-to-azure.svg) </a>

:::image type="content" source="../media/data-product-landing-zone-deployment.png" alt-text="Screenshot of the initial step in the template." lightbox="../media/data-product-landing-zone-deployment.png":::

Provide the following information in the template:

- **Subscription**: Select the subscription to which to deploy the data product.

- **Resource Group**: Type *dev-dp001* in the drop-down and select the resource group that has the DLZ prefix you created earlier and the *-dev-dp001* suffix.

- **Location**: Select a location from the drop-down. If there are no organizational policies influencing the location, it's a good idea to pick a region that is physically close to you. Verify that the region you choose supports Enterprise Scale Analytics.

- **Environment**: We recommend you choose Development.

- **Data Product Name**: Enter a prefix that will be added to all the deployed data-product resources to make them unique within the subscription.

## Step 3 - General settings

:::image type="content" source="../media/data-product-landing-zone-general-settings.png" alt-text="Screenshot of the template's General Settings tab." lightbox="../media/data-product-landing-zone-general-settings.png":::

Select the **General Settings** tab in the template and provide the following information:

- **Create Data Processing Service**: Select **Data Factory** from the drop-down menu.

- **Connect to Purview Account**: Select the Microsoft Purview instance you created when deploying the data-management landing zone from the drop-down.

- **SQL Flavor**: Select **SQL Server** from the drop-down menu.

- **Password**: Enter a strong password for your Azure SQL Server account and confirm it.

- **Enable Azure Cosmos DB**: Leave this option unchecked.

- **Enable role assignments**: This selection is optional, but you should check this option to add required permissions.

## Step 4 - Connectivity settings

:::image type="content" source="../media/data-product-landing-zone-connectivity-settings.png" alt-text="Screenshot of the template's Connectivity Settings tab." lightbox="../media/data-product-landing-zone-connectivity-settings.png":::

Select the **Connectivity Settings** tab in the template and provide the following information:

- **Virtual Network**: Select your data landing zone's virtual network.

- **Subnet**: Select the **DataIntegration** Subnet. (Follow the note at the beginning of the Virtual Network section.)

- **DNS A-Records are deployed through Azure Policy**: Select **No**, then select your subscription and all the other requested DNS Zones.

## Step 5 - Review and create

:::image type="content" source="../media/data-product-deployment-create.png" alt-text="Screenshot of the template's Review + create tab." lightbox="../media/data-product-deployment-create.png":::

Select the **Review + create** tab, then select the **Review + create** button at the bottom of the screen. The deployment will validate and check for errors. When the validation passes, select **Create**.

## Step 6 - Validation after deployment

You can use the details here to validate the deployment.

- **Resource group - XXXX-dev-dp001**: You should have the resource group and resources similar to the following image.

:::image type="content" source="../media/dev-data-product-001-validation.png" alt-text="Screenshot of the xxxx-dev-dp001 resource group and resources." lightbox="../media/dev-data-product-001-validation.png":::
