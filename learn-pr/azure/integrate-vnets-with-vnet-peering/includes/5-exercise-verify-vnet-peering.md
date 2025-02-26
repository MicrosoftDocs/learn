In the previous unit, you configured peering connections between the virtual networks to enable resources to communicate with each other. Your configuration used a hub and spoke topology. **MarketingVNet** was the hub, and **SalesVNet** and **ResearchVNet** were spokes.

:::image type="content" source="../media/5-hub-spoke-network.svg" alt-text="Diagram of a hub and spoke topology for virtual networks.":::

Remember, peering connections are nontransitive. Intermediate virtual networks don't allow connectivity to flow through them to connected virtual networks. **SalesVNet** can communicate with **MarketingVNet**. **ResearchVNet** can communicate with **MarketingVNet**. **MarketingVNet** can communicate with both **SalesVNet** and **ResearchVNet**. The only communication that isn't permitted is between **SalesVNet** and **ResearchVNet**. Even though **SalesVNet** and **ResearchVNet** are both connected to **MarketingVNet**, they can't communicate with each other because they're not directly peered to each other.

Let's confirm the connectivity across the peering connections. First, you create a connection from Azure Cloud Shell to the *public* IP address of a target virtual machine (VM). Then you connect from the target VM to the destination VM by using the destination VM's *private* IP address.

> [!IMPORTANT]
> To test the virtual network peering connection, connect to the private IP address assigned to each VM.

1. Connect to your VMs by using SSH (Secure Shell) directly from Cloud Shell. When using SSH, you first find the public IP addresses that are assigned to your test VMs.

1. Run the following command in Cloud Shell to list the IP addresses you use to connect to the VMs:

    ```azurecli
    az vm list \
        --resource-group "<rgn>[sandbox resource group name]</rgn>" \
        --query "[*].{Name:name, PrivateIP:privateIps, PublicIP:publicIps}" \
        --show-details \
        --output table
    ```

1. Record the output. You need the IP addresses for the exercises in this unit.

Before you start the tests, think about what you learned in this module. What results do you expect? Which VMs are able to communicate with each other, and which ones aren't?

## Test connections from SalesVM

In the first test, you use SSH in Cloud Shell to connect to the public IP address of **SalesVM**. You then attempt to connect from **SalesVM** to **MarketingVM** and **ResearchVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the public IP address of **SalesVM**. In the command, replace `<SalesVM public IP>` with the VM's *public* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<SalesVM public IP>
   ```

   :::image type="content" source="../media/5-sales-step-1.svg" alt-text="A diagram showing connection to the public IP address of SalesVM.":::

1. Sign in with the password that you used to create the VM. The prompt now shows that you're signed in to **SalesVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **MarketingVM**. In the command, replace `<MarketingVM private IP>` with this VM's *private* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<MarketingVM private IP>
   ```

   :::image type="content" source="../media/5-sales-step-5.svg" alt-text="Diagram showing connection from SalesVM to the private IP address of MarketingVM.":::

    The connection attempt should succeed because of the peering connection between the **SalesVNet** and **MarketingVNet** virtual networks.

1. Sign in by using the password you used to create the VM.

1. Enter `exit` to close this SSH session and return to the **SalesVM** prompt.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **ResearchVM**. In the command, replace `<ResearchVM private IP>` with this VM's *private* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<ResearchVM private IP>
   ```

1. The connection attempt should fail because there's no peering connection between the **SalesVNet** and **ResearchVNet** virtual networks. Up to 60 seconds might pass before the connection attempt times out. To force the attempt to stop, use Ctrl+C.

   :::image type="content" source="../media/5-sales-step-9.svg" alt-text="Diagram showing the attempt failing to connect from SalesVM to the private IP address of ResearchVM.":::

1. Enter `exit` to close the SSH session and return to Cloud Shell.

## Test connections from ResearchVM

In the second test, you use SSH in Cloud Shell to connect to the public IP address of **ResearchVM**. Then, you attempt to connect from **ResearchVM** to **MarketingVM** and **SalesVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the public IP address of **ResearchVM**. In the command, replace `<ResearchVM public IP>` with this VM's *public* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<ResearchVM public IP>
   ```

   :::image type="content" source="../media/5-research-step-1.svg" alt-text="Diagram showing connection to the public IP address of ResearchVM.":::

