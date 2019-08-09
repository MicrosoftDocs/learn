There are various measures you need to take to to build resilience into your applications.

Your organization needs you to meet recovery requirements, but at the same time ensure you are keeping costs and complexity down as much as possible.

In this unit, you will learn how geo-redundancy and availability clusters can help you. You will learn what is involved in failovers and failbacks for your applications. You will also understand why and how you should implement a monitoring and notification strategy.

## Add geo-redundancy for your applications

Your applications run on infrastructure. You need to be able to keep your applications running, regardless of what happens to the infrastructure running your applications. In an ideal scenario, you would also like to be able to keep running your applications even if something happens to an entire geographical region where your infrastructure is running. Occasionally, natural disasters and other issues could cause an entire geographical area to be without power or internet. You need to be able to respond to these issues gracefully and keep your applications running. You need to have geo-redundancy in place. But this can be costly.

You can make your on-premises applications geo-redundant with the help of Azure. The benefit of running redundant infrastructure for your applications in Azure is that you don't need to maintain and secure a physical location you are responsible for, and you don't have to face any traditionally associated costs. In fact with Azure, you are able to add redundancy to your applications with regions that can be on the other side of the world, with no maintenance at all that you have to handle yourself. It is done for you. This means you can achieve geo-redundancy easily and cost effectively. With the help of a VPN site-to-site connection, you can extend your on-premises network to a virtual network that is running a replica of your infrastructure in a different region inside of Azure. Azure Traffic Manager can be used to monitor the health of your on-premises network. If something happens to your on-premises location, your replica infrastructure in Azure that is in a different region altogether could then be used.

Similarly, you can set up geo-redundancy for your applications running inside of Azure. For example, if your applications are running on a group of Azure virtual machines in a virtual network, you can replicate that same set up in another region for geo-redundancy. Through virtual network peering you can connect two separate virtual networks and they are treated as one virtual network. This means traffic for these two networks does not go though the public internet or through a gateway. And this means resources can directly connect to other resources as though they were in the same network. Azure Traffic Manager monitors both of your regions for you in this case by monitoring the health of each endpoint. If something happens to your primary region, demand is routed to your secondary region.

## Add high availability clusters

High availability clustering can help you ensure your workloads remain available and running with minimal downtime. High availability clustering comes in different forms. You can achieve high availability clustering through active-active architectures, or through active-passive architectures.

An active-active architecture lets you distribute and load-balance demand between multiple nodes, such as between two Azure virtual identical machines. You can have these Azure virtual machines running together and sharing the demand between themselves. You can distribute demand to these nodes based on different routing methods.

In contrast, with an active-passive cluster type architecture, you can run identical Azure virtual machines where one node is active and in use, and the other one is passive and not in use. The only time the passive node is used is when the active node has a failure.

Because each of your nodes are running in an active-active scenario simultaneously, you are going to be facing more running costs on a day-to-day basis in an active-active scenario for machines that have the same capability as in an active/passive cluster. An active/passive cluster could comparatively help you lower your day-to-day running costs because your active node would not be running all the time. On the other hand, because you will only be running the active node in an active-passive cluster, you are will not be as flexible to meet fluctuating demand as you would with an active-active cluster.

Resources like Azure availability sets will make it possible for you to achieve high availability through multiple nodes. If something happens to one machine, like hardware failures, or network outages affect one machine, another one can be available to keep things running. You can also use Azure virtual machine scale sets to run identical machines that work in unison to scale up and down in direct response to demand. Azure Load Balancer, through its HA ports rules, will also make it possible for you to achieve active-active or active-passive clustering with your machines.



## Fail over and fail back your applications

Your organization has infrastructure for its applications running on-premises. Your organization must be able to meet compliance requirements and achieve business continuity goals. You can use Azure Site Recovery and Azure Traffic Manager together so you can failover to Azure, failback, and ensure you can keep your applications running.

You can smoothly redirect client traffic to an infrastructure created for you in Azure in case of a failure. You can create a Traffic Manager profile using Azure Traffic Manager and set a priority routing method. You create two endpoints. You create one for your on-premises environment and one for your environment that you want to create on Azure. Since you are normally running an on-premises environment and want another one in Azure to just failover to, you can set priority 1 for the on-premises environment and priority 2 for your environment on Azure. This is how Azure Traffic Manager knows how to route the traffic between the two environments. It will keep routing traffic to your on-premises environment until it notices that the endpoint isn't healthy anymore. If that is the case, then Traffic Manager will route traffic to your second environment, which is in Azure. Azure Site Recovery only starts running your virtual machines in Azure if a failover is triggered. If a disaster were to occur, you can initiate a failover from the on-premises environment to the Azure environment with Azure Site Recovery.

Azure Traffic Manager provides you the ability to set the frequency of probing to monitor your endpoints. You configure Azure Traffic Manager to monitor the health of your endpoints between 30 seconds for regular probes to 10 second intervals for faster probes.

Once a failover is completed, clients are transparently are directed to the new endpoint in Azure. When you have addressed the issue that caused the failover to be necessary, you can failback again to your on-premises environment with Azure Site Recovery. Azure Traffic Manager continues to probe for the health of your on-premises endpoint. When Azure Traffic Manager identifies that the endpoint is health again, it will direct traffic back to your on-premises environment.

## Implement a monitoring and notification strategy

It is important that you understand that your applications and the associated infrastructure will experience periodic pressures and must respond by changing appropriately to meet those pressures. For example, you could be dealing with security patches, updates and other changes that affect your applications and their infrastructures. Sometimes, you may even need to change your applications configurations and structure substantially in response to serious pressures.

You won't be able to predict all the changes you must address. You must monitor for any changes to be able to respond appropriately and timely, and to be able to learn from them.

You should first understand the options that are available to you for monitoring. There are many solutions and tools in Azure to help you do this including Azure Monitor, Application Insights, Azure Security Center, and more.

You need to also understand how the various tools available can help you. For example, you can use Azure Security Center to analyze the security of your whole infrastructure, look for, and respond to threats. Azure Security Center can notify you of security alerts, and can send notifications through email.

You use Azure Application Insights to monitor the health of all of your applications throughout the whole of your applications' lifecycles. Azure Application Insights can capture telemetry data from your applications running on-premises or in Azure. You can monitor response times, failure rates, and create your own custom metrics. Azure Application Insights can send alerts on any of your applications through email or for example, through the alert API. You can collect all of your telemetry data and store it somewhere for processing, to gain insight and learn more.

You use Azure Monitor as a single solution for you to collect, analyze and take action based on all of the telemetry data collected on your applications and their infrastructures. Azure Monitor hooks into other tools such as Azure Application Insights, to help you learn and gain understanding of applications and their environments. Azure Monitor can also notify you through alerts, or alternatively perform an automated process to address the issue that caused an alert. Azure Monitor will also allow you to monitor your resources and will auto-scale your resources for you according to rules you set based on metrics.

Use these Azure tools together to address monitoring and notifications for your applications. This will enable you to make smarter applications, keep your applications secure, and rapidly respond to demand by auto-scaling when needed.



Below is a diagram showing a scenario for the knowledge check. 