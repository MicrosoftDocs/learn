The goal in this module was to help you evaluate whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud. To help you make that decision, we explored some of Azure NetApp Files' assets:

- Ease of migration
- Workload scale
- Flexibility
- Storage technology

You learned that Azure NetApp Files:

- Supports any POSIX-compliant workload that requires shared file storage via Server Message Block (SMB), Network File System (NFS), or both. So, it can *lift-and-shift* these types of workloads.
- Works best with enterprise-scale workloads that require the highest performance and availability.
- Enables you to change a volume's service level and increase or decrease the size of a capacity pool or volume to match current demand.
- Can support any workload that requires shared file storage.

You also learned that you likely won't benefit from using Azure NetApp Files if you have:

- Workloads that require extensive reconfiguration or recoding to work in the cloud.
- Workloads that are relatively small-scale and low-performance.
- Content that's mostly static with relatively constant demand.
- Workloads that have a strict dependency or requirement for storage that is both block-based and direct-attached.

Implementing today's enterprise workloads requires the highest storage performance, maximum availability, and the flexibility to meet any demand. The significant question is: how do you migrate your most important enterprise workloads to the cloud while still maintaining the highest level of performance and availability? Azure NetApp Files provides datacenter-quality performance and high availability with all the flexibility of the cloud. The process you went through here should give you enough information to decide the correct shared-storage solution for your organization.

## Learn more

- [Azure NetApp Files](https://azure.microsoft.com/services/netapp/)
- [What is Azure NetApp Files?](/azure/azure-netapp-files/azure-netapp-files-introduction)
- [Azure Architectures](/azure/architecture/browse/?terms=netapp)
