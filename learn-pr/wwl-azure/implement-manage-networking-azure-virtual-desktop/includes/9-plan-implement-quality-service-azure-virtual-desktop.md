This unit shows you how to securely and seamlessly create an RDP connection to your Windows VMs located in an Azure virtual network directly through the Azure portal. When you use Azure Bastion, your VMs don't require a client, agent, or more software. You can also connect to a Windows VM using SSH. For information, see [Create an SSH connection to a Windows VM](/azure/bastion/bastion-connect-vm-ssh-windows).

Azure Bastion provides secure connectivity to all of the VMs in the virtual network in which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH. For more information, see [What is Azure Bastion?](/azure/bastion/bastion-overview)

## Prerequisites

Before you begin, verify that you've met the following criteria:

 -  A VNet with the Bastion host already installed.
    
    
     -  Make sure that you have set up an Azure Bastion host for the virtual network in which the VM is located. Once the Bastion service is provisioned and deployed in your virtual network, you can use it to connect to any VM in the virtual network.
     -  To set up an Azure Bastion host, see [Create a bastion host](/azure/bastion/tutorial-create-host-portal#createhost). If you plan to configure custom port values, be sure to select the Standard SKU or higher when configuring Bastion.
 -  A Windows virtual machine in the virtual network.

### Required roles

 -  Reader role on the virtual machine.
 -  Reader role on the NIC with private IP of the virtual machine.
 -  Reader role on the Azure Bastion resource.
 -  Reader role on the virtual network of the target virtual machine (if the Bastion deployment is in a peered virtual network).

### Ports

To connect to the Windows VM, you must have the following ports open on your Windows VM:

 -  Inbound port: RDP (3389) *or*
 -  Inbound port: Custom value (you'll then need to specify this custom port when you connect to the VM via Azure Bastion)

> [!NOTE]
> If you want to specify a custom port value, Azure Bastion must be configured using the Standard SKU or higher. The Basic SKU doesn't allow you to specify custom ports.

### Rights on target VM

When a user connects to a Windows VM via RDP, they must have rights on the target VM. If the user isn't a local administrator, add the user to the Remote Desktop Users group on the target VM.

## Connect

1.  In the [Azure portal](https://portal.azure.com/), to the virtual machine that you want to connect to. On the Overview page, select Connect, then select Bastion from the dropdown to open the Bastion page. You can also select Bastion from the left pane. :::image type="content" source="../media/connect-bastion-f2511e00.png" alt-text="Screenshot of Connect for Bastion.":::
    
2.  On the Bastion page, enter the required authentication credentials, then select **Connect**. If you configured your bastion host using the Standard SKU, you'll see other credential options on this page. If your VM is domain-joined, you must use the following format: `username@domain.com`. :::image type="content" source="../media/connect-vm-host-53be19dc.png" alt-text="Screenshot of Connect button enabled for Bastion.":::
    
3.  When you select Connect, the RDP connection to this virtual machine via Bastion will open in your browser (over HTML5) using port 443 and the Bastion service. The following example shows a connection to a Windows 11 virtual machine in a new browser tab. The page you see depends on the VM you're connecting to.
    
    :::image type="content" source="../media/connection-result-bastion-new-aa3c5083.png" alt-text="Screenshot of connecting to a Windows 11.":::
    When working with the VM, using keyboard shortcut keys may not result in the same behavior as shortcut keys on a local computer. For example, when connected to a Windows VM from a Windows client, CTRL+ALT+END is the keyboard shortcut for CTRL+ALT+Delete on a local computer. To do this from a Mac while connected to a Windows VM, the keyboard shortcut is Fn+CTRL+ALT+Backspace.
