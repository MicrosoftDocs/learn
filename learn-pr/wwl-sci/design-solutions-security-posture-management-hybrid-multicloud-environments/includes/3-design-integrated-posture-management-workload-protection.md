Designing an integrated security posture management solution for hybrid and multicloud environments requires architectural decisions that balance coverage, capability, and operational complexity. Microsoft Defender for Cloud serves as the foundation for this design, providing a cloud-native application protection platform (CNAPP) that extends across Azure, AWS, GCP, and on-premises resources.

## Understanding the platform architecture

Before making design decisions, understand what Defender for Cloud provides. The platform combines three capabilities: development security operations (DevSecOps) for code-level security, cloud security posture management (CSPM) for configuration assessment, and cloud workload protection (CWPP) for threat detection and response.

![Diagram that shows the core functionality of Microsoft Defender for Cloud.](../media/defender-for-cloud-pillars.png)

For posture management specifically, you choose between two tiers. Foundational CSPM provides free assessment against MCSB, asset inventory, recommendations, and secure score across Azure, AWS, and GCP. Defender CSPM adds attack path analysis, cloud security explorer, governance workflows, regulatory compliance dashboards, and agentless vulnerability scanning.

## Designing for multicloud coverage

Your first design decision involves defining the scope of coverage. Most organizations operate across multiple environments, and your architecture must account for each.

**For Azure resources**, Defender for Cloud provides native integration with no additional configuration. All Azure subscriptions can enable Foundational CSPM at no cost, giving you immediate visibility into security posture.

**For AWS and GCP**, you deploy cloud connectors that use native APIs to assess resources. Design your connector strategy to match your cloud account structure. In AWS, you can connect at the organization level to cover all accounts, or connect individual accounts for more granular control. GCP supports similar project-level or organization-level connectivity.

**For on-premises resources**, the design becomes more complex. Defender for Cloud requires Azure Arc to project on-premises servers, Kubernetes clusters, and SQL Server instances into Azure for management. This dependency shapes your architecture—you must plan Azure Arc deployment alongside your Defender for Cloud design. A later unit covers Azure Arc integration in detail.

## Choosing the right CSPM tier

The decision between Foundational and Defender CSPM depends on your security requirements and the value of advanced capabilities.

| Consideration | Foundational CSPM | Defender CSPM |
|--------------|-------------------|---------------|
| **Best for** | Organizations starting their cloud security journey, or those with mature processes who need basic assessment | Organizations requiring proactive risk identification and compliance beyond MCSB |
| **Attack path analysis** | Not available | Identifies exploitable paths to critical assets across your environment |
| **Governance workflows** | Manual tracking of remediation | Assign recommendations to owners with due dates and track progress |
| **Regulatory compliance** | MCSB only | Additional standards including PCI-DSS, ISO 27001, SOC 2, and custom frameworks |
| **Agentless scanning** | Not available | Discovers vulnerabilities without deploying agents to machines |

For most enterprise environments, start with Foundational CSPM to establish baseline visibility, then enable Defender CSPM on subscriptions containing critical workloads or sensitive data. This tiered approach optimizes cost while ensuring advanced protection where it matters most.

## Designing the agent strategy

Your architecture must address how you collect security data from compute resources. Defender for Cloud supports both agent-based and agentless approaches.

**Agentless scanning** uses cloud APIs and disk snapshots to assess machine configurations and vulnerabilities without installing software. This approach reduces operational overhead and works well for environments where agent deployment is restricted. However, agentless scanning provides point-in-time assessment rather than continuous monitoring.

**Agent-based collection** through the Azure Monitor Agent or Defender for Endpoint provides richer telemetry including runtime behavior, process execution, and network connections. Agents enable capabilities like just-in-time VM access and adaptive application controls that require real-time interaction.

Design your approach based on workload requirements. Use agentless scanning for broad coverage across development and test environments where operational simplicity matters. Deploy agents to production workloads and systems processing sensitive data where deeper visibility justifies the management overhead.

## Establishing governance and accountability

Beyond technical configuration, your design must address how your organization operationalizes posture management. Consider these architectural elements:

- **Subscription organization**: Structure Azure subscriptions and AWS accounts to align with ownership boundaries. This alignment simplifies assigning security recommendations to the teams responsible for remediation.

- **Role-based access**: Define who can view recommendations, who can remediate, and who can change Defender for Cloud settings. The Security Reader, Security Admin, and Contributor roles provide graduated access levels.

- **Integration with workflows**: Determine how security recommendations flow into your existing remediation processes. Defender for Cloud integrates with Azure DevOps, ServiceNow, and other ticketing systems to create work items automatically.

The following unit explores how to use Defender for Cloud's evaluation features to measure and improve your security posture across this integrated architecture.
