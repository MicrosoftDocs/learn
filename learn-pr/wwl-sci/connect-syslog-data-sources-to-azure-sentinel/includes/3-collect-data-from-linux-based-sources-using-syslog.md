Configuring the Azure Monitor Agent for Syslog on Linux machines:

## **For an Azure Linux VM:**

To install the agent on an Azure Linux virtual machine:

1. In the Azure portal, enter **Monitor** in the `Search resources, services, and docs` search bar.

1. In **Monitor**, scroll down the left menu to the **Settings** section and select `Data Collection Rules`.

1. In **Monitor | Data Collection Rules**, select **+ Create**.

    :::image type="content" source="../media/03-data-collection-rules-updated.png" alt-text="Screenshot of the Monitor Data Collection Rule create page.":::

1. On the `Data Collection Rule` **Basics** tab, enter a Rule name and specify a Subscription, Resource Group, Region, and Platform Type. For this exercise, select `Linux` for Platform Type.

1. Select **Next:Resources**

1. On the `Data Collection Rule` **Resources** tab, select **+ Add resources**.

1. In the **Select a scope** page, expand the **Scope** column for `Subscription` and `Resource group` types until your target VM is displayed.

1. Select the target VM and select **Apply**. You should see your Linux VM displayed as a Resource.

    :::image type="content" source="../media/03-data-collection-rule-add-resource.png" alt-text="Screenshot of the Monitor Data Collection Rule Add resources and Sect a scope pages":::

1. Select **Next: Collect and deliver**.

1. On the `Data Collection Rule` **Collect and deliver** tab, select **+ Add data source**.

1. In the **Add data source** page, select **Linux Syslog** from the `Data source type*` drop-down menu, and select **Add data source**. You should see your `Linux Syslog` Data source and a `Destinations(s)` of `Azure Monitor Logs`displayed.

1. Select **Review + create**, and **Create** after **Validation passed** is displayed.

    > [!NOTE]
    > This process initiates the Azure Monitor Linux Agent extension install.

1. After the process completes, locate **Virtual Machines** in the Azure portal and select the Linux VM you configured as a `Data Collection Rule` resource.

1. On the `Virtual machine` Overview, scroll down the left menu to the **Settings** section and select **Extensions + applications**.

1. Under the **Extensions** tab, you should see the **AzureMonitorLinuxAgent** displayed. 

    :::image type="content" source="../media/03-azure-monitor-linux-agent-azure-vm.png" alt-text="Screenshot of the Azure Monitor Linux Agent on an Azure VM." lightbox="../media/03-azure-monitor-linux-agent-azure-vm.png":::

    > [!NOTE]
    > If Microsoft Defender for Cloud Auto-provisioning is enabled, the Azure Monitor Linux Agent will be installed by default as an extension using Azure Policy assignment.

## **For any other Linux machine:**

To install the agent on non-Azure Linux physical or virtual machines:

1. In the Azure portal, enter **Arc** in the `Search resources, services, and docs` search bar.

1. In **Azure Arc**, scroll down the left menu to the **Infrastructure** section and select **Servers**.

1. On the **Servers** page, select **+ Add**.

1. On the **Add servers with Azure Arc** page, locate the **Add a single server box** and select **Generate script**.

1. On the **Add servers with Azure Arc** page, **Prerequisites** tab, review the requirements and select **Next**.

1. On the **Add servers with Azure Arc** page, **Resource details** tab, select your **Subscription** and **Resource group** from the drop-down menus under **Project details**.

    > [!TIP]
    > Select an Azure region before creating a new Resource groups.

1. On the **Add servers with Azure Arc** page, **Resource details** tab, select your **Region** and then select **Linux** from the **Operating system** drop-down menu under **Server details**.

