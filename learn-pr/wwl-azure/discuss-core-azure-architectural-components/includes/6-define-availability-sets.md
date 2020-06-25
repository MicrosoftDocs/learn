## Availability sets

**Availability sets** are a way for you to ensure your application remains online if a high-impact maintenance event is required, or if a hardware failure occurs. 

Availability sets are made up of **Update domains (UD)** and **Fault domains (FD)**.

![An illustration shows three availability sets. The first set has one update domain, the second has two update domains, and the third is without any update domain.](../media/azure-availability-sets.png)

+ **Update domains**. When a maintenance event occurs (such as a performance update or critical security patch applied to the host), the update is sequenced through update domains. Sequencing updates using update domains ensures that the entire datacenter isn't unavailable during platform updates and patching. Update domains are a logical section of the datacenter, and they are implemented with software and logic.

+ **Fault domains**. Fault domains provide for the physical separation of your workload across different hardware in the datacenter. This includes power, cooling, and network hardware that supports the physical servers located in server racks. In the event the hardware that supports a server rack becomes unavailable, only that rack of servers would be affected by the outage.

