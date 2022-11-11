[Azure Blueprints](https://azure.microsoft.com/services/blueprints) lets you define a repeatable set of governance tools and standard Azure resources that your organization requires.

A blueprint is a package related to the implementation of Azure cloud services, security, and design. A blueprint can be reused to maintain consistency and compliance.

### Things to know about Azure Blueprints

Let's take a look at some of the features of Azure Blueprints:

- Azure Blueprints can be used to scale governance practices throughout an organization. 

   :::image type="content" source="../media/azure-blueprints.png" alt-text="Diagram that shows how Azure Blueprints scales governance practices throughout an organization." border="false":::

- Azure Blueprints orchestrates the deployment of various resource templates and other artifacts. 

- With Azure Blueprints, the relationship between the blueprint definition (what should be deployed) and the blueprint assignment (what was deployed) is preserved. 

- Azure creates a record that associates a resource with the blueprint that defines it. This connection helps you track and audit your deployments. 

### Things to consider when using Azure Blueprints

As you plan the governance strategy for Tailwind Traders, consider how you can use Azure Blueprints to scale practices for the organization:

| Resource | Implementation | Description |
| --- | --- | --- |
| **Resource groups** | Subscription | Create a new resource group that can be used by other artifacts within the blueprint. Placeholder resource groups enable you to organize resources exactly the way you want them structured. They provide a scope limiter for included policy and role assignment artifacts and templates. |
| **Azure Resource Manager (ARM) Templates** | Subscription, Resource group | Use ARM templates, including nested and linked templates, to compose complex environments. Templates work great for environments like a SharePoint farm, Azure Automation State Configuration, or a Log Analytics workspace. |
| **Policy assignment** | Subscription, Resource group | Assign a policy or initiative to the subscription that's assigned to a blueprint. The policy or initiative must be within the scope of the blueprint definition location. If the policy or initiative has parameters, these parameters are assigned at creation of the blueprint or during blueprint assignment. |
| **Role assignment** | Subscription, Resource group | Add an existing user or group to a built-in role to make sure the correct users always have the correct access to your resources. Role assignments can be defined for the entire subscription, or nested to a specific resource group included in the blueprint. |

## Integration of Azure Blueprints with Azure Policy

Azure Policy is a _default allow_ and _explicit deny_ system focused on resource properties for deployment and for already existing resources. Azure Policy supports cloud governance by validating that resources within a subscription adhere to requirements and standards.
   
You can include an Azure policy as an artifact in a blueprint definition. A policy in a blueprint enables the creation of the correct pattern or design during assignment of the blueprint. You can ensure that only approved or expected changes can be made to the environment, and protect ongoing compliance according to the intent of the blueprint.