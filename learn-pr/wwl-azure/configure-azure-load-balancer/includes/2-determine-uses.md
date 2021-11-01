The Azure Load Balancer delivers high availability and network performance to your applications. The load balancer distributes inbound traffic to backend resources using load-balancing rules and health probes.

 -  Load-balancing rules determine how traffic is distributed to the backend.
 -  Health probes ensure the resources in the backend are healthy.

:::image type="content" source="../media/load-balancer-4caf947b.png" alt-text="Diagram showing how load balancer works. Left to right. The frontend is exchanging information with the Load Balancer. The Load Balancer is using rules and probes to communicate with the backend.":::


The Load Balancer can be used for inbound and outbound scenarios and scales up to millions of TCP and UDP application flows.

> [!NOTE]
> Keep this diagram in mind since it covers the four components that must be configured for your load balancer: **Frontend IP configuration**, **Backend pools**, **Health probes**, and **Load-balancing rules**.
