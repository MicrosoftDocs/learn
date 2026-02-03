SIEM and SOC teams are typically inundated with security alerts and incidents at volumes where available personnel are overwhelmed. This results in situations where many alerts are ignored and incidents aren't investigated, leaving organizations vulnerable to unnoticed attacks.

Security Orchestration, Automation, and Response (SOAR) addresses this challenge by automating recurring and predictable enrichment, response, and remediation tasks. This frees up time for more in-depth investigation and hunting for advanced threats.

## Design guidance for SOAR solutions

When designing SOAR solutions, consider these best practices:

- **Start with high-value, low-risk use cases** based on procedures that are clearly defined, with minimal variation, and low false-positive rates
- **Design for human oversight** by including approval steps for high-impact actions such as account disablement or network isolation
- **Use binary decision criteria** to reduce the need for human intervention and enhance outcome predictability
- **Ensure accurate alerts and data** since response actions depend on signal accuracy—use watchlists and reliable threat intelligence
- **Augment analyst capabilities** rather than replacing human judgment for complex tasks

## Unified SOAR in the Defender portal

The Microsoft Defender portal provides a unified SOAR platform that combines Microsoft Sentinel and Microsoft Defender XDR automation capabilities. This integration enables consistent automation across all incident sources from a single interface.

### Unified automation capabilities

| Capability | Description | Scope |
|------------|-------------|-------|
| **Automation rules** | Centrally manage incident handling—tag, assign, close incidents, create tasks, and trigger playbooks | All incidents (Sentinel and Defender XDR) |
| **Playbooks** | Execute complex, multi-step response workflows using Azure Logic Apps | Triggered from any incident source |
| **Action Center** | Centralized view of all automated and manual remediation actions with approval workflows | Cross-platform visibility |

### Defender-native automation

Some SOAR capabilities are built into Defender XDR products and operate automatically on alerts from those products:

| Capability | Description | Applies to |
|------------|-------------|-----------|
| **Automated investigation and response (AIR)** | Automatically investigates alerts and takes remediation actions | Defender for Endpoint, Office 365, Identity, Cloud Apps alerts |
| **Automatic attack disruption** | Contains active attacks at machine speed by isolating compromised assets and blocking lateral movement | High-confidence threats detected by Defender XDR correlation |

These Defender-native capabilities complement automation rules and playbooks—they handle immediate, product-specific response while automation rules orchestrate broader workflows.

## Automation rules

Automation rules serve as the orchestration layer for SOAR operations. In the unified Defender portal, automation rules with incident triggers apply universally across both Microsoft Sentinel and Microsoft Defender XDR incidents.

Use automation rules to:

- **Tag, assign, or close incidents** without requiring a playbook
- **Automate responses for multiple analytics rules** simultaneously
- **Create incident tasks** for analyst workflows
- **Trigger playbooks** for complex automation scenarios
- **Apply time-limited automation** with expiration dates for testing or maintenance

## Playbooks

Playbooks execute complex, multi-step response workflows based on Azure Logic Apps. They can be triggered from any incident in the unified portal. Playbooks provide:

- **Integration capabilities** with internal and external systems through Logic Apps connectors
- **Conditional logic** for complex decision-making workflows
- **Scalability** through Standard (single-tenant) or Consumption (multitenant) hosting models
- **Reusable patterns** for common scenarios like data enrichment, ticketing synchronization, and threat containment

| Logic Apps Model | Best for |
|------------------|----------|
| **Standard (single-tenant)** | Consistent high-volume scenarios requiring dedicated resources and fixed pricing |
| **Consumption (multitenant)** | Variable or lower-volume scenarios with pay-per-execution pricing |

### Prebuilt playbooks

Microsoft Sentinel provides prebuilt playbooks through the Content Hub for common use cases:

- Data enrichment from threat intelligence sources
- Bi-directional synchronization with ticketing systems (ServiceNow, Jira)
- Incident notifications through Microsoft Teams or Slack
- Threat response actions like endpoint isolation via Defender for Endpoint

## Design considerations for SOAR architecture

### Integration architecture

- **Multitenant and cross-workspace deployments**: Design automation that spans multiple workspaces and tenants. Use Azure Lighthouse for centralized management while maintaining data sovereignty.
- **Unified operations platform**: Plan for Microsoft Sentinel integration with the Defender portal for cohesive incident management.
- **External system integration**: Consider integration with ticketing systems, communication platforms, and third-party security tools.

### Playbook architecture decisions

- **Hosting model**: Choose between Standard and Consumption Logic Apps based on scale, performance requirements, and budget.
- **Intellectual property protection**: For MSSPs, determine where playbooks reside to protect proprietary automation logic.
- **Reusability and standardization**: Design playbook libraries that can be deployed across multiple workspaces using Content Hub templates.

### Automation strategy

- **Automation scope**: Identify which response activities should be automated versus requiring manual intervention based on risk, complexity, and business impact.
- **Governance and control**: Design approval workflows for high-impact actions to ensure appropriate oversight.
- **Use case prioritization**: Start with scenarios that provide immediate operational benefits and build confidence in automation capabilities.

## Multitenant and MSSP architectural patterns

### Centralized management model

- Service provider maintains automation rules and playbooks in their tenant
- Use Azure Lighthouse for cross-tenant access and management
- Protects intellectual property while serving multiple customers
- Enables consistent automation deployment across customer workspaces

### Distributed deployment model

- Deploy customer-specific automation in each tenant
- Maintains data sovereignty and compliance boundaries
- Simplifies permissions but increases management overhead

### Hybrid approach

- Core playbooks centralized in service provider tenant
- Customer-specific customizations in customer tenants
- Balances IP protection with flexibility
- Use cross-workspace analytics rules for unified visibility

## Best practices summary

| Practice | Description |
|----------|-------------|
| **Start simple** | Begin with high-value, low-risk automation before tackling complex scenarios |
| **Human oversight** | Include approval steps for high-impact actions |
| **Leverage templates** | Use prebuilt playbooks from Content Hub to accelerate deployment |
| **Implement governance** | Define ownership, change management, and review cycles |
| **Test thoroughly** | Validate automation in nonproduction environments before deployment |
| **Design for reliability** | Implement error handling and notification mechanisms |
