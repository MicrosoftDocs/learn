Your company is now ready to deploy a site-to-site VPN. This will allow your on-premises servers to connect to resources in Azure. You can then start to securely share data from each of your sites, and use resources hosted in Azure across your organization. You'll start by creating your Azure-side resources and the on-premises network resources. For this deployment, you'll use this network topology.

![Network topology for unit 3 exercise](../media/3-network-topology-used-in-exercise.svg)

In this exercise, you're going to simulate an on-premises datacenter (HQ-Network) by using an additional Azure virtual network. There are many makes and models of on-premises VPN devices and it isn't possible to demonstrate configuration of them in this unit. The logical method of configuration is the same but steps for HQ-Network would be replaced by steps tailored to your on-premises VPN device.

Notice in the diagram that the Local Network Gateway names in each location reflect the *target* networks as opposed to the source network. This is good practice, and makes it clear that the Local Network Gateway refers to the *other* network being connected to.

[!include[](../../../includes/azure-sandbox-activate.md)]

In this unit, you'll configure the virtual networks with a subnet, add a GatewaySubnet, and then create the local network gateway using the Azure CLI.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

## Create the Azure-side resources

1. Run the following command in the Cloud Shell to create the **Azure-VNet-1** virtual network and the **Services** subnet.

    ```azurecli
    az network vnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name Azure-VNet-1 \
        --address-prefix 10.0.0.0/16 \
        --subnet-name Services \
        --subnet-prefix 10.0.0.0/24
    ```

1. Run the following command in the Cloud Shell to add the **GatewaySubnet** subnet to **Azure-VNet-1**.

    ```azurecli
    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name Azure-VNet-1 \
        --address-prefix 10.0.255.0/27 \
        --name GatewaySubnet
    ```

1. Run the following command in the Cloud Shell to create the **LNG-HQ-Network** Local Network Gateway.

    ```azurecli
    az network local-gateway create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --gateway-ip-address 94.0.252.160 \
        --name LNG-HQ-Network \
        --local-address-prefixes 172.16.0.0/16
    ```

    This gateway represents the "On-Premises" network that is being connected to and as such, the IP address specified as the remote gateway (which is the simulated on-premises) will need to be updated later since it does not yet exist in our scenario.

## Create the simulated on-premises network and supporting resources

1. Run the following command in the Cloud Shell to create the **HQ-Network** virtual network and **Applications** subnet.

    ```azurecli
    az network vnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name HQ-Network \
        --address-prefix 172.16.0.0/16 \
        --subnet-name Applications \
        --subnet-prefix 172.16.0.0/24
    ```

1. Run the following command in the Cloud Shell to add the **GatewaySubnet** to **HQ-Network**.

    ```azurecli
    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --address-prefix 172.16.255.0/27 \
        --name GatewaySubnet \
        --vnet-name HQ-Network
    ```

1. Run the following command in the Cloud Shell to create the **LNG-Azure-VNet-1** local network gateway.

    ```azurecli
    az network local-gateway create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --gateway-ip-address 94.0.252.160 \
        --name LNG-Azure-VNet-1 \
        --local-address-prefixes 10.0.0.0/16
    ```

    This gateway is describing the Azure network that is being connected to. You will update the IP address specified as the remote gateway (which is in Azure) later.

## Verify the topology

1. Run the following command in the Cloud Shell to verify that the virtual networks have been created successfully.

    ```azurecli
    az network vnet list --output table
    ```

1. Run the following command in the Cloud Shell to verify that the local network gateways have been created successfully.

    ```azurecli
    az network local-gateway list \
        --resource-group <rgn>[sandbox resource group name]</rgn> --output table
    ```

This diagram shows the resources you've now deployed from your topology:

![Resources deployed during unit 3 exercise](../media/3-resources-deployed-during-exercise.svg)