# Exercise: Create a Windows Virtual Machine

In this exercise, you will create a Windows Virtual Machine in Azure.

## Motivation

Let's consider an alternative scenario for this exercise. Here, your organization is a school that uses Windows virtual machines to spin up test environments on which students can install web apps, configure domains, and explore Windows services and features without affecting the school's computers. Teachers can then connect to these VMs by using RDP and check on students' progress.

## Create a Windows VM

To create a Windows VM, carry out the following procedure:

1. Log onto Azure through the [Azure portal](https://portal.azure.com).

1. Click **Create a resource** in the upper left-hand corner of the Azure portal.

1. In the **search bar**, type  **Windows Server 2016 Datacenter**  and then click on the link with the same title.

### Configure the VM Settings

1. In the **Basics** blade, under the **Name** field, enter a name for your VM, such as "StudentVM".

1. In the **VM Disk Type** field, click to drop down the options, then ensure that **SSD** is selected.

1. In the **Username** field, enter a suitable user name to use to sign in to the VM.

1. In the **Password** field, enter a password that is at least 12 characters long. It must also have upper and lower-case characters, numbers, and special characters.

1. Under **Resource group**, click **Create new**, then give the resource group a name, such as "myTestRG".

1. Select a suitable location for the VM to be created, then click **OK**.

### Select the VM Image Size and Options

1. In the **Choose a size** page, click the **B1s** image, then click **Select**.

[!Note] The B1 image only has 1 GB RAM and will result in memory errors when you first log in. However, you can then resize it later as part of a later lab.

1. In the **Settings** page, under "Select Public Inbound Ports" select "No public inbound ports". We'll configure RDP access later.

### Finish Configuring the VM and Create the Image

1. Scroll down to the bottom and click **OK**.

1. In the **Create** blade, check the settings that you have configured, then at the bottom, click **Create**. The Azure Dashboard will show the VM being deployed. This may take several minutes.

## Summary

You have now created a Windows Server virtual machine that is suitable for your students' requirements and accessible from the school network. In the next unit, you will look at how you connect to and manage that VM by using RDP.
