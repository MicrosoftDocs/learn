
## Scenario 

The IT department needs network isolation and segmentation for the web application. Once the virtual network is created, the next step would be to configure virtual network peering. This allows the virtual networks to communicate with each other securely and privately.

To provide network isolation and segmentation for the web application, you create an Azure virtual network and configure subnets and virtual network peering to achieve secure and isolated network communication.  

### Architecture diagram

| Network solution  | Tasks|
| --- | --- |
| :::image type="content" source="../media/task-1.png" alt-text="Diagram with two virtual networks that are peered." border="true"::: | <ul><li>Create a virtual network </li><li> Create a subnet. </li><li>Configure vnet peering. </li></ul> |

## Exercise instructions

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).
> In this lab, when you are asked to create a resource, for any properties that are not specified, use the default value.

1. Create the Azure virtual network **app-vnet** by using the values in the following table:


    | Property | Value    |
    |:---------|:---------|
    |Resource group|**RG1**|
    |Name|	**app-vnet**|
    |Region| **East US**|
    |IPv4 address space|	**10.1.0.0/16**|
    |Subnet name|	**frontend**|
    |Subnet address range|	**10.1.0.0/24**| 
    |Subnet name|	**backend**|
    |Subnet address range|	**10.1.1.0/24**| 

1. Create the Azure virtual network **shared-services-vnet** by using the values in the following table:

    | Property | Value    |
    |:---------|:---------|
    |Resource group|**RG1**|
    |Name|	**shared-services-vnet**|
    |Region| **East US**|
    |IPv4 address space|	**10.0.0.0/16**|
    |Subnet name|	**frontend**|
    |Subnet address range|	**10.0.0.0/24**| 


1. Review the address space and subnet configurations of the existing virtual network **app-vnet** in the **RG1** resource group.

1. Peer the two virtual networks to allow traffic to flow in both directions between the **app-vnet** and **shared-services-vnet** virtual networks. Use the values in the following table: 

    | Property | Value    | 
    |:---------|:---------|
    |Peering link name|**app-vnet-to-sharedservices**|
    |Peering link name | **sharedservices-to-app-vnet**|

    [Learn more about Virtual Network Peering](/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal)

1. Verify that the peering status of both VNets is Connected.

