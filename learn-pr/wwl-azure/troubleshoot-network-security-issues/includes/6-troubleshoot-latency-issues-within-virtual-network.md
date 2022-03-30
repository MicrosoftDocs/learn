You work as a support engineer supporting Azure infrastructure. You've been contacted by your web team about an issue with the website not responding. The web team have a pool of webservers behind a load balancer and public IP address.

:::image type="content" source="../media/6-topology.png" alt-text="Screenshot of a network topology diagram showing a pool of webservers behind a load balancer.":::

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

In this exercise, you'll use what you've learned to go through steps to troubleshoot the connection issues to the virtual machines.

## Verify that the website can't be reached

 Use the cloud shell on the right.

1. Use this Azure CLI command to get the public IP address of the scale set.

    ```
    az network public-ip show \
    --resource-group cloud-shell-storage-westeurope \
    --name myScaleSetLBPublicIP \
    --query '[ipAddress]' \
    --output tsv
    ```

2. Copy the IP address, in a new tab in your browser, try to navigate to it.

:::image type="content" source="../media/6-website-not-responding.png" alt-text="Screenshot of the website not responding.":::

## Check that Network Security Groups are configured correctly

1. In another browser tab, navigate to the Azure portal.

1. Search for **Network security groups**.

:::image type="content" source="../media/6-search-nsg.png" alt-text="A screenshot showing the virtual machine scale set highlighted.":::

1. Under **Services**, click **Network Security Groups**.

:::image type="content" source="../media/6-no-network-security-groups.png" alt-text="A screenshot showing that in this environment there are no NSGs created.":::

## Check the port rules for the scale set

1. In the Azure portal, search for **scale set**, and then under **Services**, click **Virtual machine scale sets**.

:::image type="content" source="../media/6-search-vm-scale-sets.png" alt-text="A screenshot showing the virtual machine scale set highlighted.":::

2. In the list, click **myScaleSet** to view the details.

:::image type="content" source="../media/6-my-scale-set.png" alt-text="A screenshot showing the current scale set selected.":::

3. On the left, under **Settings**, click **Networking**.

:::image type="content" source="../media/6-inbound-outbound-port-rules.png" alt-text="A screenshot of Networking selected, with inbound and outbound port rules highlighted.":::

4. Click the **Inbound port rules** tab, and then click the **Outbound port rules** tab.

   Note that there are no network security groups (NSG) on this network interface.

## Check the network settings for the pool instances

1. On the left, under **Settings**, click **Instances**.

:::image type="content" source="../media/6-instances.png" alt-text="A screenshot showing an instance in the scale set highlighted.":::

1. Click the first instance listed, in the above example this is **myScaleSet_2**. In your environment this could be different.

1. On the left, under **Settings**, click **Networking**.

:::image type="content" source="../media/6-networking.png" alt-text="A screenshot showing the instances without NSG setup.":::

1. There isn't an NSG being used by this instance.

1. In the breadcrumb trail, click **myScaleSet**, and then repeat steps 2 to 4 to see that there isn't an NSG on the other instance.

## Check the load balancer for a scale set

1. Click the **Load balancing** tab, and then click the **myScaleSetLB** load balancer.

:::image type="content" source="../media/6-load-balancer.png" alt-text="A screenshot showing the myScaleSetLB highlighted.":::

1. On the left, under **Settings**, click **Frontend IP configuration**.

:::image type="content" source="../media/6-front-end-ip-configuration.png" alt-text="A screenshot showing  the frontend IP address highlighted.":::

1. Check that there is a frontend IP address, and that this is the IP you tested at the beginning of this exercise.

1. On the left, under **Settings**, click **Load balancing rules**.

:::image type="content" source="../media/6-load-balancing-rules.png" alt-text="Screen shot showing the load balancing rules.":::

    Note that there is a rule for port **80** and port **443**.

1. On the left, click **Diagnose and solve problems**.

## Use the Diagnose and solve problems troubleshooter

1. Click the **No connectivity to the backend pool** troubleshooter.

:::image type="content" source="../media/6-no-connectivity.png" alt-text="A screenshot showing the No connectivity to backend pool troubleshooter.":::

1. In the **Tell us more about the problem you are experiencing** drop-down box, click **Intermittent connectivity**.

1. Scroll down and read the insight found.

:::image type="content" source="../media/6-no-connectivity-back-end-pool.png" alt-text="Screen shot of the connectivity results showing the backend pool can't be connected to over port 443.":::

The insight points to the fact that the backend instances in the pool aren't listening for port **443**. The website instances should be listening to port **80**. This insight points to a problem in the load balancer rule.
