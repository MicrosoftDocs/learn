Azure Load Balancer delivers high availability and network performance to your applications. Administrators use load balancing to efficiently distribute incoming network traffic across back-end servers and resources. A load balancer is implemented by using load-balancing rules and health probes.

The following diagram shows how Azure Load Balancer works. The frontend exchanges information with a load balancer. The load balancer uses rules and health probes to communicate with the backend.

:::image type="content" source="../media/load-balancer-4caf947b.png" alt-text="Diagram that shows how a load balancer works as described in the text." border="false":::

### Things to know about Azure Load Balancer 

Let's take a closer look at how Azure Load Balancer operates.

- Azure Load Balancer can be used for inbound and outbound scenarios.

- You can implement a **public** or **internal** load balancer, or use both types in a combination configuration.

- To implement a load balancer, you configure four components:
   - Front-end IP configuration
   - Back-end pools
   - Health probes
   - Load-balancing rules

- The front-end configuration specifies the public IP or internal IP that your load balancer responds to.

- The back-end pools are your services and resources, including Azure Virtual Machines or instances in Azure Virtual Machine Scale Sets.

- Load-balancing rules determine how traffic is distributed to back-end resources.

- Health probes ensure the resources in the backend are healthy.

- Load Balancer scales up to millions of TCP and UDP application flows.