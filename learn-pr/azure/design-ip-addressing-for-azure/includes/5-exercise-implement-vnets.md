Now, you're ready to create and deploy some virtual networks with the IP addresses based on your design.

In this unit, you deployed three virtual networks and subnets to support resources in those virtual networks.

The **CoreServicesVnet** virtual network is deployed in the **US West** region. This virtual network has the largest number of resources. It has connectivity to on-premises networks through a VPN connection. This network has web services, databases, and other systems that are key to business operations. Shared services, such as domain controllers and DNS, are located here as well. A large amount of growth is anticipated, so a large address space is necessary for this virtual network.

The **ManufacturingVnet** virtual network is deployed in the **North Europe** region, near the location of your organization's manufacturing facilities. This virtual network contains systems for the manufacturing facilities' operations. The organization is anticipating a large number of internal connected devices from which their systems retrieve data (such as temperature) and need an IP address space for expansion.

The **ResearchVnet** virtual network is deployed in the **West India** region, near the location of the organization's research and development team that uses this virtual network. The team has a small, stable set of resources with no expectation of future growth. The team needs a few IP addresses for a few virtual machines for their work.

![A diagram of virtual networks that you need to create.](../media/5-design-implement-vnet-peering.svg)

You create the following resources:

| Virtual network | Region | Virtual network address space | Subnet | Subnet address space |
| --- | --- | --- | --- | --- |
| CoreServicesVnet | West US | 10.20.0.0/16 | - | - |
| | | | GatewaySubnet | 10.20.0.0/27 |
| | | | SharedServicesSubnet | 10.20.10.0/24 |
| | | | DatabaseSubnet | 10.20.20.0/24 |
| | | | PublicWebServiceSubnet | 10.20.30.0/24 |
| ManufacturingVnet | North Europe | 10.30.0.0/16 | - | - |
| | | | ManufacturingSystemSubnet | 10.30.10.0/24 |
| | | | SensorSubnet1 | 10.30.20.0/24 |
| | | | SensorSubnet2 | 10.30.21.0/24 |
| | | | SensorSubnet3 | 10.30.22.0/24 |
| ResearchVnet | West India | 10.40.40.0/24 | - | - |
| | | | ResearchSystemSubnet | 10.40.40.0/24|
| | | | | |

These virtual networks and subnets are structured in a way that accommodates existing resources, yet allows for projected growth. Let's create these virtual networks and subnets to lay the foundation for our networking infrastructure.

## Create the *CoreServicesVnet* virtual network

1. In Azure Cloud Shell, run the following command to create the **CoreServicesVnet** virtual network:

    ```azurecli
    az network vnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name CoreServicesVnet \
        --address-prefixes 10.20.0.0/16 \
        --location westus
    ```

1. Now, let's create the subnets that we need for the planned resources in the virtual network:

    ```azurecli
    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name CoreServicesVnet \
        --name GatewaySubnet \
        --address-prefixes 10.20.0.0/27

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name CoreServicesVnet \
        --name SharedServicesSubnet \
        --address-prefixes 10.20.10.0/24

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name CoreServicesVnet \
        --name DatabaseSubnet \
        --address-prefixes 10.20.20.0/24

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name CoreServicesVnet \
        --name PublicWebServiceSubnet \
        --address-prefixes 10.20.30.0/24
    ```

1. Let's take a look at the resources created. Run this command to show all the subnets that we configured:

    ```azurecli
    az network vnet subnet list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name CoreServicesVnet \
        --output table
    ```

    You should see the following subnets listed:

    ```output
    AddressPrefix    Name                    PrivateEndpointNetworkPolicies    PrivateLinkServiceNetworkPolicies    ProvisioningState    ResourceGroup
    ---------------  ----------------------  --------------------------------  -----------------------------------  -------------------  -------------------------------------------
    10.20.0.0/27     GatewaySubnet           Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.20.10.0/24    SharedServicesSubnet    Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.20.20.0/24    DatabaseSubnet          Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.20.30.0/24    PublicWebServiceSubnet  Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    ```

## Create the *ManufacturingVnet* virtual network

1. In Cloud Shell, run the following command to create the **ManufacturingVnet** virtual network:

    ```azurecli
    az network vnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name ManufacturingVnet \
        --address-prefixes 10.30.0.0/16 \
        --location northeurope
    ```

1. Now, let's create the subnets that we need for the planned resources in the virtual network:

    ```azurecli
    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ManufacturingVnet \
        --name ManufacturingSystemSubnet \
        --address-prefixes 10.30.10.0/24

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ManufacturingVnet \
        --name SensorSubnet1 \
        --address-prefixes 10.30.20.0/24

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ManufacturingVnet \
        --name SensorSubnet2 \
        --address-prefixes 10.30.21.0/24

    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ManufacturingVnet \
        --name SensorSubnet3 \
        --address-prefixes 10.30.22.0/24
    ```

1. Let's take a look at the resources created. Run this command to show all the subnets that we configured:

    ```azurecli
    az network vnet subnet list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ManufacturingVnet \
        --output table
    ```

    You should see the following subnets listed:

    ```azurecli
    AddressPrefix    Name                       PrivateEndpointNetworkPolicies    PrivateLinkServiceNetworkPolicies    ProvisioningState    ResourceGroup
    ---------------  -------------------------  --------------------------------  -----------------------------------  -------------------  -------------------------------------------
    10.30.10.0/24    ManufacturingSystemSubnet  Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.30.20.0/24    SensorSubnet1              Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.30.21.0/24    SensorSubnet2              Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    10.30.22.0/24    SensorSubnet3              Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    ```

## Create the *ResearchVnet* virtual network

1. In Cloud Shell, run the following command to create the **ResearchVnet** virtual network:

    ```azurecli
    az network vnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name ResearchVnet \
        --address-prefixes 10.40.40.0/24 \
        --location westindia
    ```

1. Now, let's create the subnets that we need for the planned resources in the virtual network:

    ```azurecli
    az network vnet subnet create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ResearchVnet \
        --name ResearchSystemSubnet \
        --address-prefixes 10.40.40.0/24
    ```

1. Let's take a look at the final virtual network. Run this command to show all the subnets that we configured:

    ```azurecli
    az network vnet subnet list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vnet-name ResearchVnet \
        --output table
    ```

    You should see the following subnets listed:

    ```azurecli
    AddressPrefix    Name                  PrivateEndpointNetworkPolicies    PrivateLinkServiceNetworkPolicies    ProvisioningState    ResourceGroup
    ---------------  --------------------  --------------------------------  -----------------------------------  -------------------  -------------------------------------------
    10.40.40.0/24    ResearchSystemSubnet  Enabled                           Enabled                              Succeeded            <rgn>[sandbox resource group name]</rgn>
    ```

With the virtual networks and subnets created, you have the infrastructure on which you can deploy resources.

You can further integrate these networks through virtual network peering and through Azure VPN Gateway to connect to on-premises networks. You can use network security groups to filter traffic and control access within and between virtual networks.