Once you have an idea of what deployment option is best for your requirements, determining the purchasing model, service tier, and hardware, is the next thing to determine. In this section, you'll get an overview of the options and what to use when.  

## Purchasing model  

You have two options for the purchasing model, [virtual core (vCore)-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore) (recommended) or [Database transaction unit (DTU)-based](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-dtu
). The DTU model is not available in Azure SQL MI.  

> The vCore-based model is recommended because it allows you to independently choose compute and storage resources, while the DTU-based model is a bundled measure of compute, storage and I/O resources, which means you have less control over paying only for what you need. This model also allows you to use [Azure Hybrid Benefit for SQL Server](https://azure.microsoft.com/pricing/hybrid-benefit/) and/or [Reserved capacity](https://docs.microsoft.com/azure/sql-database/sql-database-reserved-capacity) to gain cost savings (neither are available in the DTU model). In the [vCore model](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore), you pay for:  
>
> * Compute resources (the service tier + the number of vCores and the amount of memory + the generation of hardware).
> * The type and amount of data and log storage.
> * Backup storage ([read-access, geo-redundant storage (RA-GRS)](https://docs.microsoft.com/azure/storage/common/storage-designing-ha-apps-with-ragrs)).  

For the purposes of this module, we'll focus on the vCore purchasing model (recommended). You can optionally review the DTU model by [comparing vCores and DTUs in-depth here](https://docs.microsoft.com/azure/sql-database/sql-database-purchase-models
).  

## Service tier  

The next decision is choosing the service tier for performance and availability. We recommend you start with the General Purpose, and adjust as needed. There are three tiers available in the vCore model:  

* **[General purpose](https://docs.microsoft.com/azure/sql-database/sql-database-service-tier-general-purpose)**: Most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.  
* **[Business critical](https://docs.microsoft.com/azure/sql-database/sql-database-service-tier-business-critical)**: Business applications with low-latency response requirements. Offers highest resilience to failures by using several isolated replicas. This is the only tier that can leverage [in-memory OLTP](https://docs.microsoft.com/azure/sql-database/sql-database-in-memory) to improve performance.
* **[Hyperscale](https://docs.microsoft.com/azure/sql-database/sql-database-service-tier-hyperscale)**: Most business workloads with highly scalable storage (100TB+) and read-scale requirements. From a performance and cost perspective, it falls between General purpose and Business critical. *Currently only available for single databases, not managed instances or pools*.  

If you choose **General Purpose within Azure SQL DB** and the **vCore-based model**, you have an additional decision to make regarding the compute that you pay for:

* **Provisioned compute** is meant for more regular usage patterns with higher average compute utilization over time, or multiple databases using elastic pools. 
* **Serverless compute** is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless has auto-pause and resume capabilities (with a time delay you set), meaning when your database is paused, you only pay for storage.  

For a deeper explanation between provisioned and serverless compute (including scenarios), you can refer to the detailed [comparison in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-serverless#comparison-with-provisioned-compute-tier).  For a deeper explanation between the three service tiers (including scenarios), you can refer to the [service-tier characteristics](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore#service-tier-characteristics) in the documentation.  

### Hardware

The default hardware generation at this time is referred to as **Gen5** hardware. Gen4 hardware exists but is reaching [end of life in 2020](https://azure.microsoft.com/updates/gen-4-hardware-on-azure-sql-database-approaching-end-of-life-in-2020/). As technology advances, you can expect that the hardware options available will change as well. For example, Fsv2-series (compute optimized) and M-series (memory optimized) hardware options recently became available in public preview for Azure SQL DB. You can review the latest hardware generations and availability [here](https://docs.microsoft.com/azure/sql-database/sql-database-service-tiers-vcore#hardware-generations).

> Note: If you choose General Purpose within Azure SQL DB and want to use the serverless compute tier, Gen5 hardware is currently the only option and it currently can scale up to 16 vCores.  

## Summary

What purchasing model and service tier decisions you make will have a big impact on the performance, availability and cost of your deployment. After this unit, you should have a better understanding of what options are available so you can make the right decisions for your organization.  
