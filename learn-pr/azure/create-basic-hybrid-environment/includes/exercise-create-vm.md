## Create and configure your virtual machine

In this exercise, you create and configure a virtual machine (VM). This virtual machine represents your on-premises Windows Server Active Directory environment.

:::image type="content" source="../media/3-exercise-1.png" alt-text="Diagram shows progression of this module with the first exercise highlighted.":::

## Install and configure Hyper-V Manager

To start, install Hyper-V on the host computer. If you already have Hyper-V installed, you can skip to creating the virtual machine. To install Hyper-V, do the following steps.

1. On your Windows Server 2019 laptop, select the Windows icon in the lower left and type *Turn Windows features on or off*.
1. Select **Turn Windows features on or off**.
1. Expand Hyper-V and select **Hyper-V Services**.

   :::image type="content" source="../media/3-exercise-2.png" alt-text="Screenshot shows the Windows Features dialog box with Hyper-V Services selected.":::

1. Select **OK**, then select **Restart**.
1. After the computer restarts, select the Windows icon and type *Hyper-V Manager*. Select it to open it.
1. In Hyper-V Manager, right-click on the computer and select **Virtual Switch Manager**.
1. Select **New virtual network switch**.
1. Select **External** and then **Create Virtual Switch**.
1. Rename it *External*.
1. Under **External network**, make sure your Ethernet/wi-fi adapter is selected.

   :::image type="content" source="../media/3-exercise-3.png" alt-text="Screenshot shows the Virtual Switch Manager dialog box with External network highlighted." lightbox="../media/3-exercise-3.png":::

1. Select **Apply**, then select **OK**.
1. If you receive a warning that says, "Pending changes may disrupt network connectivity," select **Yes**.
1. Select **OK** to close Virtual Switch Manager.

> [!NOTE]
> If you have problems creating the External network, make sure that the host machine can connect to the internet and that the **Hyper-V Exensible Virtual Switch** is not bound to your Ethernet adapter. If so, watch the video at the end of this article for information on how to fix this issue.

## Create a virtual machine

In order to get our hybrid identity environment up and running, you need to create a virtual machine to be the on-premises Active Directory server. You can use the PowerShell script in this section to create the VM.

The script contains the following variables, which you can change to suit your environment or preferences.

| Variable | Description |
|:---------|:------------|
| $VMName       | The name of the virtual machine as it appears in Hyper-V |
| $Switch       | The external adapter that allows the virtual machine to reach the internet |
| $InstallMedia | Path and filename of the Windows Server 2019 build |
| $Path         | The location where the script creates the virtual machine |
| $VHDPath      | The location of the virtual hard disk for the virtual machine |
| $VHDSize      | The size in bytes of our virtual hard disk |

Do the following tasks:

1. Open the PowerShell ISE as Administrator.
1. Copy this script into notepad and save it as *D:\Scripts\1_CreateVM_LEARN.ps1*.

   ```powershell
    #Declare variables
    $VMName = 'DC1'
    $Switch = 'External'
    $InstallMedia = 'C:\ISO\en_windows_server_2019_updated_aug_2021_x64_dvd_a6431a28.iso'
    $Path = 'D:\VM'
    $VHDPath = 'D:\VM\DC1\DC1.vhdx'
    $VHDSize = '64424509440'

    #Create New Virtual Machine
    New-VM -Name $VMName -MemoryStartupBytes 16GB -BootDevice VHD -Path $Path -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDSize -Generation 2   

    #Set the memory to be non-dynamic
    Set-VMMemory $VMName -DynamicMemoryEnabled $false

    #Add DVD Drive to Virtual Machine
    Add-VMDvdDrive -VMName $VMName -ControllerNumber 0 -ControllerLocation 1 -Path $InstallMedia

    #Mount Installation Media
    $DVDDrive = Get-VMDvdDrive -VMName $VMName

    #Configure Virtual Machine to Boot from DVD
    Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive 
   ```

1. Using the PowerShell command line, navigate to *D:\Scripts*, type *1_CreateVM_LEARN.ps1*, and select **Enter**.

   :::image type="content" source="../media/3-exercise-4.png" alt-text="Screenshot shows the Windows PowerShell window where the script runs." lightbox="../media/3-exercise-4.png":::

After this operation completes, you can finish the operating system installation.

## Complete the operating system deployment

In order to finish building the virtual machine, you need to finish the operating system installation.

1. Hyper-V Manager, double-click on the virtual machine.
1. Select the **Start** button.
1. You're prompted to **Press any key to boot from CD or DVD**. Select any key.
1. On the Windows Server startup screen, select your language and **Next**.

   :::image type="content" source="../media/3-exercise-5.png" alt-text="Screenshot shows the Windows Setup dialog box for Windows Server 2019 where you can select a language." lightbox="../media/3-exercise-5.png":::

1. Select **Install Now**.
1. Select **Windows 2019 Standard (Desktop Experience)** and **Next**.
1. Check **I accept the license terms** and **Next**.
1. Select **Custom: Install Windows Only (Advanced)** and **Next**.
1. When prompted, enter a password for the Administrator account.

## Check your work

At this point, you should have Hyper-V installed, a new virtual machine created, and the Windows Server 2019 operating system installed on it.

To verify this exercise, connect to the virtual machine.

1. From the Windows button, select **Hyper-V Manager**.
1. In the center pane, under virtual machines, right-click the virtual machine and select **Connect**.
1. Sign-in to the new virtual machine with the password you created in the previous section.

> [!VIDEO https://msit.microsoftstream.com/embed/video/8e890840-98dc-b478-1fbc-f1ecf1b0b730?autoplay=false&amp;showinfo=true]
