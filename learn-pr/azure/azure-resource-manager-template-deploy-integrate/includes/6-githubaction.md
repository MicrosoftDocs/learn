"GitHub Actions" helps your team to be agile and competitive in today's marketplace by allowing you to automate your system/solution development life-cycle tasks.

Suppose you and your team are developing a solution that will require a significant number of resources in an Azure environment. You need to ensure the solution can be deployed quickly and automatically as part of a continuous integration/continuous delivery (CI/CD) pipeline.  That way you can automate the creation and teardown of the project's infrastructure. By including the resources management in your CI/CD pipeline You're adopting infrastructure as code (IaC) to automate the IT tasks.

Proper CI/CD pipeline also allow you to include in your deployment tasks a testing step using tools such as the ARM Template Test toolkit or arm-ttk for short mentioned in **<Insert Link to module 3 from chris>**.  It's a really good idea to include testing in your pipeline so you can focus on authoring while the arm-ttk runs a series of tests to validate your template during the deployment to avoid issues.

There are several tools available to help you achieve these goals. However, since you may already be using GitHub for your code repository, you decide to investigate GitHub Actions to see if it provides the automation you need.

In this module, you are introduced to GitHub Actions as a way to deploy your Azure Resource Management (ARM) templates.

## What is GitHub Actions?

*GitHub Actions* are packaged scripts to automate tasks in a development workflow in GitHub.

GitHub Actions enables you to create custom software development life-cycle workflows directly in your GitHub repository where your Azure Resource Manager (ARM) templates are stored. A workflow is defined by a YAML file. Workflows have one or more jobs with each job containing a set of steps that perform individual tasks. Steps can run commands or use an action. You can create your own actions or use [actions shared by the GitHub community](https://github.com/marketplace?type=actions&query=azure&WT.mc_id=MSLearn-ARM-pierrer) and customize them as needed.

A basic workflow for deploying a Resource Manager template can have at least three steps:

1. Checkout a template file.
2. Sign in to Azure.
3. Deploy a Resource Manager template

## GitHub Action input for deploying your ARM template

* `creds` **Required**
    The Service Principal information for authentication against your Azure subscription

* `templateLocation` **Required**
    The relative path to the Azure Resource Manager template in relation to the YAML workflow file

* `resourceGroupName`
    The name of the target resource group.  If you don't provide a resource group name the template will be deployed at subscription scope

* `deploymentMode`
    Incremental (only add resources to resource group) or Complete (remove extra resources from resource group). The default mode is `Incremental`.
  
* `deploymentName`
    The name of the resource group deployment to create.

* `parameters`
    The path to the ARM template parameters file or the parameters themselves in a Key-Value Pairs format

* `overrideParameters`
    The path to the ARM override parameters file or pass the parameters themselves in a Key-Value Pairs format

