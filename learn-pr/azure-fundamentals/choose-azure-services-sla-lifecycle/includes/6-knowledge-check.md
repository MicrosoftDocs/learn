Consider the following scenario. Then choose the best response for each question that follows, and select **Check your answers**.

Recall that the Tailwind Traders' Special Orders application includes two virtual machines, Azure Load Balancer, and Azure SQL Database:

:::image type="content" source="../media/4-special-orders-architecture.svg" alt-text="A diagram showing two virtual machines connected to Azure Load Balancer and Azure SQL Database." border="false":::

Here's the service-level agreement (SLA) for each service:

| Service | SLA |
| --- | --- |
| Azure Virtual Machines | 99.9 percent |
| Azure SQL Database | 99.99 percent |
| Azure Load Balancer | 99.99 percent |

To compute the composite SLA for a set of services, you multiply the SLA of each individual service. Recall that the existing composite SLA is:

$${99.9\\% \times 99.9\\% \times 99.99\\% \times 99.99\\% = 99.78\\%}$$

The team wants to add a mapping feature so that it can calculate routes between nearby suppliers and each retail store. For that, the team will use Azure Maps.

The team also needs more processing power to keep up with demand. For that, it will add a third virtual machine to the pool.

Here's a diagram that shows their proposed plan:

:::image type="content" source="../media/6-special-orders-architecture-maps.svg" alt-text="A diagram showing three virtual machines connected to Azure Load Balancer, Azure SQL Database, and Azure Maps." border="false":::

Recall that you can access SLAs from [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true).

Tailwind Traders is also considering using an augmented reality service in the Special Orders app to help customers visualize their customizations. This Azure service is currently in the public preview phase.
