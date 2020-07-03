## Governance for Managed Service Provides with Azure Arc and Azure Lighthouse

Lamna Healthcare is about to refocus their efforts on growing their business. They have been very impressed with the way that Relecloud has managed their existing Azure resources and assets.  In order to free up resources, they want Relecloud to take over the management of their on-premises resources. This would be in addition to management of their existing Azure resources.  You are aware of a service in Azure called Azure Arc. You’ll need to explore the capabilities of Azure Arc to see how it can be used to meet Lamna Healthcare’s new requirements. Finally, you’ll see how you can leverage Azure Arc within your existing Azure Lighthouse service offering.

:::image type="content" source="../media/6-azure-arc-range.png" alt-text="Diagram showing the range and extent of Miscrosoft Azure Arc":::

## Understand Azure Arc

Presently Relecloud uses Azure delegated resource management to manage Lamna Healthcare’s existing Azure resources. In order to extend that capability to manage Lamna Healthcare’s on-premises servers requires using Azure Arc. Azure Arc extends the capabilities of Azure Azure delegated resource management to enable Relecloud to service  Windows and Linux servers whether they are hosted on-premises at Lamna Healthcare, or in the cloud.

Azure Arc for servers (preview) will let Lamna Healthcare manage any Windows and Linux machines hosted outside of Azure on their corporate network, in the same way they manage native Azure virtual machines. By connecting an on-premises machine to Azure, it becomes a connected machine and is treated as a resource in Azure.

With Azure Arc Lamna Healthcare can:

- **Organize and govern across environments** – Centrally manage, organize and govern Kubernetes clusters, databases,     and servers across on-premises, edge and multi-cloud environments
- **Manage Kubernetes Apps at scale** – Manage and deploy Kubernetes applications across any environment     using DevOps techniques.
- **Run data services anywhere** - Get automated upgrades, and patches. Scale on-demand needs across     all environments for all their data estate.

By creating a single control plane, Lamna Healthcare can extend its existing Azure native operations and governance to resources that exist outside of Azure.

:::image type="content" source="../media/6-azure-arc-govenance.png" alt-text="Screenshot showing Azure Arc connected machines":::

### Using the Azure Connected Machine Agent

In order for Lamna Healthcare’s on-premises servers to be available on their Azure tenant, a Lamna Healthcare administrator will need to install the Azure Connected Machine Agent on each machine they plan to project into their Azure tenant. The Connected Machine Agent works alongside other Azure Agents that you may have installed on the target machine, and provides:

- The ability to manage policy configurations in a similar way to Azure virtual machines.
- The ability to store log data collected from the Log Analytics agent, in the workspace where the machine has been registered.

The Connected Machine agent sends an update every five minutes to the Azure tenant it is registered to.

### Generating the Connected Machine agent installation script

There are two ways the Lamna Healthcare administrator can install the Connected Machine Agent on the target machine. The first is to manually download the application and configure it on each machine. The alternative is to use an automated approach, by using a template script, to download and install the agent. For now, you’ll look at how generate an automated installation script.

> [!NOTE]
> You’ll need to have administrator permissions on the target machine in order to install and configure the agent. For Windows machines, you’ll need to be am member of the Local Administrators group. On Linux, you’ll need to use the root account.

Azure can create the script needed to onboard each server, depending on whether you have Windows or Linux servers, Kubernetes clusters, or other cloud services.

Let’s look at how Lamna Healthcare will add a Windows based on-premises server into their Azure tenant.

1. Sign in to the **Azure Portal**.
1. Navigate to the **Machines – Azure Arc** pane.
1. Select Add. This will present you with three choices.
   - Add machines using an interactive script
   - Add machines at scale
   - Add update management machines
1. Select **Add machines using an interactive script**.
1. Next, you’ll need to provide details regarding the subscription:
   - Supply the subscription type that you want to use for these on-premises resources.
   - Create or select an existing resource group. You can add these new resources to an existing resource group, but equally you may want to have them in a dedicated resource group, especially if you plan to use a service provider to manage them for you at some point later.
   - Add a region, which should be the closest to your Azure instance.
   - Next, select the operating system for the server you’ll want to onboard. Your choices are: Windows and Linux. In this case, select **Windows**.
1. Select **Review and** **Generate**.
1. Select **Download**.

At this stage the Azure Portal will generate the script you’ll use to onboard the machine, projecting it into your Azure tenant. Lamna Healthcare can download this script to a local device. Once you have a script for a Windows or Linux server, it can be used for all servers of that type.

- For Windows machines, the generated script will be a PowerShell script, called OnboardingScipt.ps1.
- For Linux machines, the generated script will be a bash script.

For more information on how to manually install the Connected Machine agent on a target machine, see [onboarding non-Azure machines using Azure Arc.](https://docs.microsoft.com/azure/azure-arc/servers/onboard-portal)[[AA5\]](#_msocom_5).

### Installing the Connected Machine agent on a Windows server

Now the Lamna Healthcare administrator has created the installation script, they will use it to install the Connected Machine agent on the target server.  The installation script must be accessible to the target machine.

> [!NOTE]
> To install or uninstall the Connected Machine agent, you must have Administrator permissions on the target machine.

1. Log into the target server
1. Copy the generated installation script to a folder on the server
1. Open an Elevated PowerShell command prompt.
1. Navigate to the folder where the installations script was stored at step 2.
1. Execute this command: **./OnboardingScript.ps1**

The agent will be downloaded and automatically configured on the server.

After installing the agent, you need to configure the agent to communicate with the Azure Arc service by running the following command:

```PowerShell
"%ProgramFiles%\AzureConnectedMachineAgent\azcmagent.exe" connect --resource-group "<resourceGroupName>" --tenant-id "<tenantID>" --location "<regionName>" --subscription-id "<subscriptionID>"
```

### Verify the connection with Azure Arc

After the Lamna Healthcare administrator has installed the agent and configure it to connect to Azure Arc for servers (preview), they can go to the Azure portal to verify that the server has been successfully connected.

:::image type="content" source="../media/6-azure-arc-non-azure-machines.png" alt-text="Screen shot from Azure Portal showing the non-azure connected machines":::

## Using Azure Lighthouse with Azure Arc Connected Machines

Now that Lamna Healthcare have added all their non-Azure machines to Azure Resource Manager in their tenant, Relecloud is in a position to manage them. Relecloud administrators will create a service offer to Lamna Healthcare to manage the non-Azure resource groups. As soon as Lamna Healthcare approve the service, Relecloud will be able to manage them in the same way that they manage Azure VMs.

:::image type="content" source="../media/6-azure-portal-connected-machines.png" alt-text="Screenshot showing Azure and Azure Arc resources":::

It is easy to identify each non-Azure device from the available resources, as their type is suffixed with Azure Arc, for example Machine – Azure Arc.

## Governance through Azure Policy

Now that Lamna Healthcare’s Azure virtual machines and non-Azure servers are projected into Relecloud Azure tenant, they can use Azure Policy to enforce organizational standards. Using the Azure Policy compliance dashboard, Relecloud staff members can evaluate the overall state of the environment. They can drill-down and get per-resource, and per-policy granularity. In addition, Relecloud can ensure resource compliance through bulk remediation for existing resources and automatic remediation for the new non-Azure resources.

For more information on Azure Policy see this link: [Governance policy overview](https://docs.microsoft.com/en-us/azure/governance/policy/overview)