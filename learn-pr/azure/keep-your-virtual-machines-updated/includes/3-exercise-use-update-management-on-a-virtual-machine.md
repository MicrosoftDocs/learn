 Your PIO wants to set up a virtual machine to serve as a web resource for local media outlets. It is imperative that this virtual machine is as protected as it can be to prevent unauthorized access. As part of your security profile, you want to implement Update Management on this VM so that you can ensure that it is always up-to-date with the latest security patches. 

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a virtual machine

Here you will create a new virtual machine to serve as a web server for the local media.

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
2. In the left navigation pane, click **Create a resource**.
3. In the **New** pane, click **Windows Server 2016 VM**.
4. In the **Basics** pane enter data as shown below. You can choose your own Username and Password. Change the subscription method to, either Free Trial or Pay-As-You-Go. Select **East US** for location. 
5. Create new resource group **RFD**

![Create VM Basics](../media/3-create-mediawebserver-basics-edited.png "Create VM Basics")

6. Click **Change size** in the size field and choose **B2s**, and then click **Select**.
7. In the **INBOUND PORT ROLES** section, the only change you need to make is, choose **Allow selected ports** in the **Public inbound ports** field. Select HTTP, HTTPS, and RDP as shown below.

![Select Public Inbound Ports](../media/3-public-inbound-ports-edited.png "Select Public Inbound Ports")

8. Click **Review + create** and then click **Create**. Wait for the VM to be created. You can click the Bell icon in the upper right corner of the portal to monitor the progress.

## Onboard Update Manager to the VM

Here you'll enable Update Manager on the virtual machine you just created.

1. In the left pane, click **Virtual machines**.
2. In the **Virtual machines** pane, select the virtual machine from the list. In this example, select **MediaWebServer**.
3. In the MediaWebServer pane, scroll down the list to **Operations**, and then click **Update management**.
4. In the **Update Management** pane, ensure that the **Enable for this VM** radio button is selected. Note that a default **Log Analytics workspace** and **Automation account** will be created. Accept the remaining defaults, and then click **Enable**.
5. In the upper left corner click the Notification bell and wait for deployment to finish.
6. When Update Management deployment has completed, the Update Management menu will appear as shown below.

![Update Management Deployment Complete](../media/3-update-management-deployment-complete-edited.png "Update Management Deployment Complete")

7. Wait for at least 15 minutes while Update Management configures the virtual machine.
8. When Update Management configuration is complete, the Update Management pane will appear as shown below.

![Update Management Configuration Complete](../media/3-update-management-vm-configured-edited.png "Update Management Configuration Complete")

9. Note that **Compliance** is now complete, that the **Failed update deployments** counter is now configured, and that in this example, Update Management has identified that there is a Cumulative Update for Windows Server available. To the right of the notification of the Cumulative Update, under **INFORMATION LINK** that there is a link to the knowledge base article for this Cumulative Update. 

## Examine Hybrid Worker Groups

1. In the left navigation pane, click **All resources**.
1. In the **All resources** pane, examine the **TYPE** column to find the resource of type **Automation Account**, and then click the Automation account.
1. In the Automation account pane, scroll down to the **Process Automation** section and in there, click **Hybrid worker groups**.
1. In the **Hybrid worker groups** pane click the **System hybrid worker groups** tab.
1. Note that the virtual machine you created is listed as shown below. 

![Hybrid Worker Group](../media/3-hybrid-worker-group.png "Hybrid Worker Group")

