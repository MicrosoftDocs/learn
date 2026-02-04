Organizations operating across hybrid, multicloud, and edge environments face unique challenges in security monitoring. Designing effective monitoring solutions requires a unified approach that extends visibility and control across all environments while optimizing costs and reducing operational complexity.

**Monitoring** focuses on real-time visibility into system health, performance, and security threats. It answers the question "What's happening now?" and enables immediate detection and response. **Logging** focuses on recording events for later analysis, compliance, and forensics—answering "What happened?" These are complementary capabilities, and monitoring solutions may also provide logging capabilities in support of a unified platform. This unit focuses on the real-time monitoring aspects; the next unit covers logging and auditing in detail, including workspace design and data retention strategies.

## Design guidance for hybrid and multicloud monitoring

When designing monitoring solutions for hybrid and multicloud environments, consider these best practices from the Microsoft Cloud Security Benchmark and Cloud Adoption Framework:

- **Establish a primary cloud platform** that serves as your enterprise control plane for consistent management across all environments.
- **Implement unified operations** to maintain one set of tools and processes across cloud providers, reducing duplicated efforts and staffing challenges.
- **Extend governance and operations** using cloud controls that can reach on-premises, multicloud, and edge deployments.
- **Design for data residency and compliance** requirements that may dictate where monitoring data must be stored.

![Diagram that shows how unified operations extends cloud controls to hybrid, multicloud, and edge deployments.](../media/primary-cloud-provider-extended.png)

## Microsoft solutions for hybrid and multicloud monitoring

Microsoft provides an integrated approach to monitoring that extends Azure's capabilities across all environments through Azure Arc and the unified security operations platform.

### Azure Arc as the foundation

Azure Arc extends the Azure platform to manage and govern infrastructure across on-premises, multicloud, and edge environments:

- **Unified resource management** by projecting non-Azure resources into Azure Resource Manager
- **Consistent policy enforcement** using Azure Policy across Azure, on-premises, AWS EC2, and GCP VM instances
- **Centralized monitoring** through Azure Monitor for all connected resources regardless of location
- **Inventory and visibility** with a cloud-based inventory bringing together Azure and hybrid infrastructure

### Azure Monitor for unified observability

Azure Monitor provides comprehensive monitoring for resources across cloud and on-premises environments. While Azure Monitor supports both real-time monitoring and log collection, this section focuses on the monitoring capabilities. Log Analytics workspace design and log retention strategies are covered in the next unit.

| Capability | Description |
|------------|-------------|
| **Metrics** | Collect and analyze numerical performance data from Azure, on-premises, and multicloud sources for real-time visibility |
| **VM insights** | Monitor operating system performance and discover application components across hybrid machines |
| **Container insights** | Use Azure Arc-enabled Kubernetes for consistent monitoring of AKS, AWS EKS, and GCP GKE clusters |
| **Dashboards and workbooks** | Visualize real-time performance metrics and create interactive reports for operational visibility |

The Azure Monitor agent can be deployed to both Azure VMs and Azure Arc-enabled servers, using the same data collection rules across all environments.

### Data collection rules for hybrid environments

Data collection rules (DCRs) define what telemetry to collect and where to send it, enabling consistent monitoring across hybrid and multicloud environments. From a monitoring perspective, DCRs enable:

- **Consistent telemetry collection** - Apply the same collection configuration to Azure VMs, Arc-enabled servers in AWS/GCP, and on-premises machines
- **Real-time data routing** - Stream performance counters and security events to Azure Monitor for immediate alerting and visualization
- **Data transformation** - Filter and transform data before ingestion to focus on security-relevant telemetry

DCRs ensure that security teams have consistent visibility across all environments, regardless of where resources are hosted.

### Alerting for hybrid and multicloud resources

Azure Monitor provides alerting capabilities that work consistently across hybrid environments:

| Alert type | Use case |
|------------|----------|
| **Metric alerts** | Near-real-time alerts comparing collected values to static or dynamic thresholds using machine learning |
| **Log search alerts** | Identify issues by analyzing log data across multiple servers using KQL queries |
| **Activity log alerts** | Monitor Azure resource operations and service health events |

Alerts can trigger action groups to notify teams, run automation runbooks, or invoke Logic Apps for automated remediation.

### Multicloud monitoring with Microsoft Defender for Cloud 

Microsoft Defender for Cloud provides continuous security monitoring across Azure, AWS, and GCP environments:

- **Real-time threat detection** generates security alerts when suspicious activities or threats are detected on workloads across all connected cloud environments
- **Workload protection monitoring** through Defender plans (Defender for Servers, Containers, Databases) that continuously monitor resources for vulnerabilities and attacks
- **Auto-provisioning of monitoring agents** automates deployment of the Azure Arc agent and Azure Monitor agent to AWS EC2 and GCP VM instances, enabling consistent security telemetry collection
- **Security alerts integration** with Azure Monitor and Microsoft Sentinel for centralized alert management, correlation, and response across hybrid environments

