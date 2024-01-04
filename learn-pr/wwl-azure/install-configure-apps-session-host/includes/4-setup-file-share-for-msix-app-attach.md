All MSIX images must be stored on a network share that can be accessed by users in a host pool with read-only permissions.

MSIX app attach doesn't have any dependencies on the type of storage fabric the file share uses. The considerations for the MSIX app attach share are same for an FSLogix share.

## Performance requirements

MSIX app attach image size limits for your system depend on the storage type you're using to store the VHD or VHDx files, and the size limitations of the VHD, VHSD, or CIM files and the file system.

The following table gives an example of how many resources a single 1-GB MSIX image with one MSIX app inside of it requires for each VM:

| **Resource**         | **Requirements** |
| -------------------- | ---------------- |
| Steady state IOPs    | 1 IOPs           |
| Machine boot sign-in | 10 IOPs          |
| Latency              | 400 ms           |

Requirements can vary widely depending how many MSIX-packaged applications are stored in the MSIX image. For larger MSIX images, you'll need to allocate more bandwidth.

### Storage recommendations.

Azure offers multiple storage options that can be used for MISX app attach. We recommend using Azure Files or Azure NetApp Files as those options offer the best value between cost and management overhead.

### Optimize MSIX app attach performance.

> [!NOTE]
> The considerations for the MSIX app attach share seen below are same as for an FSLogix share.

Here are some other things we recommend you do to optimize MSIX app attach performance:

 -  The storage solution you use for MSIX app attach should be in the same datacenter location as the session hosts.
 -  To avoid performance bottlenecks, exclude the following VHD, VHDX, and CIM files from antivirus scans:
     -  &lt;MSIXAppAttachFileShare\\&gt;\\\*.VHD
     -  &lt;MSIXAppAttachFileShare\\&gt;\\\*.VHDX
     -  \\\\storageaccount.file.core.windows.net\\share\*.VHD
     -  \\\\storageaccount.file.core.windows.net\\share\*.VHDX
     -  &lt;MSIXAppAttachFileShare&gt;.CIM
     -  \\\\storageaccount.file.core.windows.net\\share\*\*.CIM
 -  All VM system accounts and user accounts must have read-only permissions to access the file share.
 -  Any disaster recovery plans for Azure Virtual Desktop must include replicating the MSIX app attach file share in your secondary failover location.

## How to set up the file share

The setup process for MSIX app attach file share is largely the same as the setup process for FSLogix profile file shares. However, you'll need to assign users different permissions. MSIX app attach requires read-only permissions to access the file share.

If you're storing your MSIX applications in Azure Files, then for your session hosts, you'll need to assign all session host VMs both storage account role-based access control (RBAC) and file share New Technology File System (NTFS) permissions on the share.

| **Azure object**                   | **Required role**                                | **Role function**                             |
| ---------------------------------- | ------------------------------------------------ | --------------------------------------------- |
| Session host (VM computer objects) | Storage File Data SMB Share Contributor          | Read and Execute, Read, List folder contents. |
| Admins on File Share               | Storage File Data SMB Share Elevated Contributor | Full control.                                 |
| Users on File Share                | Storage File Data SMB Share Contributor          | Read and Execute, Read, List folder contents. |

To assign session host VMs permissions for the storage account and file share:

1.  Create an Active Directory Domain Services (AD DS) security group.
2.  Add the computer accounts for all session host VMs as members of the group.
3.  Sync the AD DS group to Microsoft Entra ID.
4.  Create a storage account.
5.  Create a file share under the storage account by following the instructions in [Create an Azure file share](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/storage/files/storage-how-to-create-file-share.md).
6.  Join the storage account to AD DS by following the instructions in [enable AD DS authentication for your Azure file shares](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/storage/files/storage-files-identity-ad-ds-enable.md).
7.  Assign the synced AD DS group to Microsoft Entra ID, and assign the storage account the Storage File Data SMB Share Contributor role.
8.  Mount the file share to any session host by following the instructions in [assign share-level permissions to an identity](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/storage/files/storage-files-identity-ad-ds-assign-permissions.md).
9.  Grant NTFS permissions on the file share to the AD DS group.
10. Set up NTFS permissions for the user accounts. You'll need an operating unit (OU) sourced from the AD DS that the accounts in the VM belong to.
