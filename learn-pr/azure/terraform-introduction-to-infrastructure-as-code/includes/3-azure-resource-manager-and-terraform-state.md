You've spent some time with your team learning the benefits of infrastructure as code and the different approaches that are available. Your company is growing at a rapid pace and your team knows it will be deploying a significant number of resources to Azure. As a team, you've decided that declarative infrastructure as code is the right approach to resource provisioning. The team doesn't want to maintain scripts that list every deployment step. Before beginning the process of building your first template, you need to understand how Azure Terraform and Azure Resource Manager works. Investigating the types of templates that are available to use with Azure will help you determine the next steps in your infrastructure-as-code strategy.

In this unit, you'll learn about the difference between Azure Resource Manager and Terraform state.

## Azure Resource Manager vs Terraform state

### Azure Resource Manager

Azure Resource Manager is the service that's used to deploy and manage resources in Azure with Bicep or ARM templates. You can use Resource Manager to create, update, and delete resources in your Azure subscription. It expects a declarative template that it translates that into a set of idempotent commands to create or update your resources.

### Terraform State

Terraform state is a json based representation of the resources you are managing with Terraform. Terraform is an agnostic tool that can support anything with an API end point, therefore it requires an agnostic method to manage the lifecycle of resources under management. The state file essentially maps the resource declaration in your template to the id of the resource in the target environment, in our case Azure.

## Comparison of Azure Resource Manager and Terraform State

| Item | Azure Resource Manager | Terraform State |
| --- | --- | --- |
| State file management | Not required, state is stored in Azure | State file must be stored and secured |
| Support for other cloud providers and APIs | Only works with Azure and now Entra ID | Works with any cloud or API that has a provider built for it |
| Lifecycle (create, update, delete) | Deploment stacks now allow managing the full life cycle | Terraform has always been able to manage the full lifecycle |
| Drift detection / plan | What If allows checking for updates | Terraform plan enables drift detection and planning |


