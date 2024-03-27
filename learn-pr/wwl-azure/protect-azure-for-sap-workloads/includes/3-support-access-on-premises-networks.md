| ![Cartoon image of Amita.](../media/amita.png) | When Amita starts up an office desktop computer, they are authenticated by Microsoft Active Directory. Amita opens and uses desktop SAP applications as if the SAP landscape were running on-premises. From Amita's perspective, there simply is no difference. |
| :--- | :--- |

Behind the scenes, the company’s on-premises Active Directory works with Microsoft Entra ID to provide single sign-on to both Azure and the SAP S/4 HANA landscape running in Azure. Other Azure services enable Amita’s connectivity and security.

The numbered steps below show what’s happening to the network traffic that Amita generates.

1. First, Amita’s connection resolves the URL name to an IP address using the company’s on-premises DNS and heads to Azure through an **on-premises gateway**.

2. The request then travels to Azure over a high speed, secure, dedicated connection using the **Azure ExpressRoute service**. Azure ExpressRoute provides speeds up to 10 Gb/second. Many SAP customers use ExpressRoute to connect on-premises networks and client environments with SAP systems running in Azure. 	 

3. Once Amita’s request enters Azure, another gateway accepts the traffic and routes it to a firewall. The **Azure Firewall** allows access to only specific types of approved network traffic. The service creates log files on network activity for later analysis if necessary.

	This gateway and firewall are part of a hub-and-spoke network configuration architecture that uses Azure Virtual Networks and network security groups to isolate and provide added security for parts of the solution. Other Azure virtual networks (VNets) in the solution serve as spokes in the hub-and-spoke configuration. 	 

4. Amita’s request leaves the hub VNet through an **Azure virtual network peering** connection and heads towards a configured spoke VNet. This VNet contains another network security group.	 

5. The request enters a VNet and network security group that contains an **Azure load balancer**. The load balancer will help the request gain access to the redundant web front-end cluster for the SAP applications. After the load balancer selects a server in the cluster to send the traffic, the request exits the spoke VNet.	 

6. The request arrives at the spoke VNet and Azure network security group that contains the **web application cluster**. The selected server returns the desired data back to Amita’s client desktop.
