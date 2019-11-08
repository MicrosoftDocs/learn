Andy and Tim have decided to use Terraform to provision their infrastructure. To prepare for the exercises in this module, let's examine how Terraform works and see some of its most commonly-used features.

In this section, you learn:

> [!div class="checklist"]
> * How Terraform files are structured.
> * What parts make up a typical Terraform plan.
> * How Terraform commands map to your infrastructure's lifecycle.

## How are Terraform files structured?

When working with Terraform code, there are a few files you commonly work with.

* *main.tf*

    A *.tf* file holds your Terraform configuration code. This file is often called a Terraform _plan_. Your Terraform plan specifies the infrastructure resources that you need. You can name this file whatever you'd like, but this file is commonly named *main.tf*.

* *terraform.tfvars*

    Your Terraform plan can include variables that are set when the plan runs. Variables enable you to express your configuration more generally.

    For example, you might specify the region, or location, of your resources as a variable. When you run your plan, you specify the region, such as "westus" or "northeurope".

    Variables enable you to more easily reuse your Terraform code without the need to modify the source code. They also enable you to more easily change how multiple resources are configured because variables are defined in one location.

    There are a few ways to specify each variable's value when the plan runs, which you'll learn about shortly. A *.tfvars* file is a good way to maintain larger sets of variables.

    You can name this file whatever you'd like, but this file is commonly named *terraform.tfvars*.

* *terraform.tfstate*

    *terraform.tfstate*, called the _state file_, is a JSON file that Terraform manages to help map the resources you define in your plan to the running resources your plan produces.

    For example, you might include a name as part of your resource description, but the running resource is identified by a GUID, URI, or numeric ID. Terraform uses the state file to map your name to how, Azure for example, identifies the same resource.

    In this module, you start by running Terraform locally from Cloud Shell. Here, Terraform manages the state file locally in your Cloud Shell session. Later, you move the state file to an Azure storage account to provide a shared, central location for Terraform to use in Azure Pipelines.

You'll work with each of these files shortly.

## What's in a Terraform plan?

Here, we define some of the more common pieces that make up your Terraform plan.

### Providers

A _provider_ links the Terraform resources you specify to the API calls that are needed to provision and manage those resources.

In terms of declarative programming, think of your plan as _what_ infrastructure you need and a provider as _how_ your plan is mapped to running cloud resources.

Recall that Terraform supports a number of public clouds and private cloud frameworks. Think of the `terraform` program as the core Terraform engine. The functionality for each provider &mdash; Azure, Docker, Amazon Web Services, and so on, is defined in a plugin.

Provider software versions are maintained separately from the `terraform` program. Among other things, you can specify the provider version you need in a `provider` block. Here's an example:

```terraform
provider "azurerm" {
  version = "~> 1.35"
}
```

When getting started, you don't need to include the `provider` block in your plan. In practice, you might include the provider version to help ensure your plan is run with a version of the provider you understand and have tested.

### Variables

Earlier, we defined a _variable_ in Terraform as a way to express your configuration more generally. Variables are set when the plan runs.

Here's an example of a `variable` block that defines the location, or region, for an Azure resource group:

```terraform
variable "resource_group_location" {
  description = "The location of the resource group"
}
```

Optionally, can provide a default value. This example uses "westus":

```terraform
variable "resource_group_location" {
  default = "westus"
  description = "The location of the resource group"
}
```

When you define your resource group, you use the `${var.variable}` syntax to read your variable. Here's an example:

[!code-terraform[](code/main.tf?range=30-33&highlight=32)]

To specify the values of your variables when Terraform runs, you can use:

* The `-var` argument.
* A *.tfvars* file.
* Environment variables.
* A Terraform Cloud workspace.

If you don't provide a variable's value, and the variable doesn't have a default value, Terraform prompts you for the value when your plan runs. This approach works well when getting started, but it doesn't work well in CI/CD pipelines.

### Resources

