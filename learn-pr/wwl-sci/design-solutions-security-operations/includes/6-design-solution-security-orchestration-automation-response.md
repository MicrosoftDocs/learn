## SOAR overview

SIEM/SOC teams are typically inundated with security alerts and incidents on a regular basis, at volumes so large that available personnel are overwhelmed. This results all too often in situations where many alerts are ignored and many incidents aren't investigated, leaving the organization vulnerable to attacks that go unnoticed.

One way to manage this problem is to automate any recurring and predictable enrichment, response, and remediation tasks that are the responsibility of your Security Operations Center and personnel (SOC/SecOps). This frees up time and resources for more in-depth investigation of, and hunting for, advanced threats.

As a security architect, designing effective SOAR solutions requires understanding the strategic capabilities, integration points, and architectural considerations that enable scalable, efficient security operations across enterprise environments.

## SOAR capabilities in Microsoft Sentinel

Microsoft Sentinel is a cloud-native Security Information and Event Management (SIEM) solution that includes built-in Security Orchestration, Automation, and Response (SOAR) capabilities. These SOAR capabilities include:

- **Automation rules** that centrally streamline incident handling
- **Playbooks** (Azure Logic Apps workflows) that execute predefined sequences of enrichment, containment, and remediation actions

Together, they reduce manual effort and deliver consistent, repeatable response at scale. In the Defender portal, automation rules with incident triggers apply universally across both Microsoft Sentinel and Microsoft Defender XDR incidents, ensuring cohesive and comprehensive incident management.

## Design considerations for SOAR solutions

When designing SOAR solutions for an organization, security architects should evaluate the following key considerations:

### Integration architecture

- **Multi-tenant and cross-workspace deployments** - Design automation that spans multiple Microsoft Sentinel workspaces and tenants, particularly for Managed Security Service Providers (MSSPs) or global enterprises with multiple subsidiaries. Use Azure Lighthouse to enable centralized management while maintaining data sovereignty.
- **Unified operations platform** - Plan for Microsoft Sentinel integration with Microsoft Defender portal for cohesive incident management across both Microsoft Sentinel and Microsoft Defender XDR. Starting July 2026, all customers will use Microsoft Sentinel exclusively in the Defender portal.
- **External system integration** - Consider integration requirements with existing ticketing systems (ServiceNow, Jira), communication platforms (Microsoft Teams, Slack), and third-party security tools through Azure Logic Apps connectors.

### Playbook architecture decisions

- **Logic Apps hosting model** - Choose between Standard (single-tenant, dedicated resources, better performance, fixed pricing) and Consumption (multi-tenant, pay-per-execution) based on scale, performance requirements, and budget.
- **Intellectual property protection** - For MSSPs, determine where playbooks should reside (service provider tenant vs. customer tenant) to protect proprietary automation logic while enabling customer-specific customizations.
- **Reusability and standardization** - Design playbook libraries that can be deployed across multiple workspaces using templates from Content hub to accelerate deployment and ensure consistency.


### Automation strategy

- **Automation scope** - Identify which response activities should be automated versus requiring manual intervention based on risk, complexity, and business impact. Focus on recurring, predictable tasks with clearly defined procedures and low false-positive rates.
- **Governance and control** - Design approval workflows and time-limited automation for high-impact actions to ensure appropriate oversight while maintaining efficiency.
- **Use case prioritization** - Start with high-value, low-risk scenarios that provide immediate operational benefits and build confidence in automation capabilities.

### Automation rules

Automation rules centrally manage incident handling automation and serve as the orchestration layer for SOAR operations. Architects should consider automation rules for:

- **Simple to moderate complexity scenarios** - Tag, assign, or close incidents; create incident tasks; trigger playbooks
- **Multi-rule orchestration** - Apply consistent automation across multiple analytics rules simultaneously
- **Flexible triggering** - Respond to incident creation, incident updates, or alert creation events
- **Temporary automation needs** - Use time-limited automation with expiration dates for planned maintenance or testing periods

Automation rules simplify complex workflows and enable centralized management, making them ideal for standardizing incident response procedures across the organization.

### Playbooks

Playbooks execute complex, multi-step response and remediation workflows based on Azure Logic Apps. Architects should consider playbooks for:

- **Complex automation requirements** - Multi-step workflows requiring conditional logic, external system integration, or custom business logic
- **Reusable response patterns** - Data enrichment, ticketing system synchronization, user notification workflows, and threat containment actions
- **Scalability requirements** - Choose Standard Logic Apps for high-performance, dedicated compute, or Consumption Logic Apps for variable workloads with pay-per-execution pricing

#### Architecture decision: Standard vs. Consumption Logic Apps

| Factor | Standard (Single-tenant) | Consumption (multitenant) |
|--------|--------------------------|----------------------------|
| **Pricing model** | Fixed pricing based on hosting plan | Pay-per-execution |
| **Performance** | Dedicated resources, higher throughput | Shared resources, suitable for variable workloads |
| **Use case** | Consistent high-volume scenarios | Variable or lower-volume scenarios |
| **Private endpoints** | Supported with access restrictions | Not available |
| **Multiple workflows** | Can host multiple workflows per resource | One workflow per resource |

Microsoft Sentinel provides prebuilt playbooks through the Content hub that address common use cases such as data enrichment, bi-directional synchronization with ticketing systems, orchestration of incident management through communication platforms like Microsoft Teams or Slack, and immediate threat response actions.


## Multitenant and MSSP architectural patterns

For organizations managing multiple Microsoft Sentinel workspaces across tenants (MSSPs, global enterprises), consider these architectural patterns:

### Centralized management model

- Service provider maintains automation rules and playbooks in their tenant
- Use Azure Lighthouse for cross-tenant access and management
- Protects intellectual property while serving multiple customers
- Enables consistent automation deployment across customer workspaces

### Distributed deployment model

- Deploy customer-specific automation in each tenant
- Maintains data sovereignty and compliance boundaries
- Simplifies permissions but increases management overhead
- Suitable when customers require full control over automation logic

### Hybrid approach

- Core playbooks centralized in service provider tenant
- Customer-specific customizations in customer tenants
- Balance between IP protection and flexibility
- Use cross-workspace analytics rules and workbooks for unified visibility

## Best practices for SOAR solution design

- **Start with high-value, low-risk use cases** - Automate repetitive tasks with clear decision criteria before tackling complex scenarios. Focus on use cases with well-defined procedures, minimal variation, and low false-positive rates.
- **Design for human oversight** - Include approval steps for high-impact actions such as account disablement or network isolation. Automated response should augment and extend analyst capabilities, not replace human judgment.
- **Plan for scalability** - Design automation that can extend across multiple workspaces and regions as the organization grows. Use standardized naming conventions and deployment templates to facilitate scale.
- **Leverage existing content** - Use prebuilt playbooks and automation rules from Content hub to accelerate deployment. Customize only when necessary to meet specific organizational requirements.
- **Implement governance** - Define ownership, change management processes, and regular review cycles for automation rules and playbooks. Track automation performance and adjust based on metrics.
- **Consider compliance requirements** - Ensure automated actions meet regulatory requirements for documentation, approval, and auditability. Maintain audit logs of all automated actions.
- **Test thoroughly** - Validate automation in nonproduction environments before deployment. Use time-limited automation during initial rollout to minimize risk.
- **Design for reliability** - Implement error handling and notification mechanisms. Ensure automation can gracefully handle failures and provide visibility into issues.
