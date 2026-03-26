While cloud security posture management identifies misconfigurations before attackers exploit them, cloud workload protection (CWP) detects and responds to active threats against running workloads. As a security architect, you select the right combination of workload protection plans in Microsoft Defender for Cloud to provide appropriate coverage across your hybrid and multicloud environment without creating unnecessary cost or operational burden.

## How workload protection complements posture management

Defender for Cloud provides workload protection through plans targeting specific resource types. Unlike CSPM, which assesses configuration state, these plans monitor runtime behavior to detect threats like malware execution, suspicious network connections, and exploitation attempts. Together, CSPM and CWP create defense in depth: posture management reduces the attack surface by fixing misconfigurations, while workload protection detects and responds when attackers exploit remaining vulnerabilities.

The key selection principle: enable protection plans based on the workloads present in your environment and their risk profile. Not every workload requires every protection plan.

## Available workload protection plans

Defender for Cloud offers plans for the following workload types. Each plan is enabled independently, allowing you to tailor protection to your environment.

| Workload type | Defender plan | Multicloud coverage |
|--------------|---------------|---------------------|
| Virtual machines and servers | Defender for Servers (Plan 1 or Plan 2) | Azure, AWS, GCP, on-premises via Azure Arc |
| Containers | Defender for Containers | Azure AKS, AWS EKS, GCP GKE, Arc-enabled clusters |
| SQL databases | Defender for SQL | Azure SQL, SQL Managed Instance, SQL Server on machines (including Arc-enabled) |
| Open-source databases | Defender for open-source relational databases | Azure Database for PostgreSQL, MySQL, and MariaDB |
| Azure Cosmos DB | Defender for Azure Cosmos DB | Azure Cosmos DB accounts |
| Storage accounts | Defender for Storage | Blob storage, Azure Files, Azure Data Lake Storage Gen2 |
| App Service | Defender for App Service | Azure App Service web apps, API apps, function apps |
| APIs | Defender for APIs | APIs published in Azure API Management |
| Key Vault | Defender for Key Vault | Azure Key Vault |
| Resource Manager | Defender for Resource Manager | Azure Resource Manager control plane |
| AI workloads | Defender for AI Services | Azure OpenAI Service and Microsoft Foundry |

> [!NOTE]
> Other modules cover workload-specific security design in depth—including server endpoint protection, data security for SQL and Storage, container security requirements, and application security. This unit focuses on **selecting** the right plans as part of your overall hybrid and multicloud posture management strategy.

## Selection criteria for workload protection plans

Use the following criteria when deciding which plans to enable and where:

### Workload presence and environment scope

Inventory the workload types across your Azure subscriptions, AWS accounts, GCP projects, and on-premises environments. Enable plans only where the corresponding workloads exist. For example, if a subscription contains no storage accounts, there's no reason to enable Defender for Storage on it.

For plans that support subscription-level enablement (most plans do), enabling at the subscription level automatically protects new resources of that type as they're deployed. This is the recommended approach for production subscriptions to avoid protection gaps.

### Multicloud and hybrid reach

Not all plans have equal reach across clouds. When selecting plans for a hybrid or multicloud environment, consider:

- **Cross-cloud plans**: Defender for Servers and Defender for Containers extend to AWS, GCP, and on-premises resources through Azure Arc and cloud connectors. These are critical selections for organizations with multicloud compute workloads.
- **Azure-native plans**: Plans like Defender for Storage, Defender for App Service, Defender for Key Vault, and Defender for Resource Manager protect Azure-native services only. Select these based on your Azure workload footprint.
- **Arc dependency**: Workloads outside Azure—on-premises servers, SQL Server instances, and Kubernetes clusters in other clouds—require Azure Arc onboarding before Defender for Cloud can protect them. Factor Arc deployment as a prerequisite when selecting plans for non-Azure workloads.

### Plans with tier choices

Some plans offer multiple tiers. Selection should align with the level of protection needed:

- **Defender for Servers**: Plan 1 provides endpoint detection and response (EDR) through Microsoft Defender for Endpoint integration and agent-based vulnerability scanning. Plan 2 adds agentless scanning, just-in-time VM access, file integrity monitoring, and OS baseline assessment. A common approach is Plan 2 for production and Plan 1 for development.
- **Defender CSPM versus Foundational CSPM**: While CSPM tiers were covered in the previous unit, your CSPM tier choice also affects workload protection—Defender CSPM's agentless scanning capabilities complement CWP plans by providing vulnerability discovery without additional agents.

### Foundational versus workload-specific plans

Some plans protect infrastructure that spans all workloads rather than targeting specific resource types:

- **Defender for Resource Manager** monitors control plane operations for suspicious activity and persistence techniques across the entire Azure subscription.
- **Defender for Key Vault** detects unusual access to secrets, keys, and certificates—compromised vaults can enable broader breaches across many workloads.

These plans operate at subscription level with minimal configuration overhead. Consider enabling them broadly across all production subscriptions as foundational controls, regardless of which workload-specific plans you select.

## Prioritizing plan enablement

When budgets or operational capacity require phased rollout, prioritize plan selection using risk:

| Priority | Selection criteria | Examples |
|----------|-------------------|----------|
| **High** | Workloads processing customer or regulated data; internet-facing resources; environments subject to compliance mandates | Production servers, customer-facing containers, databases with personal data, storage receiving external uploads |
| **Medium** | Internal business workloads; shared infrastructure; environments with copies of production data | Internal applications, development environments with production data copies |
| **Lower** | Isolated environments with test data or no sensitive data; temporary resources; workloads with existing protection | Test environments, ephemeral build agents, resources covered by separate tooling |

Use Defender for Cloud's coverage dashboard to visualize which subscriptions and resource types have protection plans enabled and identify gaps. This dashboard maps directly to your selection decisions and helps track plan rollout across your multicloud environment.

## Integrating workload protection alerts into operations

Selecting plans is only effective if the resulting alerts reach security operations teams:

- **Unified incident management**: Defender for Cloud integrates with Microsoft Defender XDR, surfacing CWP alerts alongside endpoint, identity, and application alerts in a single incident queue.
- **SIEM integration**: Export alerts to Microsoft Sentinel, Event Hubs, or Log Analytics for correlation with other security data sources across your hybrid environment.
- **Workflow automation**: Configure Logic Apps to trigger automated responses—such as isolating a compromised VM or rotating credentials—based on specific alert types.
- **Suppression rules**: Create rules for known false positives to reduce alert fatigue and keep security teams focused on genuine threats.

When designing alert routing, ensure coverage for alerts from all clouds. Workload protection alerts from AWS and GCP connectors flow through the same Defender for Cloud pipeline as Azure alerts, providing a single pane for multicloud threat detection.
