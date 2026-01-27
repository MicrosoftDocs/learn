Microsoft Defender for Cloud provides workload protection plans specifically designed for data services. This unit covers design considerations for implementing Microsoft Defender for Storage and Microsoft Defender for Databases to detect, respond to, and prevent threats to your data workloads.

## Microsoft Defender for Storage

[Microsoft Defender for Storage](/azure/defender-for-cloud/defender-for-storage-introduction) provides a comprehensive security layer for Azure Storage accounts, detecting unusual and potentially harmful attempts to access or exploit storage resources. This capability supports MCSB control LT-1 (Enable threat detection capabilities).

### Capabilities overview

Microsoft Defender for Storage includes three core capabilities:

| Capability | Description | Detection method |
|------------|-------------|------------------|
| **Activity monitoring** | Detect suspicious access patterns and potential threats | Behavioral analytics, threat intelligence |
| **Sensitive data threat detection** | Identify threats to sensitive data | Integration with data sensitivity settings |
| **Malware scanning** | Scan uploaded content for malware | Hash reputation, real-time scanning |

### Activity monitoring

Activity monitoring supports MCSB control DP-2 (Monitor anomalies and threats to sensitive data) by analyzing storage account operations to detect:

- **Anomalous access patterns**: Unusual geographic locations or access times
- **Permission-related anomalies**: Suspicious changes to access configurations
- **Suspicious operations**: Potential exfiltration, reconnaissance, or lateral movement
- **Unauthenticated access**: Public access to sensitive containers

Detection is powered by:

- Microsoft Threat Intelligence feeds
- Behavioral analytics using historical patterns
- Machine learning models trained on storage activity

### Sensitive data threat detection

When combined with [sensitive data discovery in Defender CSPM](/azure/defender-for-cloud/data-security-posture-enable), Defender for Storage can:

- Prioritize alerts based on data sensitivity
- Focus security team attention on truly sensitive data
- Reduce alert noise for low-sensitivity resources
- Provide context about what sensitive data types were potentially accessed

### Malware scanning

The malware scanning capability:

- Scans blobs on upload using Microsoft Defender Antivirus engine
- Supports files up to 2 GB in size
- Uses hash reputation analysis to identify known malware
- Provides near real-time scanning results
- Integrates with Event Grid for automated response

#### Malware scanning design considerations

When implementing malware scanning:

1. **Scope selection**: Enable at subscription or resource level
2. **Exclusions**: Configure exclusions for known safe file types if needed
3. **Response automation**: Use Event Grid to trigger Logic Apps or Functions for quarantine
4. **Cost awareness**: Scanning is charged per GB scanned

### Pricing and enablement options

Enable Defender for Storage at:

- **Subscription level**: Protect all storage accounts automatically
- **Resource level**: Selective enablement for specific accounts
- **Per-storage account pricing**: Based on transaction volume and data scanned

## Microsoft Defender for Databases

Microsoft Defender for Cloud offers protection plans for multiple database services, providing threat detection and vulnerability assessment capabilities.

### Available database protection plans

| Plan | Supported services |
|------|-------------------|
| **Defender for Azure SQL** | Azure SQL Database, SQL Managed Instance, SQL Server on Azure VMs |
| **Defender for open-source databases** | Azure Database for PostgreSQL, MySQL, MariaDB |
| **Defender for Azure Cosmos DB** | Azure Cosmos DB for NoSQL |

### Defender for Azure SQL

[Microsoft Defender for Azure SQL](/azure/azure-sql/database/azure-defender-for-sql) provides:

#### Vulnerability assessment

- Scan databases for misconfigurations
- Identify security weaknesses
- Track vulnerability remediation
- Compare against baseline configurations
- Express and classic configuration options

Vulnerability assessment aligns with MCSB control [PV-5: Perform vulnerability assessments](/security/benchmark/azure/mcsb-posture-vulnerability-management#pv-5-perform-vulnerability-assessments).

#### Advanced Threat Protection

Detect anomalous activities indicating potential threats:

| Threat type | Description | Example |
|-------------|-------------|---------|
| **SQL injection** | Malicious SQL code in queries | Application vulnerability exploitation |
| **Anomalous access** | Unusual login patterns | Access from suspicious IP or location |
| **Brute force** | Multiple failed authentication attempts | Password guessing attacks |
| **Data exfiltration** | Unusual data export patterns | Large data transfers |

#### Alert severity levels

- **High**: Immediate action required, potential active attack
- **Medium**: Suspicious activity warranting investigation
- **Low**: Informational findings for awareness

### Defender for open-source databases

[Microsoft Defender for open-source relational databases](/azure/defender-for-cloud/defender-for-databases-introduction) protects Azure Database services with similar capabilities:

- **Advanced Threat Protection**: Detect anomalous activities
- **Security alerts**: Actionable recommendations
- **Integration**: Unified view in Defender for Cloud portal

Supported scenarios include:

- Detecting brute force attacks on PostgreSQL/MySQL
- Identifying suspicious login patterns
- Alerting on potential SQL injection attempts

### Defender for Azure Cosmos DB

[Microsoft Defender for Azure Cosmos DB](/azure/defender-for-cloud/defender-for-databases-enable-cosmos-protections) provides:

- **Anomaly detection**: Identify unusual access patterns
- **Potential SQL injection**: Detect injection attempts in queries
- **Suspicious data access**: Monitor for data exfiltration patterns
- **Integration with Microsoft Sentinel**: Forward alerts for SIEM analysis

## Design considerations for Defender deployment

### Coverage strategy

Determine your enablement approach:

| Strategy | Pros | Cons |
|----------|------|------|
| **Subscription-wide** | Complete coverage, automatic protection for new resources | Higher cost, potential noise |
| **Resource-selective** | Cost optimization, focused protection | Manual management, coverage gaps |
| **Hybrid** | Balance of coverage and cost | Complex to manage |

The MCSB recommends enabling workload protection for all production resources containing sensitive data.

### Alert management

Alert management supports MCSB control IR-4 (Detection and analysis). Plan for alert handling:

1. **Define alert routing**: Configure email notifications and webhook integrations
2. **Establish response procedures**: Document investigation and remediation steps
3. **Integrate with SIEM**: Forward alerts to Microsoft Sentinel or third-party SIEM
4. **Automate responses**: Use Logic Apps or Azure Functions for automated remediation

### Integration with Microsoft Sentinel

[Connect Defender for Cloud to Microsoft Sentinel](/azure/sentinel/connect-defender-for-cloud) to:

- Correlate data security alerts with other security signals
- Create detection rules spanning multiple data sources
- Investigate incidents with full context
- Automate response with playbooks

### Workflow automation

Configure workflow automation for:

- **Malware detection response**: Quarantine infected blobs, notify security team
- **SQL injection alerts**: Block suspicious IP addresses, notify application owners
- **Access anomalies**: Require additional verification, initiate investigation

## Bringing it together

Microsoft Defender for Storage and Defender for Databases provide the threat detection layer for your data security strategy. Enable subscription-wide protection for production resources, configure malware scanning for uploads, and run regular vulnerability assessments. Integrate with Microsoft Sentinel for alert correlation and automated response, establishing consistent procedures for common threats like SQL injection and access anomalies.
