The **Microsoft.PowerShell.Security** module includes many built-in cmdlets that you can use to manage the basic security features on a Windows computer. To review the cmdlets included in this module, you can enter the following command:

```powershell
Get-command -module Microsoft.PowerShell.Security

```

To manage access permissions on a file or folder, you use the following cmdlets included in the **Microsoft.PowerShell.Security** module.

*Table 1: Cmdlets included in the Microsoft.PowerShell.Security module*

| **Cmdlet**  | **Description**                                                                                                                                                                                                                                       |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Get-Acl** | This cmdlet gets objects that represent the security descriptor of a file or resource. The security descriptor includes the access control lists (ACLs) of the resource. The ACL lists permissions that users and groups have to access the resource. |
| **Set-Acl** | This cmdlet changes the security descriptor of a specified item, such as a file, folder, or a registry key, to match the values in a security descriptor that you supply.                                                                             |

## Retrieving access permissions

The **Get-Acl** cmdlet displays the security descriptor for an object. For example, you can retrieve the security descriptor for a folder named **C:\\Folder1**. By default, the output displays in a table format. If you pipe the output to a list format, you can review all the information included in the security descriptor.

```powershell
Get-Acl -Path C:\Folder1|Format-List

```

By using the following command, you can retrieve a more verbose list of the access property with the file system rights, access control type, and inheritance settings for the specified object:

```powershell
(Get-Acl -Path C:\Folder1).Access

```

You can also retrieve only specific Access properties formatted in a table format, as the following example depicts:

```powershell
(Get-Acl -Path C:\Folder1).Access|Format-Table IdentityReference, FileSystemRights, AccessControlType, IsInherited

```

## Updating file and folder access permissions

The **Set-Acl** cmdlet is used to apply changes to the ACL on a specific object. The process for modifying file or folder permissions consists of the following steps:

1.  Use **Get-Acl** to retrieve the existing ACL rules for the object.
2.  Create a new **FileSystemAccessRule** to be applied to the object.
3.  Add the new rule to the existing ACL permission set.
4.  Use **Set-Acl** to apply the new ACL to the existing file or folder.

The following example assigns the **Modify** permission to **C:\\Folder1** for a local user named **User1**.

The first step is to declare a variable that includes the existing ACL rules for **Folder1**.

```powershell
$ACL = Get-Acl -Path C:\Folder1

```

The second step is to create a new FileSystemAccessRule variable which specifies the access specifications to be applied:

```powershell
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("User1","Modify","Allow")

```

The third step is to add the new access rule to the existing ACL rules for **Folder1**:

```powershell
$ACL.SetAccessRule($AccessRule)

```

Finally, you need to apply the new ACL to **Folder1**:

```powershell
$ACL | Set-Acl -Path C:\Folder1

```

> [!NOTE]
> You can also configure an access rule to remove **Folder1** permissions for **User1** by simply changing step 3 to `$ACL.RemoveAccessRule($AccessRule)`.

## Copying a security descriptor to a new object

If you want to copy the exact security descriptor to a new object, you can use a combination of the **Get-Acl** and **Set-Acl** commands as follows:

```powershell
Get-Acl -Path C:\Folder1|Set-ACL -Path C:\Folder2

```

These commands copy the values from the security descriptor of **C:\\Folder1** to the security descriptor of **Folder2**. When the commands complete, the security descriptors for both folders are identical.
