In Network Watcher, metrics and logs can diagnose complex configuration problems.

Suppose you have two Virtual Machines (VMs) that cannot communicate. You want to obtain as much information as you can to diagnose the problem.

In this unit, you will troubleshoot by using Network Watcher metrics and logs. You will use the NSG flow logs to diagnose the connectivity issue between the two VMs.

## Register the Insights provider

NSG flow logging requires Microsoft.Insights provider. To register for the Microsoft.Insights provider, complete the following steps:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account that you used to activate the sandbox.
1. In the top-left corner of portal, click **All services**. In the Filter box, type **Subscriptions**. When **Subscriptions** appears in the search results, click it.
1. Select the **Concierge** subscription, and then under **Settings**, click **Resource providers**.
1. In the search bar, type **microsoft.insights**. 
1. If the status of the **microsoft.insghts** provider is **Unregistered**, then click **Register**.

    ![Registering the Insights provider](../media/5-microsoft-insights.png)

## Create a storage account

Now, create a storage account for the NSG flow logs:

1. In the top-left corner of portal, click **Create a resource > Storage > Storage account**.
1. In the **Create storage account** page, fill in these settings:

    | Setting | Value |
    | --- | --- |
    | Subscription | Concierge |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Storage account name | nsglogstorage1 |
    | Location | East US |
    | Performance | Standard |
    | Account kind | StorageV2 |
    | Replication | Read-access geo-redundant storage |
    | Access tier | Hot |

1. Click **Review + create** and then click **Create**.

    ![Creating a storage account](../media/5-storage-account.png)

## Create log analytics workspace

To view the NSG flow logs, you will use log analytics. To install log analytics:

1. In the top-left corner of portal, click **All services**. In the Filter box, type **Log analytics**. When **Log analytics workspaces** appears in the search results, click it.
1. Click **+ Add**, complete the page with these values, and then click **OK**:

    | Setting | Value |
    | --- | --- |
    | Log Analytics Workspace | testsworkspace |
    | Subscription | Concierge |
    | Resource group | <rgn>[sandbox resource group name]</rgn> |
    | Location | East US |
    | Pricing tier | Per GB |
    | | |

    ![Creating a log analytics workspace](../media/5-log-analytics-workspace.png)

## Enable flow logging

To set up flow logging, you must configure the NSG to connect to the storage account, and add traffic analytics for the NSG:

1. In the top-left corner of the portal, click **All resources** and then click the **MyNSG** network security group.
1. Under **Monitoring**, click **NSG flow logs**.
1. Click **MyNSG** and then click **On**.
1. Under **Storage account**, click **Configure**, in the **Storage account** drop-down list select the **nslogstorage1** account, and then click **OK**.
1. Under **Traffic Analytics status** click **On**, and then in the **Traffic Analytics processing interval** drop-down list, select **Every 10 mins**.
1. Click **Log Analytics workspace** and then click **testworkspace**.
1. Click **Save**.

## Install Telnet on the frontend VM

You will use the Telnet client to test connections between the VMs. Let's install that client now:

1. In the top-left corner of the portal, click **All resources**, click **FrontendVM**, and then click **Connect**.
1. Click **Download RDP File** and then click **OK**. If you see a warning about the publisher of the remote connection, click **Connect**.
1. Sign in with the username **azureuser** and the password **Demouser@123** and then click **Yes**.
1. Click the **Start** button, type **Windows features**, and then click **Turn Windows features on or off**
1. In the **Add Roles and Features** wizard, click **Next** four times to advance to the **Features** page.
1. Select **Telnet Client**, click **Next**, and then click **Install**.
1. When the installation is complete, click **Close**.

## Generate test traffic

Now you are ready to generate some network traffic between VMs that will be caught in the flow log:

1. Open a command prompt, and then execute this command:

    ```cmd
    telnet 10.10.2.4 80
    ```

1. Execute this command:

    ```cmd
    telnet 10.10.2.4 443
    ```
    
Both connections fail after a few seconds. 

## Diagnose the problem

Now, lets use log analytics to view the NSG flow logs:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All services**, type **Network Watcher**, and then click the **Network Watcher** resource.
1. Under **Logs** click **Traffic Analytics**.
1. In the **Log Analytics workspace** drop-down list, select **testworkspace**.
1. Use the different views to diagnose the problem that prevents communication from the frontend VM to the backend VM.

## Fix the problem

There is NSG rule that is blocking outbound traffic from the backend subnet to everywhere over the ports 80, 443 and 3389. Let's reconfigure that rule now:

1. Click **All resources**, and then click **MyVNet1**.
1. Under **Settings**, click **Subnets**, and then click **BackendSubnet**.
1. Click **Network security group**, click **None**, and then click **Save**.

## Retest the connection

Connections on ports 80 and 443 should now work without problems:

1. In the RDP client, connected to **FrontendVM**, at the command prompt, execute this command:

    ```cmd
    telnet 10.10.2.4 80
    ```

1. Execute this command:

    ```cmd
    telnet 10.10.2.4 443
    ```
    
Both connections should work. 