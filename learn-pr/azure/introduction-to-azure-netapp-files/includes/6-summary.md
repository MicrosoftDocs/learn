Our goal in this module was to help you evaluate whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud. To help you make that decision, we presented some criteria you can use:

- Ease of migration
- Workload scale
- Flexibility
- Storage technology

We applied these criteria in the context of our fictional energy company. You learned that in most scenarios, Azure NetApp Files:

- Supports any POSIX-compliant workload that requires shared file storage via Server Message Block (SMB), Network File System (NFS), or both. So, it can *lift-and-shift* these types of workloads.
- Works best with enterprise-scale workloads that require the highest performance and availability.
- Enables you to change a volume's service level and increase or decrease the size of a capacity pool or volume to match current demand.
- Can support any workload that requires shared file storage.

However, you also learned that organizations would probably not benefit from using Azure NetApp Files if they have:

- Workloads that require extensive reconfiguration or recoding to work in the cloud.
- Workloads that are relatively small-scale and low-performance.
- Content that's mostly static with relatively constant demand.
- Workloads that have a strict dependency or requirement for storage that is both block-based and direct-attached.

Implementing today's enterprise workloads requires the highest storage performance, maximum availability, and the flexibility to meet any demand. In the past, companies could only achieve the performance part of this recipe by using an on-premises datacenter. However, datacenter configurations tend to be inflexible, complex, and expensive. A cloud service such as Azure offers flexibility, simplicity, and cost savings for regular workloads. So the significant question today is, how do you migrate your most important enterprise workloads to the cloud while still maintaining the highest level of performance and availability? Azure NetApp Files provides datacenter-quality performance and high availability with all the flexibility of the cloud. The process you went through here should give you enough information to decide the correct shared-storage solution for your organization. 

## References

- [Azure NetApp Files](https://azure.microsoft.com/services/netapp/)
- [Service Level Agreement (SLA) for Azure NetApp Files](https://azure.microsoft.com/support/legal/sla/netapp/v1_1/)
- [Service levels for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-service-levels)
- [Resource limits for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-resource-limits)
- [FAQs About Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-faqs)
- [Azure Files and Azure NetApp Files comparison](/azure/storage/files/storage-files-netapp-comparison)
- [Cross-region replication of Azure NetApp Files volumes](/azure/azure-netapp-files/cross-region-replication-introduction)
- [Dual-protocol volumes for Azure NetApp Files](/azure/azure-netapp-files/create-volumes-dual-protocol)
