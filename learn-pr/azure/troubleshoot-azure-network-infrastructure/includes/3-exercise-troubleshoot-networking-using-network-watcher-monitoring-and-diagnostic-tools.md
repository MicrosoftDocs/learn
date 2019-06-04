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
--location EastUS
```

2.Run the following commands to deploy virtual machine in **Frontend subnet**.

```
az vm create --resource-group <rgn>[sandbox resource group name]</rgn> \
--no-wait \
--name FrontendVM \
--location EastUS \
--vnet-name MyVNet1 \
--subnet FrontendSubnet \
--image Win2012R2Datacenter \
--admin-username azureuser \
--admin-password Demouser@123
```

3.Run the following command to create the **Backend subnet**.

```
New-AzVirtualNetworkSubnetConfig
--Name BackendSubnet \
--AddressPrefix 10.10.2.0/24 \
```

4.Run the following commands to deploy virtual machine in **Backend subnet**.

```
az vm create --resource-group <rgn>[sandbox resource group name]</rgn> \
--no-wait \
--name BackendVM \
--location EastUS \
--vnet-name MyVNet1 \
--subnet BackendSubnet \
--image Win2012R2Datacenter \
--admin-username azureuser \
--admin-password Demouser@123
````

5. NSG configuration mistake that impacts communication between the VMs.

```
az network nsg rule create --resource-group <rgn>[sandbox resource group name]</rgn> \
--Name MyNSGRule \
--nsg-name MyNsg \
--priority 4096 \
--source-address-prefixes 10.10.2/24
--source-port-ranges 80 443 3389 \
--destination-address-prefixes '*' \
--destination-port-ranges 80 443 3389
--access Deny \
--protocol TCP \
--description "Deny from specific IP address ranges on 80, 443 and 3389." 
```

6. Associate a network security group to a subnet.

```
az network vnet subnet update --resource-group <rgn>[sandbox resource group name]</rgn> \
--name BackendSubnet \
--vnet-name MyVNet1 \
--network-security-group MyNsg\
```

7. Enable Network Watcher

```
az network watcher configure \
--resource-group <rgn>[sandbox resource group name]</rgn> \ 
--locations EastUS \
--enabled
```

*The steps below are better suited for Azure portal, as the novice user may not be able comprehend the output of PowerShell commands, plus GUI displays some features better than PowerShell*

## Azure portal

In this step, you are going to use Network Watcher from the Azure portal to troubleshoot connectivity between 2 VMs in different subnets. Your colleague has reported connectivity issue over HTTP/HTTPS and RDP protocol between the 2 VMs. 

1. Sign into the Azure portal using the same account you activated the sandbox with.

1. Navigate to **All Services > Networking > Network Watcher**, select it

1. View Network Topology to visualize your network

1. Use connection monitor - test the connection from the backendVM to frontendVM.
   
   - back-to-front-RDPtest - test from backend VM to frontend VM on the RDP port (3389). Set the probe interval to be 30 secs.
   - back-to-front-HTTPtest - test from backend VM to frontend VM on the RDP port (80). Set the probe interval to be 30 secs.
 
     If you click on each test, what you will see its 100% probes failure and the device is unreachable. Now perform the same test but from frontend to backend.
     
   - front-to-back-RDPtest - test from frontend VM to backend VM on the RDP port (3389). Set the probe interval to be 30 secs.
   - front-to-back-HTTPtest -  test from frontend VM to backend VM on the RDP port (80). Set the probe interval to be 30 secs.

     If you click on each test, what you will see device status is reachable. Now you have established that the connectivity is working frontend to the backend but not the other way around.

1. Use IP flow verify to determine why access is denied? and identify the what is blocking the traffic? Run the 2 tests below.

     - back-front-RDPtest - test from backend VM to frontend VM on the RDP port (3389).
     - back-front-HTTPtest - test from backend VM to frontend VM on the RDP port (80).

       What you will see is access is denied due to NSG and security rule. In this exercise, you have successfully used network watcher tools to discover the connectivity issue between the 2 subnets. One way communication is allowed but one way is to blocked due to NSG rules.




