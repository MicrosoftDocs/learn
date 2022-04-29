[Azure Traffic Manager](/azure/traffic-manager/traffic-manager-overview) a DNS-based traffic load balancer. This service allows you to distribute traffic to your public facing applications across the global Azure regions. Traffic Manager also provides your public endpoints with high availability and quick responsiveness. It is a DNS-based traffic load balancer that enables you to distribute traffic optimally to services across global Azure regions, while providing high availability and responsiveness. Because Traffic Manager is a DNS-based load-balancing service, it load balances only at the domain level. For that reason, it can't fail over as quickly as Front Door, because of common challenges around DNS caching and systems not honoring DNS TTLs.

## How Azure Traffic Manager works in reliability scenarios

 

Traffic Manager uses DNS to direct the client requests to the appropriate service endpoint based on a traffic-routing method. You define these services by using Traffic Manager endpoints. Each endpoint is the service load balancer IP. You can use this configuration to direct network traffic from the Traffic Manager endpoint in one region to the endpoint in a different region. This is often referred to as geographic routing. For example, the following graphic depicts a typical scenario:

1. The user petitions a DNS server.

2. The DNS server queries Traffic Manager for the required record(s).

3. The result is returned from Traffic Manager.

4. The client connects directly to the defined endpoint.

:::image type="content" source="../media/traffic-manager-geographic-routing.png" alt-text="Traffic Manager routes based on assigned geography.":::



**High availability scenarios**

Traffic Manager provides for high availability for your critical apps. It does so by monitoring your endpoints and providing automatic failover when an endpoint goes down. Traffic Manager, working with Azure DNS, enables a few failover approaches, described in the following table.

| **Approach**| **Description** |
| - | - |
| Active/Passive with cold standby| Your VMs (and other appliances) that are running in the standby region aren't active until needed. However, your production environment is replicated to a different region. This approach is cost-effective but takes longer to undertake a complete failover. |
| Active/Passive with pilot light| You establish the standby environment with a minimal configuration; it has only the necessary services running to support a minimal and critical set of apps. In its default form, this approach can only execute minimal functionality. However, it can scale up and spawn more services, as needed, to take more of the production load during a failover. |
| Active/Passive with warm standby| Your standby region is pre-warmed and is ready to take the base load. Auto scaling is on, and all the instances are up and running. This approach isn't scaled to take the full production load but is functional, and all services are up and running. |


Depending on what you want to achieve, and which approach suits your needs, you can implement failover:

- Manually, by using Azure DNS, this failover solution uses the standard DNS mechanism to fail over to your backup site. This option works best when used in conjunction with the cold standby or the pilot light approaches.

- Automatically, by using Traffic Manager, with more complex architectures and multiple sets of resources capable of performing the same function, you can configure Azure Traffic Manager (based on DNS). Traffic Manager checks the health of your resources and routes the traffic from the non-healthy resource to the healthy resource automatically.

In the following graphic, both the primary region (active) and the secondary region (passive) have a full deployment. This includes the cloud services and a synchronized database. Only the primary region is actively handling network requests from the users. The secondary region becomes active only when the primary region experiences a service disruption. In that case, all new network requests are routed by Traffic Manager to the secondary region.

 

:::image type="content" source="../media/automatic-fail-over-using-traffic-manager.png" alt-text="Traffic Manager has active and passive replication sites.":::