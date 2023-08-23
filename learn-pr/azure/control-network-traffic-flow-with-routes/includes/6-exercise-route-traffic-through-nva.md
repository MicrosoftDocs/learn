Now that you've created the network virtual appliance (NVA) and virtual machines (VMs), you'll route the traffic through the NVA.

:::image type="content" source="../media/6-vms-ip-addresses.svg" alt-text="Visualization of virtual machines and IP addresses.":::

## Create public and private virtual machines

The next steps deploy a VM into the public and private subnets.

1. Open the Cloud Shell editor and create a file named cloud-init.txt.

    ```bash
    code cloud-init.txt
    ```

1. Add the following configuration information to the file. With this configuration, the `inetutils-traceroute` package is installed when you create a new VM. This package contains the `traceroute` utility that you'll use later in this exercise.

    ```Text
    #cloud-config
    package_upgrade: true
    packages:
       - inetutils-traceroute
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file, and then press <kbd>Ctrl+Q</kbd> to close the editor.

1. In Cloud Shell, run the following command to create the **public** VM. Replace `<password>` with a suitable password for the **azureuser** account.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name public \
        --vnet-name vnet \
        --subnet publicsubnet \
        --image UbuntuLTS \
        --admin-username azureuser \
        --no-wait \
        --custom-data cloud-init.txt \
        --admin-password <password>
    ```

1. Run the following command to create the **private** VM. Replace `<password>` with a suitable password.

    ```azurecli
    az vm create \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name private \
        --vnet-name vnet \
        --subnet privatesubnet \
        --image UbuntuLTS \
        --admin-username azureuser \
        --no-wait \
        --custom-data cloud-init.txt \
        --admin-password <password>
    ```

1. Run the following Linux `watch` command to check that the VMs are running. The `watch` command periodically runs the `az vm list` command so that you can monitor the progress of the VMs.

    ```bash
    watch -d -n 5 "az vm list \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --show-details \
        --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' \
        --output table"
    ```

    A **ProvisioningState** value of "Succeeded" and a **PowerState** value of "VM running" indicate a successful deployment. When all three VMs are running, you're ready to move on. Press <kbd>Ctrl-C</kbd> to stop the command and continue with the exercise.

1. Run the following command to save the public IP address of the **public** VM to a variable named `PUBLICIP`.

    ```azurecli
    PUBLICIP="$(az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name public \
        --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
        --output tsv)"

    echo $PUBLICIP
    ```

1. Run the following command to save the public IP address of the **private** VM to a variable named `PRIVATEIP`.

    ```azurecli
    PRIVATEIP="$(az vm list-ip-addresses \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name private \
        --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
        --output tsv)"

    echo $PRIVATEIP
    ```

## Test traffic routing through the network virtual appliance

The final steps use the Linux `traceroute` utility to show how traffic is routed. You'll use the `ssh` command to run `traceroute` on each VM. The first test will show the route taken by ICMP packets sent from the **public** VM to the **private** VM. The second test will show the route taken by ICMP packets sent from the **private** VM to the **public** VM.

1. Run the following command to trace the route from **public** to **private**. When prompted, enter the password for the **azureuser** account that you specified earlier.

    ```bash
    ssh -t -o StrictHostKeyChecking=no azureuser@$PUBLICIP 'traceroute private --type=icmp; exit'
    ```

    If you receive the error message `bash: traceroute: command not found`, wait a minute and retry the command. The automated installation of `traceroute` can take a minute or two after VM deployment. After the command succeeds, the output should look similar to the following example:

    ```Text
    traceroute to private.kzffavtrkpeulburui2lgywxwg.gx.internal.cloudapp.net (10.0.1.4), 64 hops max
    1   10.0.2.4  0.710ms  0.410ms  0.536ms
    2   10.0.1.4  0.966ms  0.981ms  1.268ms
    Connection to 52.165.151.216 closed.
    ```

    Notice that the first hop is to 10.0.2.4. This address is the private IP address of **nva**. The second hop is to 10.0.1.4, the address of **private**. In the first exercise, you added this route to the route table and linked the table to the **publicsubnet** subnet. So now all traffic from **public** to **private** is routed through the NVA.

    :::image type="content" source="../media/6-public-private-route.svg" alt-text="Diagram of route from public to private.":::

1. Run the following command to trace the route from **private** to **public**. When prompted, enter the password for the **azureuser** account.

    ```bash
    ssh -t -o StrictHostKeyChecking=no azureuser@$PRIVATEIP 'traceroute public --type=icmp; exit'
    ```

    You should see the traffic go directly to **public** (10.0.0.4) and not through the NVA, as shown in the following command output.

    ```Text
    traceroute to public.kzffavtrkpeulburui2lgywxwg.gx.internal.cloudapp.net (10.0.0.4), 64 hops max
    1   10.0.0.4  1.095ms  1.610ms  0.812ms
    Connection to 52.173.21.188 closed.
    ```

    The **private** VM is using default routes, and traffic is routed directly between the subnets.

    :::image type="content" source="../media/6-private-public-route.svg" alt-text="Diagram of route from private to public.":::

You've now configured routing between subnets to direct traffic from the public internet through the **dmzsubnet** subnet before it reaches the private subnet. In the **dmzsubnet** subnet, you added a VM that acts as an NVA. You can configure this NVA to detect potentially malicious requests and block them before they reach their intended targets.
