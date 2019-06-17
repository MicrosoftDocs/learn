<introduction paragraph>

<chunk 1 title>

....

<chunk 2 title>

...

## Notes from design doc
**Generalize a server and create an image of a VM**

(This unit will use zone pivots for the Linux and Windows instructions)

In this unit, you will learn the approaches for generalizing a Windows Server or Linux VM. By the end of this unit, you will be able to:

*   

Understand the method and tools for generalizing a Windows Server

*   

Understand the method and tools for generalizing a Linux VM

*   

Understand the method and tools for creating an image from the generalized Windows Server or Linux VM.

*   

How to Generalize a Windows Server

    *   Native to Windows is 'System Preparation Tool' (aka. Sysprep). This will generalize and shut down the machine. Once it is deallocated, the image can be captured to be reused.
*   

How to Generalize a Linux VM

    *   Within a Linux VM the Windows Azure Agent 'waagent' can be used using the syntax `waagent -deprovision+user -force` as root via ssh.
    *   This command does not guarantee the image is cleared of all sensitive information.  The `+user` parameter removes the last provisioned user account. To keep user credentials in the image, use only the `-deprovision` setting.
    *   To learn how to install waagent click [here](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux)
*   

Approaches to creating an image

    *   Images can be created in a variety of ways:

    *   Via the PortalOpen the Azure portal.

    *   In the menu on the left, select Virtual machines and then select the VM from the list.
    *   In the Virtual machine page for the VM, on the upper menu, select Capture.
    *   The Create Image page appears.
    *   For Name, either accept the pre-populated name or enter a name that you would like to use for the image.
    *   For Resource group, either select Create new and enter a name, or select Use existing and select a resource group to use from the drop-down list.
    *   If you want to delete the source VM after the image has been created, select Automatically delete this virtual machine after creating the image.
    *   If you want the ability to use the image in any availability zone, select On for Zone resiliency.
    *   Select Create to create the image.
    *   After the image is created, you can find it as an Image resource in the list of resources in the resource group.
    *   Using PowerShell [Link](https://docs.microsoft.com/azure/virtual-machines/windows/capture-image-resource#create-an-image-of-a-vm-using-powershell)
    *   From a snapshot created,  this gives you the ability to failback as you still have the original VHD.
