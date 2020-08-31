
Azure Arc expands the support to resources that run outside of Azure. This means that a Windows Server or Linux server that's running in Contoso's on-premises datacenter can be registered with Resource Manager and presented as a compute resource to the fabric controller. Contoso can also apply this capability to any server that's running Windows Server or Linux that's hosted by another cloud provider.

## Deploy Azure Arc to on-premises servers

Before a server can register, you must install the Azure Connected Machine agent on each of the operating systems that are targeted for Resource Manager-based management. The agent for Windows Server implements as a Windows Installer (.msi file), which is available from the Microsoft Download Center.

> [!TIP]
> Download the Azure Connected Machine agent for Windows from the [Microsoft Download Center](https://aka.ms/AzureConnectedMachineAgent?azure-portal=true).

For smaller-scale deployments, you can use the onboarding script that's available on the Azure portal.

:::image type="content" source="../media/gen-script.png" alt-text="Screenshot that depicts the Select a method blade of the Azure Arc Machines node. Two options are available: Add machines using an interactive script and Add machines at scale." border="false":::

### Azure Arc for servers agent

The Azure Arc for servers agent enables you to manage both Windows and Linux computers that you host on-premises or with another cloud provider. The Azure Connected Machine agent currently supports the following versions of the Windows and Linux operating systems:

- Windows Server 2012 R2 and later, including Server Core installations.
- Ubuntu 16.04 and 18.04 (x64)
- CentOS Linux 7 (x64)
- SUSE Linux Enterprise Server 15 (x64)
- Red Hat Enterprise Linux 7 (x64)
- Amazon Linux 2 (x64)

### Permissions

To onboard and manage machines in Azure Arc, you must have certain minimal Azure permissions, described in the following table.

|Ability|Permission requirement|
|-----------------------------------------------|------------------------------------------------------------|
|Onboard machines|Member of the Azure Connected Machine Onboarding role|
|Read, modify, re-onboard, and delete a machine|Member of the Azure Connected Machine Resource Administrator role|

> [!NOTE]
> These are the minimum permissions required. Other role holders, such as contributors and administrators of the resource, resource group or subscription can also perform these actions. 

### Installation process

You can install the agent in two ways:

- By manually running the **AzureConnectedMachineAgent.msi** Windows Installer package.
- By using a script from a PowerShell session.

The installation creates folders, services, and variables during installation.

> [!NOTE]
> The Azure Connected Machine agent sends a heartbeat message to the Azure Arc service every five minutes. If the Azure Arc service stops receiving heartbeat messages from the connected machine, it considers it offline. The machine is then marked as **Disconnected** until heartbeats resume, at which time the machine is marked as **Connected**.

### Use a script method to onboard a server

One way to onboard a server is to generate and download a script from the Azure portal. 

:::image type="content" source="../media/gen-script2.png" alt-text="Screenshot that depicts the Generate script page with a Windows PowerShell script on it." border="false":::

After you have generated and downloaded the script, you must install it. On servers that you want to onboard, sign in as a local administrator on Windows Server; for Linux, sign in as **sudo**. Then run the downloaded script.

When you run the script on target computers, the script downloads the Azure Arc agent, installs it, and onboards the server. The script prompts you to authenticate to the target Azure subscription where the corresponding resources will be created. You must also enter a generated security code.

In larger environments, you can use the Desired State Configuration (DSC) management platform in PowerShell and an Azure AD principal to perform the installation and registration in an unattended manner.

When you onboard a server, it becomes a connected machine and is represented by a corresponding Azure resource. That resource has a unique **resource ID** property. It belongs to a resource group inside a subscription, and it can benefit from Resource Manager-based mechanisms such as Azure Policy and tags.

:::image type="content" source="../media/onboard.png" alt-text="Screenshot that depicts the Machines - Azure Arc page in the Azure portal. A single computer, ContosoVM1, is listed." border="false":::
