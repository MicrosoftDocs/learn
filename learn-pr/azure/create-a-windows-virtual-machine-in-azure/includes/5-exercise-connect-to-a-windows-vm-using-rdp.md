# Exercise: Connect to a Windows Virtual Machine using RDP

<!-- I don't think this is a compelling exercise. You connected to the VM in exercise 4, but you haven't configured RDP access yet? I'd configure RDP when you configure the VM and I would skip resizing the VM and maybe go with adding a data disk or adding a VM extension. If you add a data disk, you have a reason to RDP because you need to format the new storage etc. It is much easier to create a realistic scenario out of that. Not many folks resize VMs, but most add storage. -->

In this lab, you will use the RDP client to connect to the Windows VM you created in the previous unit. You can connect by downloading and running an RDP file from the Azure Portal. This RDP file will have:

* The public IP address of the VM.
* The port number

## Motivation

From our exercise scenario, you're now a student and you want to learn about adding Roles and Features to a Windows Server computer. However, your network administrator does not want you to do this on a physical computer on the network and the school's computers are too poorly-specified to run Windows Hyper-V. Azure provides the perfect solution.

## Configure Network and Public IP Address Settings

1. In the portal, ensure the blade for the virtual machine you created earlier is open. You can find it under **All Resources** if you need to open it.

1. Go to the **Networking** section. The top of this section has links to the virtual subnet and dynamic IP address that were created along with our VM since we used the defaults. We would follow these links if we wanted to change those resources (for example changing to a Static IP address).

1. Click the **Add inbound port rule** button.

1. At the top of the **Add inbound security rule** dialog, click **basic**.

1. Select "RDP" under **Service**, then click **Add**.

## Connect to the VM by using RDP

To download the RDP file and connect to the VM, carry out the following steps:

### Download the RDP File

1. In the Overview section of the virtual machine's blade, click **Connect**.

1. In the **Connect to virtual machine** blade, note the **IP address** and **Port number** settings, then click **Download RDP File**.

1. In your browser, click **Open** or **Run** to open the RDP file.

### Connect to the Windows VM

1. In the **Remote Desktop Connection** dialog box, note the security warning and the Remote computer IP address, then click **Connect**.

1. In the **Windows Security** dialog box, enter your user name and password that you used in step 6 and 7 previously.

1. In the second **Remote Desktop Connection** dialog box, note the certificate errors, then click **Yes**.

1. Note that the virtual machine desktop takes a while to appear. This effect is because the B1 image is under-specified. You may receive a message about low memory allocation.

1. In the **Networks** dialog, click **No**.

### Resize the VM in the Azure Portal

1. Switch back to the Azure Portal, and on the virtual machine properties page, under **Settings**, click **Size**.

1. Click **D2s_v3** (2 vCPUs, 8 GB RAM), and then click **Select**. A resizing Virtual machine message will display. The VM in the RDP window will also close down.

1. Switch back to the Azure Portal, and in the left-hand pane, click **Virtual machines**.

1. In the **Virtual machines** blade, wait until your VM shows a status of **Running**. You may need to click the **Refresh** button.

1. Click the virtual machine's name, then in **Settings**, click **Size**. Note that the VM size is now set to **D2s_v3**.

### Reconnect to the Resized VM

1. Click **Virtual machines**, then click your VM. Note that the **Public IP Address** value has probably changed. Click **Connect**, and then click **Run** or **Open** in your browser.

1. In the **Remote Desktop Connection** dialog box, note the security warning and the Remote computer IP address, then click **Connect**.

1. In the **Windows Security** dialog box, enter your user name and password that you used in step 6 and 7 previously.

1. In the second **Remote Desktop Connection** dialog box, note the certificate errors, then click **Yes**. Notice how much more responsive the virtual machine is to the sign-in process.

1. Right-click the taskbar and click **Task Manager**.

1. In the Task Manager window, click **More details**.

1. Click the **Performance** tab. Note that the total memory available is 8 GB, of which about 1.2 GB will be in use. Close Task Manager.

## Summary

You have connected to a Windows VM by using RDP. With Desktop UI access you can administer this VM as you would any Windows Computer.
