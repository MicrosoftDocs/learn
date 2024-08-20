This exercise walks you through the process of provisioning the Data Management landing zone into your own Azure subscription.

### Step 1 - Complete prerequisites

Register the `Microsoft. Purview`, `Microsoft.EventHub`, and `Microsoft. Storage` resource providers in your subscription.

:::image type="content" source="../media/Azure-register-resource-provider.png" alt-text="Screenshot of registering resource providers in the Azure portal." lightbox="../media/Azure-register-resource-provider.png":::

Follow the instructions [in this article](/azure/azure-resource-manager/management/resource-providers-and-types#azure-portal) to register resources in your Azure subscription.

### Step 2 - Initiate the workflow to complete the data management landing zone using the portal wizard UI

Use the following template to set up the data-management landing zone in your Azure subscription.

<a href="https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-management-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataManagementZone.json"> ![Deploy Data Management Landing Zone](../media/deploy-to-azure.svg) </a>

:::image type="content" source="../media/data-management-landing-zone-deployment-1.png" alt-text="Screenshot of the initial step in the template." lightbox="../media/data-management-landing-zone-deployment-1.png":::

Provide the following information in the template:

- **Subscription**: Select the subscription to which you want to deploy the Data Management Landing Zone. If you have access to multiple subscriptions, choose the correct one.

- **Location**: Select a location from the drop-down. If there are no organizational policies influencing the location, it's a good idea to pick a region that is physically close to you. Verify that the region you choose supports Enterprise Scale Analytics.

- **Environment**: We recommend you choose **Development**, though you can use the same process to deploy a Test or Production environment as well.

- **Data management zone prefix**: Enter a prefix that will be added to all the deployed resource groups and resources to make them unique within the subscription.

### Step 3 - Obtain the ObjectId of Microsoft Purview root collection admin ID

This step is required only if a user other than yourself has to be added as a collection admin in the Microsoft Purview instance. To add a user, navigate to Microsoft Entra ID in a new browser window and, in the list of users, select the relevant user to find the Object ID. Select the **Copy to Clipboard** icon.

:::image type="content" source="../media/user-object-id.png" alt-text="Screenshot of obtaining a user's ObjectId." lightbox="../media/user-object-id.png":::

### Step 4 - General Settings

:::image type="content" source="../media/data-management-landing-zone-purview-root-collection-id.png" alt-text="Screenshot of the General Settings step in the template." lightbox="../media/data-management-landing-zone-purview-root-collection-id.png":::

In this step, return to the browser window with the template and select the **General Settings** tab. Paste the root collection admin object ID from the previous step into the **Purview Root Collection Admin Object ID** field.

### Step 5 - Connectivity settings

Select the **Connectivity Settings** tab, then select whether you'd like to deploy this management into an existing enterprise scale landing zone.

:::image type="content" source="../media/data-management-landing-zone-deployment-connection-settings.png" alt-text="Screenshot of the Connectivity Settings tab." lightbox="../media/data-management-landing-zone-deployment-connection-settings.png":::

### Step 6 - Review and create

Select the **Review + create** tab, then select the **Review + create** button at the bottom of the screen. The deployment will validate and check for errors. When the validation passes, select **Create**. The deployment can take around 20 minutes to complete.

:::image type="content" source="../media/data-management-landing-zone-deployment-create.png" alt-text="Screenshot of the Review + Create tab." lightbox="../media/data-management-landing-zone-deployment-create.png":::

### Step 7 - Validation after deployment

You can use the details here to validate the deployment.

- **Resource group - XXXX-dev-automation**: This resource group is a placeholder for hosting any automation account.

    :::image type="content" source="../media/data-management-landing-zone-automation-validation.png" alt-text="Screenshot of the Automation resource group." lightbox="../media/data-management-landing-zone-automation-validation.png":::

- **Resource group - XXXX-dev-consumption**: Azure Synapse Analytics private link hubs are Azure resources, which act as connectors between your secured network and the Synapse Studio web experience.

    :::image type="content" source="../media/data-management-landing-zone-consumption-validation.png" alt-text="Screenshot of the Consumption resource group." lightbox="../media/data-management-landing-zone-consumption-validation.png":::

- **Resource group - XXXX-dev-container**: To allow the Data Platform Ops to deploy standard containers for use in data science projects, the Data Management Landing Zone hosts an Azure Container Registry.

    :::image type="content" source="../media/data-management-landing-zone-container-validation.png" alt-text="Screenshot of the Container Registry resource group." lightbox="../media/data-management-landing-zone-container-validation.png":::

- **Resource group - XXXX-dev-global-dns**: The Enterprise Scale Analytics and AI solution pattern makes use of Private Links, which rely on having a private DNS zone. You should see 46 private link resources within this resource group.

    :::image type="content" source="../media/data-management-landing-zone-dns-validation.png" alt-text="Screenshot of the Global DNS resource group." lightbox="../media/data-management-landing-zone-dns-validation.png":::

- **Resource group - XXXX-dev-governance**: The Purview instance and private endpoints for communication between Purview and other services within the same private network.

    :::image type="content" source="../media/data-management-landing-zone-governance-validation.png" alt-text="Screenshot of the Governance resource group." lightbox="../media/data-management-landing-zone-governance-validation.png":::

- **Resource group - XXXX-dev-network**: The Enterprise Scale Analytics and AI solution pattern makes use of Private Links, which rely on having a private DNS zone.

    :::image type="content" source="../media/data-management-landing-zone-network-validation.png" alt-text="Screenshot of the Network resource group." lightbox="../media/data-management-landing-zone-network-validation.png":::

- **Resource group - XXXX-dev-mgmt**: This resource group is a placeholder for management functions like centralized monitoring and logging.
