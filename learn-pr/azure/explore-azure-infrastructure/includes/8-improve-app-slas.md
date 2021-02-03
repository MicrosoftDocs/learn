You can use SLAs to evaluate how your Azure solutions meet business requirements and the needs of your clients and users. By creating your own SLAs, you can set performance targets to suit your specific Azure application.  This approach is known as an *Application SLA*.

## Understand your app requirements
Building an efficient and reliable Azure solution requires knowing your workload requirements.  You can then select Azure products and services, and provision resources according to those requirements. It's important to understand the Azure SLAs that define performance targets for the Azure products and services within your solution.  This understanding will help you create achievable Application SLAs.

In a distributed system, failures will happen. Hardware can fail. The network can have transient failures. It's rare for an entire service or region to experience a disruption, but even this must be planned for.

## Resiliency

*Resiliency* is the ability of a system to recover from failures and continue to function. It's not about avoiding failures, but responding to failures in a way that avoids downtime or data loss. The goal of resiliency is to return the application to a fully functioning state following a failure. High availability and disaster recovery are two crucial components of resiliency.

When designing your architecture you need to design for resiliency, and you should perform a *Failure Mode Analysis* (FMA). The goal of an FMA is to identify possible points of failure and to define how the application will respond to those failures.

## Cost and complexity vs. high availability

*Availability* refers to the time that a system is functional and working. Maximizing availability requires implementing measures to prevent possible service failures.  However, devising preventative measures can be difficult and expensive, and often results in complex solutions.

As your solution grows in complexity, you will have more services depending on each other.  Therefore, you might overlook possible failure points in your solution if you have several interdependent services.

> [!TIP]
> For example: A workload that requires 99.99 percent uptime shouldn't depend upon a service with a 99.9 percent SLA.

Most providers prefer to maximize the availability of their Azure solutions by minimizing downtime.  However, as you increase availability, you also increase the cost and complexity of your solution.

> [!TIP]
> For example: An SLA that defines an *uptime of 99.999% only allows for about 5 minutes of total downtime per year.*

The risk of potential downtime is cumulative across various SLA levels, which means that complex solutions can face greater availability challenges.  Therefore, how critical high-availability is to your requirements will determine how you handle the addition of complexity and cost to your application SLAs.

## Considerations for defining application SLAs

- If your application SLA defines four 9's (99.99%) performance targets, recovering from failures by manual intervention may not be enough to fulfill your SLA.  Your Azure solution must be self-diagnosing and self-healing instead.
- It is difficult to respond to failures quickly enough to meet SLA performance targets above four 9's.
- Carefully consider the time window against which your application SLA performance targets are measured.  The smaller the time window, the tighter the tolerances.  If you define your application SLA as hourly or daily uptime, you need to understand these tighter tolerances might not allow for achievable performance targets.
