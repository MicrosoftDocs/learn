In this unit, you'll learn about GitHub actions and how they integrate with Terraform and Azure.

# GitHub actions

GitHub actions allow you to run Continuous Integration and Deployments (CI/CD) linked to your GitHub repositories.
You can keep everything in source control, so you can track what has changed.

There are two types of GitHub Actions, container actions and JavaScript actions. With container actions, the environment is part of the action's code. These actions can only be run in a Linux environment that GitHub hosts. Container actions support many different languages. JavaScript actions don't include the environment in the code. This limitation means you'll have to specify the environment to execute these actions. You can run in a VM in the cloud or on-premises. JavaScript actions support Linux, macOS, and Windows environments.

## GitHub Actions workflow

A workflow is a process to automate software development life-cycle tasks. With a workflow, you can build, test, package, release, or deploy any project on GitHub.

To create a workflow, you add actions to a .yml file in the .github/workflows directory in your GitHub repository.

## Terraform with GitHub Actions

The `hashicorp/setup-terraform` action is a JavaScript action that sets up Terraform CLI in your GitHub Actions workflow by:

- Downloading a specific version of Terraform CLI and adding it to the `PATH`.
- Configuring the Terraform CLI configuration file with a Terraform Cloud/Enterprise hostname and API token.
- Installing a wrapper script to wrap later calls of the `terraform` binary and expose its STDOUT, STDERR, and exit code as outputs named `stdout`, `stderr`, and `exitcode` respectively.

## Connecting to Azure

It's recommended to use an Azure Service Principal when running Terraform non-interactively (such as when running Terraform in a CI server).

## Next steps

In the next unit, we'll set up your project to use GitHub Actions.
