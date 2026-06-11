Here you see how access to an SMB volume is managed through permissions.

### NTFS file and folder permissions

You can set permissions for a file or folder by using the **Security** tab of the object's properties in the Windows SMB client.

:::image type="content" source="../media/folder-properties.png" alt-text="This screenshot shows a Windows File Explorer window with a folder Properties dialog open on the Security tab." border="true" lightbox="../media/folder-properties.png":::

### Modify SMB share permissions

You can modify SMB share permissions using Microsoft Management Console (MMC).

Modifying SMB share permissions poses a risk. If the users or groups assigned to the share properties are removed from the Active Directory, or if the permissions for the share become unusable, then the entire share becomes inaccessible.
