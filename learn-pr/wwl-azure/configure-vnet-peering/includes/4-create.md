Azure Virtual Network peering can be configured for virtual networks by using PowerShell, the Azure CLI, and in the Azure portal. In this module, we review the steps to create the peering in the Azure portal for virtual networks deployed through Azure Resource Manager.

### Things to know about creating virtual network peering

There are a few points to review before we look at how to create the peering in the Azure portal.

- To implement virtual network peering, your Azure account must be assigned to the `Network Contributor` or `Classic Network Contributor` role. Alternatively, your Azure account can be assigned to a custom role that can complete the necessary peering actions. For details, see [Permissions](/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal#permissions).

- To create a peering, you need two virtual networks. 

- The second virtual network in the peering is referred to as the _remote network_.

- Initially, the virtual machines in your virtual networks can't communicate with each other. After the peering is established, the machines can communicate within the peered network based on your configuration settings.

## How to create a virtual network peering

Sign into your Azure account in the Azure portal, and choose the subscription to use for your peering configuration.

1. Create two virtual networks to include in the peering. Remember, at least one of the virtual networks must be deployed by using the Azure Resource Manager.

1. Choose the first virtual network to use in the peering, and select **Settings** > **Add** (peering).

1. Configure the peering parameters for the first virtual network.

   The top portion of the **Add peering** dialog shows settings for _this virtual network_. The bottom portion of the dialog shows settings for the remote virtual network in the peering.

   :::image type="content" source="../media/configure-peering-6812f843.png" alt-text="Screenshot that shows how to add virtual network peering in the Azure portal." border="false":::

   - **Peering link name**: Provide a name to identify the peering on this virtual network. The name must be unique within the virtual network.

   - **Traffic to remote virtual network**: Specify how to control traffic to the remote virtual network.
   
      - **Allow**: Allow communication between resources connected to both of your virtual networks within the peered network.
      
      - **Block**: Block all traffic to the remote virtual network. You can still allow some traffic to the remote virtual network if you explicitly open the traffic through a network security group rule.

   - **Traffic forwarded from remote virtual network**: Specify how to control traffic that originates from outside your remote virtual network.    

      - **Allow**: Forward outside traffic in the remote virtual network to this virtual network within the peering. This parameter lets you forward traffic from outside the remote virtual network, such as traffic from an NVA, to this virtual network.
      
      - **Block**: Block the forwarding of outside traffic from the remote virtual network to this virtual network within the peering. Again, some traffic can still be forwarded by explicitly opening the traffic through a network security group rule. When you configure traffic forwarding between virtual networks through an Azure VPN gateway, this parameter isn't applicable.

   - **Virtual network gateway or Route Server**: Specify whether your virtual network peering should use an Azure VPN gateway. The default is to not use a VPN gateway (None).

1. Configure the peering parameters for your remote virtual network.

   In the Azure portal, you configure the remote virtual network in the peering on the **Add peering** dialog. The bottom portion shows settings for the remote virtual network.

   :::image type="content" source="../media/configure-peering-remote.png" alt-text="Screenshot that shows how to configure peering for the remote virtual network in the Azure portal." border="false":::

   - **Peering link name**: Provide a name to identify the peering on your remote virtual network. The name must be unique within the virtual network.

   - **Virtual network deployment model**: Select the deployment model of the virtual network you want to peer with.

   - **I know my resource ID**:	This setting supports scenarios where you don't have read access to the virtual network you want to peer with.
   
      As needed, select the checkbox and then enter the full resource ID of the virtual network you want to peer with. When you select this setting, the following two parameters aren't available for configuration.

   - **Subscription**: Select the subscription of the virtual network you want to peer with.

   - **Virtual network**: Select the virtual network you want to peer with.

   The remaining settings are similar to the parameters described for the first virtual network in the previous step.

1. Create at least one virtual machine in each virtual network.

1. Test communication between the virtual machines within your peered network.

## How to check your peering status

In the Azure portal, you can check the connectivity status of the virtual networks in your virtual network peering. The status conditions depend on how your virtual networks are deployed.

> [!Important]
> Your peering isn't successfully established until both virtual networks in the peering have a status of **Connected**.

- For deployment with the Azure Resource Manager, the two primary status conditions are **Initiated** and **Connected**. For the classic deployment model, the **Updating** status condition is also used.

- When you create the initial peering _to_ the second (remote) virtual network from the first virtual network, the peering status for the first virtual network is **Initiated**.

- When you create the subsequent peering _from_ the second virtual network to the first virtual network, the peering status for both the first and remote virtual networks is **Connected**. In the Azure portal, you can see the status for the first virtual network change from **Initiated** to **Connected**.