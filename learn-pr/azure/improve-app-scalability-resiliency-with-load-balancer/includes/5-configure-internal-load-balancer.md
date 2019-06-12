## Configure Internal Load Balancer

In the current healthcare portal scenario, there is a business tier which is used by the web frontend. The business tier is also deployed on two virtual machines and is a web application hosting web services or web APIs, or WCF services etc. The type of application does not matter here. The web servers hosting the patient's portal is connecting to the business tier servers. To allow the front-end web portal to survive losing a connection to an entire data center you will setup availability zones.

You want the business tier servers behind a load balancer but that load balancer should not be exposed as a public load balancer and the VMs in the pool of that load balancer will also not be public. If all the VMs hosting the business tier are in one vnet then internal load balancer can be used to distribute traffic to those VMs.

Not only can the load balancer manage public traffic, it can also be used to manage the internal load balancing of calls to buisness layers. In our healthcare portal example. The portal is made up of a standard 3 tiered architecture

- Presentation (Client) Tier
- Application Tier
- Data Tier

![Diagram of 3 tier architecture](../media/5-three-tier.gif)

As the architect you will need to also distribute the load across the internal application tier (business layer).

![Diagram of Internal Load Balancer](../media/5-internal-load-balancer.png)


