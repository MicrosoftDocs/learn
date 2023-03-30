You will use the instructions below to create and configure Azure Firewall and Route Table.

## Deploy Azure Firewall

Follow the instructions below to create a new Azure Firewall.

```azurecli
az network vnet subnet create  -n AzureFirewallSubnet -g <resource-group-name> --vnet-name <vnet-name>  --address-prefix 10.0.1.0/24

az network public-ip create  -n <name-for-firewall-pip>  -g <resource-group-name>  --version IPv4  --sku Standard

az network firewall create  -n <name-of-firewall>   -g <resource-group-name>  --location <your-preferred-azure-region>

az network firewall ip-config create --firewall-name <name-of-firewall>  --name <firewall-config-name>  --public-ip-address <name-of-firewall-pip>  --resource-group <resource-group-name>  --vnet-name <vnet-name>  

az network firewall update  --name <name-of-firewall>  --resource-group <resource-group-name>  
```

## Create route & route table

Follow the steps below to create a new route table and route.

```azurecli
az network route-table create  --name <firewall-route-table-name>  --resource-group <resource-group-name>  --location <your-preferred-azure-region> --disable-bgp-route-propagation true
```

The following route enables Azure Firewall to have direct internet connectivity:

```azurecli
az network route-table route create --resource-group <resource-group-name>  --name <route-name>  --route-table-name <firewall-route-table-name>  --address-prefix 0.0.0.0/0 --next-hop-type Internet 
```

## Associate route table with the Azure Firewall's subnet

Use the command below to apply Route Table and Route on the subnet, which is used to deploy Azure Firewall:

```azurecli
az network vnet subnet update  --name AzureFirewallSubnet  --resource-group <resource-group-name>   --vnet-name <vnet-name>  --route-table <firewall-route-table-name>
```

After setting up Azure Firewall, you'll look at how to generate a default route, which enables internet connectivity through Azure Firewall, in next unit.
