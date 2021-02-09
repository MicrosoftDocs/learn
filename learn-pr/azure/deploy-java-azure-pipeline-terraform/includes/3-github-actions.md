In this unit, you'll learn about GitHub Actions and how they integrate with Terraform and Azure.

## About GitHub Actions

As an infrastructure manager, you need your build and deployment workflows to be part of your GitHub repository and use the same version control as your project.

By using GitHub Actions, you can run a continuous integration and continuous delivery (CI/CD) process that's linked to your GitHub repositories.

With Github Actions, you can build, test, and deploy your code right from GitHub. You can also assign code reviews, manage branches, and triage issues.

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