1. Sign in by using the password that you used to create the VM. The prompt now shows that you're signed in to **ResearchVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **MarketingVM**. In the command, replace `<MarketingVM private IP>` with this VM's *private* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<MarketingVM private IP>
   ```

   :::image type="content" source="../media/5-research-step-5.svg" alt-text="Diagram showing connection to the private IP address of MarketingVM.":::

    The connection attempt should succeed because of the peering connection between the **ResearchVNet** and **MarketingVNet** virtual networks.

1. Sign in by using the password you used to create the VM.

1. Enter `exit` to close this SSH session and return to the **ResearchVM** prompt.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **SalesVM**. In the command, replace `<SalesVM private IP>` with this VM's *private* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<SalesVM private IP>
   ```

1. The connection attempt should fail because there's no peering connection between the **ResearchVNet** and **SalesVNet** virtual networks. Up to 60 seconds might pass before the connection attempt times out. To force the attempt to stop, use Ctrl+C.

   :::image type="content" source="../media/5-research-step-9.svg" alt-text="Diagram showing the attempt failing to connect ResearchVM to the private IP address of SalesVM.":::

1. Enter `exit` to close the SSH session and return to Cloud Shell.

## Test connections from Marketing VM

In the final test, you use SSH in Cloud Shell to connect to the public IP address of **MarketingVM**. You then attempt to connect from **MarketingVM** to **ResearchVM** and **SalesVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the public IP address of **MarketingVM**. In the command, replace `<MarketingVM public IP>` with this VM's *public* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<MarketingVM public IP>
   ```

   :::image type="content" source="../media/5-marketing-step-1.svg" alt-text="Diagram that shows connection to the public IP address of MarketingVM.":::

1. Sign in by using the password that you used to create the VM. The prompt shows that you're signed in to **MarketingVM**.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **ResearchVM**. In the command, replace `<ResearchVM private IP>` with this VM's *private* IP address.

    ```bash
    ssh -o StrictHostKeyChecking=no azureuser@<ResearchVM private IP>
    ```

   :::image type="content" source="../media/5-marketing-step-5.svg" alt-text="Diagram that shows Azure Cloud Shell connecting to the MarketingVNet and the ResearchVNet virtual networks, using a peering connection.":::

    The connection attempt should succeed because of the peering connection between the **MarketingVNet** and **ResearchVNet** virtual networks.

1. Sign in by using the password you used to create the VM.

1. Enter `exit` to close this SSH session, and return to the **MarketingVM** prompt.

1. In Cloud Shell, run the following command, using SSH to connect to the private IP address of **SalesVM**. In the command, replace `<SalesVM private IP>` with this VM's *private* IP address.

   ```bash
   ssh -o StrictHostKeyChecking=no azureuser@<SalesVM private IP>
   ```

   This connection attempt should also succeed because of the peering connection between the **MarketingVNet** and **SalesVNet** virtual networks.

   :::image type="content" source="../media/5-marketing-step-9.svg" alt-text="Diagram that shows Azure Cloud Shell connecting to the MarketingVNet and the SalesVNet virtual machines, using a peering connection.":::

1. Sign in by using the password you used to create the VM.

1. Enter `exit` to close this SSH session, and return to the **MarketingVM** prompt.

1. Enter `exit` to close the SSH session, and return to Cloud Shell.

This simple test using SSH demonstrates network connectivity between peered virtual networks. It also demonstrates lack of network connectivity for transitive connections. 

If these servers were running application services, the server connectivity would allow communication between the services running on the VMs. The connectivity would allow the business to share data across departments as required.
