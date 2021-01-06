In this unit, you'll learn about GitHub actions and how they integrate with Terraform and Azure.

# GitHub actions

GitHub actions allow you to run Continuous Integration and Deployments (CI/CD) linked to your GitHub repositories.
You can keep everything in source control, so you can track what has changed.

There are two types of GitHub Actions, container actions and JavaScript actions. With container actions, the environment is part of the action's code. These actions can only be run in a Linux environment that GitHub hosts. Container actions support many different languages. JavaScript actions don't include the environment in the code.

## GitHub Actions workflow

A GitHub Actions Workflow is a process to automate software development life-cycle tasks. With a workflow, you can build, test, package, release, or deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the .github/workflows directory in your GitHub repository.

## Terraform with GitHub Actions

The `hashicorp/setup-terraform` action is a JavaScript action that sets up Terraform CLI in your GitHub Actions workflow by:

- Downloading a specific version of Terraform CLI and adding it to the `PATH`.
- Configuring the Terraform CLI configuration file with a Terraform Cloud/Enterprise hostname and API token.
- Installing a wrapper script to wrap later calls of the `terraform` binary and expose its STDOUT, STDERR, and exit code as outputs named `stdout`, `stderr`, and `exitcode` respectively.

## Connecting to Azure

Cloud Shell is automatically authenticated under the Microsoft account you used to log into the Azure portal. If your account has multiple Azure subscriptions, you can switch to one of your other subscriptions.

Terraform supports several options for authenticating to Azure:

- When using Terraform interactively, authenticating via Microsoft account is recommended.
- When using Terraform from code, authenticating via Azure service principal is one recommended way.

An Azure service principal is an identity created for use with applications, hosted services, and automated tools to access Azure resources.

This access is restricted by the roles assigned to the service principal, giving you control over which resources can be accessed and at which level.

When you create a Service Principal for GitHub Actions, it requires Contributor access to an Azure subscription.

## Next steps

In the next unit, we'll set up your project to use GitHub Actions.
