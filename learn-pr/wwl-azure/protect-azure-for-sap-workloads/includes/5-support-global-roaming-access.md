| ![Cartoon image of Irwin.](../media/irwin.png) | Irwin also travels as a global product manager and needs secure and reliable access into the Azure SAP S/4 HANA system from their laptop and smart phone. Irwin frequently uses the SAP Fiori web front end and the company’s SAP applications. |
| :--- | :--- |

Because Irwin uses the public internet to access SAP. Irwin's process for authentication and network access is different than Amita’s but similar to Tim’s. In addition, Irwin's access–and user experience–benefits from a service that caches frequently used content and distributes it closer to the users in a global architecture: Azure Front Door.

The numbered steps below show what’s happening to the network traffic that Irwin generates.

1. Like Tim, Irwin opens a browser on their laptop or smart phone that directs to the SAP Fiori URL and IP address using **Azure DNS**.

2. The browser request enters the edge of the Azure network and passes inspection by the native **Azure DDoS Protection services**. The DDoS services help ensure the traffic isn't part of a larger attack

3. The request moves to the **Microsoft Entra authentication service**, which adds multifactor authentication for increased security.

4. Once authenticated, Irwin’s request proceeds to **Azure Front Door**, which displays some of the SAP Fiori content by using content caching. This improves the response time and user experience.

5. To access content from the SAP Fiori application cluster and SAP HANA database, Irwin's request proceeds through a firewall. The **Azure Firewall** ensures the connection is asking for the right ports and that Irwin's IP address is added to the allowlist.

6. Irwin’s request is still in the hub Azure Virtual Network and Azure network security group–just like Amita and Tim's requests. To access the SAP Fiori front-end cluster in the spoke VNet, Irwin's request needs **Azure virtual network peering**.

7. After going through the VNet peering service, the request enters another spoke VNet with an **Azure load balancer**. The load balancer directs the request to an appropriate SAP Fiori server.

8. Once connected to the server, Irwin’s device can display the latest data of the **SAP Fiori home page**. Irwin then selects the SAP application they need.
