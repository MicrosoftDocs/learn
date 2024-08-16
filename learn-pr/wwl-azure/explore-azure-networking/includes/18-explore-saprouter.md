SAP instances running in Azure need to be accessible from SAProuter as well. A SAProuter enables the TCP/IP communication between participating systems if there's no direct IP connection. This provides the advantage that no end-to-end connection between the communication partners is necessary on the network level. The SAProuter is listening on port 3299 by default. To connect SAP instances through a SAProuter, you need to give the SAProuter string and host name.

SAProuter should be configured for remote SAP support. If you have a site-to-site connection between your on-premises locations and Azure, and you're running SAP components, then it's likely that are already running SAProuter. In this case, implement the following steps for SAP remote support:

- Maintain the private and static IP addresses of the virtual machines that host SAP systems in the SAProuter configuration.
- Configure the NSG of the subnet that hosts the SAP Azure Virtual Machines to allow traffic through TCP/IP port 3299).

If you're connecting to Azure through the internet, and you don't have an SAP router for the virtual machines with SAP systems, then install SAProuter in a separate virtual machine in the Management subnet.

Be sure to install SAProuter in a separate virtual machine and not in your Jumpbox virtual machine. The separate virtual machine must have a static IP address. To connect your SAProuter to the SAProuter that's hosted by SAP, contact SAP for an IP address. (The SAProuter that's hosted by SAP is the counterpart of the SAProuter instance that you install on your virtual machine.) Use the IP address from SAP to configure your SAProuter instance. In the configuration settings, the only necessary port is TCP port 3299.

:::image border="false" type="content" source="../media/deployment-schema-sap-hana-saprouter-13a4e7de.png" alt-text="Diagram showing rough deployment schema for S A P HANA without a site-to-site connection and SAP router.":::

> [!NOTE]
> For more information on how to set up and maintain remote support connections through SAProuter, see the [SAP documentation](https://support.sap.com/en/tools/connectivity-tools/remote-support.html).
