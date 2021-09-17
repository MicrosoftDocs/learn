
Answer the review questions below.

## Review Questions

## Multiple Choice 
Which of the following features of Azure networking provide the ability to redirect all Internet traffic back to your company's on-premises servers for packet inspection? Select two. 
(x) User Defined Routes{{User defined routes and forced tunneling. You can use forced tunneling to redirect internet bound traffic back to the company's on-premises infrastructure. Forced tunneling is commonly used in scenarios where organizations want to implement packet inspection or corporate audits. Forced tunneling in Azure is configured via virtual network user defined routes (UDR).}}
() Cross-premises network connectivity{{You can use this feature to connect multiple networks within Azure but no on-premises.}}
() Traffic Manager{{Traffic Manager is a load balancer style tool, to move network traffic to the best network application in the cloud, no on-premises.}}



## Multiple Choice  
You are configuring Azure Firewall. You need to allow Windows Update network traffic through the firewall. Which of the following should you use? 
() Destination inbound rules{{Inbound rules would not allow Windows Update to function.}}
() NAT rules{{NAT rules are for routing your network traffic, not opening a firewall port.}} 
(x) Application rules{{Application rules. Application rules define fully qualified domain names (FQDNs) that can be accessed from a subnet. That would be appropriate to allow Windows Update network traffic.}}



## Multiple Choice  
You would like to limit outbound Internet traffic from a subnet. Which product should you install and configure? 
() Azure Web Application Firewall{{Web Application Firewall is for protecting HTTP directly, not a subnet.}}
(x) Azure Firewall{{Azure Firewall. Azure Firewall will let you limit the outbound IP addresses and ports that can be accessed. You can define network rules that define source address, protocol, destination port, and destination address.}}
() Load Balancer{{The Load Balancer guides traffic to the best server, not block traffic.}}



## Multiple Choice 
Your organization has a web application and is concerned about attacks that flood the network layer with a substantial amount of seemingly legitimate traffic. What should you do? 
() Add a Web Application Firewall{{Web Application Firewall would not work for this need, it does not protect at the network layer.}}
() Add an Azure Firewall{{Firewall does not protect at network layer attacks directly.}}
(x) Create a DDoS policy{{Create a DDoS policy to provide defense against the exhaustion resources. This exhaustion could make an application unavailable to legitimate users for example.}}

 