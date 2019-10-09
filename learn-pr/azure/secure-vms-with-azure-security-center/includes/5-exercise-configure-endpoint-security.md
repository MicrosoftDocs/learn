**Microsoft Antimalware** is available as an extension that you can add to existing VMs, or include as part of the creation of a new VM. You can use the Azure portal, Azure CLI / Powershell, or ARM template to include the extension.

Let's use the Azure portal to create a new VM and install the extension.

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. Select **Create a resource** from the left sidebar.

1. Select **Windows Server 2016 Datacenter** from the quick pick list.

1. Fill out the **Basics** tab with the following information.
    - **Subscription**: select your subscription.
    - **Resource group**: select the resource group you created earlier (**mslearnDeleteMe**) from the drop-down list.
    - **Virtual machine name**: enter a VM name such as _testvm1_.
    - **Region**: select a region such as _East US_.
    - **Username**: select a valid username you will remember.
    - **Password**: select a valid password you will remember.

    ![Screenshot showing the Basic tab for VM creation](../media/7-create-vm.png)

1. Select the **Advanced** tab. Here you can add extensions to the new VM. Click the **Select an extension to instal** and use the search box to locate **Microsoft Antimalware** and select **Create** to install it.

1. The options for the extension include the ability to ignore certain folders, filenames, and control when and how the extension scans the disk for malware. You can leave the default options in place.

    ![Screenshot showing the default options for Microsoft malware](../media/7-install-ms-malware.png)

1. Select **OK** to move back to the **Advanced** tab and note that the malware extension is set to install.

    ![Screenshot showing the Advanced tab with Microsoft malware extension installed](../media/7-install-ms-malware2.png)

1. Select **Review + Create**, verify the settings and create the new VM.

This will take a few minutes to complete - you can monitor the deployment through the **Notifications** (bell icon) view, or by clicking on the deployment message.

## Adding the extension to an existing VM

You can also add the antimalware extension to an existing VM after it has been created. This can be done with command-line tools (so it can be scripted), using the REST APIs, or through the Azure portal.

1. Select the VM you want to install the extension into.
1. Select the **Extensions** section under **Settings**.

    ![Screenshot showing the Add Extension option](../media/7-install-ms-malware3.png)

1. Locate **Microsoft Antimalware** in the presented list and select **Create** on the details screen to add the extension to your VM.

1. The same extension options are available as seen above. Once it's installed (it will take a few minutes), the extensions pane will update and show the malware extension.

    ![Screenshot showing the MS Malware extension installed into the VM](../media/7-install-ms-malware4.png)

### Monitor the status of antimalware

Azure Security Center monitors the status of antimalware protection and reports this on the **Endpoint protection issues** view in the **Compute & apps** section.

Security Center notes issues, such as detected threats and insufficient protection, that might make your VMs and computers vulnerable to malware threats. By using the information on **Endpoint protection issues**, you can make a plan to address any identified issues.

Security Center reports the following endpoint protection issues:

- **Endpoint protection not installed on Azure VMs** - A supported antimalware solution isn’t installed on these Azure VMs.

- **Endpoint protection not installed on non-Azure computers** -  A supported antimalware solution isn’t installed on these non-Azure computers.

- **Endpoint protection health issues**:

  - *Signature out of date*. An antimalware solution is installed on these VMs and computers, but the solution doesn’t have the latest antimalware signatures.

  - *No real time protection*. An antimalware solution is installed on these VMs and computers, but it isn’t configured for real-time protection. The service might be disabled, or Security Center might be unable to obtain the status because the solution isn’t supported.

  - *Not reporting*. An antimalware solution is installed but not reporting data.

  - *Unknown*. An antimalware solution is installed, but either its status is unknown or it’s reporting an unknown error.
