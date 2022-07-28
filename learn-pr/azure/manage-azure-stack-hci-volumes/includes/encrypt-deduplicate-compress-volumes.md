To complete your proof of concept, you need to validate the process of encrypting, deduplicating, and compressing volumes. You noticed the options indicating support for these features when you were testing volume creation in Windows Admin Center, but before you try implementing them, you want to identify any considerations regarding their use.

## Describe considerations regarding encrypting, deduplicating, and compressing volumes

You have the option to enable encryption, deduplication, and compression on Azure Stack HCI volumes. Each of these capabilities has its own set of considerations.

### Describe considerations regarding encrypting volumes

*BitLocker* is a data protection feature that integrates with Azure Stack HCI and provides support for CSVs. Encryption can be enabled when the volume is being created or at any point afterwards. However, if you enable it after it’s created, any volume‑dependent resource should be placed into the maintenance mode.

Windows Admin Center simplifies the BitLocker implementation by automatically installing the required operating system feature and configuring an Active Directory Domain Services (AD DS)–based protector for securing clustered volumes.

> [!NOTE]
> If you intend to provision an additional locally held BitLocker key and not rely on AD DS, you must use PowerShell instead of Windows Admin Center. Additional information regarding this functionality is available in the Microsoft documentation included in the Summary unit’s reference links.

### Describe considerations regarding deduplicating and compressing volumes

Data deduplication and compression is an operating system role service that increases the usable capacity of NTFS and ReFS volumes by deduplicating and compressing volume files. When these files are read, the deduplicated and compressed content is automatically assembled.

Data deduplication and compression follows the post-processing approach. This means that it optimizes the files stored on the volume where you enabled both of these features, rather than attempting to optimize them as part of a write operation. This minimizes its potential performance impact. The processing is handled by a scheduled background job whose characteristics depend on the configuration options that you specify.

Data Deduplication supports the following configuration options:

- Default:
  - Intended workload: General-purpose file server
  - Settings: Background optimization
  - Default optimization policy:
    - Minimum file age = 3 days
    - Optimize in-use files = No
    - Optimize partial files = No
- Hyper-V:
  - Intended workload: VDI servers
  - Settings: Background optimization
  - Default optimization policy:
    - Minimum file age = 3 days
    - Optimize in-use files = Yes
    - Optimize partial files = Yes
- Backup:
  - Intended workload: Virtualized backup applications, for example, Microsoft System Center Data Protection Manager (DPM)
  - Settings: Priority optimization
  - Default optimization policy:
    - Minimum file age = 0 days
    - Optimize in-use files = Yes
    - Optimize partial files = No

> [!NOTE]
> Small files (smaller than 32 kilobytes (KB)), encrypted files (on NTFS volumes), and files with extended attributes (on NTFS volumes) are excluded from deduplication. You also have the option to exclude individual folders or files from deduplication based on their type.

Windows Admin Center simplifies deduplication and encryption implementation by automatically installing the required operating system components and configuring the usage type you specify.

## Encrypt, deduplicate, and compress volumes

To configure encryption, deduplication, and compression of Azure Stack HCI volumes by using Windows Admin Center:

1. Open Windows Admin Center, and then connect to a Storage Spaces Direct cluster.
1. In the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, and then select the volume you intend to configure.
1. In the **Volume details** pane, in the **Optional features** section:
    1. Turn the **Deduplication and compression** switch on. To do this:
        1. In the **Enable deduplication** pane, select the deduplication mode.
        1. Select the deduplication profile you intend to use, or keep the default, and then select **Enable**.
    1. Turn the **Encryption (BitLocker)** switch on.

You can check the status of each of these features in the overview pane of the corresponding volume.
