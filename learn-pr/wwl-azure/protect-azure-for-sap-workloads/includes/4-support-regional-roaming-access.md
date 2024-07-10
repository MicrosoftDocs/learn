| ![Cartoon image of Tim.](../media/tim.png) | A regional salesperson, Tim needs secure and reliable access into the Azure SAP S/4 HANA system from their laptop and smartphone when they travel. Tim often uses the SAP Fiori web front end and their company’s SAP applications. |
| :--- | :--- |

Because Tim spends time on the road in hotels and coffee shops, Tim sometimes uses the public internet to access SAP. Use of public internet is the major reason Tim's authentication and network access is different than Amita’s.

The numbered steps below show what’s happening to the network traffic that Tim generates.

1. Tim opens a browser on a laptop or smartphone that connects to the **Azure DNS service**. The service returns an IP Address that Tim can use to reach the SAP Fiori front-end web servers.

2. Before the browser connects to the applications, it authenticates Tim’s identity. The browser request enters the edge of the Azure regional network and passes inspection by the **Azure Distributed Denial of Service Protection services**. The Azure Distributed Denial of Service Protection services help ensure the traffic isn't part of a larger attack.

3. The request moves to the **Microsoft Entra authentication service**, which adds multifactor authentication for extra security.

4. Once authenticated, Tim’s request proceeds through an **Azure Firewall**. The firewall ensures Tim is asking for the right ports and confirms Tim's IP address is added to the allowlist to enable access to the web servers. Like Amita's request, Tim's request is still in the hub Azure Virtual Network and the Azure network security group.

5. Tim’s request attempts to access the SAP Fiori front-end web services cluster in the spoke VNet through **Azure virtual network peering**.

6. First, however, an **Azure load balancer** in a spoke VNet with a network security group selects the appropriate server in the SAP Fiori web cluster that will handle Tim’s request. Traffic volume or other parameters set by the administrator affect the server selection.

7. The server displays the **SAP Fiori home page** to Tim and awaits Tim's further requests.
