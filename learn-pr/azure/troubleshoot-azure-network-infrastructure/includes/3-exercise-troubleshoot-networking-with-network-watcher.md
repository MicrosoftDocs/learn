Azure Network Watcher helps you diagnose configuration errors that prevent virtual machines (VMs) from communicating.

Suppose you have two VMs that can't communicate. You want to diagnose the problem and resolve it as fast as possible. You want to use Network Watcher to do that.

Here, you'll troubleshoot connectivity between two VMs in different subnets.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Configure a virtual network and VMs

Let's start by creating the infrastructure. We'll also purposely be creating a configuration error:

1. In your browser, open an [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) session.

1. Open the directory in which you want to create resources.

1. Select **Bash** in the top left of the **Cloud Shell** menu bar.

1. List the supported regions for your subscription.

    ```azurecli
    az account list-locations
    ```

1. Create a resource group and assign it to the variable name **RG** by running the following code, replacing `<resource group name>` with a name for your resource group, and `<name>` with the *name* of a region from the previous output.

    ```azurecli
    az group create --name <resource group name> --location <name>
    RG=<resource group name>
    ```

1. Create a virtual network named **MyVNet1** with a subnet named **FrontendSubnet** by running this command.

    ```azurecli
    az network vnet create \
        --resource-group $RG \
        --name MyVNet1 \
        --address-prefixes 10.10.0.0/16 \
        --subnet-name FrontendSubnet \
        --subnet-prefixes 10.10.1.0/24
    ```

1. Create another subnet called **BackendSubnet** by running this command.

    ```azurecli
    az network vnet subnet create \
    --address-prefixes 10.10.2.0/24 \
    --name BackendSubnet \
    --resource-group $RG \
    --vnet-name MyVNet1
    ```

1. Deploy a VM in **FrontendSubnet** by running this command, replacing `<password>` with a complex password of your choice.

    ```azurecli
    az vm create \
        --resource-group $RG \
        --name FrontendVM \
        --vnet-name MyVNet1 \
        --subnet FrontendSubnet \
        --image Win2019Datacenter \
        --admin-username azureuser \
        --admin-password <password>
    ```

    > [!NOTE]
    > If you get an error "partofthepassword: event not found", create a new password using allowed characters.

1. Install IIS on **FrontendVM** by running the following code.

    ```azurecli
    az vm extension set \
        --publisher Microsoft.Compute \
        --name CustomScriptExtension \
        --vm-name FrontendVM \
        --resource-group $RG \
        --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}' \
        --no-wait
    ```

1. Deploy a virtual machine in **BackendSubnet** by running this command, replacing `<password>` with a complex password of your choice.

    ```azurecli
    az vm create \
        --resource-group $RG \
        --name BackendVM \
        --vnet-name MyVNet1 \
        --subnet BackendSubnet \
        --image Win2019Datacenter \
        --admin-username azureuser \
        --admin-password <password>
    ```

1. Install IIS on **BackendVM** by running this command.

    ```azurecli
    az vm extension set \
        --publisher Microsoft.Compute \
        --name CustomScriptExtension \
        --vm-name BackendVM \
        --resource-group $RG \
        --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}' \
        --no-wait
    ```

1. Create a network security group (NSG) **MyNsg** by entering the following command.

    ```azurecli
    az network nsg create \
        --name MyNsg \
        --resource-group $RG
    ```

1. Create a **configuration _mistake_ that prevents communication** between the VMs.

    ```azurecli
    az network nsg rule create \
        --resource-group $RG \
        --name MyNSGRule \
        --nsg-name MyNsg \
        --priority 4096 \
        --source-address-prefixes '*' \
        --source-port-ranges '*' \
        --destination-address-prefixes '*' \
        --destination-port-ranges 80 443 3389 \
        --access Deny \
        --protocol TCP \
        --direction Inbound \
        --description "Deny from specific IP address ranges on 80, 443 and 3389."
    ```

1. Run the following command to associate a network security group with a subnet.

    ```azurecli
    az network vnet subnet update \
        --resource-group $RG \
        --name BackendSubnet \
        --vnet-name MyVNet1 \
        --network-security-group MyNsg
    ```

## Enable Network Watcher for your region

Now, let's use Azure CLI to set up Network Watcher in the same region as the infrastructure.

1. Enable Network Watcher by running this command, replacing `<location>` with the Azure region you used when you created your resource group at the beginning of this session.

```azurecli
az network watcher configure \
    --enabled true \
    --resource-group $RG \
    --locations <location>
```

## Use Network Watcher to show the topology

Now, you can use Network Watcher in the Azure portal to troubleshoot connectivity between two VMs in different subnets. Your colleague has reported a connectivity issue over HTTP/HTTPS between the two VMs. First, investigate the network topology.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the global search, enter **Network Watcher** and select that service. The **Network Watcher** Overview pane appears, listing the active network watcher.

1. In the Network Watcher menu, under **Monitoring**, select **Topology**. The **Network Watcher | Topology** pane appears.

1. In the dropdown fields, select your **Subscription** and **Resource Group** for this exercise. The network topology for **MyVNet1** displays the frontend and backend VM interfaces. This is the virtual network you created at the beginning of this exercise.

   :::image type="content" source="../media/3-network-topology.png" alt-text="Screenshot showing the exercise network topology." lightbox="../media/3-network-topology.png":::

## Use Connection Monitor to run tests from the backend to the frontend

The topology appears to be correct. To get more information, let's set up some tests in Connection Monitor. Start by creating a test from the backend VM to the frontend VM.

1. In the Network Watcher menu, under **Monitoring**, select **Connection monitor**. The **Network Watcher | Connection monitor** Overview pane appears.

