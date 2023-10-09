Your new website's deployment was a huge success. Usage volumes are much higher than anticipated. The single web server on which the website runs is showing signs of strain. Your organization wants to increase the number of servers and distribute the load using a load balancer.

You now know you can use an Azure alias record to provide a dynamic, automatically refreshing link between the zone apex and the load balancer.

In this unit, you'll:

- Set up a virtual network with two VMs and a load balancer.
- Learn how to configure an Azure alias at the zone apex to direct to the load balancer.
- Verify that the domain name resolves to one or either of the VMs on your virtual network.

## Set up a virtual network, load balancer, and VMs in Azure

Manually creating a virtual network, load balancer, and two VMs will take some time. To reduce this time, you can use a Bash setup script that's available on GitHub. Follow these instructions to create a test environment for your alias record.

1. In Azure Cloud Shell, run the following setup script:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-host-domain-azure-dns.git
    ```

1. To run the setup script, run the following commands:

    ```bash
    cd mslearn-host-domain-azure-dns
    chmod +x setup.sh
    ./setup.sh
    ```

    The setup script takes a few minutes to run. The script:

    - Creates a network security group.
    - Creates two network interface controllers (NICs) and two VMs.
    - Creates a virtual network and assigns the VMs.
    - Creates a public IP address and updates the configuration of the VMs.
    - Creates a load balancer that references the VMs, including rules for the load balancer.
    - Links the NICs to the load balancer.

    After the script completes, it shows you the public IP address for the load balancer. Copy the IP address to use it later.

## Create an alias record in your zone apex

Now that you've created a test environment, you're ready to set up the Azure alias record in your zone apex.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Resource groups**. The **Resource groups** pane appears.

1. Select the resource group: <rgn>[sandbox resource group]</rgn>. The **Resource group** pane appears.

1. In the list of resources, select the DNS zone you created in the previous exercise, wideworldimportsXXXX.com. The **wideworldimportsXXXX.com DNS zone** pane appears.

1. In the menu bar, select **+ Record set**. The **Add record set** pane appears.

1. Enter the following values for each setting to create an alias record.

    | Setting | Value |
    | ---- | ---- |
    | Name | Leave the name blank. By leaving it blank, it indicates the DNS zone for wideworldimportsXXXX.com. |
    | Type | A. Even though we're creating an alias, the base record type must still be either A, AAAA, or CNAME. |
    | Alias record set | Yes |
    | Alias type | Azure resource |
    | Azure resource | From the list of resources, select **myPublicIP**. It may take up to 15 minutes for the deployments to propagate. If this resource isn't listed, wait several minutes, refresh the portal, and try again. |

    :::image type="content" source="../media/6-aliasrecord-azurelb.png" alt-text="Screenshot of Add record set.":::

1. Select **OK** to add the record to your zone.

When the new alias record is created, it should look something like this:

:::image type="content" source="../media/6-aliasrecord04.png" alt-text="Screenshot of the DNS zone, with an alias record created.":::

## Verify that the alias resolves to the load balancer

Now, you need to verify that the alias record is set up correctly. In a real-world scenario, you'd have an actual domain, and would've completed the domain delegation to Azure DNS. You'd use the registered domain name for this exercise. Because this unit assumes there's no registered domain, you'll use the public IP address.

1. In the Azure portal, go to the resource group,  select **myPublicIP**, then select the **Copy** icon next to the IP address.

   :::image type="content" source="../media/6-publicIpaddress.png" alt-text="Screenshot of the DNS zone with an alias record created.":::

1. In a web browser, paste the Public IP address as the URL.

1. You'll see a basic web page that shows the name of the VM to which the load balancer sent the request.
