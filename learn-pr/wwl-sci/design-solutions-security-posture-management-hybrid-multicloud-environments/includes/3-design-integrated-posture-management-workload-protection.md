Designing an integrated security posture management solution for hybrid and multicloud environments requires architectural decisions that balance coverage, capability, and operational complexity. An effective design combines multiple components: security frameworks like MCSB for baseline standards, tooling for continuous assessment and protection, and operational processes for governance and remediation. Microsoft Defender for Cloud serves as a central component in this integrated design, providing a cloud-native application protection platform (CNAPP) that extends across Azure, AWS, GCP, and on-premises resources.

## Understanding the Defender for Cloud architecture

When including Defender for Cloud in your posture management solution, understand what capabilities the platform provides. The platform combines three capabilities: development security operations (DevSecOps) for code-level security, cloud security posture management (CSPM) for configuration assessment, and cloud workload protection (CWPP) for threat detection and response.

![Diagram that shows the core functionality of Microsoft Defender for Cloud.](../media/defender-for-cloud-pillars.png)

For posture management specifically, you choose between two tiers. Foundational CSPM provides free assessment against MCSB, asset inventory, recommendations, and secure score across Azure, AWS, and GCP. Defender CSPM adds attack path analysis, cloud security explorer, governance workflows, regulatory compliance dashboards, and agentless vulnerability scanning.

**Design consideration**: Defender for Cloud capabilities are progressively integrating into the unified Microsoft Defender portal. This consolidation brings cloud security posture management alongside endpoint, identity, and other security workloads in a single interface. When designing your security operations, plan for teams to work across both the Azure portal and the Defender portal during this transition. The Defender portal provides a unified view of security posture across your entire digital estate, while the Azure portal remains the primary interface for Azure-specific configuration and resource management.

## Designing for multicloud coverage

A key design decision involves defining the scope of coverage for Defender for Cloud within your integrated solution. Most organizations operate across multiple environments, and your architecture must account for each.

**For Azure resources**, Defender for Cloud provides native integration with no extra configuration. All Azure subscriptions can enable Foundational CSPM at no cost, giving you immediate visibility into security posture.

**For AWS and GCP**, you deploy cloud connectors that use native APIs to assess resources. Design your connector strategy to match your cloud account structure. In AWS, you can connect at the organization level to cover all accounts, or connect individual accounts for more granular control. GCP supports similar project-level or organization-level connectivity.

**For on-premises resources**, the design becomes more complex. Defender for Cloud requires Azure Arc to project on-premises servers, Kubernetes clusters, and SQL Server instances into Azure for management. This dependency shapes your architecture—you must plan Azure Arc deployment alongside your Defender for Cloud design. A later unit covers Azure Arc integration in detail.

## Choosing the right CSPM tier

The decision between Foundational and Defender CSPM depends on your security requirements and the value of advanced capabilities.

| Consideration | Foundational CSPM | Defender CSPM |
|--------------|-------------------|---------------|
| **Best for** | Organizations starting their cloud security journey, or those with mature processes who need basic assessment | Organizations requiring proactive risk identification and compliance beyond MCSB |
| **Attack path analysis** | Not available | Identifies exploitable paths to critical assets across your environment |
| **Governance workflows** | Manual tracking of remediation | Assign recommendations to owners with due dates and track progress |
| **Regulatory compliance** | MCSB only | More standards including PCI-DSS, ISO 27001, SOC 2, and custom frameworks |
| **Agentless scanning** | Not available | Discovers vulnerabilities without deploying agents to machines |

For most enterprise environments, start with Foundational CSPM to establish baseline visibility, then enable Defender CSPM on subscriptions containing critical workloads or sensitive data. This tiered approach optimizes cost while ensuring advanced protection where it matters most.

## Designing the agent strategy

Your architecture must address how you collect security data from compute resources. Defender for Cloud supports both agent-based and agentless approaches.

**Agentless scanning** uses cloud APIs and disk snapshots to assess machine configurations and vulnerabilities without installing software. This approach reduces operational overhead and works well for environments where agent deployment is restricted. However, agentless scanning provides point-in-time assessment rather than continuous monitoring.

**Agent-based collection** through the Azure Monitor Agent or Defender for Endpoint provides richer telemetry including runtime behavior, process execution, and network connections. Agents enable capabilities like just-in-time VM access and adaptive application controls that require real-time interaction.

Design your approach based on workload requirements. Use agentless scanning for broad coverage across development and test environments where operational simplicity matters. Deploy agents to production workloads and systems processing sensitive data where deeper visibility justifies the management overhead.

## Integrating Azure Policy with Defender for Cloud

Azure Policy serves as the enforcement engine that underpins Defender for Cloud's posture assessments. Understanding this relationship helps you design a cohesive solution that uses both tools effectively.

**How the integration works**: When Defender for Cloud evaluates your resources against security standards like MCSB, it uses Azure Policy definitions to perform those assessments. Each security recommendation in Defender for Cloud maps to one or more policy definitions. The MCSB initiative alone contains hundreds of policies covering network security, identity management, data protection, and other security domains.

**Design decisions for policy integration**:

- **Assessment vs. enforcement**: Azure Policy supports both *audit* and *deny* effects. Defender for Cloud uses audit mode by default—it reports noncompliant resources but doesn't block deployment. For critical security controls, consider enabling deny mode through Azure Policy to prevent noncompliant resources from being created in the first place.

- **Custom policies**: When your security requirements extend beyond built-in standards, create custom Azure Policy definitions. Once deployed, custom policies appear in Defender for Cloud alongside built-in recommendations, providing a unified view of compliance.

- **Initiative assignment scope**: Assign policy initiatives at the management group level to ensure consistent coverage across subscriptions. This approach aligns with Defender for Cloud's hierarchical view of your environment.

- **Exemptions**: Both Azure Policy and Defender for Cloud support exemptions for resources that intentionally don't meet a control. Manage exemptions through Azure Policy to maintain a single source of truth, and they'll reflect automatically in Defender for Cloud assessments.

**Complementary enforcement**: Use Azure Policy for preventive controls (blocking noncompliant deployments) and Defender for Cloud for detective controls (identifying existing misconfigurations). This layered approach ensures new resources deploy securely while giving you visibility into resources that predate your policies.

## Establishing governance and accountability

Beyond technical configuration, your design must address how your organization operationalizes posture management. Consider these architectural elements:

- **Subscription organization**: Structure Azure subscriptions and AWS accounts to align with ownership boundaries. This alignment simplifies assigning security recommendations to the teams responsible for remediation.

- **Role-based access**: Define who can view recommendations, who can remediate, and who can change Defender for Cloud settings. The Security Reader, Security Admin, and Contributor roles provide graduated access levels.

- **Integration with workflows**: Determine how security recommendations flow into your existing remediation processes. Defender for Cloud integrates with Azure DevOps, ServiceNow, and other ticketing systems to create work items automatically.

Your integrated posture management solution may also include complementary tools such as Defender External Attack Surface Management for internet-facing asset discovery, Security Exposure Management for cross-domain attack path analysis, and specialized solutions for specific workload types, which are covered in subsequent units. The following unit explores how to use Defender for Cloud's evaluation features, such as Secure Score to measure and improve your security posture across this integrated architecture.
