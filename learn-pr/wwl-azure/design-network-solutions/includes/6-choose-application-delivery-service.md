Azure offers several load-balancing services for distributing your workloads across multiple computing resources. As you review the options, there are several factors to consider in your planning.

### Things to know about load balancing

Azure load-balancing services can be categorized along two dimensions:
- Global or Regional
- HTTP(S) or non-HTTP(S)

In the Azure portal, the **Help me choose** default tab highlights other configuration characteristics:

- **Traffic type**: Are you designing a web (HTTP/HTTPS) application? Is the app public facing or is it private?

- **Global versus regional**: Do you need to load balance virtual machines or containers within a virtual network, or load balance scale unit/deployments across regions, or both?

- **Availability**: Does the service [SLA](https://azure.microsoft.com/support/legal/sla/) meet your requirements?

- **Cost**: Have you outlined your cost expectations? You can review the [Azure pricing](https://azure.microsoft.com/pricing/) options. In addition to the cost of the service itself, consider the operations cost for managing a solution built on that service.

- **Features and limits**: What are the overall limitations of each service? You can review the [service limits](/azure/azure-subscription-service-limits).

In the next unit, we examine features of several load-balancing services, including Azure Front Door, Traffic Manager, Load Balancer, and Application Gateway. 

### Things to consider when choosing load balancing

As you review the descriptions of the Azure load-balancing services in the next unit, you can use the following flowchart to help you to find the ideal solution for your application. The flowchart guides you through a set of key decision criteria to reach a recommendation.

> [!Tip]
> **Treat this flowchart as a starting point.**
> Every application has unique requirements, so use these recommendations as a starting point in your planning.

After you identify possible solutions for your requirements, apply the options to your scenarios and do a detailed evaluation. If your application consists of multiple workloads, evaluate each workload separately. A complete solution might incorporate two or more load-balancing solutions.

:::image type="content" source="../media/load-balancer-decision-tree-thumb.png" alt-text="Flowchart for choosing an Azure Load Balancer network solution." lightbox="../media/load-balancer-decision-tree.png" border="false":::