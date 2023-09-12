In the next stage of your security implementation, you'll deploy a network virtual appliance (NVA) to secure and monitor traffic between your front-end public servers and internal private servers. 

You configure the appliance to forward IP traffic. If IP forwarding isn't enabled, traffic that is routed through your appliance will never be received by its intended destination servers.

In this exercise, you deploy the **nva** network appliance to the **dmzsubnet** subnet. Then you enable IP forwarding so that traffic from **** and traffic that uses the custom route is sent to the **privatesubnet** subnet.

:::image type="content" source="../media/5-nva-ip-forwarding.svg" alt-text="Visualization of a Network virtual appliance with IP forwarding enabled.":::

In the following steps, you'll deploy an NVA. You'll then update the Azure virtual NIC and the network settings within the appliance to enable IP forwarding.

## Deploy the network virtual appliance

To build the NVA, deploy an Ubuntu LTS instance.

1. In Cloud Shell, run the following command to deploy the appliance. Replace `<password>` with a suitable password of your choice for the **azureuser** admin account.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name nva \
        --vnet-name vnet \
        --subnet dmzsubnet \
        --image UbuntuLTS \
        --admin-username azureuser \
        --admin-password <password>
    ```

## Enable IP forwarding for the Azure network interface

In the next steps, IP forwarding for the **nva** network appliance is enabled. When traffic flows to the NVA but is meant for another target, the NVA will route that traffic to its correct destination.

1. Run the following command to get the ID of the NVA network interface.

    ```azurecli
    NICID=$(az vm nic list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vm-name nva \
        --query "[].{id:id}" --output tsv)

    echo $NICID
    ```

1. Run the following command to get the name of the NVA network interface.

    ```azurecli
    NICNAME=$(az vm nic show \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --vm-name nva \
        --nic $NICID \
        --query "{name:name}" --output tsv)

    echo $NICNAME
    ```

1. Run the following command to enable IP forwarding for the network interface.

    ```azurecli
    az network nic update --name $NICNAME \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --ip-forwarding true
    ```

## Enable IP forwarding in the appliance

1. Run the following command to save the public IP address of the NVA virtual machine to the variable `NVAIP`.

    ```azurecli
    NVAIP="$(az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name nva \
        --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
        --output tsv)"

    echo $NVAIP
    ```

1. Run the following command to enable IP forwarding within the NVA.

    ```bash
    ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
    ```

    When prompted, enter the password you used when you created the virtual machine.
