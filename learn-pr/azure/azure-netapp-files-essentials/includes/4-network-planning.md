Network architecture planning is a key element of designing any application infrastructure. This unit helps you design an effective network architecture for your workloads to benefit from the capabilities of Azure NetApp Files.

## Network features

Azure NetApp Files volumes are designed to be contained in a special purpose subnet called a delegated subnet within your Azure Virtual Network. Hence, you can access the volumes directly from within Azure over virtual network (VNet) peering or from on-premises over a Virtual Network Gateway (ExpressRoute or VPN Gateway). The subnet is dedicated to Azure NetApp Files and there's no connectivity to the Internet.

In supported regions, you can create new volumes or modify existing volumes to use Standard or Basic network features. 

- **Standard**
    Selecting this setting enables higher IP limits and standard VNet features such as network security groups and user-defined routes on delegated subnets, and additional connectivity patterns as indicated in this article.
- **Basic** 
    Selecting this setting enables selective connectivity patterns and limited IP scale as mentioned in the Considerations section. All the constraints apply in this setting.

You can switch between Basic and Standard network features with some limitations: 

:::image type="content" source="../media/4-network-features.png" alt-text="Table comparing Basic and Standard network features." lightbox="../media/4-network-features.png":::

To learn more about network features, see [Guidelines for Azure NetApp Files network planning](/azure/azure-netapp-files/azure-netapp-files-network-topologies).

## Virtual networks for Azure NetApp Files volumes

This section explains concepts that help you with virtual network planning.

### Azure virtual networks

Before provisioning an Azure NetApp Files volume, you need to create an Azure virtual network (VNet) or use one that already exists in the same subscription. The VNet defines the network boundary of the volume.

### Subnets

Subnets segment the virtual network into separate address spaces that are usable by the Azure resources in them. When you create an instance of Azure NetApp Files, you assign the instance to a delegated subnet. A delegated subnet is a subnet that's configured with permissions to create resources that are specific to a service, which in this case is Azure NetApp Files. How network nodes connect to Azure NetApp Files in that subnet depends on where those nodes are located. 

### User-defined routes and network security groups

If the subnet has a combination of volumes with the Standard and Basic network features, user-defined routes (UDRs) and network security groups (NSGs) applied on the delegated subnets only apply to the volumes with the Standard network features.

> [!NOTE]
> Associating NSGs at the network interface level is not supported for the Azure NetApp Files network interfaces.

## Azure native environments

We cover four virtual network scenarios: local VNets, peered VNets, VNets for cross-region replication, and hybrid environments. The following diagram applies to both the local and peered VNet scenarios for an Azure native environment.

:::image type="content" source="../media/4-virtual-network-diagram.png" alt-text="Diagram depicting Azure native environment setup." lightbox="../media/4-virtual-network-diagram.png":::

### Local VNet

Connectivity in the same virtual network. Any resource running on an Azure virtual machine in the same virtual network that contains the delegated subnet can connect to the file storage provided by Azure NetApp Files. In the diagram, both VM 1 and Azure NetApp Files Volume 1 reside in the Virtual network 1, so VM 1 has direct access to Volume 1.

### VNet peering

If you have other VNets in the same region that need access to each other’s resources, the VNets can be connected using VNet peering to enable secure connectivity through the Azure infrastructure. Consider VNet 2 and VNet 3 in the diagram above. If VM 1 needs to connect to VM 2 or Volume 2, or if VM 2 needs to connect to VM 1 or Volume 1, then you need to enable VNet peering between VNet 2 and VNet 3.

Also, consider a scenario where VNet 1 is peered with VNet 2, and VNet 2 is peered with VNet 3 in the same region. The resources from VNet 1 can connect to resources in VNet 2 but can't connect to resources in VNet 3 unless VNet 1 and VNet 3 are peered. In the diagram above, although VM 3 can connect to Volume 1, VM 4 can't connect to Volume 2. The reason for this is that the spoke VNets aren't peered, and transit routing isn't supported over VNet peering.

### Global or cross-region VNet peering

Connectivity in a peered virtual network. Any resource running on an Azure virtual machine in a virtual network that's peered to the network containing the delegated subnet can connect to the file storage provided by Azure NetApp Files. In the diagram, VNet 1 and VNet 2 are peered, so VM 2 has peered access to Volume 1.

The following diagram illustrates an Azure NetApp Files environment with cross-region VNet peering.

:::image type="content" source="../media/4-global-virtual-network.png" alt-text="Diagram of a VNet design for cross-region replication." lightbox="../media/4-global-virtual-network.png":::

With Standard network features, VMs are able to connect to volumes in another region using global or cross-region VNet peering. The above diagram adds a second region to the configuration in the local VNet peering section. For VNet 4 in this diagram, an Azure NetApp Files volume is created in a delegated subnet and can be mounted on VM5 in the application subnet.

In the diagram above, VM2 in region 1 can connect to Volume 3 in Region 2. VM5 in region 2 can connect to Volume 2 in Region 1 via VNet peering between Region 1 and Region 2.

## Hybrid environments

Any resource running in an on-premises network that's connected to the Azure virtual network that contains the delegated subnet using VPN or ExpressRoute can connect to the file storage provided by Azure NetApp Files. In the diagram, the on-premises network is connected to the Azure virtual network 1 via a VPN gateway.
The following diagram illustrates a hybrid environment:

:::image type="content" source="../media/4-hybrid-environment.png" alt-text="Diagram depicting hybrid networking environment." lightbox="../media/4-hybrid-environment.png":::

In the hybrid scenario, applications from on-premises datacenters need access to the resources in Azure. In a hybrid hub-spoke topology, the hub VNet in Azure acts as a central point of connectivity to your on-premises network. The spokes are VNets peered with the hub, and they can be used to isolate workloads. Depending on the configuration, you can connect on-premises resources to resources in the hub and the spokes.

In the topology illustrated above, the on-premises network is connected to a hub VNet in Azure, and there are 2 spoke VNets in the same region peered with the hub VNet. In this scenario, the connectivity options supported for Azure NetApp Files volumes are:

* On-premises resources VM 1 and VM 2 can connect to Volume 1 in the hub over a site-to-site VPN or ExpressRoute circuit. 
* On-premises resources VM 1 and VM 2 can connect to Volume 2 or Volume 3 over a site-to-site VPN and regional VNet peering.
* VM 3 in the hub VNet can connect to Volume 2 in spoke VNet 1 and Volume 3 in spoke VNet 2.
* VM 4 from spoke VNet 1 and VM 5 from spoke VNet 2 can connect to Volume 1 in the hub VNet.
* VM 4 in spoke VNet 1 can't connect to Volume 3 in spoke VNet 2. Also, VM 5 in spoke VNet2 can't connect to Volume 2 in spoke VNet 1. This is the case because the spoke VNets aren't peered and _transit routing isn't supported over VNet peering_.
* In the architecture, if there's a gateway in the spoke VNet as well, the connectivity to the Azure NetApp Files volume from on-premises connecting over the gateway in the Hub will be lost. By design, preference would be given to the gateway in the spoke VNet and so only machines connecting over that gateway can connect to the Azure NetApp Files volume.