After you have an idea of which deployment option is best for your requirements, you need to determine the purchasing model, service tier, and hardware. In this unit, you'll get an overview of the purchasing options and when to choose them.  

## Purchasing model  

The Azure SQL purchasing model provides two options: 
- Based on virtual cores (vCore-based) 
- Based on database transaction units (DTU- based) 

The DTU model isn't available in Azure SQL Managed Instance.  

We recommend the vCore-based model because it allows you to independently select compute and storage resources. The DTU-based model is a bundled measure of compute, storage, and I/O resources. 

In the vCore model, you pay for:  

- Compute resources. (The service tier + the number of vCores and the amount of memory + the generation of hardware.)
- The type and amount of data and log storage.
- Backup storage location. (Read-access geo-redundant storage (RA-GRS), Zone-redundant storage (ZRS), or locally-redundant storage (LRS)).  

The vCore model also allows you to use Azure Hybrid Benefit for SQL Server and/or reserved capacity (pay in advance) to save money. Neither of these options is available in the DTU model.

In this module, we'll focus on the vCore purchasing model.  

## Service tier  

Next, you need to choose a service tier for performance and availability. We recommend you start with the General Purpose tier and adjust as needed. Three tiers are available in the vCore model:  

- **General Purpose**: Suitable for most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.  
- **Business Critical**: Suitable for business applications with low-latency response requirements. Offers the highest resilience to failures by using several isolated replicas. This tier is the only one that can use In-Memory OLTP to improve performance.
- **Hyperscale**: Suitable for business workloads with highly scalable storage (100 TB+) and read-scale requirements. From a performance and cost perspective, this tier falls between General Purpose and Business Critical. Hyperscale is currently available only for single databases in Azure SQL Database.  

If you choose General Purpose and the vCore-based model, you have an additional decision to make regarding the compute that you pay for:

- **Provisioned compute** is meant for more regular usage patterns with higher average compute utilization over time, or for multiple databases that use elastic pools.
- **Serverless compute** is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless has autopause and resume capabilities with a time delay that you set. When your database is paused, you pay only for storage.  

### Hardware

The default hardware generation at this time is referred to as *Gen5* hardware. As technology advances, you can expect the available hardware options to change as well. For example, Fsv2-series (compute-optimized) and M-series (memory-optimized) hardware options recently became available for SQL Database.

If you choose General Purpose within SQL Database and want to use the serverless compute tier, Gen5 hardware is currently the only option. It can currently scale up to 40 vCores.  

The purchasing model, service tier, and hardware selections you make will have a significant impact on the performance, availability, and cost of your deployment.  
