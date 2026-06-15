To create a dual-protocol volume, from the Azure NetApp Files portal, select **Volumes** from the left menu. Select **+ Add volume** to create a volume.

1. In the **Create a volume** window, under the **Basics** tab, provide information for the following fields:

    | Field | Description |
    | --- | --- |
    | Volume name | Specify the name for the volume that you're creating. Refer to [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftnetapp) for naming conventions on volumes. |
    | Capacity pool | Specify the capacity pool where you want the volume to be created. |
    | Quota | Specify the amount of logical storage that is allocated to the volume. The **Available quota** field shows the amount of unused space in the chosen capacity pool that you can use to create a new volume. The size of the new volume must not exceed the available quota. |
    | Large Volume | Regular volumes quotas are between 50 GiB and 100 TiB. Large volume quotas range from 50 TiB to 1 PiB in size. If you intend for the volume quota to fall in the large volume range, select **Yes**. Volume quotas are entered in GiB. |
    | Available throughput (MiB/S) and Max. Throughput (MiB/S) | If the volume is created in a manual QoS capacity pool, specify the throughput you want for the volume. If the volume is created in an auto QoS capacity pool, the value displayed in this field is (quota x service level throughput). |
    | Enable Cool Access, Coolness Period, and Cool Access Retrieval Policy | These fields configure storage with cool access in Azure NetApp Files. |
    | Virtual network | Specify the Azure Virtual Network from which you want to access the volume. |
    | Delegated subnet | Specify the subnet that you want to use for the volume. The subnet you specify must be delegated to Azure NetApp Files. If you haven't delegated a subnet, you can select **Create new** on the Create a volume page. In the **Create Subnet** page, specify the subnet information, and select **Microsoft.NetApp/volumes** to delegate the subnet for Azure NetApp Files. |
    | Network features | In supported regions, you can specify whether you want to use Basic or Standard network features for the volume. |
    | Encryption key source | You can select **Microsoft Managed Key** or **Customer Managed Key** as the encryption key source. |
    | Availability zone | This option lets you deploy the new volume in the logical availability zone that you specify. Select an availability zone where Azure NetApp Files resources are present. |
    | Show advanced section | Specify whether you want to hide the snapshot path and select a snapshot policy in the pull-down menu. |

2. After filling in these details, go to the **Protocol** tab and complete the following actions:

    - Select **Dual-protocol** as the protocol type for the volume.
    - Specify the **Active Directory** connection to use.
    - Specify a unique **Volume Path**. This path is used when you create mount targets.
    - Specify the **versions** to use for dual protocol: **NFSv4.1 and SMB**, or **NFSv3 and SMB**.
    - Specify the **Security Style** to use: **NTFS** (default) or **UNIX**.
    - If you want to enable SMB3 protocol encryption for the dual-protocol volume, select **Enable SMB3 Protocol Encryption**.
    - If you selected NFSv4.1 and SMB for the dual-protocol volume versions, indicate whether you want to enable **Kerberos** encryption for the volume.
    - If you want to enable access-based enumeration, select **Enable Access Based Enumeration**.
    - You can enable the non-browsable-share feature.
    - Customize Unix Permissions as needed to specify change permissions for the mount path.
    - Optionally, configure export policy for the volume.

        :::image type="content" source="../media/dual-protocol-volume-settings.png" alt-text="Screenshot of Azure NetApp Files Create a volume page. It is showing the Protocol tab with Dual-protocol selected, NFSv3 and SMB versions, NTFS security style, and an export policy rule." border="true" lightbox="../media/dual-protocol-volume-settings.png":::


3. After entering the details, select **Review + Create** to review the volume details. Select **Create** to create the volume.

4. A volume inherits subscription, resource group, and location attributes from its capacity pool. To monitor the volume deployment status, you can use the **Notifications** tab.

### Allow local NFS users with LDAP to access a dual-protocol volume

The **Allow local NFS users with LDAP** option in Active Directory connections enables local NFS client users who aren't present on the Windows LDAP server to access a dual-protocol volume that has LDAP with extended groups enabled.

To enable this option, edit an Active Directory connection and select **Allow local NFS users with LDAP**.

:::image type="content" source="../media/active-directory-allow-local-nfs-users.png" alt-text="Screenshot of Edit Active Directory settings dialog showing the Allow local NFS users with LDAP checkbox enabled." border="true" lightbox="../media/active-directory-allow-local-nfs-users.png":::