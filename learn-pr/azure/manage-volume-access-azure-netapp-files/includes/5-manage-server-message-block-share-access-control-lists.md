SMB shares can control access to who can mount and access a share, as well as control access levels to users and groups in an Active Directory domain.

The first level of permissions that get evaluated are share access control lists (ACLs).

There are two ways to view share settings:

- In the Advanced permissions settings
- With the Microsoft Management Console (MMC)

#### Prerequisites

- You must have the mount path.
- You can retrieve this in the Azure portal by navigating to the Overview menu of the volume for which you want to configure share ACLs.
- Identify the Mount path.

:::image type="content" source="../media/smb-volume-overview.png" alt-text="Screenshot of Azure portal showing the overview of an SMB volume mount path." border="true" lightbox="../media/smb-volume-overview.png":::

#### View SMB share ACLs with advanced permissions

You can only view SMB share ACLs in the Advanced permissions settings.

1. In Windows Explorer, use the mount path to open the volume. Right-click on the volume, select Properties. Switch to the Security tab then select Advanced.

    :::image type="content" source="../media/smb-share-security-properties.png" alt-text="Screenshot of Windows SMB share security properties dialog." border="true" lightbox="../media/smb-share-security-properties.png":::

2. In the new window that pops up, switch to the Share tab to view the share-level ACLs. You cannot modify share-level ACLs.

    :::image type="content" source="../media/smb-advanced-security-permissions.png" alt-text="Screenshot of Advanced Security Settings dialog showing permissions tab." border="true" lightbox="../media/smb-advanced-security-permissions.png":::

    :::image type="content" source="../media/smb-advanced-security-share.png" alt-text="Screenshot of Advanced Security Settings dialog showing share tab." border="true" lightbox="../media/smb-advanced-security-share.png":::
