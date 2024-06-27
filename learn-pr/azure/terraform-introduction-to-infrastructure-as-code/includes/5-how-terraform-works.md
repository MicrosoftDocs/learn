You've developed an understanding of the Terraform HCL language and the benefits that it provides for template authoring. Before you begin the process of writing Terraform modules to provision your resources, you want to learn more about how Terraform works.

In this unit, you'll learn about how Terraform works with providers and state files.

## Terraform CLI

What is Terraform? Fundamentally, Terraform is a CLI tool. It is free to use under the BSD license and can be downloaded [here](https://developer.hashicorp.com/terraform/install). The Terraform CLI is the only tool you need to deploy with Terraform.

You may have heard of Terraform Enterprise or Terraform Cloud. These are separate products to the Terraform CLI that provide features, such as state management and private module registry to simplify Terraform adoption. They embed the Terraform CLI, but still use the same version of the Terraform CLI that everyone else uses to deploy resources.

## Terraform providers

In the preceding unit, you learned that HCL is a domain-specific language, which means that it's designed for a specific scenario or _domain_. HCL is built to make it easy to deploy and configure any resources.

How does Terraform know about the specifics of Azure though? And how about Azure DevOps, GitHub, etc. The Terraform CLI tool doesn't know anything about Azure, it only knows how to manage state and plan deployments. Terraform providers are responsible for bridging the gap between the Terraform CLI and the target API, in our case Azure. Terraform has a concept of plugins and providers are a plugin. Providers are loaded into Terraform during the init phase based on the requirements in your HCL code.

Microsoft curates a number of providers in collaboration with HashiCorp and the community. These include:

* [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm): This provider is the most user friendly way to deploy resources into Azure. This provider may take time to support new Azure features.
* [azapi](https://registry.terraform.io/providers/Azure/azapi): This provider enable deployment of any Azure resource, including those in preview. It is always up to date with the latest Azure features.
* [azuread](https://registry.terraform.io/providers/hashicorp/azuread): This provider is used to managed Entra ID. It can manage many features, including user, groups and service principals.
* [azuredevops](https://registry.terraform.io/providers/microsoft/azuredevops): This provider is used to manage all aspects of Azure DevOps, including repos, pipelines and projects.
* [github](https://registry.terraform.io/providers/integrations/github): This provider is used to manage all aspects of GitHub, including organizations, repositories and actions.

When you deploy a resource or series of resources to Azure, you submit the Bicep template to Resource Manager, which still requires JSON templates. The tooling that's built into Bicep converts your Bicep template into a JSON template. This process is known as _transpilation_, which essentially treats the ARM template as an intermediate language. The conversion happens automatically when you submit your deployment, or you can do it manually.

:::image type="content" source="../../includes/media/plugin.png" alt-text="Diagram that shows the Terraform CLI plugin architecture." border="false" :::

## Terraform Workflow

When using the Terraform CLI, there a 4 fundamental steps in the workflow:

1. Write: Write the HCL code to define your desired state.
1. Init: Pull down providers and modules. Connect to remote state.
1. Plan: Compare desired state to actual state and generate a plan to bring actual into line with desired state.
1. Apply: Implement the plan and bring the target environment in line via API calls.

:::image type="content" source="../../includes/media/workflow.png" alt-text="Diagram that shows the Terraform CLI workflow." border="false" :::

## Terraform LifeCycle

Terraform is designed and should be used to manage the life cycle of your resources. By leveraging its state file, Terraform can manage your resource through these stages:

1. Create: The resource is in desired state, but does not exist in actual state and is created in Azure.
1. Update: The desired state of the resource attributes do not match their actual state and the resource is updated to bring in line with desired state.
1. Destroy: The resource no longer exists in desired state and is deleted from Azure.

:::image type="content" source="../../includes/media/lifecycle.png" alt-text="Diagram that shows the Terraform resourc lifecycle." border="false" :::

The update step can happen many times over the lifetime of a resource as the requirements alter over time. For example imagine you are managing Azure Firewall rules with Terraform, you may have to update these on a regular cadence to add new rules, adjust existing rules and remove rules.

## Terraform State

Terraform state is required to support the Terraform lifecycle. Terraform has no insight into Azure or any of the other clouds or services it might manage. As such it needs an agnostic way to know what it is managing. The state file is that mechanism.

By mapping the HCL configuration to a resource id in Azure, Terraform is able to know that it is managing a resource. If that resource is then removed from the HCL, Terraform knows it must plan to destroy that resource. Without a state file, Terraform would have no knowledge of that resource.

State files can contain sensitive data, they need to be stored securely. We recommend using Terraform Cloud / Enterprise or Azure Blob Storage to manage your state files.
