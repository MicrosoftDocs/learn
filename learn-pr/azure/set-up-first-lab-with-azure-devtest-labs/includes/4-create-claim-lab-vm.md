A lab VM is powerful because it provides a quick and repeatable way to spin up a pre-configured virtualized computing environment. You can use Azure DevTest Labs to add virtual machines (VMs) that are preconfigured with required software components.

Your eCommerce company has a large and expanding development team, and you need to use Azure DevTest Labs to create a pool of standardized developer VMs. The developers will access these VMs through Remote Desktop (RDP).

In this unit, you'll learn about adding VMs to an existing lab in Azure DevTest Labs, and how to pre-install software on them. You'll also be introduced to claiming and accessing a lab VM.

## Create a lab VM

A lab in Azure DevTest Labs doesn't contain any computing resources. You can add VMs to an existing lab that lab users can then use to perform their tasks.

When you add a VM to a lab, Azure DevTest Labs creates and manages all the underlying resources for hosting an Azure Virtual Machine (for example: an Azure storage account, IP address, load balancer, and more). As a lab owner, you don't have to manage this infrastructure.

There are several ways to create a lab VM in Azure DevTest Labs. You can use the Azure portal, the Azure Command Line Interface (CLI), a PowerShell script, or an ARM template.

The first step to create a lab VM is to select one of the available VM base images in the lab. In the previous unit, you've specified a list of allowed images from the Azure Marketplace.

When the virtual machine finishes provisioning, you can then connect and start using the VM. For Windows VMs, you can use a remote desktop (RDP) client; for Linux machines, you can start a secure shell (SSH) connection.

The Azure portal provides a wizard to add a VM to an existing lab. This wizard contains the following fields to configure the virtual machine:

|Field  |Description  |
|---------|---------|
|Virtual machine name     | A unique name for the virtual machine.        |
|User name     | The name of the user to connect to the virtual machine. This user is granted administrator privileges on the VM.        |
|Use a saved secret     | Allows you to use a secret from Azure Key Vault for the password.        |
|Password     | The user password for logging into the VM.        |
|Save as default password     | Allows you to save the password in Azure Key Vault.        |
|Virtual machine size     | The VM size determines the amount of compute resources like CPU, GPU, and memory that are available to the VM. You can limit the number of available options in the lab.        |
|OS disk type     | Azure VMs use managed disks, which are like physical disks but virtualized. The OS disk type determines the performance of the VM operating system disk.     |
|Artifacts     | Add or remove artifacts to the lab VM. Artifacts are used to deploy and configure your application after the VM is provisioned. |

## Add a VM to a lab

When you add a lab VM, Azure DevTest Labs starts the virtual machine and automatically assigns ownership to you. In the Azure portal, you'll see the virtual machine in **My virtual machines**. In this case, you've automatically *claimed* the virtual machine by creating it.

You can also create a **claimable** lab VM, which is a machine without an owner. In the Azure portal, the VM appears in the **Claimable virtual machines** list.

When you claim a virtual machine, Azure DevTest Labs assigns the ownership of the VM to you and starts the VM. You then have a full range of options for that VM. You can connect to the VM, customize artifacts, restart, stop, or unclaim the machine.

Azure DevTest Labs ensures that when a user claims a VM, no one else can claim the same machine. When you're done working on your lab VM, you can unclaim it, which removes the ownership and adds the VM back to the list of **Claimable virtual machines**.

:::image type="content" source="../media/devtest-labs-claim-vm.png" alt-text="Screenshot that shows how to claim a VM in Azure DevTest Labs.":::

## Artifacts

You use artifacts to configure a VM or deploy software on it, after it's provisioned. Artifacts can be:

- Tools that you want to install on the VM, such as monitoring agents or Visual Studio.
- Actions that you want to run on the VM; for example, cloning a GitHub repository.
- Applications that you want to run and test.

During the creation of a lab VM, you can specify which artifacts you want to add to it. When the VM finishes provisioning, Azure DevTest Labs installs the artifacts on the VM. If you've claimed a VM, you can add or remove artifacts at any time during the lifetime of the VM.

In your eCommerce company, you could use an artifact to install **Azure PowerShell** or developer tools to the developer lab VM. This way, you avoid making every developer go through the process of manually installing these tools.

:::image type="content" source="../media/devtest-labs-add-artifacts-blade-selected-artifacts.png" alt-text="Screenshot that shows how to add an artifact to a lab VM in Azure DevTest Labs.":::

If you want to enforce that a particular artifact is installed on all lab VMs, for example a monitoring agent, you can specify **mandatory artifacts** when you configure the lab. Azure DevTest Labs will then install these artifacts across all VMs in a lab.

Azure DevTest Labs artifacts are available in the public DevTest Labs GitHub repository. You can also create custom artifacts and host them in a private GitHub repository. In the lab configuration, you can specify which artifact repositories are available for lab users.
