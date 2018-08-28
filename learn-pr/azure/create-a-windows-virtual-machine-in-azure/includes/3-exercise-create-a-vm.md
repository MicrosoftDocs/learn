# Exercise: Create a Windows Virtual Machine

In this exercise, you will create a Windows Virtual Machine in Azure.

## Motivation

<!-- Nope, this isn't a good road to go down. Are these students exploring Windows Server? Because, client images in Azure require very specific licensing. Unless you are trying to showcase nested virtualization? I'd stick with a basic server scenario. -->

Let's consider an alternative scenario for this exercise. Here, your organization is a school that uses Windows virtual machines to spin up test environments on which students can install web apps, configure domains, and explore Windows services and features without affecting the school's computers. Teachers can then connect to these VMs by using RDP and check on students' progress.

## Create a Windows VM

To create a Windows VM, carry out the following procedure:

1. Log onto Azure through the [Azure portal](https://portal.azure.com).

1. Click **Create a resource** in the upper left-hand corner of the Azure portal.

1. In the **search bar**, type  **Windows Server 2016 Datacenter**  and then click on the link with the same title.

### Configure the VM Settings

<!-- all of this is changing in a couple of weeks when the new experience goes live. There won't be blades anymore, they are more like tabs and have a different arrangement.... -->)

1. In the **Basics** blade, under the **Name** field, enter a name for your VM, such as "StudentVM".

1. In the **VM Disk Type** field, click to drop down the options, then ensure that **SSD** is selected.

1. In the **Username** field, enter a suitable user name to use to sign in to the VM.

1. In the **Password** field, enter a password that is at least 12 characters long. It must also have upper and lower-case characters, numbers, and special characters.

1. Under **Resource group**, click **Create new**, then give the resource group a name, such as "myTestRG".

1. Select a suitable location for the VM to be created, then click **OK**.

### Select the VM Image Size and Options

1. In the **Choose a size** page, click the **B1s** image, then click **Select**.

<!-- I wouldn't do this to them... it seems mean. Tell them to use a B2 or something that won't throw errors. Also, B1 is pretty unusable and a really bad first experience. -->

[!Note] The B1 image only has 1 GB RAM and will result in memory errors when you first log in. However, you can then resize it later as part of a later lab.

<!-- why aren't you configuring access here? Especially when your proposed use case is around RDP access. I basically makes your summary incorrect.  I'd enable RDP here and show them how to change the RDP port in another module and how to open other ports like port 80. -->

1. In the **Settings** page, under "Select Public Inbound Ports" select "No public inbound ports". We'll configure RDP access later.

### Finish Configuring the VM and Create the Image

1. Scroll down to the bottom and click **OK**.

1. In the **Create** blade, check the settings that you have configured, then at the bottom, click **Create**. The Azure Dashboard will show the VM being deployed. This may take several minutes.

## Summary

You have now created a Windows Server virtual machine that is suitable for your students' requirements and accessible from the school network. In the next unit, you will look at how you connect to and manage that VM by using RDP.
