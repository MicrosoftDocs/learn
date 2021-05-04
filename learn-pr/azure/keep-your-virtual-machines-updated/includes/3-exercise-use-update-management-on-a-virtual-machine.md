 Your PIO wants to set up a virtual machine to serve as a web resource for local media outlets. It is imperative that this virtual machine is as protected as it can be to prevent unauthorized access. As part of your security profile, you want to implement Update Management on this VM so that you can ensure that it is always up-to-date with the latest security patches. 

## Create a virtual machine

Here you will create a new virtual machine to serve as a web server for the local media.

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. On the Azure portal menu or from the **Home** page, select **Create a resource**.
1. In the **New** pane, select **Windows Server 2016 Datacenter**.
1. Enter the following values in the **Create a virtual machine** window:

    | Field                | Value                                                    |
    |----------------------|----------------------------------------------------------|
    | Subscription         | *Select your Azure subscription*                         |
    | Resource group       | Create a new resource group named "mslearn-vmupdate"     |
    | Virtual machine name | MediaWebServer                                           |
    | Region               | *Select the region nearest you*                          |
    | Availability options | No infrastructure redundancy required                    |
    | Image                | Windows Server 2016 Datacenter                           |
    | Size                 | Select **Change size** and select **B2s** from the list  |
    | Username             | *Create a username of your choice and note it for later* |
    | Password             | *Create a password of your choice and note it for later* |

1. In the **INBOUND PORT ROLES** section, choose **Allow selected ports** in the **Public inbound ports** field.
1. Select **HTTP**, **HTTPS**, and **RDP**.

   :::image type="content" source="../media/3-public-inbound-ports-edited.png" alt-text="Screenshot of the inbound port rules section that shows HTTP, HTTPS, and RDP selected." border="false":::

1. Select **Review + create** and then select **Create**. 
1. Wait for the VM to be created. You can select the Bell icon in the upper right corner of the portal to monitor the progress.

## Onboard Update Manager to the VM

Here you'll enable Update Manager on the virtual machine you created.

1. In the left pane, select **Virtual machines**.
1. Select **MediaWebServer**.
1. Scroll down the list to **Operations**, and select **Guest + host updates**.
1. In the **Guest + host updates** pane, select **Go to Update management**.
   :::image type="content" source="../media/3-update-management-enable.png" alt-text="Screenshot of update management page with log analytics location and workspace, automation account subscription, and automation account fields.":::
1. Accept the defaults, and select **Enable**.
1. Wait for deployment to finish.
1. When update management deployment is complete, the Update Management page shows the status of the VM updates. You may need to refresh the page and select **Go to Update management** to see this view.
   :::image type="content" source="../media/3-update-management-deployment-complete.png" alt-text="Screenshot of the Update management page that shows the status of updates for the VM.":::

1. Wait for at least 15 minutes while Update Management configures the virtual machine.
1. When Update Management configuration is complete, you see that **Compliance** is complete and the **Failed update deployments** counter is configured.
   :::image type="content" source="../media/3-update-management-vm-configured.png" alt-text="Screenshot that shows a green check under Compliance and Update agent readiness fields.":::

   Also, in this example, Update Management has identified that there are updates for Windows Server available. Under **Information link**, there's a link to the knowledge base article for update.

## Examine Hybrid Worker Groups

1. On the Azure portal menu or from the **Home** page, select **All resources**.
1. Examine the **Type** column to find the resource type **Automation Account**, and select the Automation account.
1. In the Automation account pane, under the **Process Automation** section, select **Hybrid worker groups**.
1. Select the tab **System hybrid worker groups**.
1. You see that the virtual machine you created is listed as a system hybrid worker group.
   :::image type="content" source="../media/3-hybrid-worker-group.png" alt-text="Screenshot that shows the VM as a system hybrid worker group for the Automation account.":::
