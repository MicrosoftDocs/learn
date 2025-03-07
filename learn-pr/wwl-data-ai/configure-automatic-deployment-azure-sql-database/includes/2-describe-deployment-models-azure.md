Azure Resource Manager (ARM) templates allow you to deploy a complete set of resources using a single declarative template. You can define dependencies within the templates and use parameters to adjust deployment values at runtime. Once you have a template, you can deploy it in several ways, including through Azure Pipelines or the custom deployment options in the Azure portal. These deployments use a declarative model, specifying what should be created, while the ARM template framework determines how to deploy it.

In contrast, the imperative model, used by tools like PowerShell and Azure CLI, follows a specific sequence of tasks to be executed.

## Azure Resource Manager templates

[Azure Resource Manager](/azure/azure-resource-manager/management/overview) templates enable you to create and deploy an entire infrastructure in a declarative manner. For instance, you can deploy a virtual machine along with its network and storage dependencies in one document. ARM template supports orchestration, managing the deployment of interdependent resources in the correct order. ARM templates also support extensibility, allowing you to run PowerShell or Bash scripts on your resources post-deployment.

## PowerShell

[PowerShell](/powershell/scripting/overview), with its Az module, provides cmdlets for nearly all Azure services. For example, **Az.Compute** covers Azure Virtual Machines. PowerShell is often used for resource modification and status retrieval. While it can create resources, it isn't typically used for complex deployments. PowerShell can also deploy ARM templates, supporting both declarative and imperative models.

## Azure CLI

[Azure Command-Line Interface (CLI)](/cli/azure/what-is-azure-cli) is similar to PowerShell, supporting both imperative and declarative operations. The Azure CLI can deploy or modify Azure resources, and some commands for Azure PostgreSQL and Azure MySQL Databases are exclusive to the CLI.

## Azure portal

The Azure portal is a graphical interface for ARM template. Any resources you create and deploy using the portal will have an ARM template that you can export by selecting **Export template** in the **Automation** section of your resource group.

:::image type="content" source="../media/module-66-automation-final-01.png" alt-text="Screenshot of the export template option on the resource group blade from Azure portal." lightbox="../media/module-66-automation-final-01.png":::

The Azure portal is often the easiest way to get started with Azure. As organizations and DBAs gain experience, they typically move to more automated deployment models.

## Azure DevOps Services

In Azure DevOps Services, deployments are managed using Azure Pipelines, a comprehensive CI/CD service that automates the build, testing, and deployment of your code. You can deploy Azure resources using ARM templates in two ways: by calling a PowerShell script or by defining tasks that stage your artifacts (templates and required secrets) and then deploy the templates. This automation ensures that your deployments are consistent and reliable, reducing the risk of human error.

Continuous integration (CI) complements this by focusing on making small, frequent changes to code and regularly checking it into a version control system. CI automates the build, packaging, and testing of applications, facilitating better collaboration among developers and improving code quality. Continuous delivery (CD) builds on CI by automating the delivery of code changes to the underlying infrastructure, ensuring that your deployments aren't only consistent but also rapid and efficient. Together, Azure Pipelines and CI/CD practices streamline the entire development and deployment process, making it more efficient and reliable.

