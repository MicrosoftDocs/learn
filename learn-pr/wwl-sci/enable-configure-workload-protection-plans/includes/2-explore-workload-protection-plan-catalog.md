Contoso Financial Services enabled Cloud Security Posture Management (CSPM) and received a compliance score, but when live attacks occurred against production workloads, no security alerts appeared. The security team realized CSPM evaluates  misconfigurations, but doesn't detect threats during active attacks. Here, you learn the conceptual difference between CSPM and Cloud Workload Protection Platform (CWPP). You explore the full catalog of CWPP plans available in Defender for Cloud, and understand what each plan protects.

## Understand the difference between CSPM and CWPP

CSPM and CWPP serve complementary but fundamentally different purposes in your cloud security strategy. CSPM evaluates your environment's security posture by comparing configurations against compliance standards and best practices—it tells you what's weak or misconfigured. CWPP operates during runtime, monitoring active workloads for threats, detecting malicious behavior, and generating alerts when attacks occur in progress.

Consider a misconfigured storage account with public access enabled. CSPM identifies misconfigured storage as a security recommendation and lowers your compliance score. CWPP monitors that same storage account in real time for suspicious activity—unauthorized access attempts, unusual data transfer patterns, or malware uploads. With CSPM alone, you understand your vulnerabilities but lack visibility into active exploitation.

This distinction matters for Contoso because compliance posture and threat detection require different technical capabilities. CSPM analyzes static configurations through Azure Resource Graph queries. CWPP deploys threat intelligence, behavioral analytics, and machine learning models that process data streams from your workloads continuously. You need both to achieve comprehensive cloud security.

:::image type="content" source="../media/posture-management-workload-protection-relationship.png" alt-text="Diagram showing how CSPM and CWPP complement each other—CSPM identifies misconfigurations and posture gaps, while CWPP detects active threats and generates runtime alerts.":::

## Explore the CWPP plan catalog

Defender for Cloud offers nine CWPP plans, each designed to protect specific Azure resource types with tailored threat detection capabilities. The plans integrate with native Azure platform data, eliminating the need for separate security tools in most scenarios.

| Plan | What it protects | Key threats detected |
|------|------------------|----------------------|
| **Defender for Servers P1/P2** | Azure VMs, Arc-enabled servers, on-premises machines | Fileless attacks, process injection, lateral movement, privilege escalation |
| **Defender for Storage** | Azure Storage accounts (Blob, Files, Data Lake) | Malware uploads, unusual access patterns, data exfiltration, public exposure abuse |
| **Defender for Databases** | Azure SQL, SQL on VMs, open-source databases, Cosmos DB | SQL injection, brute-force attacks, anomalous queries, vulnerability exploitation |
| **Defender for Containers** | AKS clusters, ACR registries, container workloads | Image vulnerabilities, runtime threats, Kubernetes privilege escalation, network attacks |
| **Defender for App Service** | Azure App Service web apps and APIs | Code injection, command execution, dangling DNS takeover, suspicious network connections |
| **Defender for Key Vault** | Azure Key Vault secrets, keys, certificates | Unusual access patterns, anomalous application behavior, credential theft attempts |
| **Defender for Resource Manager** | Azure control plane operations | Lateral movement via Azure Resource Manager (ARM), suspicious resource modifications, privilege abuse |
| **Defender for APIs** | Azure API Management gateways | OWASP API Top 10 attacks, sensitive data exposure, broken authentication, excessive data exposure |
| **Defender for AI Services** | Azure OpenAI Service, Azure AI Model Inference service | Prompt injection, jailbreak attempts, data exfiltration via AI responses, model abuse |

Each plan activates immediately after enablement, with most requiring no agent deployment or configuration changes. Some plans offer tiered options—Defender for Servers provides P1 and P2 tiers with different feature sets, which you explore in detail later in this module.

## Protect compute and infrastructure

