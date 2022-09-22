> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still view the demonstration video at the bottom of this page.

Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

If you have not already run the script in unit 2, please do so now so you can follow the exercise below.

You work for Contoso as a network engineer, and users are complaining that they cannot access VM1 or VM2. You have configured two Azure virtual networks: VNet1 and VNet2. They are connected with peering.

| **Virtual network**| **IPv4 network address**| **Subnet**| **IPv4 network address**|
| :--- | :--- | :--- | :--- |
| VNet1| 10.1.0.0/16| Subnet1| 10.1.1.0/24|
||| Subnet2| 10.1.2.0/24|
| VNet2| 10.2.0.0/16| Default| 10.2.0.0/24|

:::image type="content" source="../media/5-network-1.png" alt-text="Screenshot showing the topology of v net 1." border="false":::

:::image type="content" source="../media/5-network-2.png" alt-text="Screenshot showing the topology of v net 2." border="false":::

| **Virtual machine**| **Operating system**| **VNet and subnet**| **DNS domain**|
| :--- | :--- | :--- | :--- |
| VM1| Windows Server 2019| VNet1, Subnet1| contoso.com|
| VM2| Windows Server 2019| VNet1, Subnet2| contoso.com|
| VM3| Windows Server 2019| VNet2, default| contoso.com|

## Diagnosis

Use Nslookup on VM1 and VM2 and check you get the following results:

- vm1.contoso.com – success

- vm2.contoso.com – success

- vm3.contoso.com – can't find

:::image type="content" source="../media/5-nslookup.png" alt-text="Screenshot showing the results of n s lookup in the command prompt." lightbox="../media/5-nslookup.png":::

Nslookup on VM3 gives these results:

- vm1.contoso.com – can't find

- vm2.contoso.com – can't find

- vm3.contoso.com – can't find

:::image type="content" source="../media/5-nslookup-3.png" alt-text="Screenshot of results of running n s lookup in the command prompt on vm3." lightbox="../media/5-nslookup-3.png":::

## Diagnosis

### Examine the Internet Protocol configuration of the Virtual Machines

Connect to each VM using Remote Desktop. Open a command prompt window and type: ipconfig /all

The IP addresses are:

- VM1 = 10.1.1.4

- VM2 = 10.1.2.4

- VM3 = 10.2.0.4

The DNS server address is 168.63.129.16, which is the wire server.

:::image type="content" source="../media/5-network-configure.png" alt-text="Screenshot of command prompt results after running i p config / all." lightbox="../media/5-network-configure.png":::

### Test network connectivity

Use **ping** to test network connectivity between the three virtual machines.

All three VMs are able to ping each other, so network connectivity is good at the IP level (OSI Layer 3).

:::image type="content" source="../media/5-ping-connectivity.png" alt-text="Screenshot of command screen after pinging for network connectivity." lightbox="../media/5-ping-connectivity.png":::

### Examine the Azure resource group

There are two virtual networks (VNets) called VNet1 and VNet2.

There is a private DNS zone, which is contoso.com.

:::image type="content" source="../media/5-resource-group.png" alt-text="Screenshot showing the resources within the resource group." lightbox="../media/5-resource-group.png":::

The private DNS zone has vm1 and vm2 automatically registered, but vm3 does not appear.

:::image type="content" source="../media/5-no-machine-3.png" alt-text="Screenshot showing that that vm 3 is not appearing." lightbox="../media/5-no-machine-3.png":::

Go to **Settings** > **Virtual network links**. We see that the private DNS zone is linked to VNet1, but not to VNet2.

:::image type="content" source="../media/5-virtual-network.png" alt-text="Screenshot showing the virtual links." lightbox="../media/5-virtual-network.png":::

## Resolution

### Link the private Domain Name System zone to Virtual Network 2

Navigate to the private DNS zone (contoso.com) and select the Virtual network links page. Add a new link.

- Link name: vnet2_dns

- [  ] I know the resource ID of virtual network – leave unchecked

- Subscription: &lt;the name of your subscription&gt;

- Virtual network: VNet2

- Configuration: [X] Enable auto registration

:::image type="content" source="../media/5-add-virtual-network.png" alt-text="Screenshot showing the add virtual network link screen." lightbox="../media/5-add-virtual-network.png":::

After you select OK, it may take a few minutes for the link to be created. Select Refresh occasionally to see the latest status. Wait until the link status says Completed.

### Inspect the Domain Name System name table

Navigate to the Overview page and inspect the DNS name table.

VM1, VM2, and VM3 should appear. You may need to wait a short while for VM3 to appear. Select Refresh if necessary.

Nslookup on VM1 and VM2 should resolve vm3.contoso.com.

> [!TIP]
> If VM3 does not appear after several minutes, try restarting the VM.

:::image type="content" source="../media/5-table.png" alt-text="Screenshot showing the d n s table." lightbox="../media/5-table.png":::

:::image type="content" source="../media/5-command-prompt-machine.png" alt-text="Screenshot showing the results of running the n s lookup commands." lightbox="../media/5-command-prompt-machine.png":::

:::image type="content" source="../media/5-command-prompt-lookup.png" alt-text="Screenshot of the command prompt showing the results of n s lookup." lightbox="../media/5-command-prompt-lookup.png":::

Optionally, you can test pinging the VMs, using their DNS names.

- vm1.contoso.com

- vm2.contoso.com

- vm3.contoso.com

In this demonstration you will see how to proactively troubleshoot Conditional Access policies using the What if tool in the Azure portal:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4TYML]
