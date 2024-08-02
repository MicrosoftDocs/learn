This unit shows you how to prepare a master virtual hard disk (VHD) image for upload to Azure including how to create virtual machines. These instructions are for an Azure Virtual Desktop-specific configuration that can be used with your organization's existing processes.

We recommend you use an image from the Azure Image Gallery. However, if you do need to use a customized image, make sure you don't already have the Azure Virtual Desktop Agent installed on your device. Using a customized image with the Azure Virtual Desktop Agent can cause problems with the image.

## Create a virtual machine

Windows 10 Enterprise multi-session is available in the Azure Image Gallery. There are two options for customizing this image.

 -  The first option is to provision a virtual machine in Azure (See: [Create a virtual machine from a managed image](/azure/virtual-machines/windows/create-vm-generalized-managed)).
 -  The second option is to create the image locally by downloading the image, provisioning a Hyper-V virtual machine, and customizing it to suit your needs.

## Create a virtual machine from a managed image

You can create multiple virtual machines from an Azure managed virtual machine image using the Azure portal or PowerShell. A managed virtual machine image contains the information necessary to create a virtual machine, including the OS and data disks. The virtual hard disks (VHDs) that make up the image, including both the OS disks and any data disks, are stored as managed disks.

Before creating a new virtual machine, create a managed virtual machine image to use as the source image and grant read access on the image to any user who should have access to the image.

One managed image supports up to 20 simultaneous deployments. Attempting to create more than 20 virtual machines concurrently, from the same managed image, may result in provisioning timeouts due to the storage performance limitations of a single VHD. To create more than 20 virtual machines concurrently, use a Shared Image Galleries image configured with 1 replica for every 20 concurrent virtual machine deployments.

## Use the portal

1.  Go to the [Azure portal](https://portal.azure.com) to find a managed image. Search for and select **Images**.
    
    :::image type="content" source="../media/create-images-1-bea4f083-bd73825e-862a8413-80563c6a.png" alt-text="Image of searching for and selecting of images.":::
    
2.  Select the image you want to use from the list. The image **Overview** page opens.
    
    :::image type="content" source="../media/create-vm-from-image-41027054-37daa226-cf051723-ff4faa87.png" alt-text="Image of creating virtual machine from image.":::
    
3.  Select **Create virtual machine** from the menu.
4.  Enter the virtual machine information. The user name and password entered here will be used to log in to the virtual machine. When complete, select **OK**. You can create the new virtual machine in an existing resource group, or choose **Create new** to create a new resource group to store the virtual machine.
5.  Select a size for the virtual machine. To see more sizes, select **View all** or change the **Supported disk type** filter.
6.  Under **Settings**, make changes as necessary and select **OK**.
7.  On the summary page, you should see your image name listed as a **Private image**. Select **Ok** to start the virtual machine deployment.

## Local image creation

Once you've downloaded the image to a local location, open **Hyper-V Manager** to create a virtual machine with the VHD you copied.

To create a virtual machine with the copied VHD:

1.  Open the **New Virtual Machine Wizard**.
2.  On the Specify Generation page, select **Generation 1**.
3.  Under Checkpoint Type, disable checkpoints by unchecking the check box.

You can also run the following cmdlet in PowerShell to disable checkpoints.

```powershell
Set-VM -Name <VMNAME> -CheckpointType Disabled



```

## Fixed disk

If you create a virtual machine from an existing virtual hard disk (VHD), it creates a dynamic disk by default. It can be changed to a fixed disk by selecting **Edit Disk**.

You can also run the following PowerShell cmdlet to change the disk to a fixed disk.

```powershell
Convert-VHD –Path c:\test\MY-VM.vhdx –DestinationPath c:\test\MY-NEW-VM.vhd -VHDType Fixed



```

## Upload master image to a storage account in Azure

This unit only applies when the master image was created locally.

The following instructions apply to a master image was created locally that can be loaded into an Azure storage.

1.  Convert the VM image (VHD) to Fixed if you haven't already. If you don't convert the image to Fixed, you can't successfully create the image.
2.  Upload the VHD to a blob container in your storage account. You can upload quickly with the Storage Explorer tool.
3.  Next, go to the Azure portal in your browser and search for "Images." Your search should lead you to the **Create image** page.
