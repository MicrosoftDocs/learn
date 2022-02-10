Update Domains and Fault Domains helps Azure maintain high availability and fault tolerance when deploying and upgrading applications. Each virtual machine in an availability set is placed in one update domain and one fault domain.

:::image type="content" source="../media/update-fault-domains-c1ceee00.png" alt-text="An illustration showing two fault domains with two virtual machines each. The two top virtual machines from each fault domain host Internet information service and are part of a common availability set. The next two virtual machines in each domain host SQL database and are part of another availability set.":::


## Update domains

An **update domain (UD)** is a group of nodes that are upgraded together during the process of a service upgrade (rollout). An update domain allows Azure to perform incremental or rolling upgrades across a deployment. Each update domain contains a set of virtual machines and associated physical hardware that can be updated and rebooted at the same time. During planned maintenance, only one update domain is rebooted at a time. By default, there are five (non-user-configurable) update domains, but you configure up to 20 update domains.

## Fault domains

A **fault domain (FD)** is a group of nodes that represent a physical unit of failure. A fault domain defines a group of virtual machines that share a common set of hardware, switches, that share a single point of failure. For example, a server rack serviced by a set of power or networking switches. Two fault domains mitigate against hardware failures, network outages, power interruptions, or software updates. Think of a fault domain as nodes belonging to the same physical rack.

> [!NOTE]
> Placing your virtual machines into an availability set does not protect your application from operating system or application-specific failures. For that, you need to review other disaster recovery and backup techniques.
