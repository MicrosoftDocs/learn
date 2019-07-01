You're now ready to complete your site-to-site VPN gateway by creating the public IP addresses, virtual network gateways, and connections. Remember that you used placeholders for the public IP address references when you created your local network gateways. So one of your tasks now is to update these gateways with the actual public IP addresses assigned to your virtual network gateways.

Ideally, the public IP addresses and virtual network gateways should be created *before* the local network gateways. In this exercise, you'll see how to update the local network gateways. You can use the same commands to update any configuration elements in the local network gateways, like remote network address spaces.

## Create virtual machines

To verify that your virtual networks are connected, you'll create two Ubuntu VMs, one in each of the virtual networks. You'll then use SSH to connect from the VM in the HQ-Network to the VM in the Azure-VNet-1 virtual network by using its private IP address.

To save time, you'll start the deployment of these virtual machines using the `--no-wait` parameter. This will continue deployment, but allow you to continue on with the exercise.

1. Run this command in Cloud Shell to create an Ubuntu VM in the **HQ-Network** virtual network. Replace `<password>` with a string to use for the admin password.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name HQ-VM \
        --vnet-name HQ-Network \
        --subnet Applications \
        --image UbuntuLTS \
        --admin-username azureuser \
        --no-wait \
        --admin-password <password>
    ```

1. Run this command in Cloud Shell to create an Ubuntu VM in the **Azure-VNet-1** virtual network. Replace `<password>` with a string to use for the admin password. To prove that you're making a connection through the VPN gateways, you'll provision this VM *without* a public IP address.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name Azure-VM \
        --vnet-name Azure-VNet-1 \
        --subnet Services \
        --image UbuntuLTS \
        --admin-username azureuser \
        --public-ip-address "" \
        --no-wait \
        --admin-password <password>
    ```

## Create the Azure-side VPN gateway

Next, you'll create the VPN gateway for the Azure end of the connection. It can take up to 45 minutes to create a virtual network gateway. To save time, you'll use Azure CLI commands with the `--no-wait` parameter. This parameter lets you create both virtual network gateways simultaneously to minimize the overall time required to create these resources.

1. Run this command in Cloud Shell to create the **PIP-VNG-Azure-VNet-1** public IP address.

    ```azurecli
    az network public-ip create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name PIP-VNG-Azure-VNet-1 \
        --allocation-method Dynamic
    ```

1. Run this command in Cloud Shell to create the **VNG-Azure-VNet-1** virtual network gateway.

    ```azurecli
    az network vnet-gateway create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name VNG-Azure-VNet-1 \
        --public-ip-address PIP-VNG-Azure-VNet-1 \
        --vnet Azure-VNet-1 \
        --gateway-type Vpn \
        --vpn-type RouteBased \
        --sku VpnGw1 \
        --no-wait
    ```

## Create the on-premises VPN gateway

Next, you'll create a VPN gateway to simulate an on-premises VPN device.

1. Run this command in Cloud Shell to create the **PIP-VNG-HQ-Network** public IP address.

    ```azurecli
    az network public-ip create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name PIP-VNG-HQ-Network \
        --allocation-method Dynamic
    ```

1. Run these commands in Cloud Shell to create the **VNG-HQ-Network** virtual network gateway.

    ```azurecli
    az network vnet-gateway create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name VNG-HQ-Network \
        --public-ip-address PIP-VNG-HQ-Network \
        --vnet HQ-Network \
        --gateway-type Vpn \
        --vpn-type RouteBased \
        --sku VpnGw1 \
        --no-wait
    ```

    It can take several minutes to create the gateway.

1. To monitor the progress of the gateway creation, run the following command. We're using the Linux `watch` command to run the `az network vnet-gateway list` command periodically, which allows you to monitor the progress.

    ```bash
    watch -d -n 5 az network vnet-gateway list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --output table
    ```

    After each VPN gateway shows a **ProvisioningState** of **Succeeded**, you're ready to continue. Press Ctrl+C to halt the command after the gateway is created.

    ```output
    ActiveActive    EnableBgp    GatewayType    Location        Name              ProvisioningState    ResourceGroup                         ResourceGuid                          VpnType
    --------------  -----------  -------------  --------------  ----------------  -------------------  -----------------------------  ------------------------------------  ----------
    False           False        Vpn            southcentralus  VNG-Azure-VNet-1  Succeeded            <rgn>[sandbox resource group name]</rgn>  48dc714e-a700-42ad-810f-a8163ee8e001  RouteBased
    False           False        Vpn            southcentralus  VNG-HQ-Network    Succeeded            <rgn>[sandbox resource group name]</rgn>  49b3041d-e878-40d9-a135-58e0ecb7e48b  RouteBased
    ```

## Update the local network gateway IP references

> [!IMPORTANT]
> Your virtual network gateways must be successfully deployed before you start the next exercise.

In this section, you'll update the remote gateway IP address references that are defined in the local network gateways. You can't update the local network gateways until you've created the VPN gateways and an IPv4 address is assigned to and associated with them. You can use this Azure CLI command to check whether both virtual network gateways have been created:

```azurecli
az network vnet-gateway list \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --query "[?provisioningState=='Succeeded']" \
    --output table
```

Remember to wait until the lists of gateways are successfully returned. Also, remember that the local network gateway resources define the settings of the *remote* gateway and network that they're named after. For example, the **LNG-Azure-VNet-1** local network gateway contains information like the IP address and networks for **Azure-VNet-1**.

