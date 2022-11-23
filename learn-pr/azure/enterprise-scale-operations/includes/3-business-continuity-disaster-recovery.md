Business-continuity and disaster-recovery requirements at the application layer drive platform-level capabilities. These capabilities must be available for consumption by application teams to meet their *availability targets* and *recovery targets*:

- *Availability targets* are typically measured by service-level objectives (SLOs) and service-level agreements (SLAs).
- *Recovery targets* are typically measured by recovery-point objectives (RPOs) and recovery-time objectives (RTOs).

These targets should be well understood by central IT and must inform many of the platform-level architectural decisions. A platform that can't meet application-availability targets and recovery targets puts the business at risk.

## High availability

*High availability (HA)* is the ability to handle the loss or severe degradation of a component of a system. From the platform perspective, ensuring that an application team can meet its availability targets requires understanding the application's HA patterns and the infrastructure necessary to implement those patterns.

HA patterns often include:

- Multi-region deployments
- Availability Zones
- Load balancing
- Distributed consensus
- Geo-replication

Key components in the platform design for HA include a network architecture that supports the organization's HA patterns, HA shared services, and region selection.

## Disaster recovery

*Disaster recovery (DR)* is the ability to recover from high-impact events that result in downtime and data loss. A disaster is a major event with an impact much larger and longer lasting than the application can mitigate through the HA portion of its design.

From the platform perspective, ensuring that an application team can meet its recovery targets requires understanding the organization's application DR strategies and their supporting infrastructure. Typical DR strategies require:

- Multi-region network redundancy
- Geo-replication
- Recovery automation

As with HA, network architecture and region selection are critical. The network design must provide both the redundancy and throughput necessary to support replication requirements and survive disaster scenarios. Region selection must include planning for service availability, data replication, and capacity.
