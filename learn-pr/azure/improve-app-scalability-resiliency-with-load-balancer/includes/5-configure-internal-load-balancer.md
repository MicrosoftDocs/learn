
## N-tier Architecture

The healthcare portal is split into a 3 tiered architecture.

- Presentation (Client) Tier
- Application (Business) Tier
- Data Tier

<-- An image similar to this, taken from: http://spmarchitecture.com/wp-content/uploads/2016/01/fig-multi-tier-web-application-server-architecture-5599.jpg - The backend tier, simply needs one block reflecting a database -->

![Diagram of 3 tier architecture](../media/5-three-tier-architecture.jpg)

This is a common architecture that allows scaling up and scaling out. The presentation layer is public facing, the other tiers are only accessible within the local azure virtual network. The previous exercise created an external load balancer to balance the virtual machines in the presentation layer

## Configure Internal Load Balancer

In the current healthcare portal scenario, there is an application (business) tier which is used by the presentation tier. The application tier is also deployed on two virtual machines and is a web application hosting web services. To allow the front-end web portal to survive losing a connection to an entire data center you will setup an internal load balancer using availability zones.
The internal load balancer should only be visible to the front end presentation tier. All the virtual machines hosting the business tier are in one virtual network so an internal load balancer can be used to distribute traffic to those virtual machines.

<-- Source URL: https://docs.microsoft.com/en-us/azure/load-balancer/media/load-balancer-overview/load-balancer-distribution.png - Can we change this diagram to have the internal balancer using an API layer over port 80 rather than SQL using 1433 -->

![Diagram of Internal Load Balancer](../media/5-internal-load-balancer.png)

## Choose Distribution Mode

Using the healthcare portal example. The application tier is completely stateless, so we don't need to use sticky sessions. Therefore, the default distribution mode of a 5-tuple hash can be used. This offers the greatest scalability and resilience as the virtual machine that will handle the request is decided by the load balancer, purely on the basis of the healthiest and least worked virtual machine in the set.
