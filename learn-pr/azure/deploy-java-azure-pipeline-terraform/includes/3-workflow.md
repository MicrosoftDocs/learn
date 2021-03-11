In this unit, you'll learn about DevOps and how it integrates with Terraform and Azure.

::: zone pivot="github-actions"

## About GitHub Actions

As an infrastructure manager, you need your build and deployment workflows to be part of your GitHub repository and use the same version control as your project.

By using GitHub Actions, you can run a continuous integration and continuous delivery (CI/CD) process that's linked to your GitHub repositories.

With GitHub Actions, you can build, test, and deploy your code right from GitHub. You can also assign code reviews, manage branches, and triage issues.

## GitHub Actions components

Let's describe the various GitHub Actions components, as shown in the following diagram:

![Diagram showing the relationship of GitHub Actions workflows to their component jobs, steps, and actions.](../media/3-actions.png)

- **Workflow**: Triggered by certain events or activities, a workflow is a collection of jobs and steps that automate software development lifecycle tasks.
- **Job**: A set of steps that execute on a runner.
- **Step**: A task that can run one or more commands or actions. Each step is made up of individual actions that run after a specific event occurs, such as a pull request. 
- **Action**: Standalone commands that can be combined into steps. Multiple steps can be combined to create a job. Individual actions are packaged scripts that automate software development tasks. To create a workflow, you add actions to a YAML file in the *.github/workflows* directory in your GitHub repository.

## A Terraform GitHub action

The `hashicorp/setup-terraform` action sets up the Terraform CLI in your GitHub Actions workflow by:

- Downloading a specific version of the Terraform CLI and adding it to the `PATH`.
- Configuring the Terraform CLI configuration file with a Terraform Cloud or Enterprise host name and API token.
- Installing a wrapper script to wrap later calls of the `terraform` binary and expose its STDOUT, STDERR, and exit code as outputs named `stdout`, `stderr`, and `exitcode` respectively.

## Authenticate GitHub Actions with Azure

Terraform supports several options for authenticating with Azure:

- When you use Terraform interactively, we recommend that you authenticate via a Microsoft account.
- When you use Terraform from code or by automation, we recommend that you authenticate via an Azure service principal.

An Azure service principal is an identity that you create for use with applications, hosted services, and automated tools to access Azure resources.

## Next steps

In the next unit, we'll set up a sample project and use GitHub Actions with Terraform to deploy it to Azure.

::: zone-end

::: zone pivot="azure-devops"
## Key concepts for new Azure Pipelines

Let's learn about the key concepts and components that make up a pipeline.

![key concepts graphic](../media/3-workflow-concepts.svg)

- A **trigger** tells a Pipeline to run.
- A pipeline is made up of one or more **stages**. A pipeline can deploy to one or more environments**.
- A stage is a way of organizing job in a pipeline and each stage can have one or more **jobs**.
- Each job runs on one **agent**. A job can also be **agentless**.
- Each agent runs a job that contains one or more **steps**.
- A step can be a **task** or **script** and is the smallest building block of a pipeline.
- A **task** is a pre-packaged script that does an action, such as invoking a REST API or publishing a build artifact.
- An **artifact** is a collection of files or packages published by a run.

## Terraform Tasks for Azure Pipelines

When executing commands that interact with Azure such as `plan`, `apply`, and `destroy`, the task will use an Azure Service Connection to authorize operations against the target subscription. This connection is specified via the `environmentServiceName` input

```yaml
- task: TerraformCLI
    displayName: 'terraform apply'
    inputs:
        command: apply
        environmentServiceName: 'My Azure Service Connection'
```

## State Support

The task currently supports the following backend configurations

- local (default for terraform) - State is stored on the agent file system.
- azurerm - State is stored in a blob container within a specified Azure Storage Account.
- self-configured - State configuration will be provided using environment variables or command options.

If azurerm selected, the task will prompt for a service connection and storage account details to use for the backend.

```yaml
- task: TerraformCLI
    displayName: 'terraform init'
    inputs:
        command: init
        backendType: azurerm
        backendServiceArm: 'My Azure Service Connection'
        # create backend storage account if doesn't exist
        ensureBackend: true
        backendAzureRmResourceGroupName: 'my-backend-resource-group'
        # azure location shortname of the backend resource group and storage account
        backendAzureRmResourceGroupLocation: 'eastus'
        backendAzureRmStorageAccountName: 'my-backend-storage-account'
        # azure storage account sku, used when creating the storage account
        backendAzureRmStorageAccountSku: 'Standard_RAGRS'
        # azure blob container to store the state file
        backendAzureRmContainerName: 'my-backend-blob-container'
        # azure blob file name
        backendAzureRmKey: infrax.tfstate
```

## Passing Parameters

There are multiple methods to pass parameters to terraform commands.
Variables give you a convenient way to get key bits of data into various parts of the pipeline.

You can set a variable for a build pipeline by following these steps:

1. Go to the **Pipelines** page, select the appropriate pipeline, and then select **Edit**.
1. Locate the **Variables** for this pipeline.
1. Add or update the variable.
1. To mark the variable as secret, select **Keep this value secret**.
1. Save the pipeline.

## Terraform Output to Pipeline Variables

The TerraformCLI task supports running the Terraform `output` command. When the CLI is run, pipeline variables will be created from each output variable emitted from the `terraform output` command.

## Next steps

In the next unit, we'll set up a sample project and use Azure Pipelines with Terraform to deploy it to Azure.

::: zone-end