1. From the command bar, select **Create**. The **Create Connection Monitor** page appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Connection Monitor Name | Back-to-front-HTTP-test |
    | Subscription | Select your subscription from the drop-down list |
    | Region | Select the Azure region in which you deployed your resources |
    | Workspace configuration | Use workspace created by connection monitor (default) is checked |

1. Select **Next : Test groups**. The **Add test group details** pane appears.

1. For Test group name, enter *Back-to-front-HTTP-test-group*.

1. In the **Sources** box, select **Add sources**. The **Add Sources** pane appears. 
 
1. On the **Azure endpoints** tab, select **Subnet**, ensure your subscription is selected, and then select **BackendSubnet** from the list.

    :::image type="content" source="../media/3-enable-network-watcher.png" alt-text="Screenshot that shows enabling of Network Watcher backend subnet.":::

1. Select **Add endpoints**. In the **Sources** box with the BackendSubnet identified as your source. Select this endpoint, select **Edit**, and rename it to **BackendSubnet**, then select **Save**.

    :::image type="content" source="../media/3-update-endpoint-name-network-watcher.png" alt-text="Screenshot that shows editing endpoint name.":::

1. In the **Test configurations** box, select **Add Test configuration**. The **Add Test configuration** pane appears.

1. On the **New configuration** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Test configuration name | Back-to-front-HTTP-test-configuration |
    | Protocol | HTTP |
    | Destination port | 80 |
    | Test Frequency | Every 30 seconds |
    | *Keep the default values for the remaining settings* |

1. Select **Add Test configuration** to add this test configuration to your test group.  The **Add test group details** reappears with your test configuration identified.

1. In the **Destinations** box, select **Add destinations**. The **Add Destinations** pane appears.

1. On the **Azure endpoints** tab, select **Subnet**, ensure your subscription is selected, and then select **FrontendSubnet** from the list.

1. Select **Add endpoints**. The **Add test group details** reappears with the FrontendSubnet identified as your destination.  

1. At the bottom of the pane, select **Add Test Group**. The **Create Connection Monitor** pane appears.

1. On the **Test groups** tab, notice that your test group is listed with source as backend and destination as frontend.

1. Select **Review + create** and **Create**.

If your test doesn't appear on the **Connection Monitor** pane, select the **Refresh** button. The results of the Back-to-front-HTTP-test should show that, because the NSG is associated with the backend subnet, traffic flows without issues from the backend VM to the frontend VM.

## Use Connection Monitor to run tests from the frontend to the backend

Run the same test in the opposite direction. Let's set up another test in Connection Monitor. Start by creating a test from the frontend VM to the backend VM.

1. On the **Connection Monitor** pane, select **Create**.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Connection Monitor Name | Front-to-back-HTTP-test |
    | Subscription | Select your subscription from the drop-down list |
    | Region | Select the Azure region in which you deployed your resources |

1. Select **Next : Test groups**. The **Add test group details** pane appears.

1. In **Test group name**, enter *Front-to-back-HTTP-test-group*, then select **Add sources** in the Sources box. The **Add Sources** pane appears.

1. On the **Azure endpoints** tab, select **Subnet**, ensure your subscription is selected, and then select **FrontSubnet** from the list.

1. Select **Add endpoints**. In the **Sources** box with the BackendSubnet identified as your source. Select this endpoint, select **Edit**, and rename it to **FrontendSubnet**, then select **Save**.

1. In the **Test configurations** box, select **Add Test configuration**. The **Add Test configuration** pane appears.

1. On the **New configuration** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | Test configuration name | Front-to-back-HTTP-test-configuration |
    | Protocol | HTTP |
    | Destination port | 80 |
    | Test Frequency | Every 30 seconds |
    | *Accept the default values for the remaining settings* |

1. Select **Add Test configuration**. The **Add test group details** reappears with your test configuration identified.

1. In the **Destinations** box, select **Add destinations**. The **Add Destinations** pane appears.

1. On the **Azure endpoints** tab, select **Subnet**, ensure your subscription is selected, and then select **BackendSubnet** from the list.

1. Select **Add endpoints**. The **Add test group details** pane reappears with the BackendSubnet identified as your destination.

1. At the bottom of the pane, select **Add Test Group**. The **Create Connection Monitor** pane reappears.

1. On the **Test groups** tab, notice that your Front-to-back-HTTP-test-group is now listed.

1. Select **Review + create** and **Create**.

If your test doesn't appear on the **Connection Monitor** pane, select the **Refresh** button. The results of the Front-to-back-HTTP-test should show that, because the NSG is associated with the backend subnet, no traffic flows from the frontend VM to the backend VM.

## Use IP flow verify to test the connection

Let's use the IP flow verify tool to get more information.

1. Select **Network Watcher**, and in the resource menu under **Network diagnostic tools**, select **IP flow verify**.

1. Configure the test by entering the following values for each setting, and then select **Check**.

    | Setting | Value |
    | --- | --- |
    | Subscription | Select your subscription |
    | Resource group | Select your resource group |
    | Virtual machine | BackendVM |
    | Network interface | BackendVMVMNic |
    | Protocol | TCP |
    | Direction | Inbound |
    | Local IP address | 10.10.2.4 |
    | Local port | 3389 |
    | Remote IP | 10.10.1.4 |
    | Remote port | 3389 |
    | | |

    :::image type="content" source="../media/3-ip-flow-test.png" alt-text="Screenshot showing an IP flow test.":::

1. The Result shows Access denied because of NSG and security rules.

In this exercise, you have successfully used Network Watcher tools to discover the connectivity issue between the two subnets. Communication is allowed one way but blocked the other way because of NSG rules.
