Your organization is using Azure Virtual Desktop to provide your workforce access to virtualized desktops and apps. Because of the sensitive data your organization works with and your organization's network security requirements, you can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You decided to deploy Azure Firewall to limit outbound network traffic for Azure Virtual Desktop.

You completed the following steps to deploy Azure Firewall to protect an Azure Virtual Desktop session host VM.

**Step 1: Set up the network**

- Created a hub virtual network that includes a subnet for the firewall deployment.
- Peered the hub virtual network with the virtual network used by Azure Virtual Desktop.  

**Step 2: Deployed Azure Firewall**

- Deployed Azure firewall to a subnet in the hub virtual network.
- For outbound traffic, created a default route that sends traffic from all subnets to the firewall's private IP address.

**Step 3: Created Azure Firewall rules**

- Configured the firewall with rules to filter inbound and outbound traffic for the host pool.

[!include[](../../../includes/azure-subscription-cleanup.md)]

## Learn more

- [Connect virtual networks with virtual network peering using PowerShell](/azure/virtual-network/tutorial-connect-virtual-networks-powershell)
- [Virtual network peering overview](/azure/virtual-network/virtual-network-peering-overview)
- [How to use Microsoft Edge command-line options to configure proxy settings](/deployedge/edge-learnmore-cmdline-options-proxy-settings)