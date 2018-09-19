You now have your site up and running on Azure. But how can you help ensure your site is running 24/7?

For instance, what happens when you need to do weekly maintenance? Your service will still be unavailable during your maintenance window. And because your site reaches users all over the world, there's no good time to take down your systems for maintenance. You may also run into performance issues if too many users connect at the same time.

## What are availability and high availability?

:::row:::
  :::column:::
    ![A speed train representing high availability](../media/3-availability.png)
  :::column-end:::
	:::column span="3":::
_Availability_ refers to how long your service is up and running without interruption. _High availability_, or _highly available_, refers to a service that's up and running for a long period of time.

You know how frustrating it is when you can't access the information you need. Think of a social media or news site that you visit daily. Can you always access the site, or do you often see error messages like "503 Service Unavailable"?
  :::column-end:::
 :::row-end:::

You may have heard terms like "five nines availability." Five nines availability means that the service is guaranteed to be running 99.999 percent of the time. Although it's difficult to achieve 100 percent availability, many teams strive for at least five nines.

## What is resiliency?

:::row:::
  :::column:::
    ![A health chart representing resiliency](../media/3-resiliency.png)
  :::column-end:::
	:::column span="3":::
_Resiliency_ refers to a system's ability to stay operational during abnormal conditions.

These conditions include:

- Natural disasters.
- System maintenance, both planned and unplanned, including software updates and security patches.
- Spikes in traffic to your site.
- Threats made by malicious parties, such as distributed denial of service, or DDoS, attacks.
  :::column-end:::
:::row-end:::

Imagine your marketing team wants to have a flash sale to promote a new line of vitamin supplements. You might expect a huge spike in traffic during this time. This spike could overwhelm your processing system, causing it to slow down or halt, disappointing your users. You may have experienced this disappointment for yourself. Have you ever tried to access an online sale only to find the website wasn't responding?

## What is a load balancer?

:::row:::
  :::column:::
    ![A scale representing load balancing](../media/3-lb.png)
  :::column-end:::
	:::column span="3":::
A _load balancer_ distributes traffic evenly among each system in a pool. A load balancer can help you achieve both high availability and resiliency.

Say you start by adding additional VMs, each configured identically, to each tier. The idea is to have additional systems ready, in case one goes down or is serving too many users at the same time.
  :::column-end:::
:::row-end:::

The problem here is that each VM would have its own IP address. Plus, you don't have a way to distribute traffic in case one system goes down or is busy. How do you connect your VMs so that they appear to the user as one system?

The answer is to use a load balancer to distribute traffic. The load balancer becomes the entry point to the user. The user doesn't know (or need to know) which system the load balancer chooses to receive the request.

The following illustration shows the role of a load balancer.

![An illustration showing the web tier of a three-tier architecture. The web tier has multiple virtual machines to service user requests. There is a load balancer that distributes user requests among the virtual machines.](../media/3-load-balancer.png)

You see that the load balancer receives the user's request. The load balancer directs the request to one of the VMs in the web tier. If a VM is unavailable or stops responding, the load balancer stops sending traffic to it. The load balancer then directs traffic to one of the responsive servers.

Load balancing enables you to run maintenance tasks without interrupting service. For example, you can stagger the maintenance window for each VM. During the maintenance window, the load balancer detects that the VM is unresponsive, and directs traffic to other VMs in the pool.

For your e-commerce site, the app and data tiers can also have a load balancer. It all depends on what your service requires.

## What is Azure Load Balancer?

Azure Load Balancer is a load balancer service that Microsoft provides that helps take care of the maintenance for you.

When you manually configure typical load balancer software on a virtual machine, there's a downside: you now have an additional system that you need to maintain. If your load balancer goes down or needs routine maintenance, you're back to your original problem.

If instead, however, you use Azure Load Balancer, there's no infrastructure or software for you to maintain.

The following illustration shows  the role of Azure load balancers in a multi-tier architecture.

![An illustration showing the web tier of a three-tier architecture. The web tier has multiple virtual machines to service user requests. There is a load balancer that distributes user requests among the virtual machines.](../media/3-azure-load-balancer.png)

## What about DNS?

:::row:::
  :::column:::
    ![A pin on a map representing DNS](../media/3-map-pin.png)
  :::column-end:::
	:::column span="3":::
DNS, or Domain Name System, is a way to map user-friendly names to their IP addresses. You can think of DNS as the phonebook of the internet.

For example, your domain name, contoso.com, might map to the IP address of the load balancer at the web tier, 40.65.106.192.

You can bring your own DNS server or use Azure DNS, a hosting service for DNS domains that runs on Azure infrastructure.
  :::column-end:::
:::row-end:::

The following illustration shows Azure DNS. When the user navigates to contoso.com, Azure DNS routes traffic to the load balancer.

![An illustration showing the Azure domain name system positioned in front of the load balancer.](../media/3-dns.png)

## Summary

With load balancing in place, your e-commerce site is now more highly available and resilient. When you perform maintenance or receive an uptick in traffic, your load balancer can distribute traffic to another available system.

Although you can configure your own load balancer on a VM, Azure Load Balancer reduces upkeep because there's no infrastructure or software to maintain.

DNS maps user-friendly names to their IP addresses, much like how a phonebook maps names of people or businesses to phone numbers. You can bring your own DNS server, or use Azure DNS.
