This exercise walks you through the process of provisioning the Data landing zone into your own Azure subscription.

### Step 1 - Complete Prerequisites

First, make sure you've completed the steps in this module's previous exercise and have deployed a  Data Management Zone.

### Step 2 - Initiate the workflow to complete the data management landing zone using the portal wizard UI

Use the following template to set up the data landing zone in your Azure subscription.

<a href="https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataLandingZone.json"> ![Deploy DLZ to Azure](../media/deploy-to-azure.svg) </a>

[![Screenshot of the initial step in the template.](../media/data-landing-zone-creation-1.png)](../media/data-landing-zone-creation-1.png)

Provide the following information in the template:

- **Subscription**: Select the subscription to which to deploy the Data Landing Zone.

- **Location**: Select a location from the drop-down. If there are no organizational policies influencing the location, it's a good idea to pick a region that is physically close to you. Verify that the region you choose supports Enterprise Scale Analytics.

- **Environment**: We recommend you choose **Development**.

- **Data Landing zone prefix**: Enter a prefix that will be added to all the deployed resource groups and resources to make them unique within the subscription.

### Step 3 - Obtain Microsoft Purview Self-hosted Integration Runtime Authentication Key

Use the [guidance in this article](/purview/manage-integration-runtimes) to find and copy your Microsoft Purview integration runtime keys.

[![Screenshot of the Microsoft Purview integration runtime authentication keys.](../media/integration-runtime-settings-auth-key.png)](../media/integration-runtime-settings-auth-key.png)

### Step 4 - General Settings

[![Screenshot of the template's General Settings tab.](../media/data-landing-zone-creation-2.png)](../media/data-landing-zone-creation-2.png)

Select the **General Settings** tab in the template and provide the following information:

- **Service Settings**: This step is required to set an administrator password for the Synapse workspaces, SQL Servers, and potentially Self-hosted integration runtimes hosted on the virtual machine scale set.

- **Data Governance Settings**: Select the Purview account from the drop-down to which you want to connect Synapse and Data Factory.

- **Self-hosted Integration Runtime Settings**: Specify whether you'd like to deploy Self-hosted Integration Runtimes into your Data Landing Zone.

- **Purview Self-hosted Integration Runtime Authentication Key**: Paste the authentication key you copied in step 3.

### Step 5 - Connectivity Settings

[![Screenshot of the template's Connectivity Settings tab (1 of 2).](../media/data-landing-zone-creation-3.png)](../media/data-landing-zone-creation-3.png)

[![Screenshot of the template's Connectivity Settings tab (2 of 2).](../media/data-landing-zone-creation-4.png)](../media/data-landing-zone-creation-4.png)

Select the **Connectivity Settings** tab in the template and provide the following information:

- **Virtual Network Configuration**: This is an optional step required only if the default Vnet configuration has to be altered. We don't recommend making any changes to these settings.

- **Data Management Zone Virtual Network Configuration**: Select your Data Management Zone's Vnet to peer it with your Data Landing Zone.

- **Shared Network Infrastructure Configuration**: Select **Azure Firewall** in the **Existing Firewall** drop-down, then select your subscription in the **Azure Firewall Subscription** drop-down. Select your **[XXXX]-dev-firewall** in the **Azure Firewall** drop-down.

- **Private DNS Zones**: Select the **No** radio button in the **DNS A-Records are deployed through Azure Policy** field and select the corresponding private DNS zones from the multiple drop-downs.

### Step 6 - Review and Create

[![Screenshot of the template's Review + create tab.](../media/data-landing-zone-deployment-create.png)](../media/data-landing-zone-deployment-create.png)

Select the **Review + create** tab, then select the **Review + create** button at the bottom of the screen. The deployment will validate and check for errors. When the validation passes, select **Create**. The deployment can take around 20 minutes to complete.

### Step 7 - Validation after deployment

You can use the details here to validate the deployment.

- **Resource group - XXXX-dev-network**: This resource group is a placeholder for hosting any automation accounts.

    [![Screenshot of the DLZ Network group.](../media/data-landing-zone-network-validation.png)](../media/data-landing-zone-network-validation.png)

- **Resource group - XXXX-dev-mgmt**: This resource group is a placeholder for hosting any management functions.

    [![Screenshot of the DLZ MGT group.](../media/data-landing-zone-mgmt-validation.png)](../media/data-landing-zone-mgmt-validation.png)

- **Resource group - XXXX-dev-logging**: This resource group is a placeholder for hosting data-product specific logging.

    [![Screenshot of the DLZ Logging group.](../media/data-landing-zone-logging-validation.png)](../media/data-landing-zone-logging-validation.png)

- **Resource group - XXXX-dev-runtimes**: This resource group is a placeholder for hosting data product specific CI/CD runtimes.

    [![Screenshot of the DLZ Runtimes group.](../media/data-landing-zone-runtimes-validation.png)](../media/data-landing-zone-runtimes-validation.png)

- **Resource group - XXXX-dev-storage**: This resource group is a placeholder for hosting data-product specific storage.

    [![Screenshot of the DLZ Storage group.](../media/data-landing-zone-storage-validation.png)](../media/data-landing-zone-storage-validation.png)

- **Resource group - XXXX-dev-external-storage**: This resource group is a placeholder for hosting data-product specific external storage.

    [![Screenshot of the DLZ External Storage group.](../media/data-landing-zone-external-storage-validation.png)](../media/data-landing-zone-external-storage-validation.png)

- **Resource group - XXXX-dev-metadata**: This resource group is a placeholder for hosting data-product specific metadata.

    [![Screenshot of the DLZ Metadata group.](../media/data-landing-zone-metadata-validation.png)](../media/data-landing-zone-metadata-validation.png)

- **Resource group - XXXX-dev-shared-integration**: This resource group is a placeholder for hosting centralized, shared integration services.

    [![Screenshot of the DLZ Shared Integration group.](../media/data-landing-zone-shared-integration-validation.png)](../media/data-landing-zone-shared-integration-validation.png)

- **Resource group - XXXX-dev-shared-product**: This resource group is a placeholder for hosting shared product services.

    [![Screenshot of the DLZ Shared Product group.](../media/data-landing-zone-shared-product-validation.png)](../media/data-landing-zone-shared-product-validation.png)

- **Resource group - XXXX-dev-di001**: This resource group is a placeholder for hosting data-product specific integration.

    [![Screenshot of the DLZ Data Integration group.](../media/data-landing-zone-data-integration-validation.png)](../media/data-landing-zone-data-integration-validation.png)

- **Resource group - XXXX-dev-dp001**: This resource group is a placeholder for hosting a specific data product.

    [![Screenshot of the DLZ Data Production group.](../media/data-landing-zone-data-product-validation.png)](../media/data-landing-zone-data-product-validation.png)
