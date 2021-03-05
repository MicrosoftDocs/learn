


As the lead system engineer at Contoso, you establish a pilot to examine virtual networking in Azure, including the interaction between public and private address spaces. To implement this pilot, you must find out how to assign both private and public IP addresses during the creation of Azure resources.


## Assign an IP configuration during VM creation

When you create a VM in Azure, it automatically connects to an Azure VNet. Azure also configures the VM onto a private IPv4 subnet and assigns the VM a public IPv4 address. You can reconfigure the VNet, subnet, and public IP settings during VM creation, or later.

> [!NOTE]
> You can also choose to create an additional VNet, subnet, or public IP at this point.

![Screenshot of the Create a virtual machine page in the Azure portal. The administrator has accepted the default settings for this VM in ContosoResourceGroup. The device is attached to the ContosoResourceGroup-vnet, and is assigned onto a private IPv4 subnet. The VM also has a default public IPv4 address.](../media/m18-create-virtual-machine.png)

If you want to reconfigure the VM's network settings from the Azure portal, from the **Virtual machines** page, select the appropriate VM, and then under **Settings**, select **Networking**. You can review (and in most instances, configure) the following settings:

- IP configuration (NIC Private IP and link to NIC Public IP)
- Network Interface
- VNet/subnet
- NIC Public IP
- NIC Private IP
- Inbound port rules
- Outbound port rules
- Application security groups
- Load balancing

[![Screenshot of the Networking page for a VM called ContosoLondon1, with the following information displaying: IP configuration, Network Interface, VNet/subnet, NIC Public IP, NIC Private IP, and a summary of Inbound port rules..](../media/m18-view-network.png)](../media/m18-view-network.png#lightbox)

> [!NOTE]
> If the VM is not running, you can also attach and detach network interfaces.

You can also review the Effective security rules and Topology. From the Topology, you can review the overall map of your VNet, and select the appropriate object for reconfiguration.

[![Screenshot of the Topology page in Azure portal. The VNet topology to which the ContosoLondon1 VM is attached has the resource group at the top of a tree-like structure. Connected under the resource group is the default VNET, which in turn has three network interfaces attached to it, each of which has three VMs attached to it. Each VM has a node displayed for the VM itself, the Network Security Group assigned to it, and a node that represents the IP configuration for that VM.](../media/m18-topology.png)](../media/m18-topology.png#lightbox)

## Manage VM IP addresses

After you have created your VM or other resource, you can reconfigure the private IP address settings at any time. Use the following procedure to review or edit the private IP configuration for a VM:

1. In the Azure portal, navigate to **Virtual machines**, and then select the appropriate VM.
2. On the **Overview** page for your selected VM, select **Networking**.
3. Select the appropriate network interface.
4. Select **IP configurations**.

   [![Screenshot of the IP configuration page for a selected VM's network interface. IP forwarding settings are set to Disabled.](../media/m18-network-settings.png)](../media/m18-network-settings.png#lightbox)

5. Under the IP configurations table, select the listed entry.

   ![Screenshot of the Azure portal ipconfig1 page for a selected Azure network interface. Under Public IP address settings, the public IP address is set to Associate, and under Private IP address settings, Assignment is set to Dynamic.](../media/m18-configurate-network-1.png)

6. If you want to remove the public IP address from the resource, under **Public IP address settings**, select **Disassociate**.
7. If you want to change the public IP address configuration, under **Public IP address settings**, select **IP address**.
8. On the **Choose public IP address** page, select **Create new**.

   ![Screenshot of the Create public IP address page for ipconfig1. The SKU is Basic and the Assignment is Dynamic. ](../media/m18-configurate-network-2.png)

9. Enter a new name, choose the SKU and Assignment methods, and then select **OK**.
10. Under **Private IP address settings**, you can change the assignment from **Dynamic** to **Static**. If you switch from **Dynamic**, the Static address defaults to the same IP address that was dynamically assigned, although you can change it.
11. Make any changes, and then select **Save**.
