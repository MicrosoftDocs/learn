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
| **Automation rules** | Centrally manage incident handling—tag, assign, close incidents, create tasks, and trigger playbooks | Incident-trigger rules apply to all incidents (Sentinel and Defender XDR); alert-trigger rules apply only to Sentinel alerts in the Defender portal |
| **Playbooks** | Execute complex, multi-step response workflows using Azure Logic Apps | Triggered from any incident source; can use incident-trigger or alert-trigger based on the scenario |
| **Action Center** | Centralized view of all automated and manual remediation actions with approval workflows | Cross-platform visibility |

### Defender-native automation

Some SOAR capabilities are built into Defender XDR products and operate automatically on alerts from those products:

| Capability | Description | Applies to |
|------------|-------------|-----------|
| **Automated investigation and response (AIR)** | Acts as a virtual Tier 1/Tier 2 analyst—automatically investigates alerts, determines verdicts (malicious, suspicious, or no threats found), and takes or recommends remediation actions | Devices (Defender for Endpoint), email and content (Defender for Office 365), identities (Defender for Identity) |
| **Automatic attack disruption** | Contains active attacks in real-time using high-confidence XDR signals by isolating compromised devices, disabling compromised users, and blocking malicious IP addresses | High-confidence threats including ransomware campaigns and business email compromise detected by Defender XDR correlation |

These Defender-native capabilities complement automation rules and playbooks—they handle immediate, product-specific response while automation rules orchestrate broader workflows.

## Automation rules

Automation rules serve as the orchestration layer for SOAR operations. They support three trigger types:

| Trigger type | When it runs | Use case |
|--------------|--------------|----------|
| **Incident created** | When a new incident is created | Initial triage, assignment, and notification |
| **Incident updated** | When incident status, owner, severity, or other properties change | Escalation, reassignment, synchronization with external systems |
| **Alert created** | When an alert is created by a Scheduled or NRT analytics rule | Responding to alerts that don't create incidents, or when external logic determines incident creation |

Use automation rules to:

- **Tag, assign, or close incidents** without requiring a playbook
- **Automate responses for multiple analytics rules** simultaneously
- **Create incident tasks** for analyst workflows
- **Trigger playbooks** for complex automation scenarios
- **Apply time-limited automation** with expiration dates for testing or maintenance

> [!NOTE]
> In the Defender portal, automation rules with incident triggers run on both Microsoft Sentinel and Defender XDR incidents. Alert-trigger automation rules run only on Microsoft Sentinel alerts. It can take up to 10 minutes from alert triggering to automation rule execution.

## Playbooks

Playbooks execute complex, multi-step response workflows based on Azure Logic Apps. They can be triggered from any incident in the unified portal. Playbooks provide:

- **Integration capabilities** with internal and external systems through Logic Apps connectors
- **Conditional logic** for complex decision-making workflows
- **Scalability** through Standard (single-tenant) or Consumption (multitenant) hosting models
- **Reusable patterns** for common scenarios like data enrichment, ticketing synchronization, and threat containment

### Playbook use cases

| Use case | Description |
|----------|-------------|
| **Enrichment** | Collect data and attach it to an incident so analysts can make better decisions |
| **Bi-directional sync** | Sync incidents with external ticketing systems (ServiceNow, Jira) automatically |
| **Orchestration** | Send notifications to Microsoft Teams or Slack channels for incident awareness |
| **Response** | Take immediate containment actions like isolating devices or blocking users |

### Logic Apps hosting models

| Logic Apps Model | Best for |
|------------------|----------|
| **Standard (single-tenant)** | Consistent high-volume scenarios requiring dedicated resources and predictable pricing |
| **Consumption (multitenant)** | Variable or lower-volume scenarios with pay-per-execution pricing |

### Prebuilt playbooks and templates

Microsoft Sentinel provides playbook templates through Content Hub, the Automation page, and the Microsoft Sentinel GitHub repository. Templates are prebuilt, tested workflows ready for customization—covering the use cases in the previous table. When a new version of a template is published, active playbooks created from that template show an update notification.

## Design considerations for SOAR architecture

### Integration architecture

- **Multitenant and cross-workspace deployments**: Design automation that spans multiple workspaces and tenants. Use Azure Lighthouse for centralized management while maintaining data sovereignty.
- **Unified operations platform**: Plan for Microsoft Sentinel integration with the Defender portal for cohesive incident management.
- **External system integration**: Consider integration with ticketing systems, communication platforms, and third-party security tools.

### Playbook architecture decisions

- **Hosting model**: Choose between Standard and Consumption Logic Apps based on scale, performance requirements, and budget.
- **Permissions model**: Microsoft Sentinel uses a dedicated service account to run playbooks. Grant the **Microsoft Sentinel Automation Contributor** role to the resource group containing playbooks. This service account approach increases security compared to user-based execution.
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
