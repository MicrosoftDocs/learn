In this unit, we look at Terraform configuration and scripting.

## Why Terraform?

As an infrastructure manager you need a tool for provisioning and managing Azure infrastructure. You would also like to use "infrastructure as code" in configuration files that describe the topology of your Azure resources.
Terraform is great at deploying infrastructure across cloud providers. It enables developers to use consistent tooling to manage each infrastructure definition.

### Automate infrastructure management

Terraform's template-based configuration files enable you to define, provision, and configure Azure resources in a repeatable and predictable manner.
This automation has several benefits:

- Lowers the potential for human errors while deploying and managing infrastructure.
- Deploys the same template multiple times to create identical development, test, and production environments.
- Reduces the cost of development and test environments by creating them on-demand.

### Understand infrastructure changes before being applied

As a resource topology becomes complex, understanding the meaning and effect of infrastructure changes can be difficult.

Terraform enables users to validate and preview infrastructure changes before applying them.

- Team members can collaborate more effectively by quickly understanding proposed changes and their effect.
- Unintended changes can be caught early in the development process

## Terraform Configuration

Configuration files generate an execution plan and what it will do to reach the wanted state. Terraform can then build the described infrastructure.
As the configuration changes, Terraform can determine what changed and create incremental execution plans.

Terraform configuration files use their own configuration language, similar to YAML, designed to allow descriptions of infrastructure.
You create configuration files using HCL (HashiCorp Configuration Language) syntax.
HCL is declarative, describing an intended goal rather than the steps to reach that goal.
The HCL syntax allows you to specify the cloud provider - such as Azure - and the elements that make up your cloud infrastructure.

Configuration files are stored in plain text files with a ".tf" file extension.

- main.tf (Required): Main structure to deploy the complete infrastructure directly or through calls to modules
- output.tf: Identify each return value of a Terraform module
- variables.tf: Define variables required (or not) in main.tf

![Config structure for Terraform.](../media/3-config.png)

### Modules

A group of Terraform resources can be grouped into a module, which creates a larger unit of configuration.
Modules are sets of configuration files in a single directory. 
Even a simple configuration consisting of a single directory with one or more ".tf" files.

A module has many benefits:

- They organize your project
- Encapsulate complexity
- Allow you to reuse common tasks
- And provide consistency and ensure good practices

### Main.tf

Your **main.tf** file will contain the main set of configuration for your module.
This file is often called a Terraform _plan_. Your Terraform plan specifies the infrastructure resources that you need.
You can name this file whatever you want, but it's often named **main.tf**.

## Terraform Workflow

![Terraform Workflow.](../media/3-workflow.png)

Terraform recommends its core plan/apply workflow for automation.
This workflow runs all of Terraform's CI/CD actions on new and updated GIT pull requests.

The core actions for this workflow are:

- Init: Initialize a working directory with Terraform configuration files.
- Plan: Produce a plan for changing resources to match the current configuration.
- Apply: Apply the changes described by the plan.

### State

State allows Terraform to know what Azure resources to add, update, or delete.

Terraform uses state to create plans and make changes to your infrastructure. Before any operation, Terraform does a refresh to update the state with the real infrastructure.

State is stored by default in a local text file named "terraform.tfstate". Terraform manages these files using the workflow actions you define in your modules.

You can also store State remotely, which works better in a team environment. For more information on managing remote state, see the Summary unit.

## Next steps

In the next unit, we'll discuss using GitHub Actions, along with Terraform, to provision and deploy your applications.
