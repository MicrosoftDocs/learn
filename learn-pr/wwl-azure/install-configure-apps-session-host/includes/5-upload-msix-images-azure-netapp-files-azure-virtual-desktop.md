Before you can start uploading the images, you'll need to set up Azure NetApp Files if you haven't already.

To set up Azure NetApp Files, you'll need the following things:

 -  An Azure account with contributor or administrator access
 -  A virtual machine (VM) or physical machine joined to Active Directory Domain Services (AD DS), and permissions to access it
 -  An Azure Virtual Desktop host pool made of domain-joined session hosts. Each session host must be in the same region as the region you create your Azure NetApp files in.

## Start using Azure NetApp Files

To start using Azure NetApp Files:

1.  Set up your Azure NetApp Files account by following the instructions in [Set up your Azure NetApp Files account](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/create-fslogix-profile-container.md#set-up-your-azure-netapp-files-account).
2.  Create a capacity pool by following the instructions in [Set up a capacity pool](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/azure-netapp-files/azure-netapp-files-set-up-capacity-pool.md).
3.  Join a Microsoft Entra connection by following the instructions in [Join an Active Directory connection](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/create-fslogix-profile-container.md#join-an-active-directory-connection).
4.  Create a new volume by following the instructions in [Create a new volume](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/create-fslogix-profile-container.md#create-a-new-volume) and [Configure volume access parameters](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/create-fslogix-profile-container.md#configure-volume-access-parameters).
5.  Make sure your connection to the Azure NetApp Files share works by following the instructions in [Make sure users can access the Azure NetApp Files share](https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/virtual-desktop/create-fslogix-profile-container.md#make-sure-users-can-access-the-azure-netapp-file-share).

## Upload an MSIX image to the Azure NetApp file share

With Azure NetApp Files share setup, you can start uploading images to it.

To upload an MSIX image to your Azure NetApp Files share:

1.  In each session host, install the certificate that you signed the MSIX package with. Make sure to store the certificates in the folder named Trusted People.
2.  Copy the MSIX image you want to add to the Azure NetApps Files share.
3.  Go to File Explorer and enter the mount path, then paste the MSIX image into the mount path folder.

Your MSIX image should now be accessible to your session hosts when they add an MSIX package using the Azure portal or PowerShell.
