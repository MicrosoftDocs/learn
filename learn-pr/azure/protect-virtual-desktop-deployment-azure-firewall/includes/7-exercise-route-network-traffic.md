
TODO: add your topic sentences(s)

TODO: add your scenario sub-task

TODO: add your scenario image

TODO: describe the end-state

## Route all traffic through the firewall

For the subnet used by the session host, configure the outbound default route to go through the firewall.

### Create route table

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) using the same account you used in the previous exercise units.
1. Search for and select **Route tables**.
1. Select **+ New**.
1. Use the following values.

    |Field |Value |
    |---------|---------|
    |Subscription  |  Your subscription    |
    |Resource group    |   learn-firewall-rg    |
    |Region  |   Select the same location that you used previously.   |
    |Name |   firewall-route   |

1. Select **Review + create** > **Create**.

1. After deployment completes, select **Go to resource**.

### Associate route table to workload's subnet

1. On firewall-route, under **Settings**, select **Subnets**.
1. Select **Associate**.
1. Select **Virtual network** > **learn-firewall-rg-vnet** (or sandbox rg).
1. For **Subnet**, select **default**.  This is the subnet that your session host uses. Make sure that you select only the **default** subnet for this route, otherwise your firewall won't work correctly.
1. Select **OK**.

### Add route to route table

1. Under **Settings**, select **Routes**.
1. Select **Add**.
1. Enter the following values.

    |Field |Value  |
    |---------|---------|
    |Route name    |  fw-dg       |
    |Address prefix |  0.0.0.0/0       |
    |Next hop type   |  Virtual appliance     |
    |Next hop address   |  Paste in the private IP address for the firewall from previous exercise unit.    |

11. Select **OK**.

## Create application rule collection

Create an application rule collection with rules to allow Windows Virtual Desktop access to several Fully Qualified Domain Names (FQDNs). 
<!--
1. Create application rule collection (see [Configure application rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)) & 
    1. add rule to enable Windows VirtualDesktop FQDN tag
	1. Source IP address range is host pool Vnet
	1. Protocol is https
	1. Destination is WindowsVirtualDesktop
1. Need to explicitily allow in firewall application rules exact FQDNs you need - not all captured in     WindowsVirtualDesktop FQDN. 
	   - Allow https access from your host pool subnet to *xt.blob.core.windows.net, *eh.servicebus.windows.net and *xt.table.core.windows.net. These wildcard FQDNs enable the required access, but are less restrictive.

-->


1. Search for and select **Firewalls**.
1. Select the **learn-fw** firewall.
1. Under **Settings**, select **Rules (classic)**.
1. Select the **Application rule collection** tab.
1. Select **Add application rule collection**.
1. Enter the following information.

    |Field  |Value  |
    |---------|---------|
    |Name     |     app-coll01    |
    |Priority    |    200     |
    |Action     |  Allow       |
1. Under **Rules**, in the **FQDNs tags** section, enter the following information.
 
    |Field  |Value  |
    |---------|---------|
    |Name     |     allow-virtual-desktop    |
    |Source type    | IP address        |
    |Source     |  Source IP address range is host pool Vnet     |
    |FQDN tags    |  Windows Virtual Desktop       |

1. Under **Rules**, in the **Target FQDNs** section, enter the following information.
 
    |Field  |Value  |
    |---------|---------|
    |Name     |     allow-storage-service-bus-accounts    |
    |Source type    | IP address        |
    |Source     |  Source IP address range is host pool VNet     |
    |Protocol:Port   |   https     |
    |Target FQDNs   | *xt.blob.core.windows.net, *eh.servicebus.windows.net, *xt.table.core.windows.net   |

1. Select **Add**.



## Create network rule collection

<!--
1. Create network rule collection with specific rules (see last main bullet in [Host pool outbound access..](https://docs.microsoft.com/azure/firewall/protect-windows-virtual-desktop#host-pool-outbound-access-to-windows-virtual-desktop) & [Configure network rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)).
1. 
1. Create a network rule collection add the following rules:

Allow DNS – allow traffic from your ADDS private IP address to * for TCP and UDP ports 53. (No DNS for exercise so this would be conceptual info.)
Allow KMS – allow traffic from your Windows Virtual Desktop virtual machines to Windows Activation Service TCP port 1688. For more information about the destination IP addresses, see [Windows activation fails in forced tunneling scenario](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/custom-routes-enable-kms-activation#solution)
-->
Typically, in a production deployment, you'd create a network rule collection and add rules to allow both DNS and KMS. We don't have a domain controller for this exercise. So you'll just create a rule to allow traffic from your session host VM to Windows Activation Service TCP port 1688.



1. On the learn-fw, select the **Network rule collection** tab.
1. Select **Add network rule collection**.
1. Enter the following information.

    |Field  |Value  |
    |---------|---------|
    |Name     |     net-coll01    |
    |Priority    |    200     |
    |Action     |  Allow       |



1. Under **Rules**, **IP addresses**,

    |Field  |Value  |
    |---------|---------|
    |Name     |     Allow-KMS   |
    |Protocol   |  TCP    |
    |Source type    |  IP address       |
    |Source   |    Source IP address range is host pool VNet       |
    |Destination type  |        |
    |Destination address  |  IP address       |
    |Destination Ports  |  1688   |

2. Select **Add**.

## Check your work

<!-- Introduction paragraph -->

1. Verify the firewall works by running the following command.

    ```powershell
    "rdgateway", "rdbroker","rdweb"|%{Invoke-RestMethod -Method:Get -Uri https://$_.wvd.microsoft.com/api/health}|ft -Property Health,TimeStamp,ClusterUrl
     ```

If all 3 component services are healthy, the firewall is working, if 1 or more are not healthy, the firewall is not working.
