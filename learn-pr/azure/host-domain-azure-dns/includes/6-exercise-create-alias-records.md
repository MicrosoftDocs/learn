The deployment of your new website was a huge success. Usage volumes are much higher than anticipated. The single web server that the website runs on is showing signs of strain. Your organization wants to increase the number of servers, and distribute the load using a load balancer.

You now know you can use an Azure alias record to provide a dynamic, automatically refreshing link between the zone apex and the load balancer.

In this unit, you'll:

- Set up a virtual network with two VMs and a load balancer.
- Learn how to configure an Azure alias at the zone apex to direct to the load balancer.
- Verify that the domain name resolves to one or either of the VMs on your virtual network.

## Set up a virtual network, load balancer, and VMs in Azure

Manually creating a virtual network, load balancer, and two VMs will take some time. To reduce this, you can use a Bash setup script, which is available on GitHub. Follow these instructions to create a test environment for your alias record.

1. In Azure Cloud Shell, run the following setup script.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-host-domain-azure-dns.git
    ```

1. To run the setup script, run the following commands.

    ```bash
    cd mslearn-host-domain-azure-dns
    chmod +x setup.sh
    ./setup.sh
    ```

    The setup script is going to take a few minutes to run. The script:

    - Creates a network security group.
    - Creates two NIC's and two VMs.
    - Creates a virtual network and assigns the VMs.
    - Creates a public IP address and updates the configuration of the VMs.
    - Creates a load balancer that references the VMs, including rules for the load balancer.
    - Links the NICs to the load balancer.

    After the script completes, it shows you the public IP address for the load balancer. Copy the IP address to use it later.

## Create an alias record in your zone apex

Now that you've created a test environment, you're ready to set up the Azure alias record in your zone apex.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to the resource group <rgn>[Sandbox resource group]<rgn>.

1. Select your DNS zone (wideworldimportsXXXX.com).

1. Select **Record set**. The **Add record set** pane appears.

1. Enter the following values to create an alias record.

    | Setting | Value |
    | ---- | ---- |
    | Name | Leave the name blank. By leaving it blank, it indicates the DNS zone for wideworldimportsXXXX.com |
    | Type | **A**. Even though we're creating an alias, the base record type must still be either A, AAAA, or CNAME. |
    | Alias record set | **Yes** |
    | Alias type | You can select either **Azure resource** or **Zone record set**. In this case, select the **Azure resource**. |
    | Azure resource | From the list of resources, select **myPublicIP**. |

    When you're done, it should look like this.

    ![Screenshot of Add record set](../media/6-aliasrecord-azurelb.png)

1. Select **OK** to add the record to your zone.

When the new alias record is created, it should look something like this:

![Screenshot of the DNS zone, with an alias record created](../media/6-aliasrecord04.png)

## Verify that the alias resolves to the load balancer

Now you need to verify that the alias record is set up correctly. In a real-world scenario, you'll have an actual domain, and would have completed the domain delegation to Azure DNS. So you would use the registered domain name for this exercise. Because this unit assumes there's no registered domain, you'll use the public IP address.

1. If you didn't copy the public IP address in a previous step, go to the resource group, and select **myPublicIP**. The IP address is on the upper-right side.

   ![Screenshot of the DNS zone with an alias record created](../media/6-publicIpaddress.png)

1. In a web browser, paste in the public IP address as the URL.

1. You'll see a basic web page that shows the name of the VM that the load balancer sent the request to.
