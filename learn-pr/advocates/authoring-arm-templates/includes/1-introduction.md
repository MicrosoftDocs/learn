With more enterprises adopting the cloud, many of them are adopting agile development methods. These teams iterate quickly. They need to repeatedly deploy their solutions to the cloud, and know their infrastructure is in a reliable state. Infrastructure is now an integral part of the iterative process, the division between operations and development is  disappearing. You need to manage infrastructure and application code through a unified process.

To meet these challenges, you can use the practice of infrastructure as code (IaC). IaC defines the infrastructure that needs to be deployed. And just like application code, you store the infrastructure code (the templates) in a source repository and version it. Any one on your team can run the code and deploy similar environments.  Therefore you retain control of what gets deployed but are unburdened of the daily deployments in dev, test or production environments

To implement infrastructure as code for your Azure solutions, use Azure Resource Manager (ARM) templates. The template is a JavaScript Object Notation (JSON) file that defines the infrastructure and configuration for your project.

## Learning objectives

In this module, you will:

- Identify what Azure Resource Manager is, and what's in a Resource Manager template
- Deploy a VM using the Azure CLI and a prebuilt Resource Manager template
- Customize your Resource Manager template to configure a basic web server on your VM

## Prerequisites

- Experience using Bash and the Azure CLI
- Experience working with Azure resources and resource groups
