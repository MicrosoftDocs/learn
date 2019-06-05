Network Watcher makes it easier to diagnose configuration errors prevent Virtual Machines (VMs) from communicating.

Suppose you have two VMs that cannot communicate. You want to diagnose the problem and resolve it as fast as possible. You want to use Network Watcher to do that.

Here, you will troubleshooting connectivity between two VMs in different subnets. 

[!include[](../../../includes/azure-sandbox-activate.md)]

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Configure a virtual network and VMs

Let's start by creating the problematic infrastructure, which includes a configuraion error:

1. To create the virtual network **MyVNet1** and **FrontendSubnet**, run this command:

    ```bash
    az network vnet create --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name MyVNet1 \
      --address-prefix 10.10.0.0/16 \
      --subnet-name FrontendSubnet \
      --subnet-prefix 10.10.1.0/24 \
      --location EastUS
    ```

1. To deploy a VM in **Frontend subnet**, run this command:

    ```bash
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

1. To create the **Backend subnet**, run this command:

    ```bash
    az network vnet subnet create --address-prefixes 10.10.2.0/24 \
      --name BackendSubnet \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --vnet-name MyVNet1
    ```

1. To deploy a virtual machine in **Backend subnet**, run this command:

    ```bash
    az vm create --resource-group <rgn>[sandbox resource group name]</rgn> \
      --no-wait \
      --name BackendVM \
      --location EastUS \
      --vnet-name MyVNet1 \
      --subnet BackendSubnet \
      --image Win2012R2Datacenter \
      --admin-username azureuser \
      --admin-password Demouser@123
    ```

1. To create a Network Security Group, run this command:

    ```bash
    az network nsg create --name MyNsg \
       --resource-group <rgn>[sandbox resource group name]</rgn> \
       --location EastUS
    ```

1. To create an NSG configuration mistake that prevents communication between the VMs, run this command:

    ```bash
    az network nsg rule create --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name MyNSGRule \
      --nsg-name MyNsg \
      --priority 4096 \
      --source-address-prefixes 10.10.2.0/24 \
      --source-port-ranges 80 443 3389 \
      --destination-address-prefixes '*' \
      --destination-port-ranges 80 443 3389 \
      --access Deny \
      --protocol TCP \
      --description "Deny from specific IP address ranges on 80, 443 and 3389." 
    ```

1. To associate a network security group to a subnet, run this command:

    ```bash
    az network vnet subnet update --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name BackendSubnet \
      --vnet-name MyVNet1 \
      --network-security-group MyNsg
    ```

1. To enable Network Watcher, run this command:

    <!-- TODO: This command currently causes a policy error in the sandbox. Policy to be updated to allow network watcher. -->

    ```bash
    az network watcher configure --resource-group <rgn>[sandbox resource group name]</rgn> \ 
      --locations EastUS \
      --enabled
    ```

## Use Network Watcher to diagnose a problem

Now let's use Network Watcher to troubleshoot connectivity between two VMs in different subnets. Your colleague has reported connectivity issue over HTTP/HTTPS and RDP protocol between the 2 VMs: 

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account that you used to activate the sandbox.
1. Navigate to **All Services > Networking > Network Watcher** and then click **Network Topology**.
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




