[GitHub Actions](/azure/azure-resource-manager/templates/deploy-github-actions) help your team to be agile and competitive in today's marketplace. They help you automate your tasks for the system development or solution development lifecycle.

Suppose you and your team are developing a solution that requires a significant number of resources in an Azure environment. You need to ensure that the solution can be deployed quickly and automatically as part of a continuous integration and continuous delivery (CI/CD) pipeline. That way, you can automate the creation and teardown of the project's infrastructure. By including the resource management in your CI/CD pipeline, you're adopting infrastructure as code (IaC) to automate the IT tasks.

Proper CI/CD pipelines also allow you to include a testing step in your deployment tasks, by using tools such as the Azure Resource Manager (ARM) template test toolkit (*arm-ttk* for short). For more information about this toolkit, see [Validate your deployments by using what-if and the test toolkit](/training/modules/arm-template-test/). 

It's a good idea to include testing in your pipeline so you can focus on authoring. The arm-ttk toolkit runs a series of tests to validate your template during the deployment to avoid issues.

Several tools are available to help you achieve these goals. Because you're already using GitHub for your code repository, you decide to investigate GitHub Actions to see if they provide the automation that you need.

This module introduces you to GitHub Actions as a way to deploy your ARM templates.

## What are GitHub Actions?

GitHub Actions are packaged scripts to automate tasks in a development workflow in GitHub.

GitHub Actions enable you to create custom workflows for the software development lifecycle directly in the GitHub repository where your ARM templates are stored. A YAML file defines a workflow. 

Workflows have one or more jobs. Each job contains a set of steps that perform individual tasks. Steps can run commands or use an action. You can create your own actions or use [actions shared by the GitHub community](https://github.com/marketplace?type=actions&query=azure&azure-portal=true) and customize them as needed.

A basic workflow for deploying an ARM template can have at least three steps:

1. Check out a template file.
2. Sign in to Azure.
3. Deploy the template.

The Azure sign-in action uses a service principal to authenticate against Azure. For the principal of a CI/CD workflow to deploy Azure resources, it needs the right built-in contributor.
