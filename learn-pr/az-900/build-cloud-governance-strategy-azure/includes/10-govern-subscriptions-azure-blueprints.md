So far, you've explored a number of Azure features that can help you implement your governance decisions, monitor the compliance of your cloud resources, and control access and protect critical resource from accidental deletion.

What happens when your cloud environment starts to grow beyond just one subscription? How can you scale the configuration of these features, knowing they need to be enforced for resources in new subscriptions?

Instead of having to configure features like Azure Policy for each new subscription, [Azure Blueprints](https://azure.microsoft.com/services/blueprints?azure-portal=true) enables you to define a repeatable set of governance tools and standard Azure resources that your organization requires. This enables development teams to rapidly build and deploy new environments with the knowledge that they're building within organizational compliance with a set of built-in components that speed up the development and deployment phases.

Azure Blueprints orchestrates the deployment of various resource templates and other artifacts, such as:

* Role assignments
* Policy assignments
* Azure Resource Manager templates
* Resource groups

## Blueprint process

Implementing a blueprint in Azure Blueprints involves these three steps:

1. Create an Azure Blueprint.
1. Assign the blueprint.
1. Track the blueprint assignments.

<div style="background: yellow;">
TODO: Could we make a diagram similar to the Azure Policy one?

(Tom): Maybe. I deleted the other one because it was only words and can be a loc burden. But yes, images add flavor. Let's discuss.
</div>

<div style="background: yellow;">
TODO: I'm not sure what the following paragraph is telling me.
</div>

With Azure Blueprints, the relationship between the blueprint definition (what should be deployed) and the blueprint assignment (what was actually deployed) is preserved. This connection supports improved deployment tracking and auditing.

Blueprints are also versioned, so you can track and comment on changes to your blueprint.

## How do blueprints compare to ARM templates?

If you're familiar with Azure Resource Manager (ARM) templates, you know that they define all the Azure resources in a deployment. In a single operation, you can use an ARM template to deploy multiple Azure resources.

<div style="background: yellow;">
TODO: Again, not sure what the following paragraph is telling me. I know ARM templates; just unclear what we mean by "active relationship" and "actioned" or how this relates to auditing and tracking capabilities. We also don't define "package".
</div>

Azure Blueprints are different from ARM templates. When an ARM template deploys resources, they have no active relationship with the deployed resources once they have been actioned (the templates exist in a local environment or in source control). By contrast, with Azure Blueprint, each deployment is tied to an Azure Blueprint package. This means that the relationship with resources will be maintained, even after deployment. Maintaining relationships, in this way, improves auditing and tracking capabilities.

## What are blueprint artifacts?

Each component in the blueprint definition is known as an _artifact_. Artifacts can either have no parameters (for example, the **Deploy threat detection on SQL servers** policy, which requires no further configuration), or they can contain one or more parameters that you can configure.

<div style="background: yellow;">
TODO: What are we showing here? We're talking about threat detection and now we show something about Allowed locations.

The following image TODO.
</div>

:::image type="content" source="../media/BP-allowedlocations.png" alt-text="Screenshot showing allowed locations parameters in blueprint creation.":::

A parameter is a configuration setting that can be defined when the blueprint definition is created or when the blueprint definition is assigned to a scope. In this way, you can maintain one standard blueprint, but have the flexibility to specify the relevant configuration parameters at each scope where the definition is assigned.

## How will Tailwind Traders use Azure Blueprints for ISO 27001 compliance?

[ISO 27001](https://www.iso.org/isoiec-27001-information-security.html?azure-portal=true) is a standard that applies to the security of Information Technology (IT) systems, published by the International Organization for Standardization. As part of its quality process, Tailwind Traders wants to certify that it complies with this standard. Azure Blueprints has several built-in blueprint definitions that relate to ISO 27001.

As an IT administrator, you decide to investigate the **ISO 27001: Shared Services Blueprint** definition. Here an outline of your plan:

1. Define a management group that's named **PROD-MG**.

    Recall that a management group manages access, policies, and compliance across multiple Azure subscriptions. Every new Azure subscription is added to this management group when the subscription is created.
1. Create a blueprint definition that's based on the **ISO 27001: Shared Services Blueprint** template and then publish the blueprint.
1. Assign the blueprint to your **PROD-MG** management group.

The following image shows artifacts that are created when you run an ISO 27001 blueprint from a template:

:::image type="content" source="../media/iso27001shared-blueprint.png" alt-text="Screenshot showing artifacts listed when creating an ISO 27001 blueprint from template.":::

You see that the blueprint template contains policy assignments, ARM templates, and resource groups. The blueprint deploys these artifacts to any existing subscriptions within the **PROD-MG** management group. The blueprint also deploys these artifacts to any new subscriptions as they are created and added to the management group.
