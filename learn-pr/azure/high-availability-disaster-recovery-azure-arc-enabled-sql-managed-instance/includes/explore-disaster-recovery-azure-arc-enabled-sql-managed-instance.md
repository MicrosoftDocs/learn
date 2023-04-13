Although high availability and point-in-time restore capabilities are essential to minimizing interruptions of business operations due to localized failures or data corruption issues, they are not sufficient to address all business continuity needs. Essential enterprise workloads and data services commonly require disaster recovery provisions, like those applicable to your on-premises US government contract-related data stores. These provisions must allow you to perform a failover to another US-based datacenter in case of an outage affecting the availability of the primary site.

Azure Arc-enabled SQL Managed Instance offers disaster recovery capabilities in the form of Azure failover groups. These capabilities are available in both the General Purpose and Business Critical service tiers.

## Azure failover groups

Azure failover groups involve implementing identically configured custom Kubernetes resources in different physical sites. This allows you to perform a manual failover between these resources in case of a site-level outage. The resulting behavior mirrors the distributed availability groups functionality available in Microsoft SQL Server. 

Azure failover groups asynchronously transfer data between managed instances in the primary and secondary site. The managed instances must have a matching compute, capacity, and service tiers.

:::image type="content" source="../media/failover-group-architecture-3.png" alt-text="Diagram of Azure failover groups architecture." border="false":::

## Implement disaster recovery with Azure failover groups

To implement an Azure failover group across two sites, you have to provision a Kubernetes cluster in each of the sites and make sure that both have a matching capacity of storage, vCPU, and memory resources available for their respective Azure Arc-enabled SQL Managed Instance deployment. 

The General Purpose tier of Arc-enabled SQL MI is subject to the same resource limits as SQL Server Standard Edition and uses a single replica. Implementing an Azure failover group in this case requires a single replica in the secondary site. The Business Critical Tier of Arc-enabled SQL Managed Instance is subject to the same resource limits as SQL Server Enterprise Edition and uses up to three replicas. Implementing Azure failover groups in this case requires the same number of replicas in the secondary site.

In case of an expected outage of the primary site, use the `az sql instance-failover-group-arc update --role secondary` Azure CLI command. This results in a graceful failover, which helps ensure that all pending transactions from the primary site are replicated and applied to the secondary site. If a graceful failover is not an option due to the primary instance of Azure Arc-enabled SQL Managed Instance not being available, you have to resort to a forced failover. To invoke this option, run the same Azure CLI command but set the `--role` parameter to the `force-primary-allow-data-loss` value. It is important to keep in mind that a forced failover implies the possibility of data loss.
