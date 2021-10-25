From the networking standpoint, you need to provide the following:

 -  The definition of an Azure virtual network into which you're going to deploy the VMs of the SAP application layer.
 -  The definition of a default subnet in the Azure virtual network that is the one into which the VMs are deployed.
 -  The Azure virtual network that's created needs to have at least one VM subnet and one Azure ExpressRoute virtual network gateway subnet. These subnets should be assigned the IP address ranges as specified and discussed in the following sections.

## Create the Azure virtual network for HANA Large Instances

The Azure virtual network for HANA Large Instances must be created by using the Azure Resource Manager deployment model. You can use the Azure portal, PowerShell, an Azure template, or the Azure CLI to create the virtual network.

The address space that the Azure virtual network is allowed to use is also the address range that the virtual network uses for BGP route propagation. You can restrict the virtual network address space to the specific ranges used by each subnet. You can also define the virtual network address space of a virtual network as multiple specific ranges.

You can use any naming standard you like for these tenant subnets (VM subnets). However, there must always be one, and only one, gateway subnet for each virtual network that connects to the SAP HANA on Azure (Large Instances) ExpressRoute circuit.

Following is a summary of the important facts about an Azure virtual network that connects to HANA Large Instances:

 -  You must submit the virtual network address space to Microsoft when you're performing an initial deployment of HANA Large Instances.
 -  The virtual network address space can be one larger range that covers the ranges for both the subnet IP address range of the Azure VM and the virtual network gateway.
 -  Alternatively, you can submit multiple ranges that cover the different IP address ranges of VM subnet IP address range(s) and the virtual network gateway IP address range.
 -  The defined virtual network address space is used for BGP routing propagation.
 -  The name of the gateway subnet must be: "GatewaySubnet".
 -  The address space is used as a filter on the HANA Large Instance side to allow or disallow traffic to the HANA Large Instance units from Azure. The BGP routing information of the Azure virtual network and the IP address ranges that are configured for filtering on the HANA Large Instance side should match. Otherwise, connectivity issues can occur.

## Different IP address ranges to be defined

You need to define all of the following IP address ranges before you send a request for initial deployment:

 -  **Virtual network address space**: The virtual network address space is the IP address ranges that you assign to your address space parameter in the Azure virtual networks. These networks connect to the SAP HANA Large Instance environment. We recommend that this address space parameter is a multi-line value. It should consist of the subnet range of the Azure VM and the subnet range(s) of the Azure gateway. It must NOT overlap with your on-premises or server IP pool or ER-P2P address ranges. The virtual network address space needs to be submitted to Microsoft when you ask for an initial deployment.
 -  **Azure VM subnet IP address range**: This IP address range is the one you assign to the Azure virtual network subnet parameter. This parameter is in your Azure virtual network and connects to the SAP HANA Large Instance environment. This IP address range is used to assign IP addresses to your Azure VMs. The IP addresses out of this range are allowed to connect to your SAP HANA Large Instance server(s). If needed, you can use multiple Azure VM subnets. We recommend a /24 CIDR block for each Azure VM subnet.
 -  **Virtual network gateway subnet IP address range**: Depending on the features that you plan to use, the recommended size is:
    
     -  Ultra-performance ExpressRoute gateway: /26 address block--required for Type II class of SKUs.
     -  Coexistence with VPN and ExpressRoute using a high-performance ExpressRoute virtual network gateway (or smaller): /27 address block.
     -  All other situations: /28 address block.
    
    This address range must be a part of the values used in the "VNet address space" values. This address range must be a part of the values that are used in the Azure virtual network address space values that you submit to Microsoft.
 -  **Address range for ER-P2P connectivity**: This range is the IP range for your SAP HANA Large Instance ExpressRoute (ER) P2P connection. This range of IP addresses must be a /29 CIDR IP address range. This range must NOT overlap with your on-premises or other Azure IP address ranges. This IP address range is used to set up the ER connectivity from your ExpressRoute virtual gateway to the SAP HANA Large Instance servers. This IP address range needs to be submitted to Microsoft when you ask for an initial deployment.
 -  **Server IP pool address range**: This IP address range is used to assign the individual IP address to HANA large instance servers. The recommended subnet size is a /24 CIDR block. If needed, it can be smaller, with as few as 64 IP addresses. From this range, the first 30 IP addresses are reserved for use by Microsoft. Make sure that you account for this fact when you choose the size of the range. This range must NOT overlap with your on-premises or other Azure IP addresses. This IP address range needs to be submitted to Microsoft when asking for an initial deployment.

## Optional IP address ranges that eventually need to be submitted to Microsoft

 -  If you choose to use ExpressRoute Global Reach to enable direct routing from on-premise to HANA Large Instance units, you need to reserve another /29 IP address range. This range may not overlap with any of the other IP address ranges you defined before.
 -  If you choose to use ExpressRoute Global Reach to enable direct routing from a HANA Large Instance tenant in one Azure region to another HANA Large Instance tenant in another Azure region, you need to reserve another /29 IP address range. This range may not overlap with any of the other IP address ranges you defined before.

You need to define and plan the IP address ranges that were described previously. However, you don't need to provide all of them to Microsoft. The IP address ranges that you are required to name to Microsoft are:

 -  Azure virtual network address space(s)
 -  Address range for ER-P2P connectivity
 -  Server IP pool address range

If you add additional virtual networks that need to connect to HANA Large Instances, you have to submit the new Azure virtual network address space that you're adding to Microsoft.

You can also aggregate the data that you submit to Microsoft. In that case, the address space of the Azure virtual network only includes one space. We recommend that you keep the address space tightly aligned with the actual subnet address space that you use. If needed, without incurring downtime on the virtual network, you can always add new address space values later.

> [!IMPORTANT]
> Each IP address range in ER-P2P, the server IP pool, and the Azure virtual network address space must NOT overlap with one another or with any other range that's used in your network. Each must be discrete.

## Next steps after address ranges have been defined

After the IP address ranges have been defined, the following things need to happen:

1.  Submit the IP address ranges for the Azure virtual network address space, the ER-P2P connectivity, and server IP pool address range, together with other data that has been listed at the beginning of the document. At this point, you could also start to create the virtual network and the VM subnets.
2.  An ExpressRoute circuit is created by Microsoft between your Azure subscription and the HANA Large Instance stamp.
3.  A tenant network is created on the Large Instance stamp by Microsoft.
4.  Microsoft configures networking in the SAP HANA on Azure (Large Instances) infrastructure to accept IP addresses from your Azure virtual network address space that communicates with HANA Large Instances.
5.  Depending on the specific SAP HANA on Azure (Large Instances) SKU that you bought, Microsoft assigns a compute unit in a tenant network. It also allocates and mounts storage, and installs the operating system (SUSE or Red Hat Linux). IP addresses for these units are taken out of the Server IP Pool address range that you submitted to Microsoft.

At the end of the deployment process, Microsoft delivers the following data to you:

 -  Information that's needed to connect your Azure virtual network(s) to the ExpressRoute circuit that connects Azure virtual networks to HANA Large Instances:
    
     -  Authorization key(s)
     -  ExpressRoute PeerID
 -  Data for accessing HANA Large Instances after you establish ExpressRoute circuit and Azure virtual network.
