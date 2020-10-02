The first step towards an Azure landing zone deployment is the implementation of a Cloud Adoption Framework (CAF) landing zone template. When following the *start small and expand* approach, you would start with the CAF Migration landing zone blueprint.

## Deploy the blueprint sample

Starting with an empty Azure subscription, you will deploy the blueprint sample using the following steps:

- Create a new blueprint from the sample.
- Mark your copy of the sample as **Published**.
- Assign your copy of the blueprint to a current subscription.

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free) before you begin.

## Create a new blueprint from sample

First, implement the blueprint sample by creating a new blueprint in your environment using the sample as a starter.

1. Select **All services** in the left pane. Search for and select **Blueprints**.

1. From the **Getting started** page on the left, select the **Create** button under **Create a blueprint**.

1. Find the **CAF Migration landing zone** blueprint sample under **Other Samples** and select **Use this sample**.

1. Enter the *Basics* of the blueprint sample:
   - **Blueprint name** provide a name for your copy of the CAF Migration landing zone blueprint sample.
   - **Definition location** use the ellipsis and select the management group to which you'll save your copy of the sample.

1. Select the **Artifacts** tab at the top of the page or **Next: Artifacts** at the bottom of the page.

1. Review the list of artifacts that make up the blueprint sample. Many of the artifacts have parameters that we'll define later. Select **Save Draft** when you've finished reviewing the blueprint sample.

## Publish the sample copy

Your copy of the blueprint sample has now been created in your environment. It's created in **Draft** mode and must be **Published** before it can be assigned and deployed. The copy of the blueprint sample can be customized to your environment and needs, but that modification may move it away from the CAF migrate landing zone guidance.

1. Select **All services** in the left pane. Search for and select **Blueprints**.

1. Select the **Blueprint definitions** page on the left. Use the filters to find your copy of the blueprint sample and then select it.

1. Select **Publish blueprint** at the top of the page. In the new page on the right, provide a **Version** for your copy of the blueprint sample. This property is useful for if you make a modification later. Provide **Change notes** such as "first version published from the CAF Migration landing zone blueprint sample." Then select **Publish** at the bottom of the page.

## Assign the sample copy

Once the copy of the blueprint sample has been successfully published, it can be assigned to a subscription within the management group it was saved to. This step is where parameters are provided to make each deployment of the copy of the blueprint sample unique.

1. Select **All services** in the left pane. Search for and select **Blueprints**.

1. Select the **Blueprint definitions** page on the left. Use the filters to find your copy of the blueprint sample and then select it.

1. Select **Assign blueprint** at the top of the blueprint definition page.

1. Provide the parameter values for the blueprint assignment:
   - Basics
     - **Subscriptions:** Select one or more of the subscriptions that are in the management group you saved your copy of the blueprint sample to. If you select more than one subscription, an assignment will be created for each using the parameters entered.
     - **Assignment name:** The name is pre-populated for you based on the name of the blueprint. Change as needed or leave as is.
     - **Location:** Select a region in which to create the managed identity.
     - Azure Blueprint uses this managed identity to deploy all artifacts in the assigned blueprint.
     - **Blueprint definition version:** Pick a **Published** version of your copy of the blueprint sample.
   - Lock assignment
     - Select the blueprint lock setting for your environment.
   - Managed identity
     - Choose either the default **system assigned** managed identity option or the **user assigned** identity option.
   - Blueprint parameters
     - The parameters defined in this section are used by many of the artifacts in the blueprint definition to provide consistency.

       - **Organization:** Enter your organization's name; for example, Contoso or Fabrikam. It must be unique.
       - **AzureRegion:** Select one Azure region for deployment.

   - Artifact parameters

     The parameters defined in this section apply to the artifact under which it's defined. These parameters are dynamic parameters since they're defined during the assignment of the blueprint.

1. Once all parameters have been entered, select **Assign** at the bottom of the page. The blueprint assignment is created and artifact deployment begins. Deployment takes roughly five minutes. To check on the status of deployment, open the blueprint assignment.

> [!WARNING]
> The Azure Blueprints service and the built-in blueprint samples are **free of cost**. Azure resources are [priced by product](https://azure.microsoft.com/pricing?azure-portal=true). Use the [pricing calculator](https://azure.microsoft.com/pricing/calculator?azure-portal=true) to estimate the cost of running resources deployed by this blueprint sample.

## Artifact parameters table

The following table provides a list of the blueprint artifact parameters:

|Artifact name|Artifact type|Parameter name|Description|
|-|-|-|-|
| Deploy VNet landing zone | Resource Manager template | `IPAddress_space` | **Locked** - Provide the first two octets example, 10.0 |
| Deploy Key Vault | Resource Manager template | `KV-AccessPolicy` | **Locked** - Group or user object ID to grant permissions to in Key Vault |
| Deploy Log Analytics | Resource Manager template | `LogAnalytics_DataRetention` | **Locked** - The umber of days that data will be retained in Log Analytics |
| Deploy Log Analytics | Resource Manager template | `LogAnalytics_Location` | **Locked** - The region used when establishing the workspace |
| Deploy Azure Migrate | Resource Manager template | `Azure_Migrate_Location`| **Locked** - Select the region to deploy Azure Migrate |
