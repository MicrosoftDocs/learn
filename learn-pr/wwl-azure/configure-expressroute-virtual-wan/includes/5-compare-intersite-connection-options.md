---
uid: learn.wwl.configure-expressroute-virtual-wan.compare-intersite-connection-options
title: Compare intersite connection options
description: Compare intersite connection options
durationInMinutes: 3
---
Microsoft network operates the primary and secondary connections of Azure ExpressRoute circuits in active-active mode. Administrators can force their redundant connections of an ExpressRoute circuit to operate in active-passive mode. To improve high availability, we recommend that you operate both connections of an ExpressRoute circuit in active-active mode. When you allow the connections to operate in active-active mode, Microsoft network load balances the traffic across the connections on a per-flow basis.

### Things to know about intersite connections

There are multiple Azure services that can support various intersite connection configurations. The following table highlights some common scenarios. As you review these details, think about what solution can fulfill your business requirements.

| Connection | Azure services | Bandwidth | Protocols | Scenarios |
| --- | --- | --- | --- | --- |
| **Virtual network and Point-to-site (User VPN)** | Azure IaaS services, <br> Azure Virtual Machines | Based on the gateway SKU | active-passive | _Development, test, and lab environments for cloud services_ <br><br> _Development, test, and lab environments for virtual machines_ |
| **Virtual network and Site-to-site** | Azure IaaS services, <br> Azure Virtual Machines | Typically < 1 Gbps aggregate | active-passive <br> active-active | _Development, test, and lab environments_ <br><br> _Small-scale production workloads and virtual machines_ |
| **ExpressRoute circuit** | Azure IaaS and PaaS services, <br> Microsoft 365 services | 50 Mbps up to 100 Gbps | active-active (recommended) <br> active-passive (manually forced) | _Enterprise-class and mission-critical workloads_ <br><br> _Big data solutions_ |