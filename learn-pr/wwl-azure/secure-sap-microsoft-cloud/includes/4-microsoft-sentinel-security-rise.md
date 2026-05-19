The SAP RISE certified Microsoft Sentinel solution for SAP applications allows you to monitor, detect, and respond to suspicious activities. Microsoft Sentinel guards your critical data against sophisticated cyberattacks for SAP systems hosted on Azure, other clouds, or on-premises infrastructure. [Microsoft Sentinel solution for SAP BTP](/azure/sentinel/sap/sap-btp-solution-overview) expands that coverage to SAP Business Technology Platform (BTP).

Correlation of SAP security signals with other enterprise data sources in Microsoft Defender allows you to detect sophisticated attacks that span across multiple systems and services. With built-in detections, workbooks, and playbooks, you can get started quickly and customize the solution to fit your needs.

:::image type="content" source="../media/sap-rise-security-copilot-defender-portal.png" alt-text="Screenshot of embedded Security Copilot experience in Defender with SAP RISE/ECS incidents." lightbox="../media/sap-rise-security-copilot-defender-portal.png":::

The solution allows you to gain visibility to user activities on SAP RISE/ECS and the SAP business logic layers and apply Microsoft Sentinel’s built-in content.
-	Use a single console to monitor all your enterprise estate including SAP instances in SAP RISE/ECS on Azure and other clouds, SAP Azure native, and on-premises estate.
-	Detect and automatically respond to threats: Detect suspicious activity including privilege escalation, unauthorized changes, sensitive transactions, data exfiltration and more with out-of-the-box detection capabilities.
-	Correlate SAP activity with other signals: More accurately detect SAP threats by cross-correlating across endpoints, Microsoft Entra data and more.
-	Customize based on your needs - build your own detections to monitor sensitive transactions and other business risks.
-	Visualize the data with [built-in workbooks](/azure/sentinel/sap/sap-audit-log-workbook).

:::image type="content" source="../media/sap-rise-sentinel.png" alt-text="Diagram that shows how to connect Microsoft Sentinel with SAP RISE/ECS." lightbox="../media/sap-rise-sentinel.png":::

This diagram shows an example of Microsoft Sentinel connected to an SAP managed SAP system using the agentless data connector. The [agentless SAP data connector](/azure/sentinel/sap/deployment-overview) is a cloud-native, SaaS-based connector that uses **SAP Integration Suite** (specifically SAP Cloud Connector) as the secure connectivity layer between Microsoft Sentinel and the SAP landscape. No customer-managed infrastructure such as VMs or containers is required for data collection.

For SAP RISE/ECS, the Microsoft Sentinel solution must be deployed in customer's Azure subscription. All parts of the Microsoft Sentinel solution are managed by customer and not by SAP. Connectivity to the SAP landscapes managed by SAP RISE/ECS is established through SAP Integration Suite, which provides a secure tunnel from the SAP environment to Microsoft Sentinel. Connection to SAP Business Technology Platform (BTP) uses SAP's public APIs for the Audit Log Management Service.

To enable the solution, an authorized RFC user is required on the SAP system and SAP Cloud Connector must be configured as the connection layer. The agentless data connector communicates through SAP Integration Suite to consume application log data from your SAP landscape through standard RFC calls — no agent installation on customer infrastructure is needed.
- Authentication methods supported in SAP RISE: SAP username and password or X509/SNC certificates.
- The agentless connector connects through SAP Integration Suite (SAP Cloud Connector) to the SAP RISE/ECS environment using RFC based connections.

For more information about deploying the agentless data connector, see [Microsoft Sentinel for SAP deployment overview](/azure/sentinel/sap/deployment-overview).

> [!IMPORTANT]
> The agentless data connector of the Microsoft Sentinel for SAP solution covers SAP application-layer logs. For infrastructure-level coverage — including **SAP HANA database logs**, OS logs, and NetWeaver infrastructure traces that are otherwise not available to customers in RISE — SAP offers the optional Logging Service **LogServ**. It serves as a native add-on to the Sentinel for SAP solution. Learn more in the next section.