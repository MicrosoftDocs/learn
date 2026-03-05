Centralized logging and auditing are fundamental to security operations, providing the visibility needed for threat detection, investigation, compliance, and forensics.

**Logging** focuses on recording events for historical analysis, compliance evidence, and forensic investigations. It answers the questions "What happened?" and "Can we prove compliance?" **Auditing** specifically tracks user and administrator activities to establish accountability and meet regulatory requirements. While monitoring (covered in the previous unit) provides real-time visibility, logging ensures you have a durable record of events—sometimes retained for years—to support investigations and demonstrate compliance.

## Understanding security data domains

As a security architect, it's important to understand that security log data comes from two distinct domains that converge in Microsoft Sentinel for unified analysis:

| Domain | What it covers | Primary tools | Log characteristics |
|--------|---------------|---------------|--------------------|
| **Infrastructure** | VMs, containers, networks, databases, cloud resources, AI services | Azure Monitor, Defender for Cloud, Azure Activity logs | Agent-based collection, resource-focused, high volume |
| **Productivity** | Email, files, identity, collaboration, Copilot activities | Microsoft Purview Audit, Defender XDR, Entra ID logs | Service-based collection, user-focused, compliance-critical |

Both domains are essential for comprehensive security operations:

- **Infrastructure logs** help you detect attacks on workloads, investigate lateral movement, and understand resource-level threats
- **Productivity logs** help you detect compromised accounts, investigate data exfiltration, and establish user accountability

Microsoft Sentinel serves as the convergence point, ingesting logs from both domains into a unified Log Analytics workspace. This enables security analysts to correlate an identity-based attack (detected in Entra ID or Microsoft 365 logs) with subsequent infrastructure activity (detected in Azure or multicloud logs)—providing the complete attack story.

The rest of this unit covers logging solutions for both domains: Log Analytics workspaces and Microsoft Sentinel for infrastructure data, and Microsoft Purview Audit for productivity data.

## Design guidance for centralized logging

The Microsoft Cloud Security Benchmark (MCSB) provides guidance on designing logging capabilities:

| Control | Title | Summary |
|---------|-------|---------|
| LT-3 | Enable logging for security investigation | Enable logging for cloud resources to meet requirements for security incident investigations and compliance purposes. |
| LT-4 | Enable network logging for security investigation | Enable logging for network services to support incident investigations, threat hunting, and security alert generation. |
| LT-5 | Centralize security log management and analysis | Centralize logging storage and analysis to enable correlation across log data. Assign data owners, define access guidance, and establish data retention requirements. |
| LT-6 | Configure log storage retention | Plan your log retention strategy according to compliance, regulation, and business requirements. |

> [!NOTE]
> For more information on these controls, see [Microsoft cloud security benchmark - Logging and threat detection](/security/benchmark/azure/mcsb-logging-threat-detection).

## Microsoft solutions for centralized logging

### Log Analytics workspaces

Log Analytics workspaces serve as the central repository for log data in Microsoft's security architecture. Both Azure Monitor and Microsoft Sentinel store their data in Log Analytics workspaces—Microsoft Sentinel is essentially a security solution that runs on top of a Log Analytics workspace.

When designing your logging strategy, consider:

- **What to log**: Security events, resource logs, activity logs, application logs, and network flow logs
- **Where to store**: Single workspace for correlation benefits, or multiple workspaces for data residency, access control, or cost optimization
- **How long to retain**: Configure retention per table based on compliance requirements and investigation needs

Because both services share the same workspace foundation, you can query and correlate operational data (collected via Azure Monitor) with security data (collected via Microsoft Sentinel data connectors) in a unified experience.

#### Azure Monitor logging

Azure Monitor collects infrastructure and operational log data from Azure resources, virtual machines, and hybrid environments. This data flows into Log Analytics workspaces through several collection mechanisms.

**Log types collected by Azure Monitor:**

| Log type | Description | Collection method |
|----------|-------------|-------------------|
| **Resource logs** | Detailed operational data from Azure resources (for example, Key Vault access, storage operations, database queries) | Diagnostic settings per resource |
| **Activity logs** | Subscription-level events including resource modifications, service health, and administrative actions | Automatic; use diagnostic settings to send to Log Analytics |
| **Platform metrics** | Numerical performance data collected automatically from Azure resources | Automatic; use diagnostic settings for additional routing |
| **Guest OS logs** | Windows events, Syslog, and performance counters from virtual machines | Azure Monitor agent with data collection rules |

**Diagnostic settings** are the configuration mechanism for collecting logs from Azure resources. Each Azure resource requires its own diagnostic setting to send logs to destinations:

- **Log Analytics workspace** - Enables querying with KQL, correlation with other data, and integration with Microsoft Sentinel
- **Storage account** - Cost-effective archival for compliance requirements
- **Event hub** - Stream to external SIEM systems or custom applications
- **Partner solutions** - Send directly to integrated partner monitoring tools

