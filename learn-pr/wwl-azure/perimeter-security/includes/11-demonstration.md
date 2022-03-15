An individual Azure subscription is required to perform the tasks. To subscribe, browse to [https://www.azure.microsoft.com/free](https://www.azure.microsoft.com/free)."

## VNet Peering

This lab requires two virtual machines.Each virtual machine should be in a different virtual network. For these instructions, we have AZ500vm01, AZ500vm02, AZ500-vnet, AZ500-vnet1, and az500-rg.

To save time, you can connect to each virtual machine. Also, it might helpful to edit the default.htm page on each machine, so the page provides the virtual machine name. For example, This is AZ500vm01.

In this demonstration, you will configure and test VNet peering.

**Review the infrastructure setup**

In this task, you will review the infrastructure that has been configured for this demonstration.

1.  In the **Portal**, navigate to **Virtual Machines**.
2.  Show there are two virtual machines, **AZ500vm01** and **AZ500vm02**.
3.  Select **AZ500vm01** and review the IP addresses.
4.  Select **AZ500vm02** and review the IP addresses. Make a note of the private IP address.
5.  Based on the addressing, discuss how each machine is in a different subnet.
6.  In the **Portal** navigate to **Virtual networks**.
7.  Show there are two virtual networks, **AZ500-vnet** and **AZ500-vnet1**.

**Test the virtual machine connections**

In this task, you will test connecting from AZ500vm01 to AZ500vm02's private IP address. This connection will not work. The virtual machines are in different virtual networks.

1.  Use RDP to connect to **AZ500vm01**.
2.  In a **browser**, view the **http://localhost.default.htm** page.
3.  This page should display without error.
4.  Use RDP to connect to **AZ500vm02**
5.  In a **browser**, view the **http://localhost.default.htm** page.
6.  This page should display without error.
7.  The above steps show that IIS is working on the virtual machines.
8.  Return to your **AZ500vm01** RDP session.
9.  We will now try to access **AZ500vm02**.
10. In a browser, view the **http://private\_IP\_address\_of\_AZ500vm02/default.htm** page.
11. The page will not display.
12. AZ500vm01 cannot access AZ500vm02 using the private address.

**Configure VNet peering and test the connections**

In this task, you will configure VNet peering and test the previous connection. The connection will now work.

1.  In the **Portal**, navigate to the **AZ500-vnet** virtual network.
2.  Under **Settings** select **Peerings**.
3.  **+ Add** a virtual network peering. The page adapts as you make selections.
    
     -  Name of the peering from az500-vnet to remote virtual network: **Peering-A-to-B**
     -  Virtual network: **AZ500-vnet1 (az500-rg)**
     -  Name of the peering from az500-vnet1 to az500-vnet: **Peering-B-to-A**
     -  Discuss the other configuration options.
     -  Click **OK**.
4.  Follow the notifications while the virtual network peerings are deployed.
5.  Return to your **AZ500vm01** RDP session.
6.  In the browser, refresh the **http://private\_IP\_address\_of\_AZ500vm02/default.htm** page.
7.  This page should now display.

## Azure Firewall

This task requires a virtual network with two subnets, Subnet1 and Jumpnet. Subnet1 has the 10.0.0.0/24 address range. Jumpnet has the 10.0.1.0/24 address range. Subnet1 includes a Windows virtual machine. Your resource names may be different.

**Configure the firewall subnet**

1.  In the **Portal**, select your virtual network.
2.  Under **Settings**, select **Subnets**.
3.  Click **+ Subnet** to add a new subnet for the firewall.
    
     -  Name: **AzureFirewallSubnet**
     -  Address range: **10.0.2.0/24**
     -  There is not need for a NAT Gateway, NSG, Route table, or services.
     -  Click **Add**.
4.  Wait for the subnet to deploy.

**Add and configure the firewall**

1.  Search for and select **Firewalls**.
2.  Discuss the benefits of a firewall and how it can be used to increase perimeter security.
3.  Click **+ Add**.
4.  Complete the required configuration information: subscription, resource group, name, and region.
5.  Select your **Virtual network**.
6.  Add a new **Firewall public IP address**.
7.  Create the firewall and wait for it to deploy.
8.  Navigate to your new firewall.
9.  On the **Overview** blade, locate the **Firewall private IP**.
10. Copy the address to the clipboard.

**Create a route table and route that uses the firewall**

1.  Search for and select **Route tables**.
2.  **Add** a new route table.
3.  Complete the required configuration information: name, subscription, resource group, and location.
4.  Disable **Virtual network gateway route propagation**. Review what this means.
5.  Create the route table and wait for it to deploy.
6.  Navigate to the new route table.
7.  Under **Settings**, click **Routes**.
8.  **Add** a new route. This route will ensure traffic goes through the firewall. Discuss the different next hop types.
    
     -  Route name: **your choice**
     -  Address prefix: **0.0.0.0/0/**
     -  Next hop type: **Virtual appliance**
     -  Next hope address: **Firewall\_private\_IP\_address**
9.  When finished click **Ok** and wait for the new route to deploy.

**Associate the route table with Subnet1**

1.  Still in the route table resource, under **Settings** click **Subnets**.
2.  **Associate** your virtual network and **Subnet1**. This will ensure Subnet1 uses the route table.
3.  When you are finished click **Ok** and wait for the association to complete.

**Test the firewall**

1.  In the **Portal**, navigate to a virtual machine in Subnet1.
2.  From the **Overview** blade, ensure the VM is **running**.
3.  Click **Connect** and RDP into the VM.
4.  On the virtual machine, open a browser.
5.  Try to access: www.msn.com.
6.  Notice the error. Action denied. No rule matches.

**Add a firewall application rule**

1.  In the **Portal**, navigate to your firewall.
2.  Under **Settings** select **Rules**.
3.  Select the **Application rule selection** tab.
4.  Click **Add application rule collection**.
5.  Review how application rules work and complete the required information.
    
     -  Name: **your choice**
     -  Priority: **300**
     -  Action: **Allow**
6.  Continue completing the rule, under **Target FQDNs**. This will allow Subnet1 IP address to traverse the firewall.
    
     -  Name: **Allow-MSN**
     -  Source type: **IP address**
     -  Source: **10.0.0.0/24**
     -  Protocol:Port: **http,https**
     -  Target FQDNs: **www.msn.com**
7.  Click **Add** and wait for the firewall to be updated.

**Test the firewall again**

1.  In your VM RDP session, refresh the browser page.
2.  The MSN.com page should now display.
