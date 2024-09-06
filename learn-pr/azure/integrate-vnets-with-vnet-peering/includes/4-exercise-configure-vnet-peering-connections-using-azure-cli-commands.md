You've created virtual networks and run virtual machines (VMs) within them. However, the virtual networks have no connectivity, and none of these systems can communicate with each other. 

To enable communication, you need to create peering connections for the virtual networks. To satisfy your company's requirements, you'll configure a hub and spoke topology and permit virtual network access when you create the peering connections.

## Create virtual network peering connections

Follow these steps to create connections between the virtual networks and to configure the behavior of each connection.

1. In Cloud Shell, run the following command to create the peering connection between the **SalesVNet** and **MarketingVNet** virtual networks. This command also permits virtual network access across this peering connection.

    ```azurecli
    az network vnet peering create \
        --name SalesVNet-To-MarketingVNet \
        --remote-vnet MarketingVNet \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name SalesVNet \
        --allow-vnet-access
    ```

1. Run the following command to create a reciprocal connection from **MarketingVNet** to **SalesVNet**. This step completes the connection between these virtual networks.

    ```azurecli
    az network vnet peering create \
        --name MarketingVNet-To-SalesVNet \
        --remote-vnet SalesVNet \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name MarketingVNet \
        --allow-vnet-access
    ```

Now that you have connections between Sales and Marketing, create connections between Marketing and Research.

1. In Cloud Shell, run the following command to create the peering connection between the **MarketingVNet** and **ResearchVNet** virtual networks:

    ```azurecli
    az network vnet peering create \
        --name MarketingVNet-To-ResearchVNet \
        --remote-vnet ResearchVNet \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name MarketingVNet \
        --allow-vnet-access
    ```

1. Run the following command to create the reciprocal connection between **ResearchVNet** and **MarketingVNet**:

    ```azurecli
    az network vnet peering create \
        --name ResearchVNet-To-MarketingVNet \
        --remote-vnet MarketingVNet \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name ResearchVNet \
        --allow-vnet-access
    ```

## Check the virtual network peering connections

Now that you've created the peering connections between the virtual networks, make sure the connections work.

1. In Cloud Shell, run the following command to check the connection between **SalesVNet** and **MarketingVNet**:

    ```azurecli
    az network vnet peering list \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name SalesVNet \
        --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
        --output table
    ```

1. You've created only one connection from **SalesVNet**, so you get only one result. In the **PeeringState** column, make sure the status is **Connected**.

1. Run the following command to check the peering connection between the **ResearchVNet** and **MarketingVNet** virtual networks:

    ```azurecli
    az network vnet peering list \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name ResearchVNet \
        --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
        --output table
    ```

1. Again, you've created only one connection from **ResearchVNet**, so you get only one result. In the **PeeringState** column, make sure the status is **Connected**.

1. Run the following command to check the peering connections for the **MarketingVNet** virtual network.

    ```azurecli
    az network vnet peering list \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --vnet-name MarketingVNet \
        --query "[].{Name:name, Resource:resourceGroup, PeeringState:peeringState, AllowVnetAccess:allowVirtualNetworkAccess}"\
        --output table
    ```

    Remember that you created connections from Marketing to Sales and from Marketing to Research, so you should get two connections. In the **PeeringState** column, make sure the status of both connections is **Connected**.

Your peering connections between the virtual networks should now look like this:

:::image type="content" source="../media/4-vnet-peering-configure-connections-result.svg" alt-text="Diagram of the resulting virtual network peering connections.":::

## Check effective routes

You can further check the peering connection by looking at the routes that apply to the network interfaces of the VMs.

1. Run the following command to look at the routes that apply to the **SalesVM** network interface:

    ```azurecli
    az network nic show-effective-route-table \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name SalesVMVMNic \
        --output table
    ```

    The output table shows the effective routes for the VM's network interface. For **SalesVMVMNic**, you should have a route to **10.2.0.0/16** with *Next Hop Type* of **VNetPeering**. This is the network route for the peering connection from **SalesVNet** to **MarketingVNet**.

    ```output
    Source    State    Address Prefix    Next Hop Type    Next Hop IP
    --------  -------  ----------------  ---------------  -------------
    Default   Active   10.1.0.0/16       VnetLocal
    Default   Active   10.2.0.0/16       VNetPeering
    Default   Active   0.0.0.0/0         Internet
    Default   Active   10.0.0.0/8        None
    Default   Active   100.64.0.0/10     None
    Default   Active   192.168.0.0/16    None
    ```

1. Run the following command to look at the routes for **MarketingVM**:

    ```azurecli
    az network nic show-effective-route-table \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name MarketingVMVMNic \
        --output table
    ```

    The output table shows the effective routes for the VM's network interface. For **MarketingVMVMNic**, you should have a route to **10.1.0.0/16** with a next hop type of **VNetPeering** and a route to **10.3.0.0/16** with a next hop type of **VNetGlobalPeering**. These are the network routes for the peering connection from **MarketingVNet** to **SalesVNet** and from **MarketingVNet** to **ResearchVNet**.

    ```output
    Source    State    Address Prefix    Next Hop Type      Next Hop IP
    --------  -------  ----------------  -----------------  -------------
    Default   Active   10.2.0.0/16       VnetLocal
    Default   Active   10.1.0.0/16       VNetPeering
    Default   Active   0.0.0.0/0         Internet
    Default   Active   10.0.0.0/8        None
    Default   Active   100.64.0.0/10     None
    Default   Active   192.168.0.0/16    None
    Default   Active   10.3.0.0/16       VNetGlobalPeering
    ```

1. Run the following command to look at the routes for **ResearchVM**:

    ```azurecli
    az network nic show-effective-route-table \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --name ResearchVMVMNic \
        --output table
    ```

    The output table shows the effective routes for the VM's network interface. For **ResearchVMVMNic**, you should have a route to **10.2.0.0/16** with a next hop type of **VNetGlobalPeering**. This is the network route for the peering connection from **ResearchVNet** to **MarketingVNet**.

    ```output
    Source    State    Address Prefix    Next Hop Type      Next Hop IP
    --------  -------  ----------------  -----------------  -------------
    Default   Active   10.3.0.0/16       VnetLocal
    Default   Active   0.0.0.0/0         Internet
    Default   Active   10.0.0.0/8        None
    Default   Active   100.64.0.0/10     None
    Default   Active   192.168.0.0/16    None
    Default   Active   10.2.0.0/16       VNetGlobalPeering
    ```

Now that your peering connections are configured, let's take a look at how this affects the communication between VMs.
