You need to be in the _Standard pricing tier_ of Azure Security Center to use this feature. After you activate a trial or migrate a subscription to this tier, you can enable JIT VM Access for selected Azure VMs in the subscription. If you don't want to start a trial now, you can read through the following instructions to see the required steps.

## Create a new VM

Let's start by creating a virtual machine using Azure Cloud Shell.

> [!NOTE]
> This exercise can't be performed in the Azure Sandbox, so make sure to select a subscription that's enrolled in the standard tier of Security Center, or has an active 30-day trial for Security Center.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using an account that has access to a subscription where Azure Security Center is set up for the standard tier.

1. Select the Cloud Shell icon from the top right of the Azure portal toolbar. Cloud Shell appears at the bottom of the portal.

    Start by setting some default values, so you don't have to enter them multiple times.

1. Set a default location. Here, we'll use **eastus**, but feel free to change that to a location closer to you.

    ```azurecli
    az configure --defaults location=eastus
    ```

    <!-- Paste tip-->
    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Next, create a new Azure *resource group* to hold your VM resources. We're using the name `mslearnDeleteMe` here to remind ourselves to delete this group when we are finished.

    ```azurecli
    az group create --name mslearnDeleteMe --location eastus
    ```

1. Go ahead and set this as the default resource group.

    ```azurecli
    az configure --defaults group="mslearnDeleteMe"
    ```

1. Next, run the following command to create a new Windows-based VM. Make sure to replace the following `<your-password-here>` value that with a valid password.

    ```azurecli
    az vm create \
        --name SRVDC01 \
        --image win2019datacenter \
        --resource-group mslearnDeleteMe \
        --admin-username azureuser \
        --admin-password <your-password-here>
    ```

    It takes a few minutes to create the VM and supporting resources. You should get a response similar to:

    ```json
    {
      "fqdns": "",
      "id": "/subscriptions/abcd/resourceGroups/mslearnDeleteMe/providers/Microsoft.Compute/virtualMachines/SRVDC01",
      "location": "eastus",
      "macAddress": "00-00-00-00-00-00",
      "powerState": "VM running",
      "privateIpAddress": "10.1.0.4",
      "publicIpAddress": "52.123.123.123",
      "resourceGroup": "mslearnDeleteMe",
      "zones": ""
    }
    ```

1. Use the public IP address in the response to connect to the VM using Remote Desktop (RDP). Windows has a built-in RDP client, and there are clients available for macOS and Linux if that's your preferred client system.

You should be able to connect and administer the VM. Let's fix that!

## Enable JIT VM access in Security Center

1. On the home page of the [Azure portal](https://portal.azure.com?azure-portal=true) in the top search bar, search for and select  **Security Center**. The **Overview** pane for the *Security Center* appears.

1. In the left menu pane, under **Cloud Security**, select **Azure Defender**. The **Azure Defender** pane appears for the Security Center.

1. In the main window, under **Advanced protection**, select **Just-in-time VM access**. The **Just-in-time VM access** pane appears.

1. Under **Virtual machines**, select the **Not Configured** tab.

1. Select the virtual machine from the resource group, *MSLEARNDELETEME*.

1. Select **Enable JIT on 1 VM** with your selected VM, as shown in the following screenshot.

    ![Screenshot that depicts how you can enable JIT VM Access for a selected VM.](../media/M3-RDP02.png)

    The **JIT VM access configuration** pane appears for your VM. After you enable the JIT rules, you can examine the Network Security Group for the VM. It will have a new set of rules applied to block remote management access, as shown in the following image:

    ![Screenshot that depicts rules to block remote management access.](../media/M3-RDP03.png)

    Notice that the rules are applied to the internal address, and all management ports are included - both Remote Desktop Protocol (3389) and SSH (22).

1. On the top menu bar, select **Save**. The **Just-in-time VM access** pane reappears.

## Request Remote Desktop Access

If you try to RDP into the Windows VM at this point, you will find that access is blocked. When your admin needs access, they can come into Security Center to request access.

1. Under **Virtual machines**, select the **Configured** tab.

1. Select your VM, and then select **Request access** to open up the management ports.

    ![Screenshot that depicts how you can request access to a VM.](../media/M3-RDP04.png)

    The **Request access** pane appears for SRVD01.

1. Select the ports you want to open; in this case, the Remote Desktop port (3389).

    ![Screenshot that depicts opening a port by selecting On for its toggle.](../media/M3-RDP05.png)

1. Select **Open ports** to finalize the request. You can set the number of hours to keep the port open from this pane as well. After the time has expired, the port(s) will be closed, and access will be denied.

Now, your Remote Desktop client should be able to connect successfully - at least for the time period you've allotted through Security Center.
