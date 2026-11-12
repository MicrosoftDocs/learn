In the previous unit, you matched local-agent risks to control layers. In this unit, you evaluate what a detection tells you and weigh the scope and impact of each response before you choose one.

## Choose audit or block mode based on detection accuracy

Suppose Contoso is about to turn on Microsoft Defender AI agent runtime protection, which is in preview at time of authoring. Before you decide how to roll it out, you need to know what each mode does when Defender detects prompt injection. Defender offers three modes:

- **Disabled.** Defender doesn't inspect agent activity, so agents run without prompt injection detection or blocking.
- **Audit.** Defender allows the action to continue, records the detection, and still raises an alert. The alert is informational, so your team can review what Defender would have blocked without triaging it as an active threat.
- **Block.** Defender blocks supported actions before they run, notifies the user, and raises an alert. The alert severity reflects the assessed risk.

Accuracy matters most in block mode, because a false positive there interrupts legitimate developer work.

Microsoft recommends a phased rollout that builds this confidence:

1. Enable audit mode on a small set of devices where supported agents are in active use.
2. Review the alerts, and classify inaccurate ones as false positives.
3. Deploy in audit mode to more device groups.
4. Switch to block mode on device groups where you want enforcement, after you validate that alerts are accurate and actionable.

Blocking also has the coverage limits you saw in the previous unit. It applies only where the inspection method and the agent support it, so check the [support matrix](/defender-endpoint/ai-agent-support-matrix) before you assume that block mode protects a given agent. Learn more about [setting up runtime protection](/defender-endpoint/configure-ai-agent-runtime-protection).

## Collect evidence that separates exposure from incident

A detection raises a different question than discovery does. Discovery shows what an agent could reach. A detection shows that something happened. To scope a response, you need both kinds of evidence, and you need to keep them apart.

When runtime protection detects prompt injection, Defender raises a **Suspicious AI prompt injection** alert and correlates related activity into incidents. The alert shows the detection type, severity, affected agent, process tree, and detection details. Your security operations team investigates it with the same workflows as other endpoint detections: timeline review, alert and entity correlation, and response actions. Advanced hunting is also available as an investigation surface, so you can examine the same data beyond the portal views.

| Evidence type | Examples | What it shows |
| --- | --- | --- |
| **Exposure evidence** | Inventory entry, configured Model Context Protocol (MCP) servers, exposure map relationships | What the agent could reach |
| **Incident evidence** | Alert, process tree, affected agent, related entities such as the device, correlated incidents | That Defender detected something |

Together, they support scoping. The alert and its process tree tell you which agent and device the detection involves. The inventory entry tells you which account the agent runs under, and the exposure map and configured MCP servers show which connected resources are within reach. None of this evidence by itself proves that data left the device, so state your conclusions only as far as the evidence supports them.

## Weigh the scope and impact of a response

Responses differ in how many people, devices, and workloads they affect, so compare them by scope before you compare them by strength. Consider three response types.

**Blocking a detected action at runtime.** In block mode, Defender stops the specific action it detected. This response is narrow because it applies per detection. It depends on the inspection method supporting blocking for that agent.

**Blocking agent execution on managed devices.** From the Local agents page in the Microsoft 365 admin center, which is in preview at time of authoring, an administrator can block a supported agent from running. This response applies to managed Windows devices enrolled in Microsoft Intune. The block works through policy that propagates to those devices. Several details limit it:

- Blocking isn't available for every detected agent.
- Some agents share a run type, so blocking one blocks them all. Removing the block on one also removes it for the others.
- Confirm that no legitimate business process depends on those agents before you apply the policy.
- The policy takes time to reach devices. Depending on how Intune is configured, it can take from 15 minutes up to 8 hours.

**Changing access or permissions.** You can remove or narrow access, or apply Conditional Access to the identity involved. This response changes what a user or agent identity can reach, which can also affect legitimate work. Recall from earlier in this module that Conditional Access applies only when the identity requests a token for a resource that Microsoft Entra protects.

A broader execution block isn't the same as selectively remediating one agent instance. Some approaches aim to limit one agent without removing a user's access, but availability varies by product, so confirm it in current documentation before you plan around it. Don't assume that any response leaves a user's access unchanged.

Before you choose a broader response, ask these impact questions:

- Who depends on this agent, and for what work?
- Which devices and other agents does the response reach?
- Can you reverse it, and how long does a change take to apply?
- Is audit evidence adequate, or do you need to enforce now?

> **Reflect:** An alert at Contoso shows a suspicious prompt injection on one developer's laptop, and the agent shares a run type with other agents. Which response would you choose first, and which impact question would change your decision?

## Map responsibilities across the lifecycle and services

Detection and response are two stages in a larger lifecycle. The following table shows where each documented capability fits across five stages.

| Lifecycle stage | Responsibility | Microsoft services involved |
| --- | --- | --- |
| Discover and assess | Find agents and assess their potential reach | Microsoft Defender endpoint discovery and inventory, Global Secure Access agent discovery (in preview at time of authoring), Local agents page in the Microsoft 365 admin center (in preview at time of authoring) |
| Govern and protect | Limit access and inspect agent activity | Microsoft Entra identity and Conditional Access, Microsoft Defender runtime protection (in preview at time of authoring), Microsoft Intune for deploying settings and policies |
| Detect and monitor | Raise alerts and record agent activity | Microsoft Defender alerts, Microsoft Entra logging of agent authentication and actions |
| Investigate | Scope and understand an incident | Microsoft Defender portal incidents, alerts, process tree, and advanced hunting |
| Remediate and recover | Contain the issue and restore normal work | Response actions in Microsoft Defender, execution blocks through an Intune policy from the Microsoft 365 admin center (in preview at time of authoring), access changes in Microsoft Entra |

No single product covers every stage, and coverage and preview status vary, so confirm them in current documentation.

The lifecycle also repeats. What you learn during investigation feeds back into governance and protection, for example by tightening access or moving a device group from audit to block mode. It also feeds back into discovery, because an incident can reveal agents you hadn't inventoried.
