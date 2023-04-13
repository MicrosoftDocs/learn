Rather than specify processing power, memory, and storage capacity independently, Azure provides different virtual machine sizes that offer variations of these elements in different size configurations. Azure provides a wide range of virtual machine size options that allow you to select the appropriate mix of compute, memory, and storage for your needs.

### Things to know about virtual machine sizes

The best way to determine the appropriate virtual machine size is to consider the type of workload your virtual machine needs to run. Based on the workload, you can choose from a subset of available virtual machine sizes.

The following table shows size classifications for Azure Virtual Machines workloads and recommended usage scenarios.

| Classification | Description | Scenarios |
| --- | --- | --- |
| **General purpose** | General-purpose virtual machines are designed to have a balanced CPU-to-memory ratio. | - Testing and development <br> - Small to medium databases <br> - Low to medium traffic web servers |
| **Compute optimized** | Compute optimized virtual machines are designed to have a high CPU-to-memory ratio. | - Medium traffic web servers <br> - Network appliances <br> - Batch processes <br> - Application servers |
| **Memory optimized** | Memory optimized virtual machines are designed to have a high memory-to-CPU ratio. | - Relational database servers <br> - Medium to large caches <br> - In-memory analytics |
| **Storage optimized** | Storage optimized virtual machines are designed to have high disk throughput and I/O. | - Big Data <br> - SQL and NoSQL databases <br> - Data warehousing <br> - Large transactional databases |
| **GPU** | GPU virtual machines are specialized virtual machines targeted for heavy graphics rendering and video editing. Available with single or multiple GPUs. | - Model training <br> - Inferencing with deep learning |
| **High performance computes** | High performance compute offers the fastest and most powerful CPU virtual machines with optional high-throughput network interfaces (RDMA). | - Workloads that require fast performance <br> - High traffic networks |

#### Resizing virtual machines

Azure allows you to change the virtual machine size when the existing size no longer meets your needs. You can resize a virtual machine if your current hardware configuration is allowed in the new size. This option provides a fully agile and elastic approach to virtual machine management.

When you stop and deallocate the virtual machine, you can select any size available in your region.

> [!Important]
> Be cautious when resizing production virtual machines. Resizing a machine might require a restart that can cause a temporary outage or change configuration settings such as the IP address.