Azure Resource Manager templates have the benefit of being able to deploy a full set of resources in one single declarative template. You can build dependencies into the templates, and using parameters to change deployment values at deployment time. Once you have a template, you can deploy it several ways including using an Azure DevOps pipeline, or through the custom deployments options in the Azure portal. The benefit of these deployments is that they use a declarative model, which defines what should be created. The Azure Resource Manager framework then determines how to deploy it. The alternative to the declarative model is the imperative model. Imperative frameworks include PowerShell and the Azure CLI, which follow a prescriptive order of tasks to be executed.

As mentioned above, there are two programming models that are used for cloud deployments: **imperative** and **declarative**.

In **imperative** programming, you're defining a set of prescriptive tasks for the target system to execute. A simple example of this model is using a batch script to install SQL Server and its prerequisites. In **declarative** programming, you're describing a set of resources to be defined, typically by a framework. A simple example is a CREATE TABLE statement, which describes the columns and keys to be built by the SQL Server engine. The statement acts as the framework for building the table.

## Azure Resource Manager templates

Azure Resource Manager templates allow you to create and deploy an entire infrastructure in a declarative framework. For example, you can deploy not only a virtual machine, but its network and storage dependencies in one document. Resource Manager also supports orchestration, which manages the deployment of interdependent resources so that they're created in the correct order. For example, a VM is dependent on the existence of a virtual network, so the framework will deploy the network (or check for the existence of the network) before attempting to build the VM. Azure Resource Manager templates also support extensibility, which allows you to run PowerShell or Bash scripts on your resources after they're deployed.

## PowerShell

PowerShell provides a core module known as Az PowerShell module, which has child resource providers for nearly all Azure services. For example, **Az.Compute** would cover Azure Virtual Machines. PowerShell is more commonly used for resource modification and status retrieval. While it's possible to create resources using PowerShell, it isn't typically used for complex deployments. PowerShell can also be used to deploy Azure Resource Manager templates, so in a sense it supports both declarative and imperative models.

## Azure CLI

The Azure Command Line Interface, or CLI, is similar to PowerShell in that it can be used either imperatively or declaratively. Much like PowerShell and Azure Resource Manager templates, the Azure CLI provides a mechanism to deploy or modify Azure Resources. Some commands for Azure PostgreSQL and Azure MySQL Databases are only available in the Azure CLI.

## Azure portal

The Azure portal is a graphical interface to Azure Resource Manager. Any resources you build and deploy using the portal will have an Azure Resource Manager template that you can capture by selecting **Export template** in the **Overview** section of your resource group.

:::image type="content" source="../media/module-66-automation-final-01.png" alt-text="Screenshot of the export template option on resource group on Azure portal." lightbox="../media/module-66-automation-final-01.png":::

The Azure portal is usually the easiest way to get started when first learning about the Azure platform. Organizations (and DBAs) typically move into a more automated model of deployment as their Azure estate and experience grows.

## Azure DevOps

In Azure DevOps, deployments are carried out using Azure Pipelines. Azure Pipelines are a fully featured continuous integration and continuous delivery service (CI/CD), which allows you to automate the build, testing, and deployment of your code. You can deploy Azure resources using Azure Resource Manager templates in two ways... The first method calls a PowerShell script as shown above. The second approach defines tasks that stage your artifacts (the templates themselves and any required secrets) and then deploys the templates. One task stages the artifacts and the other tasks deploys the templates.

## Continuous integration

Continuous integration is a development methodology that focused on making small changes to code and frequent code check-ins to the version control system. Continuous integration provides an automated way to build, package, and test applications. Having the framework in place facilitates more frequent check-ins, and allows better collaboration between developers, with the goal of improving code quality. Continuous delivery builds on the continuous integration and automates the delivery of code changes to the underlying infrastructure.
