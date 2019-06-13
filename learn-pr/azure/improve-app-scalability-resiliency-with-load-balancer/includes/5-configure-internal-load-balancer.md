
## N-tier Architecture

The healthcare portal is split into a 3 tiered architecture.

- Presentation (Client) Tier
- Application (Business) Tier
- Data Tier

-----Would like a to find a better image

![Diagram of 3 tier architecture](../media/5-three-tier.gif)

This is a common architecture that allows scaling up and scaling out. The presentation layer is public facing, the other tiers are only accessible within the local azure VNET. The previous exercise created an external load balancer to balance the VMs in the presentation layer

## Configure Internal Load Balancer

In the current healthcare portal scenario, there is a application (business) tier which is used by the presentation tier. The application tier is also deployed on two virtual machines and is a web application hosting web services. To allow the front-end web portal to survive losing a connection to an entire data center you will setup an internal load balancer using availability zones.
The internal load balancer should only be visible to the front end presentation tier. All the VMs hosting the business tier are in one vnet so an internal load balancer can be used to distribute traffic to those VMs.

------Can we change this diagram to have an API layer over port 80 rather than SQL
![Diagram of Internal Load Balancer](../media/5-internal-load-balancer.png)

## Choose Distribution Mode

Using the healthcare portal example. A requirement of the application tier is that it uses in memory sessions, therefore the load balancer must provide source IP affinity to maintain a users session. When we create the load balancer we must specify the distribution mode this can easily be done, like the PowerShell example below.

```Azure CLI
    Set-AzureLoadBalancedEndpoint -ServiceName MyService -LBSetName LBSet1 -Protocol TCP -LocalPort 80 -ProbeProtocolTCP -ProbePort 8080 –LoadBalancerDistribution sourceIP
```