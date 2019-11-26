You need to be in the _Standard pricing tier_ of Azure Security Center to use this feature. Once you activate a trial or migrate a subscription to this tier, you can enable JIT VM Access for selected Azure VMs in the subscription. If you don't want to start a trial now, you can read through the below instructions to see the steps necessary.

## Create a new Virtual Machine

Let's start by creating a Virtual Machine using the Cloud Shell.

> [!NOTE]
> This exercise can't be performed in the Azure Sandbox, so make sure to select a subscription that's enrolled in the standard tier of Security Center, or has an active 30-day trial for Security Center.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) using an account that has access to a subscription where Azure Security Center is setup for the standard tier.

1. Select the Cloud Shell button from the top toolbar - this will open the Cloud Shell at the bottom of the portal window.

1. Start by setting some default values, so you don't have to type them multiple times.

    Set a default location. Here we'll use **eastus**, but feel free to change that to a location closer to you.

    ```azurecli
    az configure --defaults location=eastus
    ```

    <!-- Paste tip-->
    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Next, create a new Azure Resource Group to hold your VM resources. We're using the name `mslearnDeleteMe` here to remind ourselves to delete this group when we are finished.

    ```azurecli
    az group create --name mslearnDeleteMe --location eastus
    ```

    Go ahead and set this as the default resource group.

    ```azurecli
    az configure --defaults group="mslearnDeleteMe"
    ```

1. Next, use the following command to create a new Windows-based virtual machine. Make sure to replace the `{your-password-here}` value below with a valid password.

    ```azurecli
    az vm create \
        --name SRVDC01 \
        --image win2016datacenter \
        --admin-username azureuser \
        --admin-password {your-password-here}
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

1. Navigate to **Security Center** using the tile on the main Azure dashboard.

1. Select the **Just in time VM access** section under **ADVANCED CLOUD DEFENSE**.

1. Select your VM under the **Recommended** tab.

1. Select the **Enable JIT** button with your selected VM, as shown below.

    ![Screenshot that depicts how you can enable JIT VM Access for a selected VM.](../media/M3-RDP02.png)

Once you enable the JIT rules, you can examine the Network Security Group for the VM. It will have a new set of rules applied to block remote management access, as shown in the following image:

![Screenshot that depicts rules to block remote management access.](../media/M3-RDP03.png)

Notice that the rules are applied to the internal address, and all management ports are included - both Remote Desktop Protocol (3389) and SSH (22).

## Request Remote Desktop Access

If you try to RDP into the Windows VM at this point, you will find that access is blocked. When your admin needs access, they can come into Security Center to request access.

1. Switch to the **Configured** tab in Security Center.

1. Select your VM and use the **Request access** button to open up the management ports.

    ![Screenshot that depicts how you can request access to a VM.](../media/M3-RDP04.png)

1. Select the ports you want to open - in this case, the Remote Desktop port (3389).

    ![Screenshot that depicts opening a port by selecting On for its toggle.](../media/M3-RDP05.png)

1. Use the **Open ports** button to finalize the request. You can set the number of hours to keep the port open from this panel as well. Once the time has expired, the port(s) will be closed, and access will be denied.

Now, your Remote Desktop client should be able to connect successfully - at least for the time period you've allotted through Security Center.
