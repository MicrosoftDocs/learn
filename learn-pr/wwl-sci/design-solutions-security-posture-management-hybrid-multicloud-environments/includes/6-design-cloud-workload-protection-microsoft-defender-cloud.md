While cloud security posture management identifies misconfigurations before attackers exploit them, cloud workload protection (CWP) detects and responds to active threats against running workloads. As a security architect, you design a workload protection strategy that provides appropriate coverage without creating operational burden or unnecessary cost.

## Understanding workload protection in Defender for Cloud

Defender for Cloud provides workload protection through plans targeting specific resource types. Unlike CSPM which assesses configuration state, these plans monitor runtime behavior to detect threats like malware execution, suspicious network connections, and exploitation attempts.

The key design principle: enable protection plans based on workloads present in your environment and their risk profile. Not every workload requires every protection.

## Mapping protection plans to workloads

| Workload type | Defender plan | What it protects |
|--------------|---------------|------------------|
| Virtual machines and servers | Defender for Servers | Windows and Linux machines in Azure, AWS, GCP, and on-premises via Azure Arc |
| Containers | Defender for Containers | Kubernetes clusters, container registries, images, and cluster nodes |
| SQL databases | Defender for SQL | Azure SQL Database, SQL Managed Instance, and SQL Server on machines |
| Open-source databases | Defender for open-source relational databases | Azure Database for PostgreSQL, MySQL, and MariaDB |
| Azure Cosmos DB | Defender for Azure Cosmos DB | Azure Cosmos DB accounts |
| Storage accounts | Defender for Storage | Blob storage, Azure Files, and Azure Data Lake Storage Gen2 |
| App Service | Defender for App Service | Web apps, API apps, and function apps |
| APIs | Defender for APIs | APIs published in Azure API Management |
| Key Vault | Defender for Key Vault | Azure Key Vault secrets, keys, and certificates |
| Resource Manager | Defender for Resource Manager | Azure Resource Manager control plane activity |
| AI workloads | Defender for AI Services | Azure OpenAI and other Azure AI services |

## Designing server protection

Server protection requires the most architectural decisions. Defender for Servers offers two plans:

| Capability | Plan 1 | Plan 2 |
|-----------|--------|--------|
| Defender for Endpoint integration (EDR) | Yes | Yes |
| Defender for Endpoint license included | Yes | Yes |
| Vulnerability assessment (agent-based) | Yes | Yes |
| Agentless scanning (vulnerabilities, secrets, malware) | No | Yes |
| Just-in-time VM access | No | Yes |
| File integrity monitoring | No | Yes |
| OS configuration assessment (MCSB baselines) | No | Yes |
| OS system updates assessment | No | Yes |
| Defender for DNS alerts | No | Yes |
| Premium Defender Vulnerability Management features | No | Yes |

**Plan selection**: Choose Plan 1 for EDR integration and agent-based vulnerability scanning. Choose Plan 2 for agentless scanning, just-in-time access, file integrity monitoring, or premium vulnerability management features. Consider Plan 2 for production servers and Plan 1 for development environments.

**Coverage scope**: Enable at the subscription level for simplest management. Plan 1 can enable at the resource level; Plan 2 requires subscription-level enablement. For multicloud and on-premises servers, deploy Azure Arc for full functionality.

## Designing container protection

Container protection addresses security across five domains: posture management (agentless cluster discovery and configuration assessment), vulnerability assessment (image scanning in registries and running containers), runtime threat protection (60+ Kubernetes-aware analytics mapped to MITRE ATT&CK), software supply chain protection (gated deployment blocking risky images), and deployment monitoring.

**Design consideration**: Agentless capabilities provide discovery and vulnerability assessment without components. The Defender sensor (a DaemonSet on Kubernetes nodes) enables runtime threat protection. Plan sensor deployment alongside Arc onboarding for clusters outside Azure.

## Designing database protection

Database protection monitors queries and access patterns without impacting performance.

**Defender for SQL** detects anomalous query patterns, SQL injection attacks, brute force attempts, and unusual access locations. Protection covers Azure SQL Database, SQL Managed Instance, and SQL Server virtual machines. For SQL Server outside Azure, deploy Azure Arc-enabled SQL Server for full integration.

**Defender for open-source relational databases** monitors PostgreSQL, MySQL, and MariaDB workloads. **Defender for Azure Cosmos DB** detects SQL injection, known malicious actors, and suspicious access patterns.

**Design consideration**: For SQL Server running on-premises or in other clouds, plan Azure Arc deployment as a prerequisite for Defender for SQL integration. Azure-native databases require no additional components.

## Designing storage protection

Defender for Storage provides activity monitoring (detecting unusual access patterns and data exfiltration), malware scanning (near real-time scanning of uploaded files), and sensitive data threat detection (monitoring for breach attempts on sensitive data).

**Design consideration**: Pricing is per storage account plus per-gigabyte for malware scanning. Configure scanning caps to control costs. Enable at subscription level to automatically cover new storage accounts.

## Designing application and infrastructure protection

**Defender for App Service** monitors web applications for attacks including vulnerability scanning attempts, malicious IP connections, and suspicious execution patterns. Enable for all production web applications exposed to the internet.

**Defender for APIs** protects APIs in Azure API Management, identifying posture issues like unauthenticated endpoints and detecting suspicious usage patterns. Prioritize APIs handling sensitive data.

**Defender for Key Vault** detects unusual access attempts to secrets, keys, and certificates. Compromised vaults can enable broader breaches.

**Defender for Resource Manager** monitors control plane operations for suspicious activity like persistence techniques or lateral movement. Both Key Vault and Resource Manager protection operate at subscription level with no additional configuration.

**Defender for AI Services** protects Azure OpenAI and other AI resources, detecting prompt injection attacks and unusual usage patterns. Enable for subscriptions with AI deployments processing sensitive data.

**Design consideration**: Key Vault and Resource Manager protection are foundational controls with minimal overhead - consider enabling these broadly across all production subscriptions. App Service, APIs, and AI Services protection should align with where those workloads exist.

## Prioritizing protection based on risk

**High priority** - Enable full protection for:
- Production servers processing customer data
- Databases containing PII
- Customer-facing containers and applications
- Storage accounts receiving external uploads
- Workloads subject to compliance requirements

**Medium priority**: Internal business applications, development environments with production data copies, shared infrastructure.

**Lower priority**: Isolated test environments with synthetic data, temporary workloads, resources with existing protection tools.

## Integration with security operations

Your design must address how alerts flow to security operations:

- **Alert routing**: Defender for Cloud integrates with Microsoft Defender XDR for unified incident management
- **SIEM integration**: Export alerts to Microsoft Sentinel, Event Hubs, or Log Analytics
- **Workflow automation**: Use Logic Apps for immediate responses like VM isolation or credential rotation
- **Suppression rules**: Create rules for known false positives to reduce alert fatigue

The combination of CSPM and workload protection creates defense in depth: posture management reduces attack surface by fixing misconfigurations, while workload protection detects and responds when attackers exploit remaining vulnerabilities.
