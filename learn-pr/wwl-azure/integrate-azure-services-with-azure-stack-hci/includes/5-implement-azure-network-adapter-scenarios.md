Given the increasingly hybrid nature of Contoso's environment, it is likely that you will need to frequently establish direct connectivity between your Azure Stack HCI workloads and Azure VMs. Although Contoso has already provisioned an ExpressRoute circuit to a hub virtual network that hosts core Azure infrastructure components, there are multiple isolated virtual networks not directly accessible from the on-premises datacenter that hosts your Azure Stack HCI cluster. You also anticipate deployment of Azure Stack HCI clusters to remote locations, which won't be able to use ExpressRoute connectivity. You decide to explore the functionality of Azure Network Adapter to determine whether you can use it as a workaround.

## Overview of Azure Network Adapter

Azure Network Adapter provides a convenient method of setting up a Point-to-Site (P2S) Virtual Private Network (VPN) connection from a Windows server to an Azure virtual network. This method relies on Secure Socket Tunneling Protocol (SSTP) to create an encrypted, virtual tunnel over the Internet to an Azure virtual network gateway that uses locally installed software. Azure Network Adapter does not require a local VPN device. 

After a VPN connection is established, the primary network interface of the server that hosts the Azure Network Adapter gets assigned an IP address from the range you allocate for P2S VPN clients. At the same time, the VPN client software updates the local routing configuration, so that traffic targeting the IP address space of the Azure virtual network is routed via the VPN connection. As a result, the server effectively becomes a node on that virtual network and can communicate with any Azure VM connected to it.

To set up an encrypted tunnel, P2S VPN uses certificate-based authentication. Although it is possible to use self-signed certificates for this purpose, in production environments, you should use certificates issued by an external or internal Certificate Authority (CA), which you can implement by using Active Directory Certificate Services (AD CS).

## Azure Network Adapter components

Azure Network Adapter uses locally installed software to connect to an Azure virtual network gateway, which resides in the dedicated Gateway subnet of the target Azure virtual network. There is no additional on-premises infrastructure. Azure Network Adapter uses the VPN capabilities built into the Windows Server operating system.

:::image type="content" source="../media/architecture-4.png" alt-text="The diagram depicts how Azure Network Adapter uses locally installed software to connect to an Azure virtual network gateway, which resides in the dedicated Gateway subnet of the target Azure virtual network. There is no additional on-premises infrastructure. Azure Network Adapter uses the VPN capabilities built into the Windows Server operating system." border="false":::

## Azure Network Adapter support for Azure Stack HCI

You can set up Azure Network Adapter on any Windows Server VM running on an Azure Stack HCI cluster. Multiple servers can connect to the same Azure virtual network gateway; however, each of them should use its own client certificate.

## Implementing Azure Network Adapter in Azure Stack HCI scenarios

As the next step in evaluating Azure Network Adapter, you decide to implement it in Azure Stack HCI scenarios. Azure Network Adapter is a Windows Admin Center-specific feature. Although it is possible to implement P2S VPN connectivity to Azure virtual networks by using the installation process available from the Azure portal and Azure PowerShell, Windows Admin Center simplifies the setup process. It provides an interface that prompts you for the required information, including the Azure subscription and region that hosts the target virtual network, the virtual network name, the IP address range of the Gateway subnet, the virtual network gateway SKU, the IP address range allocated to VPN clients, and the authentication certificate details. If you select the self-signed option, Windows Admin Center will automatically generate the root and client certificates for you.

:::image type="content" source="../media/wac-add-network-dapter-self-signed.png" alt-text="The screenshot depicts the Windows Admin Center interface that prompts you for the required information, including the Azure subscription and region hosting the target virtual network, the virtual network name, the IP address range of the Gateway subnet, the virtual network gateway SKU, the IP address range allocated to VPN clients, and the authentication certificate details. If you select the self-signed option, Windows Admin Center will automatically generate the root and client certificates for you." border="false":::

> [!NOTE]
> Just like any functionality that involves Azure-based services, you first need to register Windows Admin Center in Azure. 

Keep in mind that the target Azure virtual network must exist before you can start Windows Admin Center-based setup. In addition, you will need to pre-provision an Azure virtual network gateway if you intend to use a SKU other than those available from the Windows Admin Center interface.

> [!NOTE]
> Azure virtual network gateway provisioning might take about 30 minutes.

---


---