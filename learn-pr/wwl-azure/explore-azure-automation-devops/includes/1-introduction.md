Manually executing environment provisioning and configuration management is both laborious and error-prone.

Microsoft Azure DevOps advocates automation to reduce the probability of errors introduced through manual execution.

Automation also delivers the added advantage of completing the work more quickly without relying on subject experts.

Microsoft Azure is built to support automation from the ground up.

*Azure Automation* is an Azure service that provides a way for users to automate the manual, long-running, error-prone, and frequently repeated tasks commonly done in a cloud and enterprise environment.

Azure Automation saves time and increases the reliability of regular administrative tasks.

You can even schedule the tasks to be executed automatically at regular intervals.

You can automate processes using runbooks or automate configuration management by using Desired State Configuration (DSC).

For more information about Azure Automation, review [An introduction to Azure Automation](https://azure.microsoft.com/documentation/articles/automation-intro/).

:::image type="content" source="../media/azure-automation-90cfa135.png" alt-text="Azure Automation icon":::


Azure Automation isn't the only way to automate within Azure.

You can also use open-source tools to do some of these operations.

However, the integration hooks available to Azure Automation remove much of the integration complexity you would have to manage if you did these operations manually.

Some Azure Automation capabilities are:

 -  Process automation - Azure Automation provides you with the ability to automate frequent, time-consuming, and error-prone cloud management tasks.
 -  Azure Automation State Configuration - It's an Azure service that allows you to write, manage, and compile Windows PowerShell DSC configurations, import DSC Resources, and assign configurations to target nodes, all in the cloud. For more information, visit [Azure Automation State Configuration Overview](/azure/automation/automation-dsc-overview).
 -  Azure Update Manager - Manage operating system updates for Windows and Linux computers in Azure, on-premises environments, or other cloud providers. Get update compliance visibility across Azure, on-premises, and for other cloud services. You can create scheduled deployments to orchestrate update installations within a defined maintenance window. For more information, visit [Azure Update Manager](/azure/update-manager/overview).
 -  Integration with GitHub, Azure DevOps, Git, or Team Foundation Version Control repositories. For more information, go to [Source control integration in Azure Automation](/azure/automation/source-control-integration).
 -  Automate Amazon Web Services (AWS) Resources - Automate common tasks with resources in AWS using Automation runbooks in Azure. For more information, go to [Authenticate Runbooks with Amazon Web Services](/azure/automation/automation-config-aws-account).
 -  Manage Shared resources - Azure Automation consists of a set of shared resources (such as *connections*, *credentials*, *modules*, *schedules*, and *variables*) that make it easier to automate and configure your environments at scale.
 -  Run backups - Azure Automation allows you to run regular backups of non-database systems, such as backing up Azure Blob Storage at certain intervals.

Azure Automation works across hybrid cloud environments in addition to Windows and Linux operating systems.

This module describes Azure automation with Azure DevOps, using runbooks, webhooks, and PowerShell workflows.

You'll learn how to create and manage automation for your environment.

## Learning objectives

After completing this module, students and professionals can:

 -  Implement automation with Azure DevOps.
 -  Create and manage runbooks.
 -  Create webhooks.
 -  Create and run a workflow runbook and PowerShell workflows.

## Prerequisites

 -  Understanding of what DevOps is and its concepts.
 -  Familiarity with version control principles is helpful but isn't necessary.
 -  Beneficial to have experience in an organization that delivers software.