1. On the **Add servers with Azure Arc** page, **Resource details** tab, select the appropriate **Connectivity method** from the radio buttons under **Connectivity method**, and then select **Next**.

    :::image type="content" source="../media/03-add-a-server-with-azure-arc.png" alt-text="Screenshot of Add a server Azure Arc page.":::

1. On the **Add servers with Azure Arc** page, **Tags** tab, enter `Physical locations tags` as needed and select **Next**.

1. On the **Add servers with Azure Arc** page, **Download and run script** tab, either download or copy the script to the clipboard.

    > [!TIP]
    > If you're using a Microsoft Windows system with Microsoft Azure, it is easy to copy and paste the script into notepad, then ssh into your Linux machine with PowerShell to run the script in a Bash console.

1. Open a `Bash console` as an administrative (root) user on your non-Azure Linux machine and run the script.

    This script does the following:
    - Download an installation script from the Microsoft Download Center.
    - Configure the package manager to use and trust the packages.microsoft.com repository.
    - Download the agent from Microsoft's Linux Software Repository.
    - Install the agent on the server.
    - Create the Azure Arc-enabled server resource and associate it with the agent.

1. When the script successfully completes you should see a message stating `Latest version of azcmagent is installed`.

1. On the **Add servers with Azure Arc** page, **Download and run script** tab, select **Close**.

1. The next step is to connect your non-Azure Linux server `azcmagent` to **Azure Arc**.

1. Copy and edit the following Bash script to include the required parameters in double quotes:

    ```bash
     azcmagent connect --resource-group "resourceGroupName" --tenant-id "tenantID" --location "regionName" --subscription-id "subscriptionID" --cloud "cloudName"
    if [ $? = 0 ]; then echo "\033[33mTo view your onboarded server(s), navigate to https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.HybridCompute%2Fmachines\033[m"; fi

    ```

    > [!TIP]
    > You can use the export (variables) entries from the agent install script you downloaded or copied to fill in the parameters required in the agent connect script.

1. When the script editing is complete, open a `Bash console` as an administrative (root) user on your non-Azure Linux machine and run the script.

1. The script tests connectivity to Azure endpoints and then requests you to sign in to `https://microsoft.com/devicelogin` and enter the supplied code to authenticate.

    :::image type="content" source="../media/03-azcmagent-connect-script.png" alt-text="Screenshot of the azcmagent connection script running.":::

1. Open a Web browser and navigate to the address as directed, and paste or enter the code into the form and select **Next** to sign in.

1. On the **Pick an account** page, select your `administrator account` and then select **Next**. Close browser tabs when complete.

1. In your `Bash console` you should see an `INFO Connected machine to Azure` message.

1. Verify your non-Azure machine is connected to **Azure Arc** in the Azure portal by entering **Arc** in the `Search resources, services, and docs` search bar.

1. In **Azure Arc**, scroll down the left menu to the **Infrastructure** section and select **Servers**. You should see your machine with a `Status` of **Connected**.

    :::image type="content" source="../media/03-azure-arc-connected-server.png" alt-text="Screenshot of azure Arc connected Linux server":::

    > [!NOTE]
    > Select Refresh if the Linux machine is not displayed.

1. The next task is to add your newly connected Azure Arc Linux server to your previously created Data Collection Rule for Syslog.

1. In the Azure portal, enter **DCR** in the `Search resources, services, and docs` search bar.

1. Select your Syslog Data Collection Rule

1. In your `Data Collection Rule`, scroll down the left menu to the **Configuration** section and select **Resources**.

1. In **Resources** select **+ Add**

1. In the **Select a scope** page, expand the **Scope** column until your **Server - Azure Arc** `Resource type` newly connected Linux machine is displayed.

1. Select the Linux Azure Arc machine and select **Apply**

1. The Linux Azure Arc VM is now included as one of the `Data Collection Rule` Resources.

    :::image type="content" source="../media/03-azure-arc-dcr-resource.png" alt-text="Screenshot of Azure Arc Linux resource in Data Collection Rule":::
