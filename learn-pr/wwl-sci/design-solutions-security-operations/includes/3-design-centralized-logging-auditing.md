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

### Azure Monitor Logs

Azure Monitor Logs is the foundational logging platform that collects and stores log data from Azure resources, on-premises systems, and multicloud environments. Understanding Azure Monitor Logs is essential before designing Microsoft Sentinel solutions, as Sentinel builds on this foundation.

#### Log types in Azure Monitor

| Log type | Description | Collection method |
|----------|-------------|-------------------|
| **Resource logs** | Detailed operational data from Azure resources (e.g., Key Vault access, storage operations, database queries) | Diagnostic settings per resource |
| **Activity logs** | Subscription-level events including resource modifications, service health, and administrative actions | Automatic; use diagnostic settings to send to Log Analytics |
| **Platform metrics** | Numerical performance data collected automatically from Azure resources | Automatic; use diagnostic settings for additional routing |
| **Guest OS logs** | Windows events, Syslog, and performance counters from virtual machines | Azure Monitor agent with data collection rules |

#### Diagnostic settings

Diagnostic settings are the configuration mechanism for collecting logs from Azure resources. Each Azure resource requires its own diagnostic setting to send logs to destinations:

- **Log Analytics workspace** - Enables querying with KQL, correlation with other data, and integration with Microsoft Sentinel
- **Storage account** - Cost-effective archival for compliance requirements
- **Event hub** - Stream to external SIEM systems or custom applications
- **Partner solutions** - Send directly to integrated partner monitoring tools

When designing your logging architecture:

- Create diagnostic settings for each resource you need to monitor
- Select appropriate log categories based on security and compliance requirements
- Consider using Azure Policy to automatically create diagnostic settings for new resources
- Use category groups (audit, allLogs) to simplify configuration

> [!TIP]
> Use Azure Policy with the "Deploy diagnostic settings" effect to automatically configure logging for resources as they're created. This ensures consistent log collection across your environment.

#### Azure Monitor agent for guest logs

For virtual machines and Arc-enabled servers, the Azure Monitor agent collects guest operating system logs using data collection rules (covered in the previous unit for monitoring). From a logging perspective:

- **Windows Event Logs** - Security, Application, System, and custom logs
- **Syslog** - Linux system and application logs  
- **Custom text logs** - Application-specific log files
- **IIS logs** - Web server access and error logs

Data collection rules specify which logs to collect and which Log Analytics workspace to send them to, enabling consistent log collection across hybrid and multicloud environments.

### Log Analytics workspaces

Log Analytics workspaces serve as the central repository for log data in Microsoft's security architecture. When designing your logging strategy, consider:

- **What to log**: Security events, resource logs, activity logs, application logs, and network flow logs
- **Where to store**: Single workspace for correlation benefits, or multiple workspaces for data residency, access control, or cost optimization
- **How long to retain**: Configure retention per table based on compliance requirements and investigation needs

Log Analytics workspaces integrate with Microsoft Sentinel for security analytics and with Azure Monitor for operational insights, allowing you to query and correlate data across both domains when needed.

### Microsoft Sentinel log storage tiers

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

The data lake's built-in activity audit provides accountability for security operations activities—you can monitor who accessed data, ran notebooks, or created and modified jobs. This auditing is enabled by default and supports compliance requirements for tracking access to security data.

### Data lake analytics capabilities

The data lake provides multiple ways to analyze historical log data:

| Capability | Purpose | Best for |
|------------|---------|----------|
| **KQL jobs** | Run one-time or scheduled asynchronous queries against data lake data with full KQL support including joins and unions | Incident investigations using historical logs, threat intelligence matching, anomaly detection across months of data |
| **Summary rules** | Run scheduled aggregation jobs (bin sizes from 20 minutes to 24 hours) to precompute data into custom log tables | Aggregating network and firewall logs, creating baseline tables for detection, cost optimization for verbose logs |
| **Search jobs** | Run long-running searches through up to a year of data in a table, sending results to a new Analytics table | Forensic analysis when query timeout is insufficient, searching large datasets for specific events |
| **Jupyter notebooks** | Use Python-based advanced analytics with machine learning libraries | Machine learning models, complex statistical analysis, custom visualizations |

KQL jobs can promote data from the data lake tier to the analytics tier, enabling investigation of historical events alongside current incidents. This is valuable for zero-day threat detection and retrospective threat hunting.

