Manually executing environment provisioning and configuration management is laborious and error-prone. **Azure DevOps** advocates automation to reduce the probability of errors introduced through manual execution. Automation also completes work more quickly without relying on subject matter experts.

**Azure** is built to support automation. **Azure Automation** is an **Azure service** that provides a way to automate manual, long-running, error-prone, and frequently repeated tasks commonly done in cloud and enterprise environments.

**Azure Automation** saves time and increases the reliability of regular administrative tasks. You can schedule tasks to be executed automatically at regular intervals. You can automate processes using **runbooks** or automate configuration management by using **Desired State Configuration (DSC)**.

For more information about **Azure Automation**, review [An introduction to Azure Automation](/azure/automation/).

:::image type="content" source="../media/azure-automation-90cfa135.png" alt-text="Azure Automation icon":::

## Azure Automation capabilities

**Azure Automation** isn't the only way to automate within **Azure**. You can also use open-source tools for some operations. However, the integration capabilities available to **Azure Automation** remove much of the integration complexity you would have to manage if you did these operations manually.

**Azure Automation** provides the following capabilities:

- **Process automation:** Automate frequent, time-consuming, and error-prone cloud management tasks.
- **Azure Automation State Configuration:** An **Azure service** that allows you to write, manage, and compile **Windows PowerShell DSC** configurations, import **DSC Resources**, and assign configurations to target nodes in the cloud. For more information, visit [Azure Automation State Configuration Overview](/azure/automation/automation-dsc-overview).
- **Azure Update Manager:** Manage operating system updates for **Windows** and **Linux** computers in **Azure**, on-premises environments, or other cloud providers. Get update compliance visibility across **Azure**, on-premises, and other cloud services. You can create scheduled deployments to orchestrate update installations within a defined maintenance window. For more information, visit [Azure Update Manager](/azure/update-manager/overview).
- **Source control integration:** Integrate with **GitHub**, **Azure DevOps**, **Git**, or **Team Foundation Version Control** repositories. For more information, go to [Source control integration in Azure Automation](/azure/automation/source-control-integration).
- **AWS automation:** Automate common tasks with resources in **Amazon Web Services (AWS)** using **Automation runbooks** in **Azure**. For more information, go to [Authenticate Runbooks with Amazon Web Services](/azure/automation/automation-config-aws-account).
- **Shared resources:** **Azure Automation** includes a set of shared resources (such as **connections**, **credentials**, **modules**, **schedules**, and **variables**) that make it easier to automate and configure your environments at scale.
- **Backup automation:** Run regular backups of non-database systems, such as backing up **Azure Blob Storage** at specific intervals.

**Azure Automation** works across hybrid cloud environments in addition to **Windows** and **Linux** operating systems.

This module describes **Azure Automation** with **Azure DevOps**, using **runbooks**, **webhooks**, and **PowerShell workflows**. You'll learn how to create and manage automation for your environment.

## Learning objectives

After completing this module, you'll be able to:

- **Create and configure Azure Automation accounts:** Set up automation accounts to store runbooks, jobs, and automation assets.
- **Implement and manage runbooks:** Create and manage runbooks using **PowerShell**, **PowerShell Workflow**, **Python**, and graphical editors.
- **Configure webhooks:** Set up webhooks to trigger runbooks from external systems and services.
- **Integrate with source control:** Connect **Azure Automation** with **GitHub** and **Azure DevOps** for version control and CI/CD.
- **Create PowerShell workflows:** Build workflows with checkpoints and parallel processing for resilience and performance.
- **Plan hybrid management:** Implement automation across **Azure** and on-premises resources using **Hybrid Runbook Workers**.

## Prerequisites

- Understanding of **DevOps** concepts and practices.
- Familiarity with **PowerShell** scripting and command-line interfaces.
- Basic knowledge of **Azure services** and resource management.
- Experience with version control systems (**Git** or **Team Foundation Version Control**).
