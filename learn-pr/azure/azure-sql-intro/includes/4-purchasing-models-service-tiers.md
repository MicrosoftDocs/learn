After you have an idea of which Azure SQL product is best for your requirements, you need to determine the purchasing model, service tier, and hardware that best suits your workload. The purchasing model, service tier, and hardware selections you make have a significant impact on the performance, availability, and cost of your deployment.

This unit provides an overview of these technical characteristics and how they affect your deployment. 

## Purchasing model  

With the two PaaS services, the purchasing model determines how you pay for the resources you use. The purchasing model also determines the service tiers and hardware options available to you. 

The PaaS Azure SQL products offer the following purchasing models: 

- Purchase based on virtual cores (vCore-based) - applicable to Azure SQL Database and Azure SQL Managed Instance
- Purchase based on database transaction units (DTU-based) - applicable to Azure SQL Database only

With SQL Server on Azure VMs, billing is determined by the VM size and storage type, but you can control how you pay for the SQL Server license. You can either pay for the license as you go (called pay-as-you-go), or you can use your existing SQL Server license with the Azure Hybrid Benefit.

### vCore-based model

Both Azure SQL Database and Azure SQL Managed Instance offer the vCore-based purchasing model. The vCore-based purchasing model gives you flexibility, control, transparency of individual resource consumption, and a straightforward way to translate on-premises workload requirements to the cloud. 

In the vCore model, you pay for:  

- **Compute resources:** The service tier plus the number of vCores and the amount of memory plus the generation of hardware.
- **Data and log storage:** The type and amount of data and log storage.
- **Backup storage location:** Read-access geo-redundant storage (RA-GRS), zone-redundant storage (ZRS), or locally redundant storage (LRS).  

We recommend the vCore-based model, because it allows you to independently select compute and storage resources. The vCore model also allows you to use the Azure Hybrid Benefit for the SQL Server license and/or Azure Reservations to pay for resources in advance to save money. Neither of these options is available in the DTU model.

### DTU-based model

The DTU-based model is a bundled measure of compute, storage, and I/O resources. The DTU-based model is available for Azure SQL Database only. 

Compute sizes are expressed in DTUs for single databases and in elastic database transaction units (eDTUs) for elastic pools. A database transaction unit (DTU) represents a blended measure of CPU, memory, reads, and writes. The DTU-based purchasing model offers a set of preconfigured bundles of compute resources and included storage to drive different levels of application performance. 

## Service tier  

The service tier you choose determines the performance and availability of your database, such as available resources. Service tiers are only applicable to Azure SQL Database and Azure SQL Managed Instance, not SQL Server on Azure VMs.

The vCore-based model offers the following service tiers: 

- **General Purpose**: Suitable for most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.  
- **Business Critical**: Suitable for business applications with low-latency response requirements. Offers the highest resilience to failures by using several isolated replicas. This tier is the only one that can use in-memory OLTP (online transactional processing) to improve performance.
- **Hyperscale - SQL Database only**: This service tier is only available to Azure SQL Database. It's suitable for business workloads with highly scalable storage (100 TB+) and read-scale requirements. From a performance and cost perspective, this tier falls between General Purpose and Business Critical. 

The DTU-based model for Azure SQL Database offers the following service tiers:

- **Basic**: Suitable for small workloads with a low number of concurrent users. 
- **Standard**: Suitable for most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.
- **Premium**: Suitable for business applications with low-latency response requirements. 

## Compute tier

With Azure SQL Database, if you choose the General Purpose or Hyperscale tier of the vCore-based model, you have another decision to make regarding the compute tier that you pay for:

- **Provisioned compute**: 
   - Provides a specific amount of compute resource that is continuously provisioned independent of workload activity, and bills for the amount of compute provisioned at a fixed price per hour.
   - Meant for regular usage patterns with higher average compute utilization over time, or for multiple databases that use elastic pools. Provisioned compute provides a fixed amount of resources over time to ensure optimal performance, and is billed for those resources regardless of usage. In provisioned compute, you need to manage the sizing of compute resources for your workload.
- **Serverless compute**: 
   - Automatically scales compute resources based on workload activity and bills for the amount of compute used, per second. 
   - Meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless also supports automatic pausing and resuming to help further price optimize. When your database is paused, you pay only for storage.  

Compute tiers are only applicable to Azure SQL Database, and not Azure SQL Managed Instance, or SQL Server on Azure VMs. 

## Hardware

In Azure SQL Database and Azure SQL Managed Instance, the default hardware generation at this time is referred to as standard-series hardware, formerly known as Gen5. 

Common hardware configurations in the vCore model include standard-series (Gen5), Fsv2-series, and DC-series. The Business Critical service tier of Azure SQL Managed Instance, and the Hyperscale service tier of Azure SQL Database also offer premium-series and premium-series memory optimized hardware. Premium-series hardware provides the latest and greatest premium storage and compute hardware.

In the DTU-based purchasing model, customers can't choose the hardware configuration used for their databases.

The hardware for SQL Server on Azure VMs is determined by the VM size you choose. The VM size determines the number of vCPUs, memory, and storage available to your SQL Server instance. You can choose from a variety of VM sizes, including general-purpose, compute-optimized, memory-optimized, and storage-optimized VMs.

