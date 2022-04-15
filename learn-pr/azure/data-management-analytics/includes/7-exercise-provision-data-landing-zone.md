##

This module walks you through the process of provisioning the "Data landing zone" into your own Azure subscription

### Step 1 - Complete Pre-requisites

A Data Management Zone deployed. Refer to Exercise 1 for details.

### Step 2 - Initiate the workflow to complete the data management landing zone using the portal wizard UI

<a href="https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fdata-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.dataLandingZone.json"> ![Deploy DLZ to Azure](../media/deploy-to-azure.svg) </a>

![DLZ creation 1](../media/data-landing-zone-creation-1.png)

In this Step 2, provide the following information

- Subscription: Select the subscription to deploy the Data Landing Zone to.

- Location: Select from the dropdown. If there are no organizational policies influencing the location, it's a good idea to pick a region that is physically close to you. Verify that this region is supported for Enterprise Scale Analytics. A list of supported region 's available here

- Environment: We recommend you choose Development

- Data Landing zone prefix: A prefix added to all the deployed resource groups and resources to make them unique within the subscription. The length can be a max of 10 alphanumeric characters.

### Step 3 - Obtain Azure Purview Self-hosted Integration Runtime Authentication Key

![INtegration RT Auth](../media/integration-runtime-settings-auth-key.png)

### Step 4 - select next for General Settings

![DLZ Creation 2](../media/data-landing-zone-creation-2.png)

In this step 4, provide the following information

- Service Settings: This step is required to set an administrator password for the Synapse workspaces, SQL Servers and potentially Self-hosted integration runtimes hosted on virtual machine scale set.

- Data Governance Settings: Select the Purview account from the dropdown to which you want to connect Synapse and Data Factory.

- Self-hosted Integration Runtime Settings: Specify whether you would like to deploy Self-hosted Integration Runtimes into your Data Landing Zone.

- Purview Self-hosted Integration Runtime Authentication Key: Paste the previously captured SHIR authentication key. If you don’t have the key,  follow the steps on Create Purview SHIR to generate and copy it.

### Step 5 - select next for Connectivity Settings

![DLZ Creation 3](../media/data-landing-zone-creation-3.png)

![DLZ Creation 4](../media/data-landing-zone-creation-4.png)

In this Step 5, provide the following information

- Virtual Network Configuration: This one is an optional step required only if the default VNET configuration has to be altered. We don’t recommend making any changes to these settings.

- Data Management Zone Virtual Network Configuration: Select the VNET of your Data Management Zone to peer it with your Data Landing Zone.

- Shared Network Infrastructure Configuration: In, “Existing Firewall” select “Azure Firewall”. Then, select the Azure Firewall Subscription, and finally under “Azure Firewall” select the [XXXX]-dev-firewall.

- Private DNS Zones: On the “DNS A-Records are deployed through Azure Policy” radio button, choose “No” and select from the multiple dropdowns the corresponding private DNS zones.

### Step 6a - select "Review + Create" for final review and create

![DLZ Deployment Create](../media/data-landing-zone-deployment-create.png)

This will trigger the deployment validation to check for any errors.

### Step 6b - click " Create"

This will trigger the deployment. The deployment will take around 20 minutes to complete.

### Step 7 - Validation after deployment

#### You can use the details here to validate the deployment.

##### Resource Group Name - XXXX-dev-network

This resource group is a placeholder for hosting any automation account

![DLZ Network Validation](../media/data-landing-zone-network-validation.png)

##### Resource Group Name - XXXX-dev-mgmt

This resource group is a placeholder for hosting any management function

![DLZ MGT Validation](../media/data-landing-zone-mgmt-validation.png)

##### Resource Group Name - XXXX-dev-logging

This resource group is a placeholder for hosting data product specific logging

![DLZ Logging Validation](../media/data-landing-zone-logging-validation.png)

##### Resource Group Name - XXXX-dev-runtimes

This resource group is a placeholder for hosting data product specific CI/CD runtimes

![DLZ Runtimes Validation](../media/data-landing-zone-runtimes-validation.png)

##### Resource Group Name - XXXX-dev-storage

This resource group is a placeholder for hosting data product specific storage

![DLZ Storage Validation](../media/data-landing-zone-storage-validation.png)

##### Resource Group Name - XXXX-dev-external-storage

This resource group is a placeholder for hosting data product specific external storage

![DLZ External Storage Validation](../media/data-landing-zone-external-storage-validation.png)

##### Resource Group Name - XXXX-dev-metadata

This resource group is a placeholder for hosting data product specific metadata

![DLZ Metadata Validation](../media/data-landing-zone-metadata-validation.png)

##### Resource Group Name - XXXX-dev-shared-integration

This resource group is a placeholder for hosting centralized shared integration services

![DLZ Shared Integration Validation](../media/data-landing-zone-shared-integration-validation.png)

##### Resource Group Name - XXXX-dev-shared-product

This resource group is a placeholder for hosting shared product services

![DLZ Shared Product Validation](../media/data-landing-zone-shared-product-validation.png)

##### Resource Group Name - XXXX-dev-di001

This resource group is a placeholder for hosting data product specific integration

![DLZ Data INtegration Validation](../media/data-landing-zone-data-integration-validation.png)

##### Resource Group Name - XXXX-dev-dp001

This resource group is a placeholder for hosting a specific data product

![DLZ Data Production Validation](../media/data-landing-zone-data-product-validation.png)

### Other references

<a href="/azure/cloud-adoption-framework/scenarios/data-management">Data Management and Analytics</a>
