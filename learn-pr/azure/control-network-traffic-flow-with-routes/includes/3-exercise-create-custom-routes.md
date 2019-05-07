As part of your security strategy, you want to control how network traffic is routed across your Azure infrastructure. You'll use a network virtual appliance to help secure and monitor traffic. You want to ensure communications between front-end public servers and internal private servers are always routed through the appliance.

You'll configure the network so that all traffic flowing from the **fashionpublicnet** to the **fashionprivatenet** subnet will be routed through a network virtual appliance. To make this happen, you'll create a custom route for **fashionpublicnet**, to route this traffic to the **fashiondmznet** subnet. Later, you'll deploy a network virtual appliance to **fashiondmznet**.  

![Virtual network, subnets, and route table](../media/3-vnet-subnets-route-table.png)

In this exercise, you'll create the route table, custom route, and subnets. You'll then associate the route table with a subnet.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a route table and custom route

The first task is create a new routing table, and then add a custom route for all traffic intended for the **fashionprivatenet** subnet.

1. In the Cloud Shell window on the right, run the following command to create a route table.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

   ```azurecli
   az network route-table create \
     --name fashionpublictable \
     --resource-group <rgn>[sandbox resource group name]</rgn> \
     --disable-bgp-route-propagation false
   ```

1. Run the following command in the Cloud Shell to create a custom route.

   ```azurecli
   az network route-table route create \
     --route-table-name fashionpublictable \
     --resource-group <rgn>[sandbox resource group name]</rgn> \
     --name fashionproductionsubnet \
     --address-prefix 10.0.1.0/24 \
     --next-hop-type VirtualAppliance \
     --next-hop-ip-address 10.0.2.4
   ```

## Create a virtual network and subnets

The next step is to create the **fashionvnet** virtual network, and the three subnets that you need: **fashionpublicnet**, **fashionprivatenet**, and **fashiondmznet**.

1. Run the following command to create the **fashionvnet** VNet, and the **fashionpublicnet** subnet.

    ```azurecli
    az network vnet create \
        --name fashionvnet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --address-prefix 10.0.0.0/16 \
        --subnet-name fashionpublicnet \
        --subnet-prefix 10.0.0.0/24
   ```

1. Run the following command in the Cloud Shell to create the **fashionprivatenet** subnet.

    ```azurecli
    az network vnet subnet create \
        --name fashionprivatenet \
        --vnet-name fashionvnet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --address-prefix 10.0.1.0/24
     ```

1. Run the following command to create the **fashiondmznet** subnet.

    ```azurecli
    az network vnet subnet create \
        --name fashiondmznet \
        --vnet-name fashionvnet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --address-prefix 10.0.2.0/24
    ```

1. You should now have three subnets. Run the following command to show all the subnets in the  **fashionvnet** virtual network.

    ```azurecli
    az network vnet subnet list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name fashionvnet \
        --output table
    ```

## Associate the route table with the public subnet

The final step in this exercise is to associate the route table with the **fashionpublicnet** subnet.

1. Run the following command to associate the route table to the public subnet.

    ```azurecli
    az network vnet subnet update \
        --name fashionpublicnet \
        --vnet-name fashionvnet \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --route-table fashionpublictable
    ```
