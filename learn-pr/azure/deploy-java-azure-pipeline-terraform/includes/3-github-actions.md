In this unit, you'll learn about GitHub actions and how they integrate with Terraform and Azure.

# GitHub actions

GitHub actions allow you to run Continuous Integration and Deployments (CI/CD) linked to your GitHub repositories.

GitHub Actions are composed of the following components:

- Workflows: Automated processes added to your repository.
- Events: An activity that triggers a workflow.
- Jobs: A set of steps that execute on a runner.
- Steps: A task that can run one or more commands (actions).
- Actions: Standalone commands that can be combined into steps. Multiple steps can be combined to create a job.
- Runners: Server that has the GitHub Actions runner application installed.

## GitHub Actions workflow

A GitHub Actions Workflow is a process to automate software development life-cycle tasks. With a workflow, you can build, test, package, release, or deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the .github/workflows directory in your GitHub repository.

## Terraform with GitHub Actions

The `hashicorp/setup-terraform` action sets up Terraform CLI in your GitHub Actions workflow by:

- Downloading a specific version of Terraform CLI and adding it to the `PATH`.
- Configuring the Terraform CLI configuration file with a Terraform Cloud/Enterprise hostname and API token.
- Installing a wrapper script to wrap later calls of the `terraform` binary and expose its STDOUT, STDERR, and exit code as outputs named `stdout`, `stderr`, and `exitcode` respectively.

## Connecting GitHub Actions to Azure

Terraform supports several options for authenticating to Azure:

- When using Terraform interactively, authenticating via Microsoft account is recommended.
- When using Terraform from code, authenticating via Azure service principal is one recommended way.

An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources.

## Next steps

In the next unit, we'll set up a sample project and use GitHub Actions to deploy to Azure.
