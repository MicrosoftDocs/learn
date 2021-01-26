Traditional file management techniques are no longer sufficient when dealing with continually increasing volumes of data that need to be monitored, audited, classified, archived, or blocked. Instead, you need to consider a more comprehensive approach that leverages tools such as FSRM.

## Overview of FSRM

You can use FSRM to manage and classify data that is stored on file servers. FSRM includes the following features:

- Quota management. This feature facilitates limiting the space allowed for a volume or folder. Quotas can apply automatically to new folders that you create on a volume. You can also define quota templates that you can apply to new volumes or folders.
- File screening management. This feature helps control the types of files that users can store on a file server. You can limit the file types with specific file extensions that users can store on your file shares. For example, you can create a file screen that doesn't allow users to save files with an.mp3 extension in a file server's personal shared folders.

> [!IMPORTANT]
> File screening only considers the file extension. It doesn't examine the file contents.

- Storage reports. This feature helps with identifying trends in disk usage and effectiveness of data classification. You can also monitor attempts by a selected group of users to save unauthorized files.
- File Classification Infrastructure. This feature automates the data classification process. You can dynamically apply access policies to files based on their classification. Example policies include Dynamic Access Control for restricting access to files, file encryption, and file expiration. You can classify files automatically by using file classification rules, or you can classify them manually by modifying the properties of a selected file or folder.
- File management tasks. This feature allows you to apply conditional policies and actions to files based on such criteria as file location, classification properties, in addition to file creation, modification, or access date. The actions that file management tasks support include the ability to expire files, encrypt files, or run a custom command.
- Access-denied assistance. This feature generates custom error messages to users who are not able to access files because of insufficient permissions or FSRM-based protection mechanisms.

> [!NOTE]
> You can configure and manage FSRM by using the File Server Resource Manager Microsoft Management Console (MMC) console or by using Windows PowerShell.

## Demonstration

The following video demonstrates how to:

- Configure quota management.
- Configure file screening.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest with a domain member server containing a single NTFS-formatted data volume.
1. Configure quota management. Set the quota limit on the data volume.
1. Validate quota management. Create a file which size is much lower than the limit and verify that the operation was successful. Try creating another file slightly higher than the quota limit and verify that the operation failed. Finally, check the amount of space available on the volume.
1. Configure file screening. Configure blocking of image files.
1. Validate quota management. Try creating a file with the extension .png and verify the operation failed.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Mfsg]