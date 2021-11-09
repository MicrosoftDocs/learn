[**Azure Blueprints**](https://azure.microsoft.com/services/blueprints) lets you define a repeatable set of governance tools and standard Azure resources that your organization requires. Azure Blueprints are used to scale governance practices throughout an organization. 

A blueprint is a package related to the implementation of Azure cloud services, security, and design. A blueprint can be reused to maintain consistency and compliance.

:::image type="content" source="../media/azure-blueprints.png" alt-text="Compose, manage, and scale.":::

With Azure Blueprints, the relationship between the blueprint definition (what should be deployed) and the blueprint assignment (what was deployed) is preserved. In other words, Azure creates a record that associates a resource with the blueprint that defines it. This connection helps you track and audit your deployments. 
Azure Blueprints orchestrates the deployment of various resource templates and other artifacts.

| **Resource**| **Hierarchy Options**| **Description** |
| - | - | - |
| **Resource Groups** | Subscription | Create a new resource group for use by other artifacts within the blueprint. These placeholder resource groups enable you to organize resources exactly the way you want them structured and provides a scope limiter for included policy and role assignment artifacts and templates. |
| **Azure Resource Manager Template** | Subscription, Resource group | Templates, including nested and linked templates, are used to compose complex environments. Example environments: a SharePoint farm, Azure Automation State Configuration, or a Log Analytics workspace. |
| **Policy Assignment** | Subscription, Resource group | Allows assignment of a policy or initiative to the subscription the blueprint is assigned to. The policy or initiative must be within the scope of the blueprint definition location. If the policy or initiative has parameters, these parameters are assigned at creation of the blueprint or during blueprint assignment. |
| **Role Assignment** | Subscription, Resource group | Add an existing user or group to a built-in role to make sure the right people always have the right access to your resources. Role assignments can be defined for the entire subscription or nested to a specific resource group included in the blueprint. |

### How are Azure Blueprints different from Azure Policy

A policy is a default allow and explicit deny system focused on resource properties during deployment and for already existing resources. It supports cloud governance by validating those resources within a subscription adhere to requirements and standards. 

A policy can be included as one of many artifacts in a blueprint definition. Including a policy in a blueprint enables the creation of the right pattern or design during assignment of the blueprint. The policy inclusion makes sure that only approved or expected changes can be made to the environment to protect ongoing compliance to the intent of the blueprint.
