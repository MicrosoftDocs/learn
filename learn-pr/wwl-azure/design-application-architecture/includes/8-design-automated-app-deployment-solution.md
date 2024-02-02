
With the move to the cloud, many teams have adopted agile development methods. These teams must iterate quickly and repeatedly deploy their solutions to the cloud. Teams must be assured their infrastructure is in a reliable state. Application code must be managed through a unified process.

To meet these challenges in your design for Tailwind Traders, you're investigating how to automate deployments by using the practice of [infrastructure as code](/devops/deliver/what-is-infrastructure-as-code). Let's explore two Azure solutions for deployment and automation of your applications: Azure Resource Manager templates and Azure Automation. 

### Things to know about Azure Resource Manager templates

[Azure Resource Manager (ARM) templates](/azure/azure-resource-manager/templates/overview) are files that define the infrastructure and configuration for your deployment. When you write an ARM template, you take a declarative approach to your resource provisioning. ARM templates describe each resource in the deployment, but they don't describe how to deploy the resources. 

There are many benefits to using ARM templates for your resource provisioning. As you review the benefits, think about how ARM templates can be used in the Tailwind Traders architecture solution.

- ARM templates are _idempotent_, which means you can repeatedly deploy the same template and get the same result.

- When an ARM template deployment is submitted to Azure Resource Manager, the resources in the ARM template are deployed in parallel. This orchestration feature process allows deployments to finish faster.

- The `WhatIf` parameter available in PowerShell and the Azure CLI allows you to preview changes to your environment before deploying the ARM template. This parameter details any creations, modifications, and deletions that will be made by your template.

- ARM templates submitted to Resource Manager are validated before the deployment process. This validation alerts you to any errors in your template before resource provisioning.

- You can break up your ARM templates into smaller components and link them together at deployment.

- Your ARM templates can be integrated into multiple CI/CD tools like Azure DevOps and GitHub Actions.

- With deployment scripts, you can run Bash or PowerShell scripts from within your ARM templates. Through extensibility, you can use a single template to deploy a complete solution.

#### ARM template formats

There are two formats available for ARM templates and Azure resource deployments, JSON and Bicep. JavaScript Object Notation (JSON) is an open-standard file format that multiple languages can use. Bicep is a new domain-specific language that was recently developed for authoring templates by using an easier syntax. You can use the Bicep CLI to decompile any JSON template into a Bicep template.

### Things to know about Azure Bicep templates

[Bicep](/azure/azure-resource-manager/bicep/overview) is an ARM template language that's used to declaratively deploy Azure resources. Bicep is a domain-specific language, which means that it's designed for a specific scenario or domain. Bicep is used to create ARM templates. 

:::image type="content" source="../media/bicep-to-json.png" alt-text="Illustration that shows the process of authoring with a Bicep ARM template via a JSON ARM template to Azure." border="false":::

There are many reasons to choose Bicep as the main tool set for your infrastructure as code deployments.

- Bicep is native to the Azure ecosystem. When new Azure resources are released or updated, Bicep will support those features on day one.

- JSON and Bicep templates are fully integrated within the Azure platform. With Resource Manager-based deployments, you can monitor the progress of your deployment in the Azure portal.

- Bicep is a fully supported product with Microsoft Support.

- All state is stored in Azure. Users can collaborate and have confidence their updates are handled as expected.

- If you're already using JSON templates as your declarative template language, it isn't difficult to transition to Bicep. You can use the Bicep CLI to decompile any template into a Bicep template.

### Things to know about Azure Automation

[Azure Automation](/azure/automation/automation-intro) delivers a cloud-based automation and configuration service that supports consistent management across your Azure and non-Azure environments. Azure Automation gives you complete control in three service areas: process automation, configuration management, and update management. Let's examine the details of this service, and consider how it can be implemented in the Tailwind Traders application architecture.

| Service | Description |
| --- | --- |
| **Process automation** | Process automation enables you to automate frequent, time-consuming, and error-prone cloud management tasks. This service helps you focus on work that adds business value. By reducing errors and boosting efficiency, it also helps to lower your operational costs. The service allows you to author runbooks graphically in PowerShell or by using Python. |
| **Configuration management** | Configuration management enables access to two features, Change Tracking and Inventory and Azure Automation State Configuration. The service supports change tracking across services, daemons, software, registry, and files in your environment. The change tracking helps you diagnose unwanted changes and raise alerts. |
| **Update management** | The update management service includes the Update Management feature for Windows and Linux systems across hybrid environments. The feature allows you to create scheduled deployments that orchestrate the installation of updates within a defined maintenance window. 