Azure SQL Database and Azure SQL Managed Instance provide great availability options by default in the various service tiers. There are some additional things you can do to increase or modify the availability of your databases/instances, and you can directly see the impact on the service-level agreement (SLA). In this unit, you'll see how you can go further with various options for availability in Azure SQL.

## Availability Zones

In the Business critical tier in Azure SQL Database, you can opt in (for no additional fee) for a zone-redundant configuration if your region supports that. At a high level, the Always On availability group (AG) that runs behind Business critical databases and managed instances is deployed across three Availability Zones within a region. An Availability Zone is basically a separate datacenter within a given region. There's always a physical separation between Availability Zones. This capability protects against catastrophic failures that might occur to a datacenter in a region.


:::image type="content" source="../media/7-availability-zones.png" alt-text="Diagram that shows the Availability Zone architecture." border="false":::

From performance standpoint, there might be a small increase in network latency because your AG is now spread across datacenters that have some distance between them. For this reason, Availability Zones isn't turned on by default. You can choose to use what's commonly called a "Multi-Az" or a "Single-Az" deployment. Configuring this option is as simple as adding a parameter to a PowerShell/Azure CLI command or selecting a check box in the portal.  

Availability Zones are relatively new to Azure SQL, so they're currently  available only in certain regions and service tiers. Over time, this capability is likely to be supported in more regions and potentially more service tiers.

## Azure SQL SLA

Azure SQL maintains a service-level agreement (SLA) that provides financial backing to the commitment to achieve and maintain service levels. If your service level isn't achieved and maintained as described in the SLA, you might be eligible for a credit towards a portion of your monthly service fees.

Currently, the highest availability (99.995%) can be achieved from an Azure SQL Database Business critical deployment with Availability Zones configured. Additionally, the Business critical tier is the only option in the industry, which supplies RPO and RTO SLAs of 5 seconds and 30 seconds, respectively. RPO stands for recovery point object, which represents how much data one is potentially prepared and willing to lose in the worst case scenario. RTO stands for recovery time objective, which represents how much time it takes, if or when a disaster occurs, to be back up and running again.

For General purpose or single zone Business critical deployments, the SLA is 99.99%.

The Hyperscale tier's SLA depends on the number of replicas. Recall, in Hyperscale you choose how many replicas you have, and if there are zero, when you fail over, it is more similar to that of General purpose. If you have replicas, then a failover is more similar to that of Business critical. The corresponding SLA depending on number of replicas is:  

* 0 replicas: 99.5%
* 1 replica: 99.9%
* 2 or more replicas: 99.99%

## Geo-replication and auto-failover groups

Outside of making a selection of service tier (and availability zones where applicable), there are some other options for getting read scale or the ability to fail over to another region: geo-replication and auto-failover groups. In SQL Server on-premises, configuring either of these options is something that would take much planning, coordination, and time.

The cloud, and Azure SQL specifically, have made this process easier for you. For both geo-replication and auto-failover groups, you can get configured with a few clicks in the Azure portal or a few commands in PowerShell/Azure CLI.

There are some decision points that can help you decide if geo-replication or auto-failover groups are best for your scenario.

|                                              | Geo-replication | Failover groups  |
|:---------------------------------------------| :-------------- | :----------------|
| Automatic failover                           |     No          |      Yes         |
| Fail over multiple databases simultaneously  |     No          |      Yes         |
| User must update connection string after failover      |     Yes         |      No          |
| SQL Managed Instance support                   |     No          |      Yes         |
| Can be in same region as primary             |     Yes         |      No          |
| Multiple replicas                            |     Yes         |      No          |
| Supports read-scale                          |     Yes         |      Yes         |
| &nbsp; | &nbsp; | &nbsp; |
