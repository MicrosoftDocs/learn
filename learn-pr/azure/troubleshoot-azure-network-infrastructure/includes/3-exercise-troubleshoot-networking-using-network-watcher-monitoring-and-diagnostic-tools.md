3. **Exercise - Troubleshoot networking using Network Watcher monitoring and diagnostic tools**

In this module, you will do an exercise which involves troubleshooting connectivity between 2 VMs in different subnets. This exercise will be broken down into 2 parts. First, you will create a VNet with 2 subnets *(frontend and backend)*. Deploy VM inside each subnet and enable Azure Network Watcher. This will be done using the Azure CLI. In the second part, you will use the Azure portal to troubleshooting connectivity between 2 VMs in different subnets.

## Exercise - Troubleshoot networking using Network Watcher monitoring and diagnostic tools


1.Run the following command to create the virtual network **MyVNet1** and **FrontendSubnet**.

```
az network vnet create --resource-group <rgn>[sandbox resource group name]</rgn> \
--name MyVNet1 \
--address-prefix 10.10.0.0/16 \
--subnet-name FrontendSubnet \
--subnet-prefix 10.10.1.0/24 \
--location WestUS
```

2.Run the following commands to deploy virtual machine in **Frontend subnet**.

```
az vm create --resource-group <rgn>[sandbox resource group name]</rgn> \
--no-wait \
--name FrontendVM \
--location WestUS \
--vnet-name MyVNet1 \
--subnet FrontendSubnet \
--image Win2012R2Datacenter \
--admin-username azureuser \
--admin-password Demouser@123
```

3.Add the Network Watcher Agent to the  **FrontendVM**. 

```
 Set-AzVMExtension --resource-group <rgn>[sandbox resource group name]</rgn> \`
  --Location WestUS \
  --VMName FrontendVM \
  --Name networkWatcherAgent \
  --Publisher Microsoft.Azure.NetworkWatcher \
  --Type NetworkWatcherAgentWindows \
  --TypeHandlerVersion 1.4 \
```

4.Run the following command to create the **Backend subnet**.

```
New-AzVirtualNetworkSubnetConfig
--Name BackendSubnet \
--AddressPrefix 10.10.2.0/24 \
```

5.Run the following commands to deploy virtual machine in **Backend subnet**.

```
az vm create --resource-group <rgn>[sandbox resource group name]</rgn> \
--no-wait \
--name BackendVM \
--location WestUS \
--vnet-name MyVNet1 \
--subnet BackendSubnet \
--image Win2012R2Datacenter \
--admin-username azureuser \
--admin-password Demouser@123
````

6.Add the Network Watcher Agent to the  **BackendVM**.

```
 Set-AzVMExtension --resource-group <rgn>[sandbox resource group name]</rgn> \
  --Location WestUS \
  --VMName BackendVM \
  --Name networkWatcherAgent \
  --Publisher Microsoft.Azure.NetworkWatcher \
  --Type NetworkWatcherAgentWindows \
  --TypeHandlerVersion 1.4 \
```

7. NSG configuration mistake that impacts communication between the VMs.

```
az network nsg rule create --resource-group <rgn>[sandbox resource group name]</rgn> \
--Name MyNSGRule \
--nsg-name MyNsg \
--priority 4096 \
--source-address-prefixes 10.10.2/24
--source-port-ranges 80 \
--destination-address-prefixes '*' \
--destination-port-ranges 80 8080 3389
--access Deny \
--protocol TCP \
--description "Deny from specific IP address ranges on 80, 8080 and 3389." 
```

## Enable Network Watcher

```
az network watcher configure \
--resource-group <rgn>[sandbox resource group name]</rgn> \ 
--locations WestUS \
--enabled
```

*The steps below are better suited for Azure portal, as the novice user may not be able comprehend the output of PowerShell commands, plus GUI displays some features better than PowerShell*

## Azure portal

In this step, you are going to use Network Watcher from the Azure portal to troubleshoot connectivity between 2 VMs in different subnets

1. Sign into the Azure portal using the same account you activated the sandbox with.

1. Navigate to **All Services > Networking > Network Watcher**, select it

1. View Network Topology

1. Use connection troubleshoot to test connectivity from **BackendSubnet** VM (10.10.2.0/24) to the **FrontendSubnet** VM over port *80, 8080 and 3389*

1. Use IP flow verify to determine why access is denied? and identify the  **NSG rule** that is blocking the traffic

1. Use connection troubleshoot to test connectivity from **FrontendSubnet** VM (10.10.1.0/24) to the **BackendSubnet** VM over port *80, 8080 and 3389*. This should work as there is NSG rules blocking traffic.


