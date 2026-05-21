Azure offers four main storage services:
- Azure Blob
- Azure Files
- Azure NetApp Files
- Azure Disks

Azure Blob offers many features for programmatic accessibility, cooling capability, and resilience through replication, including protection against malware attacks through immutability, versioning, and point-in-time restore. If your workloads need to access data using specific NFS versions or CIFS/SMB, Azure Files may be more suitable. If NFS and CIFS/SMB are both required, consider Azure NetApp Files.

Always pick the target service based on the requirements of the future use case. Requirements may differ for different data sets, even when the data resides on the same storage system. Always treat data sets with the same requirements as a group, because doing so significantly affects whether you meet your requirements and optimize costs.

Learn more: [Compare Azure storage services](/azure/storage/common/storage-introduction)

The following flowchart outlines when to pick which offering based on these requirements:

:::image type="content" source="../media/file-service-images-with-independent-software-vendor.png" alt-text="Flowchart showing how to select an Azure storage service based on access protocol requirements.":::

## Azure Blob and ADLS Gen2

Carefully evaluate how your workloads will access data in their future state. If they access data using REST API, BlobFuse, ABFS, or NFS version 3 only, use Blob and ADLS Gen2 for automatic cooling of data, vaulted backups, versioning, and immutability, to name a few.

Learn more: [Azure Blob and ADLS Gen2 overview](/azure/storage/blobs/storage-blobs-overview)

Access data on Blob using the Blob API whenever possible.

Legacy applications can also access data using [NFS](/azure/storage/blobs/network-file-system-protocol-support) or [SFTP](/azure/storage/blobs/secure-file-transfer-protocol-support), or mount storage using [BlobFuse](/azure/storage/blobs/blobfuse2-what-is).

## Azure Files

If your access pattern requires SMB or NFS version 4 or 4.1, consider Azure Files. Resiliency through replication is comparable, but capabilities such as immutability aren't available.

> [!NOTE]
> While Azure Files also supports NFS, only NFS *or* SMB can be turned on at a time. If you need both protocols, use Azure NetApp Files.

Learn more: [Azure Files overview](/azure/storage/files/storage-files-introduction)

> [!IMPORTANT]
> While the Azure Files pay-as-you-go model may seem cheaper at first glance, it can lead to higher costs. The cost depends on your access patterns, so evaluate it carefully. Learn more: [Azure Files billing models](/azure/storage/files/understanding-billing).

## Azure NetApp Files

If your use case requires SMB and NFS access in parallel against the same dataset (otherwise you could split them to distinct services), select Azure NetApp Files.
Also, if your workload has high performance or low-latency requirements, select Azure NetApp Files.

Learn more: [Azure NetApp Files overview](/azure/azure-netapp-files/azure-netapp-files-introduction) and [Azure NetApp Files learning path](/training/modules/introduction-to-azure-netapp-files/)

## Azure Managed Disks
For workloads that demand block-like devices (that is, high-performance locally attached disks, or legacy applications that can't be changed to work with cloud-native data access), use Azure Disks.

Learn more: [Azure Managed Disks overview](/azure/virtual-machines/managed-disks-overview)

> [!TIP]
> Moving data to cloud-native storage platforms like Azure Blob, Azure Files, or Azure NetApp Files enables significant modernization benefits. Azure-integrated storage ISV offerings can complement this by supporting policy-driven data movement and application-transparent access. Evaluate whether your applications can interact with data on these services directly (for example, through local mounting via BlobFuse) or through industry-standard protocols such as NFS, SMB, or SFTP.

## ISV offerings
In some scenarios, the standard offerings don't meet your needs. Microsoft has many partner companies that can help.
Learn more: [Validated partner storage solutions](/azure/storage/solution-integration/validated-partners/primary-secondary-storage/partner-overview)