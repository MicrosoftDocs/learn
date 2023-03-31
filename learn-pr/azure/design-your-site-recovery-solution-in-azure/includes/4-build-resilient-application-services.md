There are various measures you need to take to build resilience into your applications.

Your organization needs you to meet recovery requirements, while ensuring costs and complexity are kept down as much as possible.

In this unit, you learn how geo-redundancy and availability clusters can help. You see what's involved in failovers and failbacks for your applications, and you understand why and how you should implement a monitoring and notification strategy.

## Add geo-redundancy for your applications

Your applications run on infrastructure. You need to be able to keep your applications running, regardless of what happens to the infrastructure running your applications. You also want to keep running your applications even if something happens to an entire geographical region where your infrastructure operates. Natural disasters and other issues could cause an entire geographical area to be without power or internet access. To respond to these issues gracefully and keep your applications running, Geo-redundancy should be in place. But, it can be costly if it isn't done right.

You can use Azure to make your on-premises applications geo-redundant. The benefit of running redundant infrastructure for your applications in Azure is that you're not responsible for maintaining and securing a physical location. Also, you don't have to face any traditionally associated costs. In fact, with Azure you can add redundancy to your applications with regions that might be on the other side of the world and there's no maintenance for you to handle. Maintenance is done for you, which means you achieve geo-redundancy easily and cost effectively.

By using a VPN site-to-site connection, you can extend the on-premises network to a virtual network that's running a replica of your infrastructure in a different region inside Azure. Azure Traffic Manager can be used to monitor the health of your on-premises network. If something happens to the on-premises location, you could then use the replica infrastructure in Azure that's located in an entirely different geographical region.

Similarly, you could set up geo-redundancy for your applications running inside Azure. For example, if your applications run on a group of Azure virtual machines in a virtual network, you can replicate the same set-up in another region for geo-redundancy. Through virtual network peering, you connect two separate virtual networks that are treated as one. This process means that traffic for these two networks doesn't go through the public internet or a gateway. Resources can directly connect to other resources as though they were in the same network. In this case, Traffic Manager looks at both regions for you by monitoring the health of each endpoint. If something happens to your primary region, demand is routed to your secondary region.

## Add high availability clusters

High availability clustering helps you ensure your workloads remain available and running with minimal downtime. High availability clustering comes in different forms. You can achieve high availability clustering through active-active architectures, or through active-passive architectures.

An active-active architecture lets you distribute and load balance demand between multiple nodes, such as two identical Azure virtual machines. You can have these Azure virtual machines running together and sharing the demand. You can also distribute demand to these nodes based on different routing methods.

![Active-active example.](../media/4-active-active-cluster.png)

The previous diagram is a high-level example of an active-active cluster in action.

In contrast, an active-passive cluster type architecture lets you run Azure virtual machines where one node is active and in use, and the other node is passive and not in use. You use the passive node only when the active node has a failure.

Because each of your nodes is running in an active-active scenario simultaneously, you're going to be facing more running costs on a day-to-day basis in an active-active scenario, if the machines have the same specifications as machines in an active/passive cluster. Active-passive clusters can be more cost effective than an active-active cluster. Because the passive node isn't actively servicing user requests, you may see lower software licensing costs and lower resource costs. However, because you only run the active node in an active-passive cluster, you aren't as flexible to meet fluctuating demand as you are with an active-active cluster.

Resources like Azure availability sets help you to achieve high availability through multiple nodes. If something affects one machine, like hardware failures or network outages, another machine can be available to keep things running. You could also use Azure Virtual Machine Scale Sets to create an active-active cluster, and run machines that work to scale up and down in direct response to demand. Azure Load Balancer, through its high availability (HA) ports rules, can also help you to achieve active-active or active-passive clustering for your machines.

## Fail over and fail back your applications

Your organization has infrastructure for its applications running on-premises. You must help ensure that compliance requirements are met, and business continuity goals are achieved. By using Azure Site Recovery and Traffic Manager together, you can fail over to Azure, then fail back, to ensure you keep the applications running.

If there's a failure, you can smoothly redirect client traffic to an infrastructure created for you in Azure. Use Traffic Manager to create a Traffic Manager profile and set a priority routing method. Then you create two endpoints, one for your on-premises environment, and another for the environment that you want to set up on Azure.

Because you're normally running an on-premises environment and want another one in Azure only to fail over to, you can set priority 1 for the on-premises environment, and priority 2 for your environment on Azure. This priority is how Traffic Manager knows how to route the traffic between the two environments. Traffic Manager keeps routing traffic to your on-premises environment until it notices that the endpoint isn't healthy anymore. If that's the case, Traffic Manager routes traffic to your second environment, in Azure. Azure Site Recovery only starts running your virtual machines in Azure if a failover is triggered. If a disaster occurs, you can use Azure Site Recovery to start a failover from the on-premises environment to the Azure environment.

Traffic Manager gives you the ability to set the frequency of probing to monitor your endpoints. You configure Traffic Manager to monitor the health of your endpoints between 30 seconds for regular probes, to 10-second intervals for faster probes.

After a failover is completed, clients are directed transparently to the new endpoint in Azure. When you've addressed the issue that caused the failover, you can use Azure Site Recovery to fail back again to your on-premises environment. Traffic Manager continues to probe for the health of your on-premises endpoint. When Traffic Manager identifies that the endpoint is healthy again, it directs traffic back to your on-premises environment.

![Hybrid network.](../media/4-hybrid-network.png)
