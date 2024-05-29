In this module, you learned how routing preference in Azure can help you determine how traffic is routed to applications in your Azure subscription. Our goal was to help you evaluate whether routing preference could help fulfill the goal of the network traffic cost savings project. We developed some criteria you can use to guide your decision:

* Cost
* Performance

You applied these criteria to your fictional car company. The analysis helped you see how routing preference options affect network performance and cost. After determining the network performance requirements of the factory application, you determined that changing the routing preference of the application to *Internet* from *Microsoft network* fulfills the goal of the network cost-savings project.

The criteria helped you evaluate whether changing the routing preference of the application would result in network cost savings for the car factory application. You learned how routing preference worked by changing how traffic for applications hosted in Azure routes, either by the public internet (hot potato routing) or across the Microsoft network (cold potato routing).

You learned about routing preference unmetered and how it's only for use with CDN providers that are part of the routing preference unmetered program.

You should now have the information you need to determine the right routing preference for your organization in Azure.

## Related content

* [What is routing preference?](/azure/virtual-network/ip-services/routing-preference-overview)
* [What is routing preference unmetered?](/azure/virtual-network/ip-services/routing-preference-unmetered)
* [Configure routing preference for a public IP address using the Azure portal](/azure/virtual-network/ip-services/routing-preference-portal)
* [Network routing preference for Azure Storage](/azure/storage/common/network-routing-preference)
