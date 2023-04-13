
The best way to determine the appropriate VM size is to consider the type of workload your VM needs to run. Based on the workload, you're able to choose from a subset of available VM sizes. Workload options are classified as follows on Azure:


| VM Type | Description |
|--|--|
| General Purpose |Balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers. |
| Compute Optimized | High CPU-to-memory ratio. Good for medium traffic web servers, network appliances, batch processes, and application servers. |
| Memory Optimized | High memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics. |
| Storage Optimized | High disk throughput and IO ideal for Big Data, SQL, NoSQL databases, data warehousing and large transactional databases. |
| GPU | Specialized virtual machines targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND) with deep learning. Available with single or multiple GPUs. |
| High Performance Compute | Our fastest and most powerful CPU virtual machines with optional high-throughput network interfaces (RDMA). |

**What if my size needs change?**

Azure allows you to change the VM size when the existing size no longer meets your needs. You can resize the VM - as long as your current hardware configuration is allowed in the new size. This provides a fully agile and elastic approach to VM management.

If you stop and deallocate the VM, you can then select any size available in your region since this removes your VM from the cluster it was running on.

> [!CAUTION]
> Be cautious when resizing production VMs - they will be rebooted automatically which can cause a temporary outage and change some configuration settings such as the IP address.


## Additional resources

*  For information about pricing of the various sizes, see the pricing pages for [Linux](https://azure.microsoft.com/pricing/details/virtual-machines/#Linux) or [Windows](https://azure.microsoft.com/pricing/details/virtual-machines/Windows/#Windows).
*  For availability of VM sizes in Azure regions, see [Products available by region](https://azure.microsoft.com/regions/services/).

 