Azure Virtual Machine Availability Sets implements two node concepts to help Azure maintain high availability and fault tolerance when deploying and upgrading applications: _update domains_ and _fault domains_. Each virtual machine in an availability set is placed in one update domain and one fault domain.

### Things to know about update domains

An update domain is a group of nodes that are upgraded together during the process of a service upgrade (or _rollout_). An update domain allows Azure to perform incremental or rolling upgrades across a deployment. Here are some other characteristics of update domains.

- Each update domain contains a set of virtual machines and associated physical hardware that can be updated and rebooted at the same time.

- During planned maintenance, only one update domain is rebooted at a time.

- By default, there are five (non-user-configurable) update domains.

- You can configure up to 20 update domains.

### Things to know about fault domains

A fault domain is a group of nodes that represent a physical unit of failure. Think of a fault domain as nodes that belong to the same physical rack.

- A fault domain defines a group of virtual machines that share a common set of hardware (or _switches_) that share a single point of failure. An example is a server rack serviced by a set of power or networking switches.

- Two fault domains work together to mitigate against hardware failures, network outages, power interruptions, or software updates. 

Let's look at a scenario with two fault domains that have two virtual machines each. The virtual machines in each fault domain are contained in different availability sets. The web availability set contains two virtual machines with one machine from each fault domain. The SQL availability set contains two different virtual machines with one from each fault domain.

:::image type="content" source="../media/update-fault-domains-c1ceee00.png" alt-text="Illustration that shows two fault domains with two virtual machines each. The virtual machines in each fault domain are contained in different availability sets." border="false":::