With more enterprises adopting the cloud, many of them are adopting agile development methods. These enterprises need to repeatedly deploy their solutions to the cloud (in different environments dev, test, prod...). Infrastructure is now an integral part of that iterative process. However you still need to design and manage that infrastructure in a controlled manner.

To meet these challenges, you can use the practice of infrastructure as code (IaC). IaC defines the infrastructure that needs to be deployed. And just like application code, you store the infrastructure code (the templates) in a source repository and version it. Any one on your team can run the code and deploy similar environments. That way, you retain control of what gets deployed but are unburdened of the daily deployments in dev, test, or production environments.

To implement infrastructure as code for your Azure solutions, use Azure Resource Manager (ARM) templates. The template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project.

## Learning objectives

In this module, you will learn:

- What an Azure Resource Manager template is, and what its components are.
- How to write your own ARM template from scratch.
- You'll learn to add parameters, variables, resources, functions, and outputs to your template.

## Prerequisites

- Experience using Bash and the Azure CLI
- Experience working with Azure resources and resource groups
