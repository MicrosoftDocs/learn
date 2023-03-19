When considering the use of routing preference in Azure, you should first analyze your scenario. As the network engineer in charge of the traffic cost savings project, you've learned what routing preference is and how it works. You suspect that changing the routing preference of the public IP address of the application in the Central US region might alleviate some of the cost of data transfer between the car factory in Singapore and the application in Azure.

Here, well discuss how you can decide whether changing the routing preference of the application is Azure fulfills the goal of the traffic cost savings project. We'll list some criteria that indicates whether routing preference will meet your cost savings goal.

* Cost savings

* Performance

## Decision criteria

Routing preference helps alleviate network traffic costs in your subscription. The routing preference of "Internet" will minimize traffic on the Microsoft network by routing traffic to services hosted in Azure across the public Internet. Adjusting the routing preference to "Internet" might not be necessary for small organizations with a limited number of global locations or if network cost isn't an issue. Performance of network transfer must also be considered. The routing of traffic across the public Internet might perform slower than the "Microsoft" network option. Here's a discussion of each of these factors.

|     |     |
| --- | --- |
| **Criteria** | **Analysis**|
| **Cost savings** | Will changing the routing preference to "Internet" result in network traffic cost savings? </br> Ingress and egress traffic with "Internet" routing preference is cheaper than the routing preference of "Microsoft network". |
| **Performance** | Does performance of the network traffic a concern? Traffic routed over the public Internet has performance comparable to other cloud providers. The optimal performance will always be with the default routing preference of "Microsoft network". |

## Apply the criteria

Changing the routing preference to "Internet" is a good choice if you wish to save costs on Internet egress costs in your Azure subscription. However, if performance considerations are a concern and you wish to have the best network performance as possible, then the routing preference choice of "Microsoft network" is a better fit. Let's explore how this criteria applies to the network costs savings project.

The car manufacturer you work for has tasked you with determining a way to save network costs for the factory in Singapore. Currently, the application used by the factory in the Central US region has a routing preference of "Microsoft network". You met with the application developers of the application and have determined that the application doesn't have a network performance requirement.

You learned in the previous units that the "Internet" routing preference will minimize traffic across the Microsoft network. Routing the traffic for the application across the public Internet could result in the cost savings goal of the project.

## Should the application routing preference be changed to "Internet"?

You've determined that "Yes", routing preference will fullfil the goal of the cost savings project by reducing the network costs of traffic between the factory in Singapore and the application in the Central US region. Users in the factory connecting to the application won't see a noticeable performance difference between routing across the Microsoft Network and the public Internet. The application developers determined that the performance difference of routing over the public Internet won't adversely affect the application the factory uses in the Central US region.
