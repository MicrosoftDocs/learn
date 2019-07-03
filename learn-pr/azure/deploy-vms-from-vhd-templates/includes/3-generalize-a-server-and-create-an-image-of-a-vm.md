You've learnt about what the Azure images are and how you can customize them. Now you're ready to start learning about how you can create an image of a Windows and Linux VM.

In this unit, you'll learn how to customize an image and then create a virtual machine from that image using Powershell.  You'll learn about the different methods you can use to create customized images and how you can deploy these.

## Generalize a server and create an image of a VM

You can generalize a Windows server by using sysprep.  Running sysprep on a Windows server will removed all the GUID details and hostnames and make that server OS unique, which you can then deploy multiple VMs.

To generalize a Windows VM:
- Login to your Windows VM.
- Open a Command Prompt window and change the directory to %windir%\system32\sysprep. Run sysprep.exe.
- Select Shutdown.

You can then use either the Azure portal or Powershell to create an image of this generalized server.

In the Azure portal perform the below:

- Select the Virtual machine
- On the Virtual machine page,  select Capture.
- From the Create image page, fill in all the boxes or accept the precreated entries
- If you want to delete the source VM after the image has been created, select Automatically delete 

In Powershell, you can:
- Create an image of a VM
- Create an image from a managed disk
- Create an image from a snapshot
- Create an image from a VHD in a storage account

### Linux VMs

To generalize a Linux VM, you would use the Azure CLI to capture and generalize the Linux VM.
To capture a linux VM, perform the below steps:

- SSH into the Linux server and type the following command:
 
        `sudo waagent –deprovision+user`

This command cleans the system and makes it ready for reprovisioning. The below tasks are completed by actioning this command:
 
- Removes SSH host keys
- Clears nameserver configuration 
- Removes the root user's password 
- Removes DHCP client leases
- Sets host name to localhost.localdomain
- Deletes the last provisioned user account

To generalize the VM run the command:

        `azure vm generalize 

### Approaches to creating an image

Images can be created in a variety of ways:

- Via the Portal Open the Azure portal.
In the menu on the left, select Virtual machines and then select the VM from the list.
- In the Virtual machine page for the VM, on the upper menu, select Capture.
- The Create Image page appears.
- For Name, either accept the pre-populated name or enter a name that you would like to use for the image.
- For Resource group, either select Create new and enter a name, or select Use existing and select a resource group to use from the drop-down list.
- If you want to delete the source VM after the image has been created, select Automatically delete this virtual machine after creating the image.
- If you want the ability to use the image in any availability zone, select On for Zone resiliency.
Select Create to create the image.
- After the image is created, you can find it as an Image resource in the list of resources in the resource group.
Using PowerShell Link
- From a snapshot created, this gives you the ability to failback as you still have the original VHD.

