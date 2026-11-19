To connect the adoption goals from the introduction to daily operations, you first examine how ISOC shares signals, context, workflows, and response in Microsoft Defender. The focus is on the capabilities and operating practices that support detection, investigation, and response, rather than placing every task in one screen.

> [!NOTE]
> ISOC is in preview. Capabilities and availability might change during the preview period. Treat current product behavior and requirements as planning inputs that require revalidation before implementation.

## Understand the integrated model

The ISOC model brings together several security operations disciplines:

- **XDR** correlates signals across supported Microsoft Defender workloads and provides investigation and response context.
- **SIEM capabilities** support security operations workflows, data expansion, analytics, and automation.
- **Threat intelligence** adds information that helps teams understand and prioritize threats.
- **Automation** standardizes supported actions and reduces repetitive handling.
- **AI capabilities** support tasks such as generating playbooks from natural-language descriptions.

These capabilities operate through the Microsoft Defender portal, but they don't all have the same prerequisites. Some work with eligible Defender data without an ISOC workspace. Others use an ISOC workspace to support broader data or workspace-based functions.

The [ISOC overview](/defender-xdr/isoc-overview) shows cases, threat intelligence, workbooks, and automation in the Defender navigation. Your plan maps these entry points to team responsibilities while keeping each capability's prerequisites separate.

:::image type="content" source="../media/integrated-security-operations-defender-home.png" lightbox="../media/integrated-security-operations-defender-home.png" alt-text="Screenshot of Microsoft Defender Home with navigation entries for cases, threat intelligence, workbooks, and automation.":::

An integrated tool experience doesn't replace the operating model. Your plan still defines:

- Who owns triage, investigation, response, and platform administration.
- How analysts transfer and escalate work.
- Which response actions require approval.
- How teams record decisions and audit activity.
- Which data each role can access.
- How capability changes move from evaluation to production use.

## Connect capabilities to workflows

Use the existing incident-response lifecycle to identify integration points. For example:

1. **Detect and prioritize:** Determine which supported signals and data sources inform prioritization.
1. **Investigate:** Define how analysts use incident context, cases, evidence, tasks, and workbooks.
1. **Coordinate:** Establish case ownership, service-level expectations, and escalation paths.
1. **Respond:** Identify repeatable actions that are candidates for governed automation.
1. **Improve:** Use outcomes, audit history, and operational metrics to refine detections and workflows.

Case management illustrates this approach. A case can combine investigation context, tasks, evidence, comments, activity history, ownership, and workflow tracking. Incident cases are in preview, while generic cases support other security operations work. Your planning task is to define how the team uses cases consistently, not to reproduce a case configuration procedure.

The Cases page in the [case management guidance](/defender-xdr/siem-defender-case-management) shows incident and generic case tabs, case identifiers, and service-level tracking. Your plan defines who monitors these records and when service-level breaches trigger escalation.

:::image type="content" source="../media/case-management-cases-page.png" lightbox="../media/case-management-cases-page.png" alt-text="Screenshot of the Microsoft Defender Cases page with Incident and Generic tabs, case and incident identifiers, and service-level tracking columns.":::

Workbooks provide another integration point. They use advanced hunting queries to visualize supported security data. Workbooks are saved at the tenant level, but the data a person sees depends on access to the relevant scope and workload. This distinction means dashboard visibility and underlying data access both belong in the operating model.

## Keep people accountable

ISOC includes AI and automation, but accountability remains with the security team. Generated playbooks and automated actions require review, testing, permission design, and operational ownership before production use. Your plan identifies where automation helps, who validates it, how exceptions are handled, and how the team monitors results.

Use the integrated model to reduce disconnected work, but preserve control points for sensitive actions. The result is an operating approach in which shared context supports collaboration and each capability has a defined owner, purpose, and boundary.
