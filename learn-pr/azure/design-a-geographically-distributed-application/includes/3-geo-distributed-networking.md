In a distributed app, it's important to ensure that components can communicate reliably and, when there's a failure, requests can always be routed to a different component or region.

The shipping company architecture you looked at in the previous unit is primarily Platform-as-a-Service (PaaS). The services involved (like App Service) are internet-facing. Most of the networking is intrinsically provided by Azure, and doesn't require explicit design, routing, and securing via Network Security Groups (NSG) and similar mechanisms. However, a robust DNS service is required and, when failures occur, you want to make sure that traffic is rerouted and users continue to get a good service.

Here, you'll learn how Azure DNS and Azure Traffic Manager can support the shipping company's app architecture.

## Azure DNS

You'll host any domains needed by our app using Azure DNS, a first-party Azure service that hosts domains and provides name resolution entirely via Azure infrastructure. One advantage of Azure providing the DNS for our app is that we'll manage and program against it using all the standard Azure tools – the portal, PowerShell, and the CLI – without needing to deal with some external site or third-party tools. Because it's inherently multi-regional, the SLA for the service guarantees that valid DNS requests receive a response from at least one Azure DNS name server all the time.

## Azure Traffic Manager

Azure Traffic Manager provides the core component and 'brain' of the networking architecture for the app. Azure Traffic Manager is a DNS-layer service that routes traffic according to policies you define. Describing all the policies that Traffic Manager supports could occupy an entire module. You can distribute traffic between endpoints in Azure and on-premises, and even nest routing policies within one another for more granular control. But the **priority** routing mode is most appropriate for our scenario. This mode consists of a primary service endpoint for all traffic, and a backup endpoint in another region in case the primary becomes unavailable. You'll host the primary endpoint in West Europe, and the secondary endpoint in its paired region of North Europe.

### Endpoint monitoring

Traffic Manager uses highly configurable endpoint monitoring. You define the protocol, port, path, custom header settings, expected status code ranges, tolerated number of failures, and so on. You'll get a continuous idea of the overall health of all parts of your application. 

<!--todo: Illustrate this priority routing mode with a simplified diagram based on https://docs.microsoft.com/azure/traffic-manager/traffic-manager-routing-methods#priority-traffic-routing-method with just a single failover but clearly shown in a separate region -->

In the first unit, you saw that transitory failures affect infrastructure in the cloud. Your endpoint monitoring should differentiate between a momentary failure of some Azure service (best dealt with by robustly coding the app to retry intelligently the same request a moment later), and the primary endpoint actually becoming unreachable because of a serious problem – either with the application or services in the primary region. 

### Traffic Manager policies

You can set policies about what should happen with different kinds of problems or errors. If a failure affects an entire Azure region, you'll want to manually remove the failed region from Traffic Manager's rotation. That's until you've verified that all application subsystems in that region have been restored. Otherwise, a partial recovery of some services in the region could lead to Traffic Manager flip-flopping between the regions.