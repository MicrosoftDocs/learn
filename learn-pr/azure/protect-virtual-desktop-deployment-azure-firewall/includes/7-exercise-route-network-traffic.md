In the previous exercise, you deployed Azure Firewall with a Firewall Policy. Now you'll create the required policy rules before you configure outbound routing through the firewall. Creating the rules first prevents an interruption when the default route becomes active.

## Prepare the route table

Create and associate a route table with the session-host subnet. Don't add routes yet. You'll add them after the firewall rules are ready.

1. Create a route table in the same resource group as your host pool VMs and firewall.
1. Associate the route table to the subnet that your host pool VMs use.

### Create route table

First, you'll create a route table named *firewall-route*.

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for and select **Route tables**.
1. Select **+ Create**.
1. Use the following values:

    |Field |Value |
    |---------|---------|
    |Subscription  |  Your subscription    |
    |Resource group    |   learn-firewall-rg    |
    |Region  |   Select the same location that you used previously.   |
    |Name |   firewall-route   |

    :::image type="content" source="../media/7-create-route-table.png" alt-text="Screenshot that shows the information to include when creating a route table.":::

1. Select **Review + create** > **Create**.

1. After deployment completes, select **Go to resource**.

### Associate route table to the workload's subnet

Now, you'll associate *firewall-route* to the host pool's subnet.

1. On **firewall-route**, under **Settings**, select **Subnets**.
:::image type="content" source="../media/7-firewall-route-subnet.png" alt-text="Screenshot that shows the subnet option under settings for the firewall route.":::
1. Select **+ Associate**.
1. Select the following values:

    |Field |Value  |
    |---------|---------|
    |Virtual network    |  hostVNet      |
    |Subnet |  hostSubnet      |

1. Select **OK** and wait until the association is added.

## Create an application rule collection

By default, the firewall denies access to everything, so you need to configure conditions under which traffic is allowed through the firewall.

Create application rule collections in the Firewall Policy to allow the required Azure Virtual Desktop fully qualified domain names (FQDNs). Before using these rules in production, compare them with [Required FQDNs and endpoints for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint), because the endpoint list can change.

1. In the Azure portal, search for and select **Firewall Policies**.
1. Select **learn-fw-policy**.
1. Under **Settings**, select **Application rules**, and then select **Add a rule collection**.
1. Enter the following information:

    | Field | Value |
    | --- | --- |
    | Name | **avd-application-rules** |
    | Priority | **200** |
    | Rule collection action | **Allow** |
    | Rule collection group | **DefaultApplicationRuleCollectionGroup** |

### Add the application rules

1. Under **Rules**, add the following rule for the managed Azure Virtual Desktop FQDN tag:

    | Field | Value |
    | --- | --- |
    | Name | **allow-avd-service** |
    | Source type | **IP address** |
    | Source | **10.0.0.0/16** |
    | Protocol:port | **https:443** |
    | Destination type | **FQDN tag** |
    | Destination | **WindowsVirtualDesktop** |

1. Add a rule for the supporting HTTPS endpoints:

    | Field | Value |
    | --- | --- |
    | Name | **allow-avd-support-https** |
    | Source type | **IP address** |
    | Source | **10.0.0.0/16** |
    | Protocol:port | **https:443** |
    | Destination type | **FQDN** |
    | Destination | `login.microsoftonline.com`, `catalogartifact.azureedge.net`, `*.prod.warm.ingest.monitor.core.windows.net`, `gcs.prod.monitoring.core.windows.net`, `mrsglobalsteus2prod.blob.core.windows.net`, `wvdportalstorageblob.blob.core.windows.net`, `*.service.windows.cloud.microsoft`, `*.windows.cloud.microsoft`, `*.windows.static.microsoft` |

1. Add a rule for certificate validation endpoints:

    | Field | Value |
    | --- | --- |
    | Name | **allow-certificate-validation** |
    | Source type | **IP address** |
    | Source | **10.0.0.0/16** |
    | Protocol:port | **http:80** |
    | Destination type | **FQDN** |
    | Destination | `oneocsp.microsoft.com`, `www.microsoft.com`, `*.aikcertaia.microsoft.com`, `azcsprodeusaikpublish.blob.core.windows.net`, `*.microsoftaik.azure.net`, `ctldl.windowsupdate.com` |

1. Select **Add**.

> [!IMPORTANT]
> Don't enable TLS inspection for Azure Virtual Desktop traffic.

## Create a network rule collection

Create a network rule for Windows activation. The `WindowsVirtualDesktop` service-tag route provides direct relayed Remote Desktop Protocol (RDP) connectivity on UDP port 3478. Domain Name System (DNS) requests from the session host go to the firewall DNS proxy that you configured in the previous exercise.

1. On **learn-fw-policy**, under **Settings**, select **Network rules**, and then select **Add a rule collection**.
1. Enter the following information:

    | Field | Value |
    | --- | --- |
    | Name | **avd-network-rules** |
    | Priority | **200** |
    | Rule collection action | **Allow** |
    | Rule collection group | **DefaultNetworkRuleCollectionGroup** |

1. Under **Rules**, add the following Windows activation Key Management Services (KMS) rule:

    | Field | Value |
    | --- | --- |
    | Name | **allow-kms** |
    | Source type | **IP address** |
    | Source | **10.0.0.0/16** |
    | Protocol | **TCP** |
    | Destination ports | **1688** |
    | Destination type | **FQDN** |
    | Destination | `azkms.core.windows.net` |

1. Select **Add**.

## Add outbound routes

The firewall policy now allows the required traffic. Add a default route to Azure Firewall and a more specific route that provides direct access to the Azure Virtual Desktop gateway and broker.

### Add the default route

1. In the Azure portal, search for and select **Route tables**, and then select **firewall-route**.
1. Under **Settings**, select **Routes**.

    :::image type="content" source="../media/7-firewall-route-routes.png" alt-text="Screenshot that shows the routes option under settings on the firewall route table.":::

1. Select **+ Add**.
1. Enter the following values:

    | Field | Value |
    | --- | --- |
    | Route name | **firewall-default-route** |
    | Destination type | **IP Addresses** |
    | Destination IP addresses or CIDR ranges | `0.0.0.0/0` |
    | Next hop type | **Virtual appliance** |
    | Next hop address | The **Firewall private IP** address from the previous exercise |

    :::image type="content" source="../media/7-add-route.png" alt-text="Screenshot that shows the information to include when adding a route.":::

1. Select **Add**.

### Add the Azure Virtual Desktop service route

1. Select **+ Add** again, and enter the following values:

    | Field | Value |
    | --- | --- |
    | Route name | **avd-service-route** |
    | Destination type | **Service tag** |
    | Destination service tag | **WindowsVirtualDesktop** |
    | Next hop type | **Internet** |

1. Select **Add**.

Azure uses the most specific matching route. The service-tag route sends gateway and broker traffic directly to the service, which avoids disconnections during Azure Firewall scale-in. Traffic without a more specific route follows the `0.0.0.0/0` default route to the firewall.

## Check your work

At this point, traffic without a more specific route uses the firewall, while gateway and broker traffic uses the direct service-tag route. Use the Azure Virtual Desktop Agent URL Tool on the session host to validate access to the required endpoints.

1. In the Azure portal, search for and select **Virtual machines**.
1. Select the session-host VM whose name starts with **learnhost**.
1. Under **Operations**, select **Run command** > **RunPowerShellScript**.
1. Enter and run the following script:

     ```powershell
     $urlTool = Get-ChildItem 'C:\Program Files\Microsoft RDInfra' `
         -Filter WVDAgentUrlTool.exe `
         -File `
         -Recurse |
             Sort-Object {
                 [version]($_.Directory.Name -replace '^RDAgent_', '')
             } -Descending |
             Select-Object -First 1

     if (-not $urlTool) {
         throw 'The Azure Virtual Desktop Agent URL Tool was not found.'
     }

     & $urlTool.FullName
     ```

1. Review the output and confirm that every required endpoint is accessible.

If a required endpoint is inaccessible:

1. Compare the failed endpoint with the current required endpoint list.
1. Confirm that the endpoint is in the correct application rule and that the protocol and port match.
1. If name resolution fails, confirm that DNS proxy is enabled and that **hostVNet** uses the firewall private IP address as its DNS server.
1. Correct the configuration, rerun the tool, and confirm that the endpoint is accessible.
