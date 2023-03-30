The following steps explain how to create and configure Azure Route Server (ARS).  Here, you'll use Azure Command Line Interface (CLI). However, you can use Azure Portal, PowerShell or Terraform to achieve same effect.

## Create Resource Group & Virtual Network
It is recommended to deploy Azure VMware Solution private cloud as part of Azure Landing Zone Architecture. Using Landing Zone architecture helps to meet changing requirements effectively, meet governance requirements faster and promote reuse of shared services to drive cost optimization. In this architecture, a separate subscription is used to deploy Azure VMware Solution private cloud. Azure Landing Zone connectivity subscription should be used to deploy Azure Networking services such as Azure Route Server, Azure ExpressRoute Gateway, Azure Firewall, etc.

The first step you will take is to configure Azure VMware Solution private cloud with the right resource group and virtual network to enable outbound internet connectivity.

Use the commands below to deploy them:

```azurecli
az group create -l <your-preferred-azure-region> -n <resource-group-name>

az network vnet create  -n <vnet-name>  -g <resource-group-name>  --address-prefix 10.0.0.0/16

az network vnet subnet create  -n RouteServerSubnet -g <resource-group-name> --vnet-name <vnet-name>  --address-prefix 10.0.0.0/24

az network public-ip create  -n <name-for-route-server-pip>  -g <resource-group-name>  --version IPv4  --sku Standard

$ars_subnet_id=$(az network vnet subnet show  --name RouteServerSubnet  --resource-group <resource-group-name> --vnet-name <vnet-name>  --query id -o tsv)
```

## Deploy Azure Route Server

Azure Route Server uses BGP to exchange routes between a custom or third party NVA router and ExpressRoute Gateway. ExpressRoute Gateway is the one which is used to terminate Azure VMware Solution private cloud. Use the instructions below to create Azure Route Server.

Now that you have AVS private cloud configured, you need to set up a route exchange mechanism. To do this, you'll start by deploying Azure Route Server:

```azurecli
az network routeserver create --name <routeserver-name>  --resource-group <resource-group-name>  --hosted-subnet $ars_subnet_id  --public-ip-address <name-for-route-server-pip> 
```

## Enable Branch-to-branch connectivity
The last step is to set up your route exchange mechanism is to enable branch-to-branch connectivity: 

```azurecli
az network routeserver update --name <routeserver-name>  --resource-group <resource-group-name>   --allow-b2b-traffic true
```

You have now completed two important tasks. First, you will need to configure Azure VMware Solution private cloud correctly for outbound internet connectivity. Second, you will set up a route exchange mechanism between ARS and Azure VMware Solution private cloud.  You will look at introducing security into the design in next unit.
