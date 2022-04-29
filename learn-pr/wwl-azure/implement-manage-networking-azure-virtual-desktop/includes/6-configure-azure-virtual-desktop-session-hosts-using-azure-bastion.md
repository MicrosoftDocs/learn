Microsoft Bastion provides secure connectivity to all VMs in a virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

Before you begin, verify that you have met the following criteria:

 -  A VNet with the Bastion host already installed. Make sure that you have set up an Azure Bastion host for the virtual network in which the VM is located. Once the Bastion service is provisioned and deployed in your virtual network, you can use it to connect to any VM in the virtual network.
 -  A Windows virtual machine in the virtual network.
 -  The following required roles:
 -  Reader role on the virtual machine.
 -  Reader role on the NIC with private IP of the virtual machine.
 -  Reader role on the Azure Bastion resource.

To connect to the Windows VM, you must have the following port open on your Windows VM:

 -  Inbound ports: RDP (3389).

## Connect

1.  Open the Azure portal. Navigate to the virtual machine that you want to connect to, then select **Connect**. Select **Bastion** from the dropdown.:::image type="content" source="../media/azure-virtual-desktop-connect-to-bastion-71d12fde.png" alt-text="Select Bastion.":::
    

2.  After you select Bastion from the dropdown, a side bar appears that has three tabs: RDP, SSH, and Bastion. Because Bastion was provisioned for the virtual network, the Bastion tab is active by default. Select **Use Bastion**.:::image type="content" source="../media/azure-virtual-desktop-activate-connection-to-bastion-2308246b.png" alt-text="Select Use Bastion.":::
    

3.  On the **Connect using Azure Bastion** page, enter the username and password for your virtual machine, then select **Connect**.:::image type="content" source="../media/azure-virtual-desktop-authenticate-bastion-8a50037b.png" alt-text="Connect to Bastion.":::
    

4.  The RDP connection to this virtual machine via Bastion will open directly in the Azure portal (over HTML5) using port 443 and the Bastion service.:::image type="content" source="../media/azure-virtual-desktop-remote-desktop-protocol-bastion-85af324e.png" alt-text="Connect using port 443.":::
    
