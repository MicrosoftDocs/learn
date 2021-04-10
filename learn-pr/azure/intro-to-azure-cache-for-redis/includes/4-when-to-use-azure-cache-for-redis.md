
In this unit, we'll discuss how to determine if Azure Cache for Redis is a suitable caching solution for your organization. We'll evaluate Azure Cache for Redis against the following criteria: 

- Simplicity
- Reliability
- Scaling

## Decision criteria

To determine whether to use Azure Cache for Redis, use the criteria described in the following table.

| Criteria    | Analysis     |
| ------------------------- | ---------------------------- |
| Simplicity | A managed service offers many benefits, including: provisioning, setup, scaling, updates, and patching. |
| Reliability | It's vital that any caching solution is highly available to ensure that your apps can deliver at peak performance, even when there are component failures. |
| Scaling | It's important that the system is capable of responding to changes in load. Scaling should be automatic, and take place without downtime. |


## Apply the criteria

Review the following questions when considering Azure Cache for Redis as your data integration solution. 

### Do you want a managed service approach?

When you use Azure Cache for Redis, you are implementing a fully managed service. This provides many benefits, including:

- Automatically managed patching, updates, provisioning, configuration, setup, and scaling.
- Implement Azure Monitor to track parameters and metrics within the cache, infrastructure, and network.
- Use any Redis client to connect to the service.

### Is reliability critical?

Azure Cache for Redis provides several reliability and high availability features. These include: OSS Cluster, data persistence, zone redundancy, and geo-replication. 

Specifically, Azure Cache for Redis provides the following high availability capabilities:

- Includes a redundant pair of VMs configured for automatic failover 

   > [!NOTE]
   > Excludes Basic tier.

- Up to 99.999% availability in the Enterprise tiers. 
- Supports a zone-redundant configuration.
- Supports active geo-replication to create global caches with local latency across regions.


### Do you anticipate sudden changes in load?

It's important that the system is capable of responding to changes in load. Sudden changes in demand might occur when you run sales promotions, or at specific times of the year. With Azure Cache for Redis, scaling is automatic, and occurs without downtime. 

## Summary

In summary, consider implementing Azure Cache for Redis when you meet one or more of the following criteria:

- You want to implement a caching solution for your apps that's based on industry standard technologies.
- You don't want to worry about the underlying VMs or infrastructure, and want the simplicity of a fully managed service.
- High availability is critical to your organization's business goals.
- The system you select must be capable of responding automatically to both anticipated and unanticipated changes in demand.
- You need the same performance and scaling benefits throughout the world.

When determining which tier to select, use the following guidance: 

- Choose the Basic or Standard tiers only for non-critical workloads.
- Choose the Premium or Enterprise tiers when you require more performance.
- Choose the Enterprise tiers when you:

   - Need higher availability than is available with the Premium tier.
   - Require RedisBloom, RediSearch, and RedisTimeSeries module integration.

- Choose the Enterprise Flash tier when you want to reduce costs by using non-volatile memory.

