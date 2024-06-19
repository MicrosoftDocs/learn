> [!CAUTION]
> This article references CentOS, a Linux distribution that is nearing End Of Life (EOL) status. Please consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

Azure Arc expands the support for Azure Resource Manager to resources running outside of Azure. This means that a physical server or a VM running in an on-premises datacenter can be registered with Azure Resource Manager and presented as a compute resource to the fabric controller. This applies to any server running the Windows Server or Linux server in an on-premises datacenter or hosted by a third-party cloud provider.

## Deploy Azure Arc to on-premises computers

Before the physical server or VM can register, you must install the Azure Connected Machine agent on each of the operating systems targeted for Azure Resource Manager-based management. The agent for Windows Server is implemented as a Microsoft Windows Installer (.msi), which is available from the Microsoft Download Center.

> [!TIP]
> Download the Azure Connected Machine agent from the [Microsoft Download Center](https://aka.ms/AzureConnectedMachineAgent?azure-portal=true).

For smaller-scale deployments, you can use the onboarding script available directly from the Azure portal.

:::image type="content" source="../media/m14-generate-script-bac9e06c.png" alt-text="A screenshot of the Select a method page of the Azure Arc Machines node. Two options are available: Add machines using an interactive a script, and Add machines at scale.":::


### Azure Connected Machine agent

The Azure Connected Machine agent enables you to manage Windows and Linux machines hosted on-premises or with another cloud provider. The Azure Connected Machine agent officially supports the following versions of the Windows and Linux operating systems:

 -  Windows Server 2008 R2 SP1, 2012 R2, 2016, 2019, and 2022
 -  Azure Stack HCI
 -  Ubuntu 16.04, 18.04, and 20.04 LTS (x64)
 -  CentOS Linux 7 and 8 (x64)
 -  SUSE Linux Enterprise Server (SLES) 12 and 15 (x64)
 -  Red Hat Enterprise Linux (RHEL) 7 and 8 (x64)
 -  Amazon Linux 2 (x64)
 -  Oracle Linux 7 (x64)

### Permissions

To onboard and manage machines to Azure Arc-enabled servers, you must have the respective Azure permissions described in the following table.

:::row:::
  :::column:::
    **Role**
  :::column-end:::
  :::column:::
    **Ability**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Connected Machine OnboardingOnboard machines
  :::column-end:::
  :::column:::
    Onboard machines
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Connected Machine Resource Administrator
  :::column-end:::
  :::column:::
    Read, modify, and delete a machine
  :::column-end:::
:::row-end:::


### Installation process

Deploy at ease, selecting from a range of onboarding methods:

 -  Using a single server deployment script generated from Azure portal
 -  Using an at scale service principal based deployment script generated from Azure portal
 -  Using PowerShell script or PowerShell remoting
 -  Using a Configuration Manager script for a collection of devices
 -  Using a Configuration Manager custom task sequence for a collection of devices
 -  Using Group Policy for an organizational unit or domain
 -  Directly from Azure Portal through Automation Update Management
 -  Directly from Windows Admin Center

The installation creates a number of folders, Windows services, and environment variables during installation. These changes are detailed in the following table.

:::row:::
  :::column:::
    **Object type**
  :::column-end:::
  :::column:::
    **Details**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Folders
  :::column-end:::
  :::column:::
    `C:\Program Files\AzureConnectedMachineAgent`, `%ProgramData%\AzureConnectedMachineAgent`, `%ProgramData%\AzureConnectedMachineAgent\Tokens`, `%ProgramData%\AzureConnectedMachineAgent\Config`, `%SystemDrive%\Program Files\ArcConnectedMachineAgent\ExtensionService\GC`, `%ProgramData%\GuestConfig`, `%SystemDrive%\AzureConnectedMachineAgent\ExtensionService\downloads`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Services
  :::column-end:::
  :::column:::
    Azure Hybrid Instance Metadata Service and Guest Configuration Service
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Variables
  :::column-end:::
  :::column:::
    IDENTITY\_ENDPOINT (value: `http://localhost:40342/metadata/identity/oauth2/token`) and IMDS\_ENDPOINT (value `http://localhost:40342`)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local security group
  :::column-end:::
  :::column:::
    Hybrid agent extension applications
  :::column-end:::
:::row-end:::


> [!NOTE]
> The Azure Connected Machine agent sends a heartbeat message to the Azure Arc service every 5 minutes. If the Azure Arc service stops receiving heartbeat messages from the connected machine, it considers it offline. The machine is then marked as **Disconnected** until heartbeats resume, at which time the machine is marked as **Connected**.

### Using a PowerShell Script method to onboard a machine

A typical way to onboard a computer is to generate and download a Windows PowerShell script from the Azure portal. To generate the script, use the following procedure:

1.  In the Azure portal, search for **Azure Arc**, and then from the returned list, select **Azure Arc**.
2.  In Azure Arc, select **Servers** from the left navigation bar.
3.  On the **Azure Arc \| Servers** page, select **+ Add**.
4.  On the **Add servers with Azure Arc** page, select **Generate script under Add a Single server**.
5.  On the **Prerequisites** section of the **Add servers with Azure Arc** page, review the **Prerequisites** and then select **Next**.
6.  On the **Resource details** section of the **Add servers with Azure Arc** page, select the following information, and then select **Next**.
    
     -  Subscription
     -  Resource group
     -  Region
     -  Operating system
     -  Optionally, proxy server URL

:::image type="content" source="../media/m14-generate-script-4-24b1b904.png" alt-text="m14-generate-script-4.png":::


1.  On the **Tags** section of the **Add servers with Azure Arc** page, add Tags and select **Next**.
2.  On the **Download and run script** section of the **Add servers with Azure Arc** page, select **Download**.
3.  Sign in as a local administrator on computers that you want to onboard, and then run the downloaded script.

When you install the script on target computers, the script downloads the Azure Arc agent from the Microsoft Download center, installs the agent on the server, and then creates an Azure Arc-enabled server resource to associate with the agent.

The script prompts you to authenticate the target Azure subscription. You must also enter a generated security code and may need to verify your request with multifactor authentication.

:::image type="content" source="../media/m14-onboard-1-a668975c.png" alt-text="A screenshot of the Administrator: Windows PowerShell window with the installation script running. The administrator is entering a security code to confirm their intention to onboard the machine.":::


> [!NOTE]
> Computers will all be assigned to the same subscription, resource group, and Azure region.

In larger environments, you can use the remote PowerShell scripting or a service principal l to perform the installation and registration in an unattended manner. Alternatively, you can automate the deployment using Configuration Manager or Group Policy.

When you onboard a hybrid machine to Azure Arc-enabled servers, it becomes a connected machine and is represented by a corresponding Azure resource. That resource has a unique Resource ID property. It belongs to a resource group inside a subscription, and it can benefit from Azure Resource Manager-based mechanisms such as Azure Policy and tags.

:::image type="content" source="../media/m14-onboard-2-931e0b22.png" alt-text="A screenshot of the Machines - Azure Arc page in the Azure portal. A single computer, ContosoVM1, is listed.":::
