
Azure NetApp Files volumes are designed to be contained in a special purpose subnet called a delegated subnet within your Azure Virtual Network. You must delegate a subnet to Azure NetApp Files for secured access control by restricting network traffic to the assigned subnet. You can access the volumes directly from within Azure over VNet peering or from on-premises over a Virtual Network Gateway. When you create a volume, you need to specify the delegated subnet.

### Considerations

- When creating the delegated subnet for Azure NetApp Files, the size of the subnet matters. A subnet with a /28 network mask provides only 11 usable IP addresses, which might be insufficient for certain use cases. In that case, you should plan for a larger delegated subnet.
- In each VNet, only one subnet can be delegated to Azure NetApp Files. A NetApp account can deploy volumes into multiple VNets, each having its own delegated subnet.
- When using Basic network features, you can't designate a network security group (NSG) or service endpoint in the delegated subnet. Doing so causes the subnet delegation to fail.

You can add a subnet to a virtual network that you want to use for Azure NetApp Files. To create a new subnet, you need to complete the following required fields in the Add Subnet page:

1. **Name**: Specify the subnet name.
2. **Address range**: Specify the IP address range.
3. **Subnet delegation**: Select Microsoft.NetApp/volumes.

![This screenshot shows the Add subnet blade in the Azure Portal for a virtual network called my.vnet. The configuration includes Name field with anf.subnet, Address range CIDR block with 10.2.1.0/28 (providing 10.2.1.0 – 10.2.1.15), Network security group set to None, Route table set to None, and Subnet Delegation set to Microsoft.Netapp/volumes. This is a typical setup for an Azure NetApp Files (ANF) delegated subnet.](../media/managing-azure-netapp-files-register-setup/image003.png)

**Note**: You can also create and delegate a subnet when you create a volume for Azure NetApp Files.