> [!TIP]
> Use Azure Policy with the "Deploy diagnostic settings" effect to automatically configure logging for resources as they're created. This ensures consistent log collection across your environment.

**Azure Monitor agent** collects guest operating system logs from virtual machines and Arc-enabled servers using data collection rules:

- **Windows Event Logs** - Security, Application, System, and custom logs
- **Syslog** - Linux system and application logs
- **Custom text logs** - Application-specific log files
- **IIS logs** - Web server access and error logs

#### Microsoft Sentinel logging

> [!IMPORTANT]
> Microsoft Sentinel is transitioning to the Microsoft Defender portal. Starting March 31, 2027, Microsoft Sentinel will only be available in the Defender portal. Plan your workspace design with this unified experience in mind.

Microsoft Sentinel uses **data connectors** to ingest security-focused data into a Log Analytics workspace. Organizations can choose to use the same workspace as Azure Monitor (for better cross-domain correlation) or a dedicated workspace (for security team isolation and cost separation). While some connectors use Azure Monitor's infrastructure (diagnostic settings and Azure Monitor agent), others use service-to-service APIs for Microsoft and third-party security products.

**Data connector types:**

| Connector type | Examples | Collection mechanism |
|----------------|----------|---------------------|
| **Diagnostic settings-based** | Azure Firewall, Key Vault, Azure Activity | Uses same diagnostic settings as Azure Monitor |
| **Azure Monitor agent-based** | Windows Security Events, Syslog/CEF from security appliances | Uses same AMA infrastructure as Azure Monitor |
| **API-based/service-to-service** | Microsoft Defender XDR, Microsoft Entra ID, Office 365 | Direct service integration unique to Microsoft Sentinel |
| **Custom/Logs ingestion API** | Non-Microsoft products, custom applications | REST API with data collection rules |

This architecture means security architects must decide whether to enable Microsoft Sentinel on a workspace:

- **Log Analytics workspace without Sentinel** - For operational data that only needs querying and alerting (Azure Monitor alert rules)
- **Log Analytics workspace with Sentinel enabled** - Adds SIEM capabilities (detection rules, incidents, hunting) to ALL data in the workspace, regardless of collection method

When Microsoft Sentinel is enabled, logs collected via Azure Monitor (diagnostic settings, AMA) become available for Microsoft Sentinel's security analytics alongside data from Sentinel-specific connectors.

### Microsoft Sentinel storage tiers

Microsoft Sentinel provides two storage tiers optimized for different use cases:

| Tier | Purpose | Retention | Best for |
|------|---------|-----------|----------|
| **Analytics tier** | High-performance querying for real-time analytics, alerting, hunting, and all Microsoft Sentinel features | 30 days default; Microsoft Sentinel solution tables extend to 90 days free; can extend up to two years at cost | Primary security data requiring real-time detection and investigation |
| **Data lake tier** | Cost-effective long-term storage with scheduled analytics | Up to 12 years | Secondary security data, compliance retention, historical trend analysis |

The analytics tier keeps data in an interactive state for immediate access, while the data lake tier stores data in a cost-effective cold state for long-term retention.

:::image type="content" source="../media/sentinel-log-tiers.png" alt-text="Diagram showing Microsoft Sentinel log tiers with analytics retention and data lake retention options.":::

### Microsoft Sentinel data lake

The Microsoft Sentinel data lake is a fully managed, cloud-native data lake purpose-built for security operations. Key benefits include:

- **Open format Parquet data files** for interoperability and extensibility
- **Single copy of data** mirrored from analytics tier for efficient storage
- **Separation of storage and compute** for flexibility and cost optimization
- **Multiple analytics engines** including KQL and Jupyter notebooks
- **Up to 12 years of retention** for compliance requirements
- **Activity auditing** tracks data lake activities including data access, job management, and query events

Data in the analytics tier is automatically mirrored to the data lake tier at no extra cost when retention periods match. Organizations can choose to ingest data exclusively into the data lake tier for high-volume, lower-security-value logs.

:::image type="content" source="../media/data-lake-tiers-data-flow.png" lightbox="../media/data-lake-tiers-data-flow.png" alt-text="A block diagram that depicts the mirroring of data from analytics tier to the data lake tier.":::

### Data lake analytics capabilities

The data lake provides multiple ways to analyze historical log data:

| Capability | Purpose | When to use |
|------------|---------|-------------|
| **KQL jobs** | Asynchronous queries with full KQL support; can promote data to analytics tier | Incident investigations, threat intelligence matching, retrospective hunting for zero-day threats |
| **Summary rules** | Scheduled aggregations (20 min to 24-hr bins) into custom tables | Recurring aggregations for detection rules, cost optimization for verbose logs |
| **Search jobs** | Long-running searches through up to a year of data | Forensic analysis requiring large dataset scans |
| **Jupyter notebooks** | Python-based analytics with ML libraries | Machine learning models, complex statistical analysis |

