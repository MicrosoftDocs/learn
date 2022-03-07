Once you have the name and location set, you need to decide on the size of your VM. Rather than specify processing power, memory, and storage capacity independently, Azure provides different VM sizes that offer variations of these elements in different sizes. Azure provides a wide range of VM size options allowing you to select the appropriate mix of compute, memory, and storage for what you want to do.

The best way to determine the appropriate VM size is to consider the type of workload your VM needs to run. Based on the workload, you're able to choose from a subset of available VM sizes. Workload options are classified as follows on Azure:

:::row:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **Example Usage**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    General purpose
  :::column-end:::
  :::column:::
    Balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Compute optimized
  :::column-end:::
  :::column:::
    High CPU-to-memory ratio. Good for medium traffic web servers, network appliances, batch processes, and application servers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Memory optimized
  :::column-end:::
  :::column:::
   High memory-to-CPU ratio. Great for relational database servers, medium to large caches, and in-memory analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage optimized
  :::column-end:::
  :::column:::
    High disk throughput and IO ideal for Big Data, SQL, NoSQL databases, data warehousing, and large transactional databases.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    GPU
  :::column-end:::
  :::column:::
    Specialized virtual machines targeted for heavy graphic rendering and video editing, as well as model training and inferencing (ND) with deep learning. Available with single or multiple GPUs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    High performance compute
  :::column-end:::
  :::column:::
    Our fastest and most powerful CPU virtual machines with optional high-throughput network interfaces (RDMA).
  :::column-end:::
:::row-end:::


## Resizing virtual machines

Azure allows you to change the VM size when the existing size no longer meets your needs. You can resize a VM if your current hardware configuration is allowed in the new size. This provides a fully agile and elastic approach to VM management.

When you stop and deallocate the VM, you can select any size available in your region.

> [!NOTE]
> Be cautious when resizing production VMs. Resizing may require a restart that can cause a temporary outage or change configuration settings like the IP address.
