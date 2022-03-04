## Scenario 1: Name resolution scoped to a single virtual network

In this scenario, you have a virtual network and resources in Azure, including virtual machines (VMs). You want to resolve the resources from within the virtual network via a specific domain name (DNS zone). You also need the name resolution to be private and not accessible from the internet. Furthermore, for the VMs within the VNET, you need Azure to automatically register them into the DNS zone.

:::image type="content" source="../media/resolution-single-zonesv2-56c8d638.png" alt-text="A VNet is shown with two VMs.VMs are querying the Azure DNS and private IP addresses are returned.":::


In the above diagram, VNET1 contains two VMs (VM1 and VM2). Each VM has a private IP address. When you create a Private Zone (contoso.lab) and link it to VNet1, Azure DNS will automatically create two A records in the zone if you enable auto registration in the link configuration. DNS queries from VM1 to resolve `VM2.contoso.lab` will receive a DNS response that contains the Private IP of VM2. And, a Reverse DNS query (PTR) for the Private IP of VM1 (10.0.0.4) issued from VM2 will receive a DNS response that contains the FQDN of VM1, as expected.

## Scenario 2: Name resolution for multiple networks

Name resolution across multiple virtual networks is probably the most common usage for DNS private zones. The following diagram shows a simple version of this scenario where there are only two virtual networks - VNet1 and VNet2.

 -  VNet1 is designated as a **Registration** virtual network and VNET2 is designated as a **Resolution** virtual network.
 -  The intent is for both virtual networks to share a common zone `contoso.lab`.
 -  The Resolution and Registration virtual networks are linked to the zone.
 -  DNS records for the Registration VNet VMs are automatically created. You can manually add DNS records for VMs in the Resolution virtual network.

:::image type="content" source="../media/resolution-multiple-zones-c3e11b8d.png" alt-text="Two VNets, VNet1 and VNet2. VNet1 has VM1 and VM2. VNet2 has VM3, VM4, and VM5. Both VNets are connected to Azure DNS with records.":::


In this configuration:

 -  **DNS queries across the virtual networks are resolved**. A DNS query from a VM in the Resolution VNet, for a VM in the Registration VNet, will receive a DNS response containing the Private IP of VM.
 -  **Reverse DNS queries are scoped to the same virtual network**. A Reverse DNS (PTR) query from a VM in the Resolution virtual network, for a VM in the Registration VNet, will receive a DNS response containing the NXDOMAIN of the VM. But, a reverse DNS query from a VM in the Resolution VNet, for a VM in the same VNet, will receive the FQDN.
