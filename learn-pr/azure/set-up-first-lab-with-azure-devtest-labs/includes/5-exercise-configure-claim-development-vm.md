Lab VMs in Azure DevTest Labs allow you to self-provision pre-configured and managed virtual machines.

For your eCommerce company, you want to create a pool of Windows-based developer VMs. Each developer can take a VM from the pool to perform their development activities. All developers need Azure PowerShell installed in the VM to manage their Azure resources.

In this exercise, you'll use the Azure portal to add a pre-configured, claimable VM to your lab in Azure DevTest Labs. You'll then claim the VM to connect to it.

During the process, you'll:

- Add a claimable VM to an existing lab in Azure DevTest Labs and configure an artifact.
- Claim a VM.
- Connect to the VM by using remote desktop (RDP).

## Add a lab VM

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Enter **DevTest Labs** in the search text box, and then select **DevTest Labs** from the list of services.

    :::image type="content" source="../media/search-devtest-labs.png" alt-text="Screenshot that shows the search box in the Azure portal to search Azure DevTest Labs resources.":::

1. From the list of labs, select your lab.

1. On the **DevTest Labs** page, select **+ Add** on the toolbar.

1. On the **Choose a base** page, select the **Windows Server 2022 Datacenter** marketplace image for the VM.

    :::image type="content" source="../media/add-lab-vm-select-base.png" alt-text="Screenshot that shows the screen to select a base image for a new lab VM from the list images." lightbox="../media/add-lab-vm-select-base.png":::

1. On the **Basics Settings** tab, provide the following information:

    |Field  |Value |Description  |
    |---------|---------|---------|
    |Virtual machine name     | Keep the default value | A unique name for the virtual machine.        |
    |User name     | Keep the default value | The name of the user to connect to the virtual machine. This user is granted administrator privileges on the VM.        |
    |Use a saved secret     | Unchecked | Allows you to use a secret from Azure Key Vault for the password.        |
    |Password     | *Enter a password* | The user password for logging into the VM.        |
    |Save as default password     | Unchecked | Allows you to save the password in Azure Key Vault.        |
    |Virtual machine size     | Choose Standard_D2s_v3 | The VM size determines the amount of compute resources like CPU, GPU, and memory that are available to the VM. You can limit the number of available options in the lab.        |
    |OS disk type     | Standard HDD | Azure VMs use managed disks, which are like physical disks but virtualized. The OS disk type determines the performance of the VM operating system disk.     |

## Add artifacts to a lab VM

You use artifacts to configure a VM or deploy software on it, after it's provisioned. You'll use an artifact to pre-install Azure PowerShell on the lab VM.

1. Select **Add or Remove Artifacts**

    :::image type="content" source="../media/add-lab-vm-basic-settings-add-artifact.png" alt-text="Screenshot that shows the basic settings screen, highlighting the link to add and remove artifacts.":::

1. On the **Add artifacts** page, select **Azure PowerShell** from the list, and then select **OK** in the right pane to add it to the list of selected artifacts.

    :::image type="content" source="../media/add-lab-vm-add-artifacts.png" alt-text="Screenshot that shows the screen for adding artifacts to a lab VM.":::

1. Select **OK** to confirm the selected artifacts.

## Make the VM claimable

A claimable VM in Azure DevTest Labs is a VM that has no owner assigned to it. You'll make the VM claimable to allow developers to claim and use it afterwards.

1. Select the **Advanced Settings** tab and provide the following information:

    |Field  |Value |Description  |
    |---------|---------|---------|
    |Make this machine claimable     | Yes | Create a claimable VM, which has no owner assigned to it.        |
    |Number of instances     | 2 | Create a pool of lab VMs. |

    :::image type="content" source="../media/add-lab-vm-advanced-settings.png" alt-text="Screenshot that shows the advanced settings screen when adding a new lab VM to a lab.":::

## Create the lab VM

1. Return to the **Basic Settings** tab and select **Create**.

    :::image type="content" source="../media/add-lab-vm-create.png" alt-text="Screenshot that shows the basic settings screen when adding a new lab VM to a lab.":::

1. You're returned to the **DevTest Labs** page. Under **My Lab**, select **Claimable virtual machines**.

    :::image type="content" source="../media/claimable-virtual-machines.png" alt-text="Screenshot that shows the list of claimable virtual machines." lightbox="../media/claimable-virtual-machines.png":::

1. After a few minutes, select **Refresh** if your virtual machines don't appear. Installation times will vary based on the selected hardware, base image, and artifact(s). The installation for the configurations used in this exercise was approximately 11 minutes.

## Claim the VM

By claiming a VM, you take its ownership and you can customize, restart, stop, or connect to it.

1. On the **DevTest Labs** page, under **My Lab**, select **Claimable virtual machines**.

    You should see the two claimable VMs with the **Available** status that you created earlier.

1. Select the ellipsis (**...**) next to one of the VMs in the list, and then select the **Claim machine** menu item.

    :::image type="content" source="../media/claimable-virtual-machines-claim-machine.png" alt-text="Screenshot that shows the context menu to claim a VM from the list of claimable virtual machines." lightbox="../media/claimable-virtual-machines-claim-machine.png":::

1. Refresh the list of claimable VMs. The VM you've claimed should no longer be in the list.

1. On the **DevTest Labs** page, select **Overview**. You should see the claimed VM in the **My virtual machines** list.

    :::image type="content" source="../media/my-virtual-machines.png" alt-text="Screenshot that shows the list of my virtual machines on the lab overview page.":::

## Connect using RDP

1. On the **DevTest Labs** page, select **Overview**.

1. Select the ellipsis (**...**) next the VM in **My virtual machines**, and then select the **Connect** menu item.

    :::image type="content" source="../media/lab-vm-connect.png" alt-text="Screenshot that shows the context menu to connect to a lab VM.":::

1. Your browser will now download a Remote Desktop (RDP) file, which has the configuration to connect to the lab VM.

    :::image type="content" source="../media/download-rdp.png" alt-text="Screenshot that shows the downloaded RDP file in the browser downloads list.":::

1. Open the RDP file to connect to the lab VM. Enter the user name and password that you used earlier for creating the lab VM.

    :::image type="content" source="../media/lab-vm-rdp-session.png" alt-text="Screenshot that shows the desktop of the lab VM in a remote desktop session.":::

## Verify the artifact configuration

1. Inside the lab VM remote desktop session, start **Windows PowerShell**.

1. Verify that the Azure PowerShell module is available on the lab VM by entering the following command:

    ```powershell
    Get-InstalledModule -Name Azure
    ```

    The command result will show the currently installed version of Azure PowerShell.

    :::image type="content" source="../media/lab-vm-azure-powershell.png" alt-text="Screenshot that shows the output of the PowerShell command.":::

You've now created a pool of lab VMs in the lab by using one of the allowed VM base images. By using artifacts, you've pre-configured the VMs with the necessary software tools. Developers can now quickly claim these VMs to take ownership, and use them for their development activities.
