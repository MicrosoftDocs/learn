You've learned how routing preference in Azure can help you determine how traffic is routed to applications in your Azure subscription. Our goal was to help you evaluate whether routing preference could help fulfill the goal of the network traffic cost savings project. We developed some criteria you can use to guide your decision:

    * Cost

    * Performance

We applied these criteria to our fictional car company. The analysis helped us see how routing preference options affect network performance and cost. After determining the network performance requirements of the factory application, you determined that changing the routing preference of the application to "Internet" from "Microsoft network" fulfils the goal of the network cost savings project.

The criteria helped you evaluate whether changing the routing preference of the application would result in network cost savings for the car factory application. You learned how routing preference worked by changing how traffic for applications hosted in Azure routes, either by the public Internet (hot potato routing) or across the Microsoft network (cold potato routing).

You learned about Routing Preference unmetered and how it is only for use with CDN providers that are part of the routing preference unmetered program.

You should now have the information you need to determine if routing preference in Azure is right for your organization.

## References

* [What is routing preference?](https://learn.microsoft.com/azure/virtual-network/ip-services/routing-preference-overview)

* [What is Routing Preference Unmetered?](https://learn.microsoft.com/azure/virtual-network/ip-services/routing-preference-unmetered)

* [Configure routing preference for a public IP address using the Azure portal](https://learn.microsoft.com/azure/virtual-network/ip-services/routing-preference-portal)

* [Network routing preference for Azure Storage](https://learn.microsoft.com/en-us/azure/storage/common/network-routing-preference)
