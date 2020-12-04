In this unit, we look at Terraform configuration and scripting.

## Hashicorp Configuration Language (HCL)

Terraform uses its own configuration language, similar to YAML, designed to allow descriptions of infrastructure.
You create configuration files using HCL (HashiCorp Configuration Language) syntax.
HCL is declarative, describing an intended goal rather than the steps to reach that goal.
The HCL syntax allows you to specify the cloud provider - such as Azure - and the elements that make up your cloud infrastructure.

![Hashicorp Configuration Language.](../media/3-content.png)

> [!IMPORTANT]
> More information on the HCL language syntax is provided at the end of the Module in the Summary unit

### Modules

A module is a set of configuration files in a single directory. Even a simple configuration consisting of a single directory with one or more.tf files is a module.

- Organize configuration
- Encapsulate configuration
- Reuse configuration
- Provide consistency and ensure good practices

![Module structure for Terraform.](../media/3-modules.png)

### State

Terraform state is used to reconcile deployed resources with Terraform configurations. State allows Terraform to know what Azure resources to add, update, or delete. By default, Terraform state is stored locally when you run the terraform apply command. This configuration isn't ideal for the following reasons:

- Local state doesn't work well in a team or collaborative environment.
- Terraform state can include sensitive information.
- Storing state locally increases the chance of inadvertent deletion.

Terraform supports the persisting of state in remote storage. For More information on managing remote state, see the Summary unit.

### Configuration Files

Configuration files describe the components needed to run applications.

- main.tf (Required): Main structure to deploy the complete infrastructure directly or through calls to modules
- output.tf: Identify each return value of a Terraform module
- variables.tf: Define variables required (or not) in main.tf, we need to define the var type and it allows to you assign a default value.

![Config structure for Terraform.](../media/3-config.png)

### Providers

A Terraform configuration file starts off with the specification of the provider. When using Azure, you'll specify the Azure provider (azurerm) in the provider block
- Azure, Kubernetes, Docker, VMware, and so on
- Resources – the things you can create
- Data Sources – the things you can reference

### Main.tf

![Main.tf structure.](../media/3-main.png)

- Provider: API authentication & interaction
- Terraform: Terraform version
- Data: Get data from already existing services
- Locals: generates new variables using functions and expressions
- Resource: Describes resources & dependencies
- Module: Reusability & complexity abstraction

### Best Practices

- Start writing your configuration with modules in mind
- Use local modules to organize and encapsulate your code
- Use the public Terraform Registry to find useful modules
- Publish and share modules with your team

## Workflow

![Terraform Worflow.](../media/3-workflow.png)

When running Terraform in automation, the focus is usually on the core plan/apply cycle.

- Init: Initialize a working directory with Terraform configuration files.
  - The terraform init command looks through all of the *.tf files in the current working directory and automatically downloads any of the providers required for them. In this example, it will download Azure provider as we're going to deploy Azure resource.
- Validate: Validates configuration files in a directory without checking remotely
- Plan: Produce a plan for changing resources to match the current configuration.
  - The terraform plan command is used to create an execution plan. Terraform determines what actions are necessary to achieve the wanted state specified in the configuration files.
- Apply: Apply the changes described by the plan.
- Destroy: Remove the TF manage infrastructure

## Next steps

In the next unit, we'll use Terraform to provision your environment.