A _resource_ is the primary construct in Terraform. A resource defines one piece of infrastructure that you need. Resources can include compute resources such as virtual machines or App Service, data and storage resources such as Azure storage or Azure SQL Database, and many more.

Here are a few resources you'll work with shortly. These resources define an Azure resource group, and App Service plan, and an App Service instance.

[!code-terraform[](code/main.tf?range=30-53&highlight=37-38,50-51)]

Notice that you can define some attributes, such as the parent resource group's name and location, directly from other resources. Terraform creates a dependency graph that expresses these relationships so that it can create and manage your resources in the correct order.

### Output values

An _output value_ is a way to expose information to the person or process that runs your plan.

Terraform prints each output value after it applies your plan. You can also fetch an output value later when you need it.

Here's an example that outputs the host name of an App Service instance:

[!code-terraform[](code/main.tf?range=55-58)]

You can fetch output values after Terraform runs. Later, you'll see how to fetch the name of an App Service instance who's name is generated dynamically and pass that name to a later job in Azure Pipelines.

### Terraform settings

A _Terraform settings_ block specifies configuration settings for Terraform itself.

You commonly use this block to specify the version of Terraform that you need. Here's an example:

[!code-terraform[](code/main.tf?range=1-3)]

Specifying the version enables you to _pin_, or specify, the version you've tested with. As Terraform releases new versions, you can test and verify your configurations and then update the version when you're ready.

The settings block also enables you to specify the location of the state file. You'll do so later when you move the state file to an Azure storage account.

## What commands will I need?

Terraform provides commands that map to your infrastructure's lifecycle. Here are some of the more common commands you use in this module.

### Initialize

The `terraform init` command initializes your Terraform environment. This command downloads the plugins you need and also verifies that Terraform can access your plan's state file.

### Plan

The `terraform plan` command produces an execution plan that's based on your configuration. This command doesn't modify any infrastructure. Rather, it's a way for a human to review what changes would be made if the plan were applied.

This command is useful when developing your Terraform configuration because it helps you visualize and understand the affect your plan will have.

The output you see resembles how many file difference tools work. You see a plus **+** symbol next to resources that Terraform will create, and a minus **-** symbol next to ones that Terraform will destroy. The output also shows each of the attributes that are applied to each resource, such as resource group's name or the storage account tier.

You typically omit this command when running Terraform in a CI/CD pipeline. By the time your plan reaches the pipeline, your plan should express your infrastructure requirements and you should understand the affect your plan will have.

### Apply

The `terraform apply` command runs your execution plan. Think of it as a way to apply the proposed changes you get from the `terraform plan` command.

Like `terraform plan`, this command prints out an execution plan. It also prompts you to verify the configuration one final time before the plan runs. Later, you'll see how to skip this verification step when you run your plan in Azure Pipelines.

The `terraform apply` command is an idempotent operation. Recall that an idempotent operation is one that that provides the same result each time you apply it. This means that `terraform apply` takes no action if the actual state of your infrastructure matches what's expressed in your plan. Terraform won't recreate or duplicate your resources if the environment has not changed. This makes `terraform apply` safe to run in a CI/CD pipeline.

However, if your Terraform plan changes or some other process inadvertently changes your infrastructure, `terraform apply` places your infrastructure in the desired state.

### Destroy

The `terraform destroy` command destroys all infrastructure resources that are defined in your plan.

Like, `terraform apply`, the `terraform destroy` command prompts you to verify the operation and provides an execution plan that you can review before taking action.

You might not run `terraform destroy` in your pipeline if your resources are long-lived. However, you'll likely run this command many times as you develop your plan and test out new ideas.

## What's next?

Let's see what Tim and Andy plan to do next.

**Tim:** Before we run anything in Azure Pipelines, I'd like to see first whether we can build and run the plan we need locally.

**Andy:** I agree. Doing so will give us a clear understanding of the process and will show us what else we need to run Terraform in the pipeline.