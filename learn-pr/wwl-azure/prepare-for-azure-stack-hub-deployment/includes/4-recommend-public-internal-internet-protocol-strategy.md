In the context of Azure Stack Hub, a public IP address is an IP address that's accessible from outside of Azure Stack Hub. Whether that external network is public internet routable or is on an intranet and uses private address space doesn't matter for the purposes of this unit, the steps are the same.

While you can set up multiple IP pools, you won't be able to select which one to use. Azure Stack Hub threads all IP pools as one. When you create a resource, you can't pick an IP for assignment.

## Add a public IP address pool

You can add public IP addresses to your Azure Stack Hub system at any time after the initial deployment of the Azure Stack Hub system.

At a high level, the process of adding a new public IP address block to Azure Stack Hub looks like this:

:::image type="content" source="../media/Recommend-public-IP-96022b25.png" alt-text="Diagram showing normalized relational tables.":::


## Obtain the address block from your provider

You need to obtain the address block you want to add to Azure Stack Hub. Depending on where you obtain your address block from, consider what the lead time is and manage this against the rate at which you're consuming public IP addresses in Azure Stack Hub.

Azure Stack Hub will accept any address block that you provide if it's a valid address block and doesn't overlap with an existing address range in Azure Stack Hub. Make sure you obtain a valid address block that's routable and non-overlapping with the external network to which Azure Stack Hub is connected. After you add the range to Azure Stack Hub, you can't remove it.

## Add the IP address range to Azure Stack Hub

1.  In a browser, go to your administrator portal dashboard. For this example, we'll use ``` https://adminportal.local.azurestack.external ```.
2.  Sign in to the Azure Stack Hub administrator portal as a cloud operator.
3.  On the default dashboard, find the Region management list and select the region you want to manage. For this example, we use local.
4.  Find the Resource providers tile and click on the network resource provider.
5.  Click on the Public IP pools usage tile.
6.  Click on the Add IP pool button.
7.  Provide a name for the IP pool. The name you choose helps you easily identify the IP pool. It's a good practice to make the name the same as the address range, but that isn't required.
8.  Enter the address block you want to add in CIDR notation. For example: 192.168.203.0/24
9.  When you provide a valid CIDR range in the Address range (CIDR block) field the Start IP address, End IP address and Available IP addresses fields will automatically populate.
10. After you review the info on the blade and confirm that everything looks correct, select **Ok** to commit the change and add the address range to Azure Stack Hub.
