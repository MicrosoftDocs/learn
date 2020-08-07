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
- Backup storage. (Read-access geo-redundant storage (RA-GRS)).  

The vCore model also allows you to use Azure Hybrid Benefit for SQL Server and/or reserved capacity to gain cost savings. Neither options are available in the DTU model.

For most databases, the vCore model is recommended. For the purposes of this module, we'll focus on the vCore purchasing model.  

## Service tier  

The next decision is choosing the service tier for performance and availability. We recommend you start with the General Purpose, and adjust as needed. There are three tiers available in the vCore model:  

- **General Purpose**: Suitable for most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.  
- **Business Critical**: Suitable for business applications with low-latency response requirements. Offers highest resilience to failures by using several isolated replicas. This tier is the only one that can leverage in-memory OLTP to improve performance.
- **Hyperscale**: Suitable for business workloads with highly scalable storage (100 TB+) and read-scale requirements. From a performance and cost perspective, it falls between general purpose and business critical. Hyperscale is currently only available for single databases in Azure SQL Database.  

If you choose General Purpose and the vCore-based model, you have an additional decision to make regarding the compute that you pay for:

- **Provisioned compute** is meant for more regular usage patterns with higher average compute utilization over time, or multiple databases using elastic pools.
- **Serverless compute** is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless has autopause and resume capabilities (with a time delay you set), meaning when your database is paused, you only pay for storage.  

### Hardware

The default hardware generation at this time is referred to as Gen5 hardware. Gen4 hardware exists but is reaching end of life in 2020. As technology advances, you can expect that the hardware options available will change as well. For example, Fsv2-series (compute optimized) and M-series (memory optimized) hardware options recently became available in public preview for SQL Database.

If you choose General Purpose within SQL Database and want to use the serverless compute tier, Gen5 hardware is currently the only option and it currently can scale up to 16 vCores.  

The purchasing model, service tier, and hardware selections you make will have a large impact on the performance, availability, and cost of your deployment.  
