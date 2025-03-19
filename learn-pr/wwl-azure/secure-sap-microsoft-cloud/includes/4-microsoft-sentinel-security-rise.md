

The SAP RISE certified Microsoft Sentinel solution for SAP applications allows you to monitor, detect, and respond to suspicious activities. Microsoft Sentinel guards your critical data against sophisticated cyberattacks for SAP systems hosted on Azure, other clouds, or on-premises infrastructure. [Microsoft Sentinel solution for SAP BTP](/azure/sentinel/sap/sap-btp-solution-overview) expands that coverage to SAP Business Technology Platform (BTP).

The solution allows you to gain visibility to user activities on SAP RISE/ECS and the SAP business logic layers and apply Microsoft Sentinel’s built-in content.
-	Use a single console to monitor all your enterprise estate including SAP instances in SAP RISE/ECS on Azure and other clouds, SAP Azure native, and on-premises estate.
     -Detect and automatically respond to threats: Detect suspicious activity including privilege escalation, unauthorized changes, sensitive transactions, data exfiltration and more with out-of-the-box detection capabilities.
       -Correlate SAP activity with other signals: More accurately detect SAP threats by cross-correlating across endpoints, Microsoft Entra data and more.
       -Customize based on your needs - build your own detections to monitor sensitive transactions and other business risks.
       -Visualize the data with [built-in workbooks](/azure/sentinel/sap/sap-audit-log-workbook).

:::image type="content" source="../media/sap-rise-sentinel.png" alt-text="Diagram that shows how to connect Microsoft Sentinel with SAP RISE/ECS.":::
This diagram shows an example of Microsoft Sentinel connected through an intermediary VM or container to SAP managed SAP system. The intermediary VM or container runs in customer's own subscription with configured SAP data connector agent. Connection to SAP Business Technology Platform (BTP) uses SAP's public APIs for the Audit Log Management Service.

For SAP RISE/ECS, the Microsoft Sentinel solution must be deployed in customer's Azure subscription. All parts of the Microsoft Sentinel solution are managed by customer and not by SAP. Private network connectivity from customer's vnet is needed to reach the SAP landscapes managed by SAP RISE/ECS. Typically, this connection is over the established vnet peering or through alternatives described in this document.

To enable the solution, only an authorized RFC user is required and nothing needs to be installed on the SAP systems. The container-based [SAP data collection agent](/azure/sentinel/sap/deployment-overview?tabs=agent) included with the solution can be installed either on VM or AKS/any Kubernetes environment. The collector agent uses an SAP service user to consume application log data from your SAP landscape through RFC interface using standard RFC calls. 
- Authentication methods supported in SAP RISE: SAP username and password or X509/SNC certificates
- Only RFC based connections are possible currently with SAP RISE/ECS environments

> [!IMPORTANT]
>
> - Running Microsoft Sentinel in an SAP RISE/ECS environment requires: Importing an SAP transport change request for the following log fields/source: Client IP address information from SAP security audit log, DB table logs (preview), spool output log. Microsoft Sentinel's built-in content (detections, workbooks, and playbooks) provides extensive coverage and correlation without those log sources.
> - SAP infrastructure and operating system logs aren't available to Microsoft Sentinel in RISE, due to shared responsibility model.