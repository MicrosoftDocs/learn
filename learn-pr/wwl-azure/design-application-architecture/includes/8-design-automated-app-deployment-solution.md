With the move to the cloud, many teams have adopted agile development methods. These teams must iterate quickly and repeatedly deploy their solutions to the cloud. Teams must be assured their infrastructure is in a reliable state. Application code must be managed through a unified process.

To meet these challenges, you can automate deployments and use the practice of [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code). In this unit, you’ll learn how to evaluate different Azure solutions for deployment and automation for your applications. These solutions include Azure Resource Manager templates, and Azure Automation. 

## What are Azure Resource Manager templates?

[Azure Resource Manager templates](/azure/azure-resource-manager/templates/overview) are files that define the infrastructure and configuration for your deployment. When you write a template, you take a declarative approach to your resource provisioning. These templates describe each resource in the deployment, but they don't describe how to deploy the resources. 

There are many benefits to using templates for your resource provisioning. These benefits are described in the following table:

| **Function**| **Template benefit** |
| - | - |
| Repeatable results| Templates are idempotent. Idempotent means you can repeatedly deploy the same template and get the same result. |
| Orchestration| When a template deployment is submitted to Azure Resource Manager, the resources in the template are deployed in parallel. This process allows deployments to finish faster. |
| Preview| The WhatIf parameter, available in PowerShell and Azure CLI, allows you to preview changes to your environment before template deployment. This parameter will detail any creations, modification, and deletions that will be made by your template. |
| Testing and Validation| Templates submitted to Resource Manager are validated before the deployment process. This validation alerts you to any errors in your template before resource provisioning. |
| Modularity| You can break up your templates into smaller components and link them together at deployment. |
| CI/CD integration| Your templates can be integrated into multiple CI/CD tools, like Azure DevOps and GitHub Actions. |
| Extensibility| With deployment scripts, you can run Bash or PowerShell scripts from within your templates. Through extensibility, you can use a single template to deploy a complete solution. |


> [!NOTE]
> Two types of templates are available for use today: JSON templates and Bicep templates. JavaScript Object Notation (JSON) is an open-standard file format that multiple languages can use. Bicep is a new domain-specific language that was recently developed for authoring templates by using an easier syntax. You can use either template format for your templates and resource deployments.

## What are Bicep templates?

[Bicep](/azure/azure-resource-manager/bicep/overview) is an Azure Resource Manager template language that's used to declaratively deploy Azure resources. Bicep is a domain-specific language, which means that it's designed for a specific scenario or domain. Bicep is used to create Azure Resource Manager templates. 

:::image type="content" source="../media/bicep-to-json.png" alt-text="A graphic that depicts the process of authoring using a Bicep template via JSON template to Azure.":::


There are many reasons to choose Bicep as the main tool set for your infrastructure as code deployments. These benefits are described in the following table.

| **Feature**| **Description** |
| - | - |
| Azure-native | Bicep is native to the Azure ecosystem. When new Azure resources are released or updated, Bicep will support those features on day one. |
| Azure integration | Templates, both JSON and Bicep, are fully integrated within the Azure platform. With Resource Manager-based deployments, you can monitor the progress of your deployment in the Azure portal. |
| Azure support | Bicep is a fully supported product with Microsoft Support. |
| No state or state files to manage	| All state is stored in Azure. Users can collaborate and have confidence their updates are handled as expected. |
| Easy transition from JSON | If you're already using JSON templates as your declarative template language, it isn't difficult to transition to Bicep. You can use the Bicep CLI to decompile any template into a Bicep template. |


## What is Azure Automation?

[Azure Automation](/azure/automation/automation-intro) delivers a cloud-based automation and configuration service that supports consistent management across your Azure and non-Azure environments. Automation gives you complete control of process automation, configuration management, and update management. 

| **Process**| **Description** |
| - | - |
| Process Automation| Enables you to automate frequent, time-consuming, and error-prone cloud management tasks. This service helps you focus on work that adds business value. By reducing errors and boosting efficiency, it also helps to lower your operational costs. The service allows you to author runbooks graphically, in PowerShell, or using Python. |
| Configuration Management| Enables access to two features: Change Tracking and Inventory and Azure Automation State Configuration. The service supports change tracking across services, daemons, software, registry, and files in your environment to help you diagnose unwanted changes and raise alerts. |
| Update management| Includes the Update Management feature for Windows and Linux systems across hybrid environments. The feature allows you to create scheduled deployments that orchestrate the installation of updates within a defined maintenance window. |
