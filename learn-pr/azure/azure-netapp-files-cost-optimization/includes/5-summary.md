You've learned how Azure NetApp Files resource consumption is billed on provisioned storage capacity. The storage in Azure NetApp Files is provisioned as capacity pools. Capacity pools are billed monthly based on a set cost per allocated GiB per hour.

You also learned that using Azure NetApp Files storage with cool access, you can configure inactive data to move from any Azure NetApp Files service-level storage (the hot tier) to an Azure storage account (the cool tier).

- The purpose of cool access is to save cost by transparently moving 'cold data' off to lower cost Azure storage.
- If the working set is predictable, you can save cost by moving infrequently accessed data blocks to the cool tier.

Also, billing in Azure NetApp Files is done based on the following factors:

- The capacity in the service level
- Unallocated capacity within the capacity pool
- The capacity in the cool tier (by enabling tiering for volumes in a capacity pool)
- Network transfer between the hot tier and the cool tier at the rate that is determined by the markup on top of the transaction.

## Learn more

- [Cost model for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-cost-model)
- [Examples of billing structure with storage with cool access in Azure NetApp Files](/azure/azure-netapp-files/cool-access-introduction#billing)
- [Performance considerations for Azure NetApp Files with cool access](/azure/azure-netapp-files/performance-considerations-cool-access)
