
TODO: add your topic sentences(s)

TODO: add your scenario sub-task

TODO: add your scenario image

TODO: describe the end-state

## Route all traffic through the firewall

For the subnet used by the session host, configure the outbound default route to go through the firewall.

1. In the Azure portal, search for and select **Route tables**.
1. Select **+ New**.
1. Use the following values.

    |Field |Value |
    |---------|---------|
    |Subscription  |  Your subscription    |
    |Resource group    |   learn-firewall-rg    |
    |Region  |   Select the same location that you used previously.   |
    |Name |   Firewall-route   |

1. Select **Review + create** > **Create**.

After deployment completes, select **Go to resource**.

1. On the Firewall-route page, select **Subnets** and then select **Associate**.
1. Select **Virtual network** > **Test-FW-VN**.
1. For **Subnet**, select **Workload-SN**. Make sure that you select only the **Workload-SN** subnet for this route, otherwise your firewall won't work correctly.

13. Select **OK**.
14. Select **Routes** and then select **Add**.
15. For **Route name**, type **fw-dg**.
16. For **Address prefix**, type **0.0.0.0/0**.
17. For **Next hop type**, select **Virtual appliance**.

    Azure Firewall is actually a managed service, but virtual appliance works in this situation.
18. For **Next hop address**, type the private IP address for the firewall that you noted previously.
19. Select **OK**.

Configure WVD host pool subnet User Defined Route all traffic via Firewall (default route now points to firewall):
    
[Create a default route](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#create-a-default-route) - steps here include creating Firewall-route (in route tables) and then from that route associating with the WVD subnet.

## Create application rule collection

1. Create application rule collection (see [Configure application rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)) & 
    1. add rule to enable Windows VirtualDesktop FQDN tag
	1. Source IP address range is host pool Vnet
	1. Protocol is https
	1. Destination is WindowsVirtualDesktop
1. Need to explicitily allow in firewall application rules exact FQDNs you need - not all captured in     WindowsVirtualDesktop FQDN. 
	   - Allow https access from host pool subnet to specific URLs (in article).
	   - 
	   - 
From tutorial:

1. Open the **Test-FW-RG**, and select the **Test-FW01** firewall.
1. On the **Test-FW01** page, under **Settings**, select **Rules (classic)**.
1. Select the **Application rule collection** tab.
1. Select **Add application rule collection**.
1. For **Name**, type **App-Coll01**.
1. For **Priority**, type **200**.
1. For **Action**, select **Allow**.
1. Under **Rules**, **Target FQDNs**, for **Name**, type **Allow-Google**.
1. For **Source type**, select **IP address**.
1. For **Source**, type **10.0.2.0/24**.
1. For **Protocol:port**, type **http, https**.
1. For **Target FQDNS**, type **`www.google.com`**
1. Select **Add**.

Azure Firewall includes a built-in rule collection for infrastructure FQDNs that are allowed by default. These FQDNs are specific for the platform and can't be used for other purposes. 

## Create network rule collection

1. Create network rule collection with specific rules (see last main bullet in [Host pool outbound access..](https://docs.microsoft.com/azure/firewall/protect-windows-virtual-desktop#host-pool-outbound-access-to-windows-virtual-desktop) & [Configure network rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)).

This is the network rule that allows outbound access to two IP addresses at port 53 (DNS).

1. Select the **Network rule collection** tab.
1. Select **Add network rule collection**.
1. For **Name**, type **Net-Coll01**.
1. For **Priority**, type **200**.
5. For **Action**, select **Allow**.
6. Under **Rules**, **IP addresses**, for **Name**, type **Allow-DNS**.
7. For **Protocol**, select **UDP**.
9. For **Source type**, select **IP address**.
1. For **Source**, type **10.0.2.0/24**.
2. For **Destination type** select **IP address**.
3. For **Destination address**, type **209.244.0.3,209.244.0.4**

   These are public DNS servers operated by CenturyLink.
1. For **Destination Ports**, type **53**.
2. Select **Add**.

## Check your work

<!-- Introduction paragraph -->

1. Verify the firewall works by running the following command.

    ```powershell
    "rdgateway", "rdbroker","rdweb"|%{Invoke-RestMethod -Method:Get -Uri https://$_.wvd.microsoft.com/api/health}|ft -Property Health,TimeStamp,ClusterUrl
     ```

If all 3 component services are healthy, the firewall is working, if 1 or more are not healthy, the firewall is not working.
