Azure Virtual Network peering can be configured for virtual networks by using PowerShell, the Azure CLI, and in the Azure portal. In this module, we review the steps to create the peering in the Azure portal for virtual networks deployed through Azure Resource Manager.

### Things to know about creating virtual network peering

There are a few points to review before we look at how to create the peering in the Azure portal.

- To implement virtual network peering, your Azure account must be assigned to the `Network Contributor` or `Classic Network Contributor` role. Alternatively, your Azure account can be assigned to a custom role that can complete the necessary peering actions. For details, see [Permissions](/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions).

- To create a peering, you need two virtual networks. 

- The second virtual network in the peering is referred to as the _remote network_.

- Initially, the virtual machines in your virtual networks can't communicate with each other. After the peering is established, the machines can communicate within the peered network based on your configuration settings.


## How to connect virtual networks across Azure regions with Azure Global VNet peering 

<iframe width="854" height="480" src="https://www.youtube.com/embed/pSqDlQlcsLo" title="How to move Azure Storage Blobs between containers" allowfullscreen></iframe>


## How to check your peering status

In the Azure portal, you can check the connectivity status of the virtual networks in your virtual network peering. The status conditions depend on how your virtual networks are deployed.

> [!Important]
> Your peering isn't successfully established until both virtual networks in the peering have a status of **Connected**.

- For deployment with the Azure Resource Manager, the two primary status conditions are **Initiated** and **Connected**. For the classic deployment model, the **Updating** status condition is also used.

- When you create the initial peering _to_ the second (remote) virtual network from the first virtual network, the peering status for the first virtual network is **Initiated**.

- When you create the subsequent peering _from_ the second virtual network to the first virtual network, the peering status for both the first and remote virtual networks is **Connected**. In the Azure portal, you can see the status for the first virtual network change from **Initiated** to **Connected**.