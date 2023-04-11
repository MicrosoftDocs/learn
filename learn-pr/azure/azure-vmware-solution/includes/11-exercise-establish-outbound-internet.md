This unit focuses on practical implementation of enabling network controls using Azure Firewall. You'll then test if those controls are working or not from a VM in Azure VMware Solution workload segment.

## Capture Azure VMware Solution workload segment address space

Use command below to get the workload segment address space from Azure VMware Solution private cloud:

```azurecli

az vmware workload-network segment show --resource-group <resource-group-name>  --private-cloud <avs-private-cloud-name>
```

## Configure Azure Firewall Rule for Azure VMware Solution workload network segment
Use command below to configure Firewall rule for workload segment:

```azurecli
az network firewall network-rule create  --collection-name <firewall-rule-collection-name>  --destination-addresses <*-or-selective-addresses-to-be-opened>  --destination-ports <*-or-selective-ports-to-be-opened>  --firewall-name <name-of-firewall>  --name <firewall-rule-name> --protocols <*-or-selective-protocols-to-be-opened>  --resource-group <resource-group-name>  --priority <your-priority-preference>  --source-addresses <azure-vmware-solution-workload-network-segment-address-space>  --action Allow
```

## Test outbound internet connectivity from a VM in Azure VMware Solution workload network segment

1. Log on to the VM in Azure VMware Solution workload network segment.
1. Navigate to any public URL from the VM. Any public URL should be accessible from browser.
