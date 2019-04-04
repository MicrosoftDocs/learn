You've created VNets with virtual machines running within them, but there is no connectivity between them and none of these systems can communicate with each other. To enable this communication, you'll need to create the VNet peering connections to connect the virtual networks together. To satisfy your company's requirements, you'll configure a hub and spoke topology, and permit virtual network access when you create the peering connections.

## Create VNet peering connections

In these steps, you'll create the connections between each VNet, and configure the behavior of each connection.

1. Run the following command in the Cloud Shell to create the VNet peering connection between the **SalesVNet** and **MarketingVNet**. This command also permits VNet access across this peering connection.

    ```azurecli
    az network vnet peering create --name SalesVNet-To-MarketingVNet \
        --remote-vnet MarketingVNet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name SalesVNet \
        --allow-vnet-access
    ```

1. Run the following command in the Cloud Shell to create a reciprocal connection from the **MarketingVNet** to the **SalesVNet**. This step will complete the connection between these virtual networks.

    ```azurecli
    az network vnet peering create --name MarketingVNet-To-SalesVNet \
        --remote-vnet SalesVNet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name MarketingVNet \
        --allow-vnet-access
    ```

Now that you have connections between Sales and Marketing, you'll need to create connections between Marketing and Research.

1. Run the following command in the Cloud Shell to create the VNet peering connection between the **MarketingVNet** and **ResearchVNet**.

    ```azurecli
    az network vnet peering create --name MarketingVNet-To-ResearchVNet \
        --remote-vnet ResearchVNet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name MarketingVNet \
        --allow-vnet-access
    ```

1. Run the following command in the Cloud Shell to create the reciprocal connection between the **ResearchVNet** and the **MarketingVNet**.

    ```azurecli
    az network vnet peering create --name ResearchVNet-To-MarketingVNet \
        --remote-vnet MarketingVNet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ResearchVNet \
        --allow-vnet-access
    ```

## Check that VNet peering connections are connected

Now that you've created the VNet peering connections, you should check the status to ensure they are successfully connected.

1. First, run the following command in the Cloud Shell to check that the connection from the **SalesVNet** to the **MarketingVNet** is connected.

    ```azurecli
    az network vnet peering list --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name SalesVNet \
        --output table
    ```

1. You've only created a single connection from the **SalesVNet** so there's only one result. In the **PeeringState** column, look to see if the status is **Connected**.

1. Next, run the following command in the Cloud Shell to check that the VNet peering from the **ResearchVNet** to the **MarketingVNet** is connected.

    ```azurecli
    az network vnet peering list --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ResearchVNet \
        --output table
    ```

1. Again, you've only created one connection from the **ResearchVNet**, so there is only a single result. In the **PeeringState** column, look to see if the status is **Connected**.

1. Finally, run the following command in the Cloud Shell to check the VNet peering connections in the **MarketingVNet**.

    ```azurecli
    az network vnet peering list --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name MarketingVNet \
        --output table
    ```

    Remember that you created connections from Marketing to Sales, and from Marketing to Research. As a result, there should be two connections shown. In the **PeeringState** column, look to see if the status is **Connected** for both connections.

1. Your VNet peering connections between the virtual networks should now look like this.

   ![The resulting VNet Peering connections](../media/4-vnet-peering-configure-connections-result.svg)

## Check effective routes

We can further see that the peering has been established by taking a look at the routes that apply to the network interfaces of the virtual machines.

1. Run the following command to look at the routes that apply to the **SalesVM** network interface.

    ```azurecli
    az network nic show-effective-route-table --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name SalesVMVMNic \
        --output table
    ```

    This will show the effective routes for the network interface for this virtual machine. For the **SalesVMVMNic**, you should a route to **10.2.0.0/16** with a next hop type of **VNetPeering**. This is the network route for the peering connection from the **SalesVNet** to the **MarketingVNet**.

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

1. Next, let's look at the routes for the **MarketingVM**.

    ```azurecli
    az network nic show-effective-route-table --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name MarketingVMVMNic \
        --output table
    ```

    This will show the effective routes for the network interface for this virtual machine. For the **MarketingVMVMNic**, you should a route to **10.1.0.0/16** and **10.3.0.0/16** with a next hop type of **VNetGlobalPeering**. This is the network route for the peering connection from the **MarketingVNet** to the **SalesVNet**, and the **SalesVNet** to the **ResearchVNet**.

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

1. Finally, let's look at the routes for the **ResearchVM**.

    ```azurecli
    az network nic show-effective-route-table --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name ResearchVMVMNic \
        --output table
    ```

    This will show the effective routes for the network interface for this virtual machine. For the **ResearchVMVMNic**, you should a route to **10.2.0.0/16** with a next hop type of **VNetPeering**. This is the network route for the peering connection from the **ResearchVNet** to the **MarketingVNet**.

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

Now that we have our peering configured, let's take a look at how this impacts the communication between virtual machines.