### Monitoring AI workloads

Organizations deploying generative AI applications require specialized monitoring. **Microsoft Defender for AI Services** provides real-time threat detection for AI workloads:

| Capability | Description |
|------------|-------------|
| **Prompt injection detection** | Identifies attempts to manipulate AI models through malicious prompts |
| **Jailbreak monitoring** | Detects attempts to bypass AI safety controls |
| **Data leakage alerts** | Monitors for sensitive data exposure through AI responses |
| **Credential theft detection** | Identifies attempts to extract credentials or secrets through AI interactions |

Defender for AI Services integrates with the Defender XDR portal, allowing security teams to correlate AI workload alerts with other security incidents. When designing monitoring for environments with Azure OpenAI or Azure AI Model Inference services, include these AI-specific threat detection capabilities in your security operations architecture.

### Centralized monitoring visibility in the Defender portal

The Microsoft Defender portal provides a unified view of security monitoring data across hybrid and multicloud environments. From a monitoring design perspective, this centralization enables:

- **Single pane of glass** for security alerts from Azure, AWS, GCP, and on-premises resources
- **Correlated incident view** that combines alerts from multiple sources into unified incidents
- **Real-time dashboards** displaying threat detection status across all connected environments
- **Integrated alert management** with alerts from Defender for Cloud, Microsoft Sentinel, and Defender XDR services visible in one location

This centralized visibility eliminates the need for security teams to switch between multiple consoles when monitoring hybrid environments, reducing mean time to detect (MTTD) threats.

> [!NOTE]
> This unit focuses on infrastructure monitoring across hybrid and multicloud environments. Microsoft 365 productivity workloads (email, files, identity, collaboration) have their own monitoring capabilities through Microsoft Defender XDR services, and are covered in [Design solutions for securing Microsoft 365](/training/modules/design-solutions-secure-microsoft-365/). The Defender portal serves as the convergence point where infrastructure and productivity monitoring combine for unified incident correlation and response.

## Architect-level design considerations

### Workspace architecture decisions

As a cybersecurity architect, workspace topology is a key decision that affects both monitoring and logging effectiveness. From a monitoring perspective, consider:

- **Threat correlation** - Security analysts need to correlate events across identities, endpoints, and network traffic. Data in separate workspaces requires cross-workspace queries, which are slower and more complex.
- **Alert context** - When an alert fires, analysts need the surrounding context from related logs. Fragmented workspaces mean analysts may miss critical context during investigations.
- **Detection rules** - Analytics rules and detection logic work most efficiently when all relevant data sources are in the same workspace.

The next unit covers workspace architecture in more depth, including log retention tiers, cost optimization, and compliance considerations.

### Agent deployment strategy at scale

Deploying the Azure Monitor agent consistently across hybrid environments ensures complete monitoring coverage. For non-Azure machines, the Azure Arc agent must be installed first to enable Azure Monitor agent deployment. Design your agent deployment approach based on environment characteristics:

- **Azure Policy with remediation tasks** - Automatically deploy Azure Monitor agent to Arc-enabled servers that don't have it installed. Best for enforcing consistent monitoring across large estates.
- **Defender for Cloud auto-provisioning** - Automatically deploys Arc agent and monitoring extensions to AWS EC2 and GCP VM instances when connectors are configured. Simplifies multicloud onboarding.

> [!TIP]
> Use Azure Resource Graph queries to identify monitoring coverage gaps—resources that are Arc-enabled but missing the Azure Monitor agent or required data collection rules. For sample queries, see [Azure Resource Graph sample queries for Azure Arc-enabled servers](/azure/azure-arc/servers/resource-graph-samples).

### Monitoring coverage and resilience

Plan for scenarios where monitoring agents may be unavailable:

- **Agent health monitoring** - Configure alerts for agent heartbeat failures to detect offline Arc-enabled servers
- **Connectivity requirements** - Arc agents require outbound HTTPS (443) to Azure endpoints; plan network architecture accordingly
- **Graceful degradation** - Azure Monitor agent caches data locally during temporary disconnections and syncs when connectivity is restored

### Network architecture considerations

- Design network connectivity using VPNs, ExpressRoute, or private endpoints for secure telemetry transfer
- Use Azure Private Link for Log Analytics workspaces to keep monitoring traffic off the public internet
- Plan for network latency when determining workspace placement—high latency can affect real-time alerting

## Design considerations summary

| Factor | Consideration |
|--------|---------------|
| **Data residency** | Regulatory requirements may dictate where monitoring data is stored |
| **Latency** | Place workspaces close to monitored resources when performance is critical |
| **Cost** | Balance centralization benefits against egress and ingestion costs |
| **Access control** | Design RBAC to support operational teams across different environments |
| **Scalability** | Plan for growth as more resources are connected across environments |

For organizations with multiple tenants or subsidiaries, Azure Lighthouse enables centralized management while maintaining data sovereignty and compliance boundaries.
