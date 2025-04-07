
**Azure Load Balancer** operates at layer 4 of the Open Systems Interconnection (OSI) model. It's the single point of contact for clients. Azure Load Balancer distributes inbound flows that arrive at the load balancer's front end to backend pool instances. These flows are according to configured load-balancing rules and health probes. The backend pool instances can be Azure Virtual Machines or instances in a virtual machine scale set.

## Choosing a load balancer type

Load balancers can be public (external) or internal (private).

A [**public load balancer**](/azure/load-balancer/components) can provide outbound connections for virtual machines (VMs) inside your virtual network. These connections are accomplished by translating their private IP addresses to public IP addresses. External load balancers are used to distribute client traffic from the internet across your VMs. That internet traffic might come from web browsers, module apps, or other sources.

An [**internal load balancer**](/azure/load-balancer/components) is used where private IPs are needed at the frontend only. Internal load balancers are used to load balance traffic from internal Azure resources to other Azure resources inside a virtual network. A load balancer frontend can also be accessed from an on-premises network in a hybrid scenario.

This diagram shows how public and internal load balance can work together.

:::image type="content" source="../media/load-balancer-3cfca04c.png" alt-text="Diagram that shows a public and internal load balancer.":::

## How to select a load balancer type (video)

This video reviews how to select a load balancer type.  

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=096fa8d5-dde4-41b4-b025-99a1ced3f98f]


## Azure load balancer and availability zones

Azure Load Balancer supports [availability zones scenarios](/azure/reliability/reliability-load-balancer#availability-zone-support). A Load Balancer can either be zone redundant, zonal, or nonzonal. 

### Zone redundant

:::image type="content" source="../media/zone-redundant-019f3528.png" alt-text="Diagram that shows Zone redundant load balancers in Azure.":::


In a region with Availability Zones, a Standard Load Balancer can be zone-redundant. A single frontend IP address survives zone failure. The frontend IP can be used to reach all (nonimpacted) backend pool members no matter the zone. One or more availability zones can fail and the data path survives as long as one zone in the region remains healthy.

### Zonal

:::image type="content" source="../media/zonal-load-balancer-3933c0be.png" alt-text="Diagram that shows Zonal load balancers in Azure.":::

You can choose to have a frontend guaranteed to a single zone, which is known as a *zonal*. With this scenario, a single zone in a region serves all inbound or outbound flow. Your frontend shares fate with the health of the zone. The data path is unaffected by failures in zones other than where it was guaranteed. 

### Nonzonal

Load Balancers can also use a "no-zone" frontend. In these scenarios, a public load balancer would use a public IP or public IP prefix, an internal load balancer would use a private IP. This option doesn't give a guarantee of redundancy.

## Selecting an Azure load balancer SKU

There are several [load balancer SKUs](/azure/load-balancer/skus): Basic, Standard, and Gateway. These SKUs differ in terms of their scenario scope and scale, features, and cost. The [Gateway Load Balancer SKU](/azure/load-balancer/gateway-overview) is for high performance and high availability scenarios with Network Virtual Appliances (NVAs). This table compares the Standard and Basic Load Balancer.

> [!IMPORTANT]
> On September 30, 2025, Basic Load Balancer will be retired. 

| **Features** | **Standard Load Balancer** | **Basic Load Balancer** |
| --- | ---  | ---|
| Backend pool size | Supports up to 1,000 instances. | Supports up to 300 instances. |
|  Backend pool endpoints |Any virtual machines or virtual machine scale sets in a single virtual network. | Virtual machines in a single availability set or virtual machine scale set. |
| Health probes | TCP, HTTP, HTTPS | TCP, HTTP |
| Health probe down behavior | TCP connections stay alive on an instance probe down and on all probes down. | TCP connections stay alive on an instance probe down. All TCP connections end when all probes are down. |
| Availability Zones | Zone-redundant and zonal frontends for inbound and outbound traffic. | Not available. |
| Diagnostics | Azure Monitor multi-dimensional metrics. | [Azure Monitor logs](/azure/load-balancer/load-balancer-monitor-log) |
| Secure by default | Closed to inbound flows unless allowed by a network security group. Internal traffic from the virtual network to the internal load balancer is allowed.  | Open by default. Network security group optional. |
| Multiple front ends | Inbound and outbound | Inbound only |
| SLA | 99.99% | Not available |

> [!TIP]
> Learn more about the Load Balancer check out the [Introduction to Azure Load Balancer](/training/modules/intro-to-azure-load-balancer/) module.