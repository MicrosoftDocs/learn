In Azure Network Watcher, metrics and logs can diagnose complex configuration issues.

Suppose you have two virtual machines (VMs) that can't communicate. You want to obtain as much information as you can to diagnose the problem.

In this unit, you'll troubleshoot by using Network Watcher metrics and logs. To diagnose the connectivity issue between the two VMs, you'll then use the network security group (NSG) flow logs.

## Register the Microsoft.Insights provider

NSG flow logging requires the *Microsoft.Insights* provider. To register for that provider, complete the following steps.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true), and log in to the directory with access to the subscription you created resources in.

1. In the Azure portal, search for, select **Subscriptions**, and then select your subscription.

1. In the left menu pane, under **Settings**, select **Resource providers**. Your subscription's **Resource providers** pane appears.

1. In the search bar, enter **microsoft.insights**.

1. If the status of the **microsoft.insights** provider is **Unregistered**, select **Register**.

    ![A screenshot that shows the registered Microsoft.Insights provider.](../media/5-microsoft-insights.png)

## Create a storage account

Now, create a storage account for the NSG flow logs.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. Then, select **Storage**, search for and select **Storage account**. The **Storage account** pane appears.

1. Select **Create**. The **Create storage account** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Select your subscription |
    | Resource group | Select your resource group |
    | **Instance details** |
    | Storage account name | Create a unique name |
    | Location | Select the same region as your resource group |
    | Performance | Standard |
    | Account kind | StorageV2 |
    | Replication | Read-access geo-redundant storage |

1. Go to the **Advanced** tab, and enter the following value for its setting.

    | Setting | Value |
    | --- | --- |
    | **Blob storage** |
    | Blob access tier (default) | Hot |

1. Select **Review + create**, and when validation passes, select **Create**.

## Create a Log Analytics workspace

To view the NSG flow logs, you'll use Log Analytics.

1. On the Azure portal menu or from the **Home** page, search for and select **Log Analytics Workspace**. The **Log Analytics Workspace** pane appears.

1. Select **Create**. The **Create Log Analytics workspace** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Select your subscription |
    | Resource group | Select your resource group |
    | **Instance details** |
    | Name | testsworkspace |
    | Region | Select the same region as your resource group |

1. Select **Next : Pricing tier**. On the **Pricing tier** tab, enter the following value for the setting.

    | Setting | Value |
    | --- | --- |
    | **Pricing tier** |
    | Pricing tier | Pay-as-you-go (Per GB 2018) |
    | | |

1. Select **Review + Create**, and after validation passes, select **Create**.

## Enable flow logs

To set up flow logs, you must configure the NSG to connect to the storage account, and add traffic analytics for the NSG.

1. On the Azure portal menu, select **All resources**. Then, select the **MyNSG** network security group.

1. In the middle menu pane, under **Monitoring**, select **NSG flow logs**. The **MyNsg | NSG flow logs** pane appears.

1. Select **MyNSG**, and then select **On**.

1. Under **Storage account**, select **Configure**. In the **Storage account** dropdown, select the storage account you created earlier. Then, select **OK**.

1. Under **Traffic Analytics status**, select **On**. In the **Traffic Analytics processing interval** dropdown, select **Every 10 mins**.

1. Select **Log Analytics workspace**, and then select **testworkspace**.

1. Select **Save**.

## Generate test traffic

Now, you're ready to generate some network traffic between VMs to catch in the flow log.

1. On the Azure portal menu, select **All resources**, select **FrontendVM**, and from the top menu bar, select **Connect**.

1. From the dropdown list, select **RDP**, and then select **Download RDP File**. If you see a warning about the publisher of the remote connection, select **Connect**.

1. Sign in with the username **azureuser** and the password you specified when you created the VM, and then select **Yes**.

1. Open a PowerShell prompt, and run the following command.

    ```PowerShell
    Test-NetConnection 10.10.2.4 -port 80
    ```

The connection test fails after a few seconds.

## Diagnose the problem

Now, let's use log analytics to view the NSG flow logs.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu, select **All services**. Then, under **Networking**, select **Network Watcher**.

1. In the left menu pane, under **Logs**, select **Traffic Analytics**. The **Network Watcher | Traffic Analytics** pane appears.

1. In the **Log Analytics workspace** dropdown, select **testworkspace**.

1. Use the different views to diagnose the problem that prevents communication from the front end VM to the back end VM.

## Fix the problem

An NSG rule is blocking inbound traffic to the back end subnet from everywhere over the ports 80, 443, and 3389 instead of just blocking inbound traffic from the Internet. Let's reconfigure that rule now.

1. On the Azure portal menu, select **All resources**, and then select **MyNsg**.

1. In the middle menu pane, under **Settings**, select **Inbound security rules**, and then select **MyNSGRule**. The **MyNSGRule** pane appears.

1. In the **Source** field, select **Service Tag** from the dropdown list, and in the **Source service tag** field, select **Internet** from the dropdown list.

1. Select **Save**.

## Retest the connection

Connections on port 80 should now work without problems.

1. In the RDP client, connect to **FrontendVM**. At the PowerShell prompt, run the following command.

    ```PowerShell
    Test-NetConnection 10.10.2.4 -port 80
    ```

The connection test should now succeed.