Your compute resources represent the most common attack surface because they run application code and process business data. **Defender for Servers** provides the most comprehensive protection, with two pricing tiers that differ in vulnerability assessment, endpoint detection, and response capabilities. You examine these differences thoroughly in the next unit, where you plan and enable server protection for Contoso's workloads.

**Defender for App Service** integrates natively with the platform to monitor web application traffic, API calls, and file operations without requiring agent installation. The plan detects code injection attempts, command execution attacks, and scanning behavior, plus identifies dangling DNS configurations that attackers could exploit for subdomain takeover. Because App Service operates as a fully managed platform, Defender analyzes data at the Azure infrastructure layer rather than within your application code.

**Defender for Resource Manager** monitors the Azure control plane—the API layer where you create, modify, and delete resources. Attackers who compromise an identity with Owner or Contributor permissions often execute lateral movement through ARM template operations. Operations like creating new VMs in different subscriptions or exfiltrating data by modifying resource configurations. This plan detects suspicious patterns in Azure Resource Manager activity, including unusual geographic locations, rare API combinations, and rapid resource provisioning that suggests automated reconnaissance.

**Defender for Containers** protects Kubernetes environments and container registries, detecting threats during image build, registry storage, and runtime execution. The plan scans container images for vulnerabilities, monitors AKS cluster control plane operations, and analyzes runtime behavior inside pods. Container security architecture—sensor deployment, registry scanning configuration, and runtime policy—is a broad subject in its own right; this unit focuses on identifying when to include Defender for Containers in your overall CWPP plan.

## Protect data and services

While compute resources execute attacks, data resources represent what attackers ultimately target. **Defender for Storage** operates at three distinct layers—Activity Monitoring detects unusual access patterns and public exposure events, Malware Scanning analyzes uploaded content for malicious files, and Sensitive Data Threat Detection combines both capabilities with data classification insights. You configure these layers individually to align protection depth with the risk profile of Contoso's storage accounts.

**Defender for Databases** functions as an umbrella plan that activates protection for four database engine types: Azure SQL Database, SQL Server on Azure VMs, open-source relational databases (PostgreSQL, MySQL, MariaDB), and Azure Cosmos DB. The plan detects SQL injection attempts, brute-force authentication attacks, and anomalous query patterns that suggest data exfiltration or privilege abuse. Each database engine receives tailored threat models—SQL injection detection differs between relational and NoSQL systems because the query languages and attack vectors diverge significantly.

**Defender for Key Vault** monitors access to secrets, keys, and certificates stored in Azure Key Vault, detecting unusual access patterns that deviate from normal application behavior. When an identity that typically retrieves one secret suddenly requests dozens, or when access originates from an unfamiliar geographic location, the plan generates alerts for investigation. This protection proves critical because compromised credentials often provide attackers with persistent access to your environment even after you remediate the initial breach.

## Defend APIs and AI workloads

APIs and AI services represent emerging attack surfaces that require specialized protection beyond traditional infrastructure security. **Defender for APIs** integrates with Azure API Management to analyze traffic patterns, detect OWASP API Top 10 vulnerabilities, and classify sensitive data exposed through API responses. The plan uses Cloud Security Graph to understand relationships between APIs, backend services, and data stores, identifying exposure risks that span multiple resources. APIs often expose authentication weaknesses or return excessive data in responses—attacks that CWPP must detect at the protocol level rather than through infrastructure monitoring.

**Defender for AI Services** provides real-time protection for Azure OpenAI Service and Azure AI Model Inference service deployments, addressing threats unique to large language models and generative AI systems. The plan integrates with Azure AI Content Safety Prompt Shields and Microsoft Threat Intelligence. Then detects prompt injection attacks, jailbreak attempts, sensitive data anomalies in model responses, and credential theft targeting AI infrastructure. As organizations deploy AI-powered applications—like Contoso's planned customer-facing financial assistant—these attack vectors become as relevant as traditional server and database threats.

Both API and AI protection plans activate without requiring changes to your application code or API configurations. Defender analyzes data from Azure platform services, applying machine learning models trained on threat intelligence specific to API abuse and AI system manipulation.