## Microsoft Purview Audit for compliance

Microsoft Purview Audit provides an integrated auditing solution for Microsoft 365 services, tracking user and administrator activities to support security investigations, forensics, and compliance obligations.

### Audit retention and design considerations

| Tier | Default retention | Extended retention | Design consideration |
|------|-------------------|-------------------|---------------------|
| **Audit (Standard)** | 180 days | N/A | Included with most Microsoft 365 licenses; sufficient for general auditing |
| **Audit (Premium)** | One year for Exchange, SharePoint, Entra ID | Up to 10 years with add-on license | Required for regulatory compliance; includes high-value forensic events (MailItemsAccessed, SearchQueryInitiated) |

Audit (Premium) provides access to intelligent insight events critical for breach investigations—such as identifying exactly which email items an attacker accessed. Custom retention policies can target specific workloads, activities, or users.

### Integration with Microsoft Sentinel

For centralized logging architectures, integrate Microsoft Purview audit logs with Microsoft Sentinel to correlate user activities with infrastructure security events and maintain long-term retention through the data lake tier.

## Architect-level design considerations

### Workspace architecture for centralized logging

As a cybersecurity architect, workspace topology is a critical design decision for centralized logging:

| Pattern | When to use | Trade-offs |
|---------|-------------|------------|
| **Single workspace** | Need maximum correlation across all log data, smaller organizations | Best visibility, but may not meet data residency or access control requirements |
| **Separate security and operational workspaces** | Security team requires isolated workspace, different retention needs | Enables dedicated Microsoft Sentinel workspace with 90-day free retention, but reduces cross-domain correlation |
| **Regional workspaces** | Data sovereignty requirements, geographically distributed operations | Meets compliance, but increases management complexity and limits correlation |
| **Dedicated cluster** | Ingesting 100+ GB/day, need customer-managed keys or dedicated capacity | Better performance and security, but higher minimum commitment |

For most organizations, combining Azure Monitor operational data and Microsoft Sentinel security data in the same workspace provides:

- Better visibility across all data for investigation
- Potential cost savings through commitment tiers
- Simplified management and querying

Use table-level RBAC to restrict access to sensitive security tables if combining workspaces.

### Multitenant and MSSP architectures

Organizations with multiple Azure tenants—including managed security service providers (MSSPs) and large enterprises with subsidiaries—require strategies for centralized logging across tenant boundaries.

| Pattern | Description | Best for |
|---------|-------------|----------|
| **Distributed** | Workspace in each tenant; use Azure Lighthouse for cross-tenant access | Full data isolation, regulatory compliance, customer-controlled billing |
| **Centralized** | Single workspace in provider tenant collecting from all customers | Simplified management, cross-customer analytics, provider-owned artifacts |
| **Hybrid** | Customer workspaces with summary rules or Logic Apps exporting aggregated data to central workspace | Balance of isolation and centralized reporting |

For distributed architectures, use **Azure Lighthouse** to enable service provider analysts to access customer workspaces from their own tenant. The **Defender portal supports multitenant management** with a primary workspace and multiple secondary workspaces, enabling unified incident views across tenants.

> [!NOTE]
> Diagnostics-based connectors (Azure Firewall, Storage, Activity logs, Entra ID) can only send data to workspaces in the same tenant as the resource. Plan tenant architecture accordingly.

### Access control for centralized logging

Design access control using multiple layers:

| Method | Use case |
|--------|----------|
| **Workspace-context access** | SOC analysts who need access to all security data |
| **Resource-context RBAC** | Application teams who should see only logs for their resources |
| **Table-level RBAC** | Restrict specific tables (like SecurityEvent) from nonsecurity users |

**Resource-context RBAC** is valuable when combining operational and security logs in the same workspace—application owners can query logs for resources they manage without accessing security-sensitive tables.

Design recommendation: Place the Microsoft Sentinel workspace in a dedicated subscription to simplify permission isolation from application resource groups.

### Data tiering strategy

Design your tiering strategy based on data classification:

| Data classification | Recommended tier | Retention guidance |
|--------------------|------------------|--------------------|
| **Primary security data** (alerts, incidents, identity logs) | Analytics tier | 90 days to two years depending on investigation needs |
| **Secondary security data** (firewall logs, proxy logs, NetFlow) | Data lake tier with summary rules | 1-7 years; use summary rules to aggregate into analytics tier |
| **Compliance/audit data** | Analytics tier mirrored to data lake | Match regulatory requirements (often 7-10 years) |
| **High-volume, low-value logs** (verbose application logs) | Data lake tier only | Based on compliance; query on-demand with KQL jobs |
