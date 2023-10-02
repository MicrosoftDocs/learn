With the requirements clear and planning completed, Contoso is almost ready to begin onboarding new customers. Before you start, you want a better understanding of how the process works.

In this unit, you'll take a more in-depth look at Azure delegated resource management. Then you'll learn how to configure an Azure Resource Manager template and how to deploy it.

## Azure delegated resource management

### Key components of Azure delegated resource management

Azure delegated resource management is the technology capability that gives Contoso access to customer resources from your own tenant, with Azure Lighthouse. Azure delegated resource management has three key components:

- The principal ID and the display name of the user, group, or service principal that is being granted the permissions. The principal ID is displayed as the Object ID in Azure Active Directory.
- The role definition ID of the Azure in-built role that contains the most appropriate level of permissions that you want to grant. Together, the principal ID, principal ID display name, and the role definition are known as the authorization for Azure Lighthouse.
- The scope of the authorization: a subscription, a resource group or multiple resource groups.

>[!TIP]
>You can also onboard multiple subscriptions owned by the same customer, by deploying your Azure Resource Manager template separately to each target subscription.

The scope is defined by choosing the correct Azure Resource Manager template for your target type and deploying that into the appropriate customer subscription.

## Azure Resource Manager templates

Azure Resource Manager templates are free to use and are available online via GitHub. Each template is a code block that contains the instructions that allow you to meet a specific scenario or need, and a parameter file.

When you visit the GitHub repository (https://github.com/Azure/Azure-Lighthouse-samples/), you'll find many templates, four of which you can use to onboard your customers.

| **Onboarding scenario**                                      | **Template to use**                                          |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Subscription                                                 | [delegated-resource-management](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/delegated-resource-management/subscription) |
| Resource group                                               | [rg-delegated-resource-management](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/delegated-resource-management/rg) |
| Multiple resource groups within a subscription               | [multipleRgDelegatedResourceManagement](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/delegated-resource-management/rg) |
| Subscription when using an offer published to Azure Marketplace | [marketplace-delegated-resource-management](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/marketplace-delegated-resource-management) |

Templates can be used to automate and streamline the onboarding process, however:

- If you have multiple subscriptions in a tenant, each one needs a separate onboarding deployment
- If you want to onboard multiple resource groups, each with different subscriptions, you'll also need separate onboarding deployments

## Configuring an Azure Resource Manager template

A template is divided into two parts: a code (template) file and a parameter file. The code files provided in the samples don't need any modification - just make sure you select the right one corresponding to your target scope of subscription, resource group, or multiple resource groups. You need to modify the parameter file.

Deploying Azure Lighthouse to your customers requires you to fill in the following information about your service offering in the Azure Resource Manager template parameters file:

- mspOfferName - A readable short name relevant to your services contract
- mspOfferDescription - A short description of the managed service offer
- managedByTenantId - Contoso's tenant ID such as df4602a3-920c-435f-98c4-49ff031b9ef6
- authorizations - The list of Contoso's requested principal IDs, principal ID display names, and role definition IDs.

This information is visible to the customer and Contoso inside Azure Lighthouse in the customer's Azure portal, after they've been successfully onboarded.

All of the template files are based on JSON. So, when editing templates, you need a text editing program like Notepad or Visual Studio Code, which also has a Resource Manager Tools extension to help you identify possible errors.

### Configuring the parameter file

Here's an example of what the file looks like:

```JSON
{
    "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "mspOfferName": {
            "value": "Contoso managed services"
        },
        "mspOfferDescription": {
            "value": "Subscription management by Contoso managed services"
        },
        "managedByTenantId": {
            "value": "df4602a3-920c-435f-98c4-49ff031b9ef6"
        },
        "authorizations": {
            "value": [
                { 
                    "principalId": "<insert the principal ID>", 
                    "roleDefinitionId": "acdd72a7-3385-48ef-bd42-f606fba81ae7",
                    "principalIdDisplayName": "Customer_Helpdesk" 
                }, 
                { 
                    "principalId": "<insert the principal ID>", 
                    "roleDefinitionId": "5e467623-bb1f-42f4-a55d-6e525e11384b",
                    "principalIdDisplayName": "Customer_Backup_Management"
                    
                },
                { 
                    "principalId": "<insert the principal ID>", 
                    "roleDefinitionId": "b24988ac-6180-42a0-ab88-20f7382dd24c",
                    "principalIdDisplayName": "Customer_Subscription_Management" 
                }
                    ]
                }                
        }
}
```

## Deploying your Azure Resource Manager template

As Contoso doesn't yet have access to their new customer's Azure environments, but they've established a relationship with them over the signing of the new services contracts, Contoso distributes the template files to the customers to deploy. One of the customer's users who has the Owner role for their Azure subscriptions can then deploy the template in their subscriptions.

The onboarding template files always require a subscription-level deployment, even if you're onboarding only one or more resource groups within a subscription. For subscription level deployments you need to use Cloud Shell, for example:

```azurecli
# Log in first with az login if you're not using Cloud Shell

# Deploy Azure Resource Manager template using template and parameter file locally
az deployment sub create --name <deploymentName> \
                         --location <AzureRegion> \
                         --template-file <pathToTemplateFile> \
                         --parameters <parameters/parameterFile> \
                         --verbose

# Deploy external Azure Resource Manager template, with local parameter file
az deployment sub create --name <deploymentName> \
                         --location <AzureRegion> \
                         --template-uri <templateUri> \
                         --parameters <parameterFile> \
                         --verbose
```

In the following exercise, you'll configure an Azure Resource Manager template and deploy it to three new customers.
