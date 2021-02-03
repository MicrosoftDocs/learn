With the build artifacts successfully generated and published into Azure Pipelines, you're ready to proceed to the next step. This step isn't dependent on the build, instead it involves provisioning of the Azure resources into which you will deploy artifacts. Starting with the predefined **ASP.NET** templates simplifies generation of the YAML pipeline you'll now modify, as your first set of deployment steps. This deployment follows the concept of *Infrastructure as Code*.

## What is Infrastructure as Code?

Infrastructure as Code (IaC) applies DevOps principles to manage and maintain services that are traditionally the responsibility of infrastructure and platform teams within an IT organization. These services include compute, networking, and storage components that serve as the basis for deployment of software, which is the primary focus of development and operations teams. IaC started gaining prominence with the advent of cloud technologies, which practically eliminated dependency on physical, on-premises infrastructure.

IaC leverages automation to set up infrastructure services and control their configuration. By using IaC, you can automatically provision Azure App Service web apps and Azure SQL databases, into which you can subsequently deploy your apps and load your data. This approach offers a range of benefits, including consistency, scalability, agility, and repeatability.

There are two ways to implement IaC:

- Declarative. Declarative code defines what the code should accomplish but does not define how to achieve the result. When operating in Azure, you can use such tools and techniques as Azure Resource Manager templates, Terraform, or Ansible for this purpose.
- Imperative. Imperative code defines both what the program should accomplish and how to achieve the result. When operating in Azure, you can use such tools and techniques as Azure PowerShell, Azure CLI, or Azure SDK for this purpose.

> [!NOTE]
> You can incorporate any of these tools and techniques into Azure Pipelines.

In addition, because IaC relies on code to describe the target environment, you can store your infrastructure and configuration code in version control, along with the application code. This, in turn, also allows you to use the same process to build, deploy, and maintain your infrastructure and applications.

### What is idempotency?

Idempotency is a term that's used in mathematics and computer science. An idempotent operation is one that provides the same result each time you apply it. In the context of IaC, the idempotency means that deploying imperative or declarative code will always yield the same set of resources with the configuration defined by that code. As an example, consider running the Azure CLI **az group create** command with **aspdevops-rg** and **eastus** as the values of its **-name** and **-location** parameters:

```
az group create -name apdevops-rg -location eastus
```

When you first run this command, its execution will create a resource group with the matching name and location (if such group doesn't already exist) and generate output that provides its JSON representation. Every subsequent execution will result in the same outcome, without affecting the resource group state or generating an error message. This effectively means that this Azure CLI command is idempotent.

Idempotency is a critical component of IaC. In scenarios more complex than the one involving creating a resource group, you could use IaC to restore the original configuration of an Azure resource and ensure consistency of your environment.

### IaC and Azure Pipeline stages

Because IaC tasks provision infrastructure separately from artifacts that are deployed afterwards, you might consider encapsulating these tasks into a dedicated stage within an Azure pipeline. While, in general, it might make sense to still run all stages together, the multi-stage approach of IaC will simplify testing artifact deployments separately from infrastructure provisioning.

## Target environment

Another important decision you need to make when migrating ASP.NET apps to Azure is the choice of the target service that will host deployed artifacts. To maximize performance, scalability, and cost savings benefits, you choose Azure App Service and Azure SQL Database as the web and database platform, respectively.

Azure App Service is a platform-as-a-service (PaaS) Azure offering that you can use to host web and API apps. This service provides such benefits as:

- Autoscaling that dynamically adjusts amount of compute resources available to your apps based on the criteria that you specify.
- High availability that protects your apps from localized hardware and software failures.
- Integration with Azure Pipelines and GitHub repositories.

Azure App Service simplifies deployment and configuration of web and API apps, including ASP.NET apps, providing an intuitive, Azure portal-based interface for managing their settings, such as, for example, database connection strings.

Azure SQL Database is a PaaS relational database offering. It provides a highly available, fully managed SQL database service that includes automatic patching and backups.

:::image type="content" source="../media/5-web-app-azure.png" alt-text="An Azure data-driven web app architecture with a resource group containing an App Service plan, App Service web app, Azure SQL logical server and an Azure SQL database.":::

### Authenticating to the target environment

Before you provision a target infrastructure and deploy your software, you need to first authorize access from Azure Pipelines to the target environment. When targeting Azure App Service and Azure SQL Database, that environment is an Azure subscription.

Azure Pipelines provides several different methods for providing authenticated access to Azure subscriptions. In the upcoming exercise, you'll use an Azure Active Directory (Azure AD) service principal for this purpose, which you can generate automatically from within the Azure DevOps portal. Within an Azure DevOps project, that service principal is represented by a service connection, which you can make available to any pipeline within the project.

### Provisioning the target environment

To implement the target environment, you decided to use an Azure CLI script because you're familiar with Bash scripting. Based on your cursory overview of Azure CLI documentation, the commands to create an Azure resource group, an Azure App Service web app, and an Azure SQL database seemed straightforward. In addition, you verified that Azure Pipelines offer built-in Azure CLI tasks, which support Azure service connection and references to variable groups.

The second of these two points is important because, to deploy an Azure logical SQL server and an Azure App Service web app, you need to assign to each a globally unique name. You can identify such names prior to the first deployment, store them by using a variable group, and reference them during pipeline execution across multiple stages.

> [!NOTE]
> To reference a variable group from within a pipeline, you need to configure the variable group access setting and link the variable group to the pipeline. You'll step through this process in the upcoming exercise.

### Connectivity to the target environment

Both Azure App Service and Azure SQL Database implement public endpoints. For your solution to work, there's one more consideration. The logical Azure SQL server includes a built-in firewall, which, by default, blocks all incoming traffic. To allow Azure App Service web apps to access any of its databases, you need to add a firewall rule that allows traffic originating from Azure.

## Azure Pipelines agents for deployment of Azure resources

To perform deployment of Azure resources, you have more flexibility because of multi-platform support for Azure CLI. This allows you to choose any of the Microsoft-hosted agents, including those running Ubuntu or macOS.
