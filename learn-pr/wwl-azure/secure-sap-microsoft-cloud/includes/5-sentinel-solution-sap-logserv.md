As covered in the previous unit, the Microsoft Sentinel solution for SAP applications provides powerful application-layer monitoring — tracking SAP user activity, business transactions, and critical security events while correlating them with threat signals across your entire IT estate. However, in SAP RISE/ECS environments, infrastructure and database logs remain under SAP's shared responsibility model and aren't accessible to customers through the agentless data connector.

**SAP LogServ** is an optional add-on service in your SAP Cloud ERP private package that closes this gap. It unlocks access to all remaining logs from SAP's managed services — including complete SAP HANA database insights, system-level security telemetry, and audit trails — streaming them directly into Microsoft Sentinel Solution for SAP.

> [!NOTE]
> SAP LogServ is a first-of-its-kind Sentinel-native integration built by SAP. RISE on Azure customers have the exclusive ability to leverage this push-based integration without any intermediary infrastructure - Unlike other pull-based mechanisms involving log-forwarding functions.

## Solution architecture

Deploy the LogServ integration solution provided by SAP alongside the Microsoft Sentinel for SAP solution for full coverage across the entire SAP RISE/ECS stack.

:::image type="content" source="../media/logserv-architecture.png" alt-text="Diagram showing high-level integration flow of SAP LogServ with Microsoft Sentinel across the full SAP RISE stack." lightbox="../media/logserv-architecture.png":::

The combined architecture provides coverage across three layers:

| Layer | Coverage | Provided by |
| :--- | :--- | :--- |
| **Application** | SAP user activities, business transactions, audit logs, sensitive transactions, RFC calls | Microsoft Sentinel for SAP (agentless data connector) |
| **Infrastructure** | Operating system logs, syslog, NetWeaver infrastructure traces | SAP LogServ add-on |
| **Database** | SAP HANA audit logs, diagnostic traces, security events | SAP LogServ add-on |

## Key log sources from SAP LogServ

SAP adds relevant log sources as they become available in RISE. Key log sources include:

SAP HANA database logs are a critical addition. Without LogServ, HANA audit logs, diagnostic traces, and security events aren't available through any customer-facing interface in RISE. With LogServ enabled, your SOC team gains direct visibility into database-level activities such as:
- Privilege escalation attempts at the HANA layer
- Unauthorized schema access or data exports
- Configuration changes to HANA security settings
- Database user management events

Beyond HANA database, LogServ also provides operating system-level logs and SAP basis infrastructure traces from the managed environment.

## Built-in security content

The LogServ integration comes with built-in security content in Microsoft Sentinel Solution for SAP to help you get started quickly.

### Application-layer analytic rules (Microsoft Sentinel for SAP)

The Microsoft Sentinel for SAP solution ships with [60+ built-in analytic rules](/azure/sentinel/sap/sap-solution-security-content?pivots=connection-agentless) covering the application layer — detecting threats like privilege escalation, unauthorized changes, sensitive transactions, and data exfiltration.

:::image type="content" source="../media/app-layer-analytic-rules.png" alt-text="Screenshot showing application-layer analytic rules from the Microsoft Sentinel for SAP solution." lightbox="../media/app-layer-analytic-rules.png":::

### Infrastructure and database detections (SAP LogServ add-on)

LogServ extends detection capabilities to the infrastructure and database layer with dedicated analytic rules for SAP HANA, surfacing threats that are invisible at the application layer alone.

:::image type="content" source="../media/hana-db-detections.png" alt-text="Screenshot showing SAP HANA database detection rules provided by the SAP LogServ integration." lightbox="../media/hana-db-detections.png":::

Learn more from [this blog article](https://community.sap.com/t5/enterprise-resource-planning-blog-posts-by-members/deploy-built-in-sap-logserv-detection-rules-in-microsoft-sentinel-and/ba-p/14141749).

### LogServ workbook

A built-in workbook provides operational insights into your LogServ data — visualizing log ingestion patterns, available log sources, and helping you create alerts for anomalies.

:::image type="content" source="../media/logserv-workbook1.png" alt-text="Screenshot showing the upper part of the SAP LogServ workbook in Microsoft Sentinel with log ingestion patterns and source overview." lightbox="../media/logserv-workbook1.png":::

:::image type="content" source="../media/logserv-workbook2.png" alt-text="Screenshot showing the lower part of the SAP LogServ workbook in Microsoft Sentinel with log ingestion patterns and source overview." lightbox="../media/logserv-workbook2.png":::

Learn more from [this blog article](https://community.sap.com/t5/enterprise-resource-planning-blog-posts-by-members/gaining-operational-insights-with-the-sap-logserv-workbook-on-microsoft/ba-p/14165489)

## Getting started

SAP LogServ is an optional add-on for SAP RISE/ECS and SAP Cloud ERP private edition customers. To get started:

1. **Activate LogServ** — Contact SAP to enable the LogServ add-on for your SAP Cloud ERP private environment.
2. **Deploy Microsoft Sentinel for SAP** — Ensure the agentless data connector is configured for application-layer coverage as described in the previous unit.
3. **Install the LogServ add-on** — Deploy the SAP-provided LogServ integration solution from the Microsoft Sentinel content hub into your workspace.
4. **Configure log selection** — Choose which infrastructure and database log sources to ingest based on your security and compliance requirements.
5. **Enable analytic rules** — Activate the built-in HANA and infrastructure detection rules alongside the existing application-layer rules.

:::image type="content" source="../media/logserv-deployment-view.png" alt-text="Diagram showing high-level integration flow of SAP LogServ with Microsoft Sentinel across the full SAP RISE stack." lightbox="../media/logserv-deployment-view.png":::

For detailed deployment instructions, see the [SAP LogServ integration with Microsoft Sentinel blog series](https://community.sap.com/t5/enterprise-resource-planning-blog-posts-by-members/ultimate-blog-series-sap-logserv-integration-with-microsoft-sentinel/ba-p/14126401).

> [!IMPORTANT]
> LogServ complements the Microsoft Sentinel for SAP solution. For full-stack coverage, deploy both the agentless data connector (application layer) and the LogServ add-on (infrastructure and database layers).
