An individual Azure subscription is required to perform the tasks. To subscribe, browse to [https://www.azure.microsoft.com/free](https://www.azure.microsoft.com/free)."

## VNet Peering

This lab requires two virtual machines. Each virtual machine should be in a different virtual network. For these instructions, we have AZ500vm01, AZ500vm02, AZ500-vnet, AZ500-vnet1, and az500-rg.

To save time, you can connect to each virtual machine. Also, it might be helpful to edit the default.htm page on each machine, so the page provides the virtual machine name. For example, This is AZ500vm01.

In this demonstration, you will configure and test VNet peering.

**Review the infrastructure setup**

In this task, you will review the infrastructure that has been configured for this demonstration.

1. In the **Portal**, navigate to **Virtual Machines**.
1. Show there are two virtual machines, **AZ500vm01** and **AZ500vm02**.
1. Select **AZ500vm01** and review the IP addresses.
1. Select **AZ500vm02** and review the IP addresses. Make a note of the private IP address.
1. Based on the addressing, discuss how each machine is in a different subnet.
1. In the **Portal** navigate to **Virtual networks**.
1. Show there are two virtual networks, **AZ500-vnet** and **AZ500-vnet1**.

**Test the virtual machine connections**

In this task, you will test connecting from AZ500vm01 to AZ500vm02's private IP address. This connection will not work. The virtual machines are in different virtual networks.

1. Use RDP to connect to **AZ500vm01**.
1. In a **browser**, view the `http://localhost.default.htm` page.
1. This page should display without error.
1. Use RDP to connect to **AZ500vm02**
1. In a **browser**, view the `http://localhost.default.htm` page.
1. This page should display without error.
1. The above steps show that IIS is working on the virtual machines.
1. Return to your **AZ500vm01** RDP session.
1. We will now try to access **AZ500vm02**.
1. In a browser, view the **http://private\_IP\_address\_of\_AZ500vm02/default.htm** page.
1. The page will not display.
1. AZ500vm01 cannot access AZ500vm02 using the private address.

**Configure VNet peering and test the connections**

In this task, you will configure VNet peering and test the previous connection. The connection will now work.

1. In the **Portal**, navigate to the **AZ500-vnet** virtual network.
1. Under **Settings** select **Peerings**.
1. **+ Add** a virtual network peering. The page adapts as you make selections.
     -  Name of the peering from az500-vnet to remote virtual network: **Peering-A-to-B**
     -  Virtual network: **AZ500-vnet1 (az500-rg)**
     -  Name of the peering from az500-vnet1 to az500-vnet: **Peering-B-to-A**
     -  Discuss the other configuration options.
     -  Click **OK**.
1. Follow the notifications while the virtual network peerings are deployed.
1. Return to your **AZ500vm01** RDP session.
1. In the browser, refresh the **http://private\_IP\_address\_of\_AZ500vm02/default.htm** page.
1. This page should now display.

## Azure Firewall

This task requires a virtual network with two subnets, Subnet1 and Jumpnet. Subnet1 has the 10.0.0.0/24 address range. Jumpnet has the 10.0.1.0/24 address range. Subnet1 includes a Windows virtual machine. Your resource names may be different.

**Configure the firewall subnet**

1. In the **Portal**, select your virtual network.
1. Under **Settings**, select **Subnets**.
1. Click **+ Subnet** to add a new subnet for the firewall.
     -  Name: **AzureFirewallSubnet**
     -  Address range: **10.0.2.0/24**
     -  There is not need for a NAT Gateway, NSG, Route table, or services.
     -  Click **Add**.
1. Wait for the subnet to deploy.

**Add and configure the firewall**

1. Search for and select **Firewalls**.
1. Discuss the benefits of a firewall and how it can be used to increase perimeter security.
1. Click **+ Add**.
1. Complete the required configuration information: subscription, resource group, name, and region.
1. Select your **Virtual network**.
1. Add a new **Firewall public IP address**.
1. Create the firewall and wait for it to deploy.
1. Navigate to your new firewall.
1. On the **Overview** blade, locate the **Firewall private IP**.
1. Copy the address to the clipboard.

**Create a route table and route that uses the firewall**

1. Search for and select **Route tables**.
1. **Add** a new route table.
1. Complete the required configuration information: name, subscription, resource group, and location.
1. Disable **Virtual network gateway route propagation**. Review what this means.
1. Create the route table and wait for it to deploy.
1. Navigate to the new route table.
1. Under **Settings**, click **Routes**.
1. **Add** a new route. This route will ensure traffic goes through the firewall. Discuss the different next hop types.
     -  Route name: **your choice**
     -  Address prefix: **0.0.0.0/0/**
     -  Next hop type: **Virtual appliance**
     -  Next hope address: **Firewall\_private\_IP\_address**
1. When finished click **Ok** and wait for the new route to deploy.

**Associate the route table with Subnet1**

1. Still in the route table resource, under **Settings** click **Subnets**.
1. **Associate** your virtual network and **Subnet1**. This will ensure Subnet1 uses the route table.
1. When you are finished click **Ok** and wait for the association to complete.

**Test the firewall**

1. In the **Portal**, navigate to a virtual machine in Subnet1.
1. From the **Overview** blade, ensure the VM is **running**.
1. Click **Connect** and RDP into the VM.
1. On the virtual machine, open a browser.
1. Try to access: www.msn.com.
1. Notice the error. Action denied. No rule matches.

**Add a firewall application rule**

1. In the **Portal**, navigate to your firewall.
1. Under **Settings** select **Rules**.
1. Select the **Application rule selection** tab.
1. Click **Add application rule collection**.
1. Review how application rules work and complete the required information.
     -  Name: **your choice**
     -  Priority: **300**
     -  Action: **Allow**
1. Continue completing the rule, under **Target FQDNs**. This will allow Subnet1 IP address to traverse the firewall.
     -  Name: **Allow-MSN**
     -  Source type: **IP address**
     -  Source: **10.0.0.0/24**
     -  Protocol:Port: **http,https**
     -  Target FQDNs: **www.msn.com**
1. Click **Add** and wait for the firewall to be updated.

**Test the firewall again**

1. In your VM RDP session, refresh the browser page.
1. The MSN.com page should now display.
