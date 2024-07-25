Managing Internet connections with SAP RISE/ECS involves understanding network communication paths and implementing appropriate security measures.

## Internet connections with SAP RISE/ECS

SAP workloads require a network egress path to the Internet for communication with external applications and interfaces. Similarly, your company’s user base (for example, SAP Fiori) needs an Internet ingress or inbound connections to the SAP landscape. Network communication to and from the Internet is by default not enabled for SAP RISE/ECS customers, and default networking uses private IP ranges only. Internet connectivity requires planning with SAP, to optimally protect customer’s SAP landscape.

> [!NOTE]
> For SAP RISE managed workloads, work with your SAP representative to explore your needs for https, RFC, or other communication paths.

When you enable Internet bound or incoming traffic with SAP RISE, the network communication is protected through various Azure technologies such as network security groups (NSGs), application security groups (ASGs), Application Gateway with Web Application Firewall (WAF), proxy servers, and other features depending on use and network protocols. These services are entirely managed through SAP within the SAP RISE/ECS virtual network and subscription. The SAP RISE to and from Internet remains within the SAP RISE/ECS virtual network and doesn't transit into/from the customer’s own virtual networks.

:::image border="false" type="content" source="../media/sap-rise-internet.png" alt-text="Diagram shows SAP Cloud Connector V M from S A P RISE virtual network connecting through Internet to S A P B T P. S A P RISE / E C S provides inbound/outbound internet connectivity. Customer's own workloads go through own internet breakout, not crossing over to S A P RISE virtual network.":::

Applications within a customer's own virtual network connect to the Internet directly from the respective virtual network, or through centrally managed services like Azure Firewall, Azure Application Gateway, NAT Gateway, and others. Connectivity to SAP BTP from non-SAP RISE/ECS applications follows the same network Internet-bound path on the customer side. If an SAP Cloud Connector is needed for integration, run it on the customer's virtual machines. Essentially, customers manage SAP BTP or any public endpoint communication themselves if an SAP RISE workload is not involved.

## Network communication ports with SAP RISE

Any Azure service with access to the customer virtual network can communicate with the SAP landscape running within the SAP RISE/ECS subscription via the available ports.

:::image border="false" type="content" source="../media/sap-rise-open-ports.png" alt-text="Diagram of open ports on an S A P RISE / E C S system. R F C connections for BAPI and IDoc, https for OData and Rest/SOAP. O D B C / J D B C for direct database connections to S A P HANA. All connections through the private virtual network peering. Application Gateway with public I P for https as a potential option, managed through S A P.":::

Your SAP system in SAP RISE can be accessed through the open network ports, as configured and opened by SAP for your use. https, RFC and JDBC/ODBC protocols can be used through private network address ranges. Additionally, applications can access through https on a publicly available IP, exposed by SAP RISE managed Azure application gateway. For details and settings for the application gateway and NSG open ports, contact SAP.

See [Integrating Azure services with SAP RISE](/azure/sap/workloads/rise-integration-services) for more information about how the available connectivity allows you to extend your SAP landscape with Azure services.
