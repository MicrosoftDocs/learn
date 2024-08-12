Fabrikam Residences is interested in automatically applying Azure best practices for their Azure VMs, and for their servers in other clouds and on-premises. In this unit, you learn how Azure Automanage can be used to click, set, and forget servers anywhere.

> [!CAUTION]
> On 31 August 2024, both Automation Update Management and the Log Analytics agent it uses will be retired. Migrate to Azure Update Manager before that. Refer to guidance on migrating to Azure Update Manager [here](/azure/update-manager/guidance-migration-automation-update-management-azure-update-manager?WT.mc_id=Portal-Microsoft_Azure_Automation).

## Overview of Azure Automanage

Azure Automanage machine best practices is a service that discovers, onboards, and configures certain services in Azure that would benefit your virtual machine, so that you don't have to. These services are Azure best practices services, helping enhance reliability, security, and management for Arc-enabled servers.

Azure Automanage machine best practices can be readily applied to Azure Arc-enabled servers to:

- Intelligently onboard servers to select best practices Azure services.
- Automatically configure each service per Azure best practices.
- Support customization of best practice services.
- Monitor for drift and correct for it when drift is detected.

## Participating services

These Azure services are automatically onboarded for you when you use Automanage machine best practices on an Azure Arc-enabled server:

- **Machine Insights Monitoring** Azure Monitor for machines monitors the performance and health of your virtual machines, including their running processes and dependencies on other resources.
- **Update Management** You can use Update Management in Azure Automation to manage the operating system updates for your machines. You can quickly assess the status of available updates on all agent machines and manage the process of installing required updates for servers.
- **Change Tracking and Inventory** Combines change tracking and inventory functions to allow you to track virtual machine and server infrastructure changes. The service supports change tracking across services, daemons software, registry, and files in your environment to help you diagnose unwanted changes and raise alerts. Inventory support allows you to query in-guest resources for visibility into installed applications and other configuration items.
- **Azure Guest Configuration** Guest Configuration policy is used to monitor the configuration and report on the compliance of the machine. The guest configuration service installs the Azure Compute security baseline in audit-only mode.
- **Azure Automation Account** Azure Automation supports management throughout the lifecycle of your infrastructure and applications.
- **Log Analytics Workspace** Azure Monitor stores log data in a Log Analytics workspace. This workspace is an Azure resource and a container where data is collected, aggregated, and serves as an administrative boundary.

## Onboarding Arc-enabled servers to Azure Automanage

You can onboard Arc-enabled servers to Automanage directly from Azure portal, through Azure Policy, or with an ARM template.

To onboard in Azure portal, search for and select **Automanage – Azure machine best practices**. From there, you can select which VMs and Azure Arc-enabled servers to onboard, and select their configuration profiles with specific best practices.

To onboard servers at scale to Azure Automanage, you can use the built-in Azure Policy Configure virtual machines to be onboarded to Azure Automanage. Finally, you can use an ARM template to onboard your specified Azure Arc-enabled server to Azure Automanage.

Across Azure portal, Azure Policy, and ARM templates, there are versatile ways to onboard your Azure Arc-enabled servers to Azure Automanage best practices.
