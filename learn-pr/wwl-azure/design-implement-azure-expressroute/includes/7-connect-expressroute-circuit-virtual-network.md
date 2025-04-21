

Reliability consists of two principles: resiliency and availability. The goal of resiliency is to prevent failures and, in the event they do occur, to restore your applications to a fully operational state. The objective of availability is to provide consistent access to your application or workloads. It's important to proactively plan for reliability based on your business needs and application requirements.

An ExpressRoute circuit in three different [resiliency](/azure/expressroute/design-architecture-for-resiliency#standard-resiliency) types: **Standard** Resiliency, **High** Resiliency, and **Maximum** Resiliency. 

This video reviews ExpressRoute resiliency examples.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=de4ed81c-1748-47f6-b5b1-ad1636848b6a]

### Standard resiliency

Standard resiliency in ExpressRoute is a single circuit with two connections configured at a single site. Built-in redundancy (Active-Active) is configured to facilitate failover across the two connections of the circuit.

The subsequent diagram illustrates the logical architecture of an ExpressRoute circuit designed for standard resiliency.

:::image type="content" source="../media/standard-resiliency.png" alt-text="Diagram of ExpressRoute standard resiliency architecture":::

### High resiliency

High resiliency, also referred to as ExpressRoute Metro, enables the use of multiple sites within the same metropolitan (Metro) area to connect your on-premises network through ExpressRoute to Azure. High resiliency offers site diversity by splitting a single circuit across two sites. The first connection is established at one site and the second connection at a different site. 

The subsequent diagram illustrates the logical architecture of an ExpressRoute circuit designed for high resiliency.

:::image type="content" source="../media/high-resiliency.png" alt-text="Diagram of ExpressRoute high resiliency architecture.":::
image high-resiliency


### Maximum resiliency

The Maximum resiliency architecture in ExpressRoute is structured to eliminate any single point of failure within the Microsoft network path. This set up is achieved by configuring a pair of circuits across two distinct locations for site diversity with ExpressRoute. The objective of Maximum resiliency is to enhance reliability, resiliency, and availability, as a result ensuring the highest level of resilience for business and/or mission-critical workloads. For such operations, we recommend that you configure maximum resiliency

The subsequent diagram illustrates the logical architecture of an ExpressRoute circuit designed for maximum resiliency.

:::image type="content" source="../media/maximum-resiliency.png" alt-text="Diagram of ExpressRoute maximum resiliency architecture.":::