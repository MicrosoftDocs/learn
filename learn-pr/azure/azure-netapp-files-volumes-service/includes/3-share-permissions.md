Azure NetApp Files share and file permissions work behind the scenes to control the access permissions of users and groups.

Azure NetApp Files provides several ways to secure your NAS data. One security option is using permissions. In NAS, permissions can be broken down into two categories:

- Share access permissions limit who can mount a NAS volume. NFS controls share access permissions via IP address or hostname. SMB controls this using user and group access control lists (ACLs).
- File access permissions limit what users and groups can do once a NAS volume is mounted. File access permissions are applied to individual files and folders.

## Share access permissions

The first entry point to be secured in a NAS environment is access to the share. With share access permissions, you can lock down who can and cannot mount the share.

A share is the main entry point to the volume and most restrictive permissions override other permissions. Share permissions should abide by a funnel logic as shown in the image below, where the share allows more access than the underlying files and folders.

:::image type="content" source="../media/3-permissions-hierarchy.png" alt-text="Diagram showing permissions hierarchy in Azure NetApp Files." lightbox="../media/3-permissions-hierarchy.png":::

## NFS export policies

An export policy is a container for a set of access rules that are listed in order of desired access. These rules control access to NFS shares by using client IP addresses or subnets.

Volumes in Azure NetApp Files are shared to NFS clients by exporting a path that is accessible to a client. Both NFSv3 and NFSv4.x use export policies to limit access to an NFS share in Azure NetApp Files.

If a client isn't listed in an export policy rule, then that client is unable to mount the NFS export. The export policy rules are read in sequential order. If a more restrictive policy rule is applied to a client, then it's read and applied first. Subsequent policy rules that allow more access are ignored.

:::image type="content" source="../media/3-export-policy.png" alt-text="Diagram showing how export policies work." lightbox="../media/3-export-policy.png":::

This diagram shows a client that has an IP of 10.10.10.10 getting read-only access to a volume because the subnet 0.0.0.0/0 (every client in every subnet) is set to read-only and is listed first in the policy.

Default policy rule in Azure NetApp Files

When creating a new volume, a default policy rule is created. The default rule has the following values:
- Index = 1
- Allowed clients = 0.0.0.0/0 (all clients allowed access)
- Access = Read & write
- Root access = On
- Chown mode = Restricted

>[!NOTE]
>These values can be changed at volume creation or after the volume has been created.

### Export policy rules with NFS Kerberos enabled in Azure NetApp Files

NFS Kerberos can be enabled only on volumes using NFSv4.1 in Azure NetApp Files.

When Kerberos is enabled, the values for the export policy rules change to allow specification of which Kerberos mode should be allowed. Multiple Kerberos security modes can be enabled in the same rule if you need access to more than one.

The security modes include:

- **Kerberos 5:** Only initial authentication is encrypted.
- **Kerberos 5i:** User authentication plus integrity checking.
- **Kerberos 5p:** User authentication, integrity checking and privacy. All packets are encrypted.



:::image type="content" source="../media/3-create-volume-export-policy.png" alt-text="Screenshot of create volume interface with export policies." lightbox="../media/3-create-volume-export-policy.png":::

>[!NOTE]
>Only Kerberos-enabled clients can access volumes with export rules specifying Kerberos; no AUTH_SYS access is allowed when Kerberos is enabled.

## Root squashing

A root user has unfettered access to anything in an NFS volume. There would be scenarios where you want to restrict root access to an Azure NetApp Files volume. The only way to limit root access is to tell the NFS server that the root from a specific client is no longer root.

Using export policy rules, you can select "Root access: off" to squash root to a non-root. This means that the root on the specified clients is now user ID 65534 and has access to files and folders based on the ACLs/mode bits specified for that user and the user no longer has root privileges.

## Export policy rule ordering

The order of export policy rules determines how they are applied. Consider the following scenario with two export policies:

:::image type="content" source="../media/3-export-policy-example.png" alt-text="Screenshot showing how to move export policies." lightbox="../media/3-export-policy-example.png":::

- The first rule in the index includes all clients in all subnets by way of the default policy rule using 0.0.0.0/0 as the allowed client's entry. That rule allows “Read & Write” access to all clients for that Azure NetApp Files NFSv3 volume.
- The second rule in the index explicitly lists NFS client 10.10.10.10. It's configured to limit access to “Read only” with no root access (root is squashed).

In this scenario, the client 10.10.10.10 receives access due to the first rule in the list. To fix this and set access to the desired level, the rules can be reordered to place the desired client access rule above any subnet/CIDR rules. You can reorder export policy rules in the Azure portal.

## SMB shares

SMB shares enable end users to access SMB or dual-protocol volumes in Azure NetApp Files. SMB shares can control access to who can mount and access a share, as well as control access levels to users and groups in an Active Directory domain. The first level of permissions that get evaluated are share ACLs.

Access controls for SMB shares are limited in the Azure NetApp Files control plane to only SMB security options such as access-based enumeration and non-browsable share functionality. These security options are configured during volume creation with the Edit volume functionality.  

:::image type="content" source="../media/3-edit-server-message-block-volume.png" alt-text="Screenshot of edit volume interface." lightbox="../media/3-edit-server-message-block-volume.png":::

Share-level permission ACLs are managed through a Microsoft Management Console rather than through Azure NetApp Files. These ACLs are found under **System Tools > Shared Folders > Shares.**

:::image type="content" source="../media/3-shared-folders.png" alt-text="Screenshot of share folders interface." lightbox="../media/3-shared-folders.png":::

To manage share permissions, right-click the name of the share you want to modify from the list then select Properties. You can add, remove, or modify the share ACLs.

:::image type="content" source="../media/3-volume-properties.png" alt-text="Screenshot of volume properties options." lightbox="../media/3-volume-properties.png":::

