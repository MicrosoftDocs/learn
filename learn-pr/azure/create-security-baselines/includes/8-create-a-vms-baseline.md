Azure Policy is a service in Azure that you use to create, assign, and manage policies. These policies enforce different rules and effects over your resources, so those resources stay compliant with your corporate standards and service level agreements. Azure Policy meets this need by evaluating your resources for non-compliance with assigned policies. For example, you can have a policy to allow only a certain SKU size of virtual machines in your environment. Once this policy is implemented, new and existing resources are evaluated for compliance. With the right type of policy, existing resources can be brought into compliance.

## Azure networking security recommendations

Here are the security recommendations you should follow to set Virtual Machine (VM) policies on your Azure subscription. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps on your own subscription with your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### A VM agent must be installed and enabled for data collection for Azure Security Center - Level 1

Azure Security Center enables you to see which VMs require the VM Agent and will recommend that you enable the VM Agent on those VMs. The VM Agent is installed by default for VMs that are deployed from the Azure Marketplace. Data is needed to assess the VM security state, provide security recommendations, and alert on host-based threats.

1. Sign in to the Azure portal.

1. Select **Security Center**, and then select **Pricing & settings**.

1. Select the subscription.

1. Select **Data Collection**.

1. Slide the **Auto Provisioning** slider to **On**.

1. Select a Workspace to use.

1. Select **Save**.

![Screenshot ASC Auto provisioning pane](../media/8-auto.png)

### Ensure that OS disk are encrypted - Level 1

Azure Disk Encryption helps protect and safeguard your data to meet your organizational security and compliance commitments. It uses the BitLocker feature of Windows and the DM-Crypt feature of Linux to provide volume encryption for the OS and data disks of Azure virtual machines (VMs). It is also integrated with Azure Key Vault to help you control and manage the disk encryption keys and secrets, and ensures that all data on the VM disks are encrypted at rest while in Azure storage. Azure Disk Encryption for Windows and Linux VMs is in General Availability in all Azure public regions and Azure Government regions for Standard VMs and VMs with Azure Premium Storage.

If you use Azure Security Center (recommended), you're alerted if you have VMs that aren't encrypted.

1. Sign in to the Azure portal.

1. Go to the **Virtual machines** pane.

1. For each VM, go to **Settings**.

1. Select **Disks**.

1. Ensure that the **OS disk** has encryption set to **Enabled**.

1. Ensure that each disk under **Data disks** has encryption set to **Enabled**.

![Screenshot VM disk encryption pane](../media/8-asc-disk-encryption.png)

### Ensure only approved extensions are installed - Level 1

Azure virtual machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or to run a script inside of it, a VM extension can be used. Azure VM extensions can be run with the Azure CLI, PowerShell, Azure Resource Manager templates, and the Azure portal. Extensions can be bundled with a new VM deployment, or run against any existing system.

1. Sign in to the Azure portal.

1. Go to the **Virtual machines** pane.

1. For each VM, go to **Settings**.

1. Select **Extensions**.

1. Ensure that the listed extensions are approved for use.

![Screenshot of VM Extensions pane](../media/8-extensions.png)

### Ensure that the OS patches for the VMs are applied - Level 1

Azure Security Center monitors daily Windows and Linux virtual machines (VMs) and computers for missing operating system updates. Security Center retrieves a list of available security and critical updates from Windows Update or Windows Server Update Services (WSUS), depending on which service is configured on a Windows computer. Security Center also checks for the latest updates in Linux systems. If your VM or computer is missing a system update, Security Center will recommend that you apply system updates.

1. Sign in to the Azure portal.

1. Select **Security Center**. The Security Center - Overview opens.

1. Go to **Security Center - Recommendations**.

1. Ensure that there are no recommendations for **Apply system updates**.

![Screenshot of ASC Recommendations pane](../media/8-asc-recommend.png)

### Ensure that VMs have an installed and running endpoint protection solution - Level 1

Azure Security Center monitors the status of antimalware protection and reports this under the Endpoint protection issues pane. Security Center highlights issues, such as detected threats and insufficient protection, which can make your virtual machines (VMs) and computers vulnerable to antimalware threats. By using the information under Endpoint protection issues, you can identify a plan to address any issues identified.

1. Use the same process as described in the previous recommendation.

> [!TIP]
> Remember to select **Save** if you make changes to any of the settings.