> [!TIP]
> Use KQL jobs for incident investigations, threat intelligence matching, and promoting data from data lake to analytics tier. Use summary rules for recurring aggregations that support detection rules. Use search jobs when you need to scan large datasets for specific events.

### Data connectors and data flow

When you onboard to Microsoft Sentinel data lake, your existing data connectors can send data to:

- **Analytics tier only** - For data requiring real-time alerting and hunting
- **Analytics tier with data lake mirroring** - Default configuration for most security data
- **Data lake tier only** - For high-volume logs with limited real-time security value


:::image type="content" source="../media/data-lake-tiers-data-flow.png" lightbox="../media/data-lake-tiers-data-flow.png" alt-text="A block diagram that depicts the mirroring of data from analytics tier to the data lake tier.":::

## Microsoft Purview Audit for compliance

Microsoft Purview Audit provides an integrated auditing solution to help organizations respond to security events, forensic investigations, and compliance obligations.

### Audit capabilities

- **Enabled by default** for organizations with appropriate subscriptions
- **Thousands of searchable audit events** across Microsoft 365 services
- **Audit search tool** in the Microsoft Purview portal for investigation
- **Audit Search Graph API** for programmatic access
- **PowerShell cmdlets** (Search-UnifiedAuditLog) for scripted searches and automation
- **Export to CSV** for analysis and reporting
- **Office 365 Management Activity API** for SIEM integration with higher bandwidth for Premium

### Audit retention tiers

| Tier | Default retention | Extended retention | Use case |
|------|-------------------|-------------------|----------|
| **Audit (Standard)** | 180 days | N/A | General auditing needs for all users |
| **Audit (Premium)** | 1 year for Exchange, SharePoint, Entra ID; 180 days for other services | Up to 10 years with add-on license | Regulatory compliance, forensic investigations |

> [!NOTE]
> The 10-year retention requires both an E5 license and a 10-Year Audit Log Retention add-on license. Custom retention policies can specify retention by workload, activity type, or specific users.

### Audit (Premium) intelligent insights

Audit (Premium) provides access to high-value events critical for forensic and compliance investigations:

| Service | Intelligent insight events |
|---------|---------------------------|
| **Exchange Online** | MailItemsAccessed, Send, SearchQueryInitiatedExchange, MailItemsRead |
| **SharePoint Online** | SearchQueryInitiatedSharePoint, FileAccessedExtended |
| **Microsoft Teams** | Meeting join/leave, message events with sensitivity labels |

These events help determine the scope of compromise during breach investigations—for example, identifying exactly which email items an attacker accessed or what searches a compromised account performed.

### Custom audit log retention policies

As an architect, you can create custom retention policies to meet specific compliance requirements:

- Retain audit records based on **specific Microsoft 365 services** (Exchange, SharePoint, Entra ID)
- Target **specific activities** within a service
- Apply policies to **specific users** for targeted retention
- Set **priority levels** when multiple policies apply to the same records

Organizations can have up to 50 custom audit log retention policies.

### Integration with Microsoft Sentinel

Microsoft Purview audit logs can be integrated with Microsoft Sentinel to:

- Centralize audit data with other security telemetry
- Correlate user activities with security events
- Create analytics rules for suspicious activity patterns
- Maintain long-term retention through data lake tier
- Use intelligent insight events in detection rules for insider threat scenarios

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

### Design considerations summary

When designing your centralized logging architecture, consider:

| Factor | Consideration |
|--------|---------------|
| **Data ownership** | Assign owners responsible for each log source's access, retention, and processing |
| **Retention requirements** | Align retention periods with compliance regulations and investigation needs; use data lake tier for long-term retention |
| **Cost optimization** | Use appropriate storage tiers based on data value and access patterns; use commitment tiers for 100+ GB/day |
| **Access control** | Implement table-level RBAC to control access to sensitive log data; use resource-context RBAC for operational data |
| **Data residency** | Ensure log storage locations meet regulatory requirements; consider regional workspaces if needed |
| **Integration** | Design for correlation between operational and security logs; plan Purview Audit integration with Microsoft Sentinel |
| **Resilience** | Consider log multicasting to secondary workspace for critical data if regional availability is required |

> [!IMPORTANT]
> Microsoft Sentinel is transitioning to the Microsoft Defender portal. Starting March 31, 2027, Microsoft Sentinel will only be available in the Defender portal. Plan your workspace design with this unified experience in mind.
