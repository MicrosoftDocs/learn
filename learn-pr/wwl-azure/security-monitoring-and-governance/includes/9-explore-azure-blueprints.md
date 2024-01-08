Azure Blueprints enables cloud architects to define a repeatable set of Azure resources that implement and adhere to an organization's standards, patterns, and requirements.

Azure Blueprints helps development teams build and deploy new environments rapidly with a set of built-in components that speed up development and delivery.

Furthermore, it's done while staying within organizational compliance requirements.

:::image type="content" source="../media/azure-blueprint-icon-a3ae9a51.png" alt-text="Icon-representing Azure Blueprints icon":::


Azure Blueprints provides a declarative way to orchestrate deployment for various resource templates and artifacts, including:

 -  Role assignments
 -  Policy assignments
 -  Azure Resource Manager templates
 -  Resource groups

To implement Azure Blueprints, complete the following high-level steps:

1.  Create a blueprint.
2.  Assign the blueprint.
3.  Track the blueprint assignments.

With Azure Blueprints, the relationship between the blueprint definition (what *should be* deployed) and the blueprint assignment (what *is* deployed) is preserved.

The blueprints in Azure Blueprints are different from Azure Resource Manager templates.

When Azure Resource Manager templates deploy resources, they have no active relationship with the deployed resources. They exist in a local environment or source control.

By contrast, with Azure Blueprints, each deployment is tied to an Azure Blueprints package. It means that the relationship with resources will be maintained, even after deployment. This way, keeping relationships improves deployment tracking and auditing capabilities.

## Usage scenario

Whether government, industry, or organizational, Adhering to security and compliance requirements can be difficult and time-consuming.

To help you to trace your deployments and audit them for compliance, Azure Blueprints uses artifacts and tools that speed up your path to certification.

Azure Blueprints is also helpful in Azure DevOps scenarios. Mainly where blueprints are associated with specific build artifacts and release pipelines, and blueprints can be tracked rigorously.

You can learn more about Azure Blueprints at [Azure Blueprints](https://azure.microsoft.com/services/blueprints/).