1. Run this command in Cloud Shell to retrieve the IPv4 address assigned to **PIP-VNG-Azure-VNet-1**.

    ```bash
    PIPVNGAZUREVNET1="$(az network public-ip show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name PIP-VNG-Azure-VNet-1 \
        --query "[ipAddress]" \
        --output tsv)"
    ```

1. Run this command in Cloud Shell to update the **LNG-Azure-VNet-1** local network gateway so that it points to the public IP address attached to the **VNG-Azure-VNet-1** virtual network gateway.

    ```azurecli
    az network local-gateway update \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name LNG-Azure-VNet-1 \
        --gateway-ip-address $PIPVNGAZUREVNET1
    ```

1. Run this command in Cloud Shell to retrieve the IPv4 address assigned to **PIP-VNG-HQ-Network**.

    ```bash
    PIPVNGHQNETWORK="$(az network public-ip show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name PIP-VNG-HQ-Network \
        --query "[ipAddress]" \
        --output tsv)"
    ```

1. Run this command in Cloud Shell to update the **LNG-HQ-Network** local network gateway so that it points to the public IP address attached to the **VNG-HQ-Network** virtual network gateway.

   ```azurecli
   az network local-gateway update \
       --resource-group <rgn>[sandbox resource group name]</rgn> \
       --name LNG-HQ-Network \
       --gateway-ip-address $PIPVNGHQNETWORK
   ```

## Create the connections

You'll now complete the configuration by creating the connections from each VPN gateway to the local network gateway that contains the public IP address references for that gateway's remote network.

1. Create the shared key to use for the connections. In the following command, replace `<shared key>` with a text string to use for the IPSec pre-shared key. The pre-shared key is a string of printable ASCII characters no longer than 128 characters. You'll use this pre-shared key on both connections.

    ```bash
    SHAREDKEY=<shared key>
    ```

1. Remember that **LNG-HQ-Network** contains a reference to the IP address on your simulated on-premises VPN device. Run this command in Cloud Shell to create a connection from **VNG-Azure-VNet-1** to **LNG-HQ-Network**.

    ```azurecli
    az network vpn-connection create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name Azure-VNet-1-To-HQ-Network \
        --vnet-gateway1 VNG-Azure-VNet-1 \
        --shared-key $SHAREDKEY \
        --local-gateway2 LNG-HQ-Network
    ```

1. Remember that **LNG-Azure-VNet-1** contains a reference to the public IP address associated with the **VNG-Azure-VNet-1** VPN gateway. This connection would normally be created from your on-premises device. Run this command in Cloud Shell to create a connection from **VNG-HQ-Network** to **LNG-Azure-VNet-1**.

    ```azurecli
    az network vpn-connection create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name HQ-Network-To-Azure-VNet-1  \
        --vnet-gateway1 VNG-HQ-Network \
        --shared-key $SHAREDKEY \
        --local-gateway2 LNG-Azure-VNet-1
    ```

You've now finished the configuration of the site-to-site connection. The tunnels should automatically connect and become active.

## Verification steps

To verify that your virtual networks are connected, you'll use SSH to connect from the VM in **HQ-Network** to the VM in the **Azure-VNet-1** virtual network by using its private IP address.

1. Run the following command in Cloud Shell to show the public IPv4 address assigned to the **HQ-VM** VM. Remember this address. You'll need it to connect to **HQ-VM**.

    ```azurecli
    az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name HQ-VM \
        --output table
    ```

1. Run the following command in Cloud Shell to show the private IPv4 address assigned to the **Azure-VM** VM. Remember this address. You'll need it to connect to **Azure-VM**.

    ```azurecli
    az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name Azure-VM \
        --output table
    ```

    Remember that you provisioned **Azure-VM** *without* a public IP address. The private IPv4 address assigned to **Azure-VM** should be 10.0.0.4. You'll use this IPv4 address to connect from **HQ-VM** across the site-to-site connection to **Azure-VM**.

1. Run this command in Cloud Shell to open an SSH connection to **HQ-VM** by using the public IPv4 address.

    ```bash
    ssh azureuser@<public-ip-address-of-hq-vm>
    ```

1. You'll get a security notification when you first connect. Enter **yes** when prompted, and then enter the password you used when you created the VM.

1. You're now connected to **HQ-VM** at HQ. To prove you can connect to a VM in the **Azure-VNet-1** virtual network and that data can flow, open an SSH session to the private IPv4 address. While still signed in to **HQ-VM**, use the following command.

    ```bash
    ssh azureuser@10.0.0.4
    ```

1. You'll get a security notification when you first connect. Enter **yes** when prompted, and then enter the password you used when you created the VM.

    You should now be connected to **Azure-VM**. This machine wasn't assigned a public IP address. You can access this VM only through the site-to-site connection.

1. Run this command to close the SSH session from **HQ-VM** to **Azure-VM**.

    ```bash
    exit
    ```

1. Run this command to close the SSH session from Cloud Shell to **HQ-VM**.

    ```bash
    exit
    ```

The site-to-site configuration is now complete. Your final topology, including the VMs, subnets, and connections with logical connection points, is shown in this diagram:

![Resources deployed during unit 4 exercise](../media/4-resources-deployed-during-exercise-final.svg)
