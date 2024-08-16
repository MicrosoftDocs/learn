Fabrikam Residences is struggling to automate its deployment, management, response, and orchestration of servers and VMs across its hybrid and multicloud environment. Azure Automation delivers a cloud-based automation, operating system updates, and configuration service that supports consistent management across Azure and non-Azure environments. In this unit, you learn about Azure Automation’s core capabilities.

## Overview of Change Tracking and Inventory

Change Tracking and Inventory combines functions that allow you to track Azure Arc-enabled Linux and Windows servers and server infrastructure changes. The service supports change tracking across services, daemons, software, registry, and files in your environment to help you diagnose unwanted changes and raise alerts. Inventory support allows you to query in-guest resources for visibility into installed applications and other configuration items. For example, Fabrikam Residences could use Change Tracking and Inventory to know which LOB software they're running on their servers. This visibility across on-premises and cloud estates could help when preparing for license renewals and planning updates to those apps. With Azure Arc-enabled servers, you can benefit from a consistent and comprehensive change tracking and inventory experience across Azure and non-Azure environments.

## Overview of Update Management

You can use Update Management in Azure Automation to manage the operating system updates for your Azure Arc-enabled servers. You can quickly assess the status of available updates and manage the process of installing the required updates for your machines that report to Update Management. The following diagram illustrates how Update Management assesses and applies security updates to connected Azure VMs and Arc-enabled servers.

![Diagram showing the Update Management workflow.](../media/update-management-flow.png)

## Overview of Process Automation

Process Automation in Azure Automation allows you to automate frequent, time-consuming, and error-prone management tasks. Process automation supports the integration of Azure services and other third-party systems required in deploying, configuring, and managing your end-to-end processes. The service allows you to author graphical, PowerShell, and Python runbooks. To run runbooks directly, you can deploy a Hybrid Runbook Worker directly to the Azure Arc-enabled servers.  
