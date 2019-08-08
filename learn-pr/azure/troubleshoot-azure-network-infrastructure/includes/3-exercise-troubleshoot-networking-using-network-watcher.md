Network Watcher makes it easier to diagnose configuration errors prevent Virtual Machines (VMs) from communicating.

Suppose you have two VMs that cannot communicate. You want to diagnose the problem and resolve it as fast as possible. You want to use Network Watcher to do that.

Here, you will troubleshoot connectivity between two VMs in different subnets. 

[!include[](../../../includes/azure-sandbox-activate.md)]

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Configure a virtual network and VMs

Let's start by creating the problematic infrastructure, which includes a configuration error:

1. In the Cloud Shell, to create the virtual network **MyVNet1** and **FrontendSubnet**, run this command:

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

## Enable Network Watcher for your region

Now let's use the Azure CLI to set up Network Watcher in the same region as the infrastructure. 

To enable Network Watcher, run this command:

```bash
az network watcher configure --resource-group <rgn>[sandbox resource group name]</rgn> \ 
  --locations EastUS \
  --enabled
```

## Use Network Watcher to show the topology

Now you can use Network Watcher to troubleshoot connectivity between two VMs in different subnets. Your colleague has reported connectivity issue over HTTP/HTTPS and RDP protocol between the two VMs. First, investigate the network topology: 

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account that you used to activate the sandbox.
1. Navigate to **All Services > Networking > Network Watcher** and then click **Topology**.
1. In the drop-down lists, select the only subscription and resource group. Network Watcher displays your network topology:

    ![Network topology](../media/3-network-topology.png)

## Use connection monitor to run tests from the backend to the frontend

The topology appears to be correct. Let's set up some tests in connection monitor to obtain more information. Start by creating two tests from the backend VM to the frontend VM:

1. Under **Monitoring**, click **Connection monitor**, and then click **+ Add**.
1. Configure the connection monitor with these values, and then click **Add**:

    | Setting | Value |
    | --- | --- |
    | Name | Back-to-front-RDP-test |
    | Subscription | Concierge |
    | Virtual machine | BackendVM |
    | Destination virtual machine | FrontendVM |
    | Port | 3389 |
    | Probing interval | 30 seconds |
    | | |

    ![Back-to-front RDP test](../media/3-back-to-front-rdp-test.png)

1. Click **+ Add** and then configure a second test with these values, and then click **Add**:

    | Setting | Value |
    | --- | --- |
    | Name | Back-to-front-HTTP-test |
    | Subscription | Concierge |
    | Virtual machine | BackendVM |
    | Destination virtual machine | FrontendVM |
    | Port | 80 |
    | Probing interval | 30 seconds |
    | | |

1. In the list of tests, click **Back-to-front-RDP-test**, click **...**. and then click **Start**.
1. Examine the results.
1. In the list of tests, click **Back-to-front-HTTP-test**, click **...**. and then click **Start**.
1. Examine the results. 

The results should show that no traffic flows from the backend VM to the frontend VM.

## Use connection monitor to run tests from the frontend to the backend

Run the same tests in the opposite direction:

1. Under **Monitoring**, click **Connection monitor**, and then click **+ Add**.
1. Configure the connection monitor with these values, and then click **Add**:

    | Setting | Value |
    | --- | --- |
    | Name | front-to-back-RDP-test |
    | Subscription | Concierge |
    | Virtual machine | FrontendVM |
    | Destination virtual machine | BackendVM |
    | Port | 3389 |
    | Probing interval | 30 seconds |
    | | |

1. Click **+ Add** and then configure a second test with these values, and then click **Add**:

    | Setting | Value |
    | --- | --- |
    | Name | Front-to-back-HTTP-test |
    | Subscription | Concierge |
    | Virtual machine | FrontendVM |
    | Destination virtual machine | BackendVM |
    | Port | 80 |
    | Probing interval | 30 seconds |
    | | |

1. In the list of tests, click **Front-to-back-RDP-test**, click **...**. and then click **Start**.
1. Examine the results.
1. In the list of tests, click **Front-to-back-HTTP-test**, click **...**. and then click **Start**.
1. Examine the results.

The results should show that traffic flows without problems from the frontend VM to the backend VM.

## Use IP flow to test the connection

Let's use the IP flow test tool to obtain more information:

1. Under **Network diagnostic tools**, click **IP flow verify**.
1. Configure the test with these values, and then click **Check**:

    | Setting | Value |
    | --- | --- |
    | Subscription | Concierge |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Virtual machine | BackendVM |
    | Network interface | BackendVMVMNic |
    | Protocol | TCP |
    | Direction | Outbound |
    | Local IP address | 10.10.2.4 |
    | Local port | 3389 |
    | Remote port | 10.10.1.4 |
    | Remote port | 3389 |
    | | |

    ![IP flow test](../media/3-ip-flow-test.png)

1. Examine the results. They show that access is denied due to NSG and security rule. 

In this exercise, you have successfully used network watcher tools to discover the connectivity issue between the two subnets. One way communication is allowed but one way is to blocked due to NSG rules.




