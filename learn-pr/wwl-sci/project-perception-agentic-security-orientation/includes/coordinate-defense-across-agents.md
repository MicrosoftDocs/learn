Triggering a playbook launches several coordinated stages of work with a single click. Understanding what actually happens inside that click is the difference between trusting the output and treating it like a black box.

## A playbook walkthrough: Protect against a threat

A coordinated agent playbook takes a security objective and orchestrates the sequence of work needed to close that objective. The harness passes context and findings from one stage to the next, and each stage runs on the agent built for that kind of work.

The _Protect against a threat_ playbook is the canonical example. When a threat actor advisory arrives, a SOC engineer starts the playbook from Perception, and it runs four stages as one connected workflow:

1. **Threat intelligence analysis.** The Threat Intelligence Agent (Blue) extracts the actor's tactics, techniques, and indicators.
1. **Attack path analysis.** The Recon Agent (Red) reads that intelligence and maps whether the environment presents the paths the actor exploits.
1. **Posture prioritization.** The Posture Prioritization Agent (Green) ranks the resulting findings by real-world risk and recommends remediation order.
1. **Detection engineering.** The Detection Authoring Agent (Blue) writes new rules to close coverage gaps identified along the way.

:::image type="content" source="../media/perception-session-detail.png" alt-text="Screenshot of a Protect against a threat session detail with four agents used and five outputs listed." lightbox="../media/perception-session-detail.png":::

At each stage, the agent for the next stage reads what the previous one produced through security context, without a ticket in between. That's what "coordinated" means in practice.

:::image type="content" source="../media/perception-overview.png" alt-text="Screenshot of the Perception overview dashboard with an agent-activity Sankey diagram from inputs to playbooks to agents." lightbox="../media/perception-overview.png":::

_Protect against a threat_ is the canonical playbook that coordinates across several areas of work. Project Perception also ships playbooks focused on one area of work that dig into it deeply. Both patterns use the same primitives: a specialized agent handling each stage, shared context, and approval gates. The difference is how many areas of work each playbook covers.

The following table shows the two coordination patterns across Project Perception's preview playbook catalog. Each focused playbook concentrates on one area of work you saw in the previous unit.

| Pattern | Example playbooks |
| --- | --- |
| Coordinated across several areas of work | _Protect against a threat_ (four stages, walked through above) |
| Focused on one area of work | - _Extract threat intelligence_ (threat intelligence analysis) <br> - _Investigate incident_ (incident investigation) <br> - _Identify attack paths_ (attack path analysis) <br> - _Assess identity risks_ (attack path analysis, identity-focused) |

## How humans stay in control

Project Perception's agents each specialize in a defined area of work rather than one super-agent doing everything, and each agent operates under a [least-privilege identity](/security/agentic-security/agentic-security-application-card?azure-portal=true#safety-components-and-mitigations) scoped to the minimum permissions its task requires. Attack path analysis needs different access than posture prioritization, and posture prioritization needs different access than alert triage. Agents run at machine speed. Humans stay in control through safeguards built into the workflow rather than a separate governance module:

- **[Approval gates](/security/agentic-security/agentic-security-supervise-work?azure-portal=true).** Pause the workflow before high-impact actions.

:::image type="content" source="../media/perception-sessions.png" alt-text="Screenshot of the Sessions page grouping runs into In progress, Waiting for input, and Completed columns." lightbox="../media/perception-sessions.png":::

- **Least-privilege agent identity.** Each agent runs under its own dedicated Microsoft Entra Agent ID identity with access scoped to what it's built to do, so agent activity is attributable to that agent and not to a human.
- **URBAC prerequisite.** As covered in the module prerequisites, [unified role-based access control (URBAC)](/defender-xdr/manage-rbac?azure-portal=true) across Microsoft Defender workloads is currently required before Perception can be used.
- **Audit logging.** Every agent action is logged.

Project Perception inherits the identity, permission, and audit controls already in use in the Defender portal rather than introducing a parallel governance model.

## Where this leaves you

Playbooks connect specific stages, with specialized agents handling each stage and humans retaining control over critical decisions.

> [!TIP]
> **Before you move on:** Which four stages did the _Protect against a threat_ playbook coordinate, and in what order? If the sequence isn't clear, revisit the numbered list and the diagram.

With the playbook mechanics on paper, the next question is how to recognize which situations call for a coordinated playbook in the first place.
