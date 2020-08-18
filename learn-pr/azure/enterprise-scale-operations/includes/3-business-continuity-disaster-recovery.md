Business continuity and disaster recovery requirements at the application layer will drive platform-level capabilities. These capabilities must be available for consumption by application teams to meet their availability targets and recovery targets. Availability targets are typically measured by Service Level Objectives (SLO) and Service Level Agreements (SLA). Recovery targets are typically measured with Recovery Point Objectives (RPO) and Recovery Time Objectives (RTO). These targets should be well understood by Central IT and must inform many of the platform-level architectural decisions. A platform that cannot meet application availability targets and recovery targets puts the business at risk.

## High availability

High availability (HA) is the ability to handle the loss or severe degradation of a component of a system. From the platform perspective, ensuring an application team can meet their availability targets means understanding the application's HA patterns and the infrastructure required to implement the patterns. These patterns often will include multi-region deployments, Availability Zones, load balancing, distributed consensus, and geo-replication. Key components in the platform design for HA include a network architecture that supports the organization's HA patterns, HA shared services, and region selection.

## Disaster recovery

Disaster Recovery (DR) is the ability to recover from high-impact events that result in downtime and data loss. A disaster is a major event with an impact much larger and long-lasting than the application can mitigate through the HA portion of its design. From the platform perspective, ensuring an application team can meet their recovery targets means understanding their organization's application DR strategies and the infrastructure required to implement them. Typical DR strategies will require multi-region network redundancy, geo-replication, and recovery automation. As with HA, network architecture and region selection are critical. The network design must provide both the redundancy and throughput necessary to support replication requirements and survive disaster scenarios. Region selection must include planning for service availability, data replication, and capacity.

## Design Recommendations

- Use multiple regions and peering locations for ExpressRoute connectivity.
- Avoid single points of failure (SPOF) in platform services.
- Use Azure Availability Zones when possible.
- Use Azure paired regions when planning for business continuity and DR.
- Avoid using overlapping IP address ranges for production and DR sites.

## Knowledge Check

An application with low latency network requirements between the service tiers must withstand an Azure data center outage. Which feature should be included in the architecture?

    A. Azure Front Door
    B. Availability Zones
    C. Availability Sets
    D. Read Access Geo-Redundant Storage
