A situation lands on your desk. Identifying the areas of security work involved helps you understand its scope, but doesn't determine the right tool. These three situations help you distinguish work that benefits from focused agent support from work that needs coordination across several capabilities.

## The recognition question

Work through these steps before reading each situation's diagnosis.

1. **Name the objective and areas of work.** What outcome does your organization need? Which of the six areas does the immediate need touch: threat intelligence analysis, alert triage, incident investigation, detection engineering, attack path analysis, posture prioritization?
1. **Assess the execution and coordination needs.** Would agent-supported execution help complete a focused task? Do several capabilities need to pass findings through a connected workflow? Consider the required handoffs, not just the number of areas involved.
1. **Confirm support and feasibility.** Check whether Perception offers a supported agent or playbook for the objective and whether its requirements and authorized scope can be met. For more information, see the [playbook requirements](/security/agentic-security/agentic-security-concepts#playbook).
1. **Choose the response that fits.** Use existing analyst tools, a focused Perception agent or playbook, a playbook that coordinates several capabilities, or a combination. If no supported option meets the need or a prerequisite is missing, use existing workflows or resolve the gap before you run it.

**The number of areas is a clue about scope, not a selection rule.** A single area can benefit from a focused agent or playbook. Several areas don't automatically justify a coordinated playbook. Support, inputs, authorization, and organizational needs are essential parts of the decision.

## Situation one: a new threat actor advisory

A threat intelligence advisory arrives about a previously unnamed state-linked actor observed targeting organizations in your sector. Leadership needs a same-day read on whether the environment is exposed, which specific paths would be exploited if that actor targeted your organization, what should be remediated first, and where detection coverage needs to close.

**Areas of work the situation touches.** Threat intelligence analysis, attack path analysis, posture prioritization, detection engineering. That's four areas of work across all three teams of agents: Blue, Red, Green, Blue.

**Diagnosis.** This objective benefits from coordination because each stage needs the previous stage's findings. The _Protect against a threat_ playbook connects Threat Intelligence Agent, Recon Agent, Posture Prioritization Agent, and Detection Authoring Agent, with security context carrying findings between them. It's a candidate, not an automatic choice because four areas are involved. Before you select it, confirm that it supports the required environment and outcome and that its requirements and authorized scope can be met. Otherwise, address the gap or coordinate the response through existing workflows.

## Situation two: an analyst triaging a specific alert

An analyst is triaging a suspicious sign-in alert on a VIP account. They want a fast summary of the alert stack, a KQL query to check for related activity elsewhere in the tenant, and a read on the account's recent behavior.

**Areas of work the situation touches.** Alert triage. Summarizing the alert stack, running the KQL check for related activity, and pulling the account's recent behavior are all part of the same triage task.

**Diagnosis.** This is a focused triage task, with no stated need for coordination across several capabilities. Existing alert-triage tools are a reasonable choice for the analyst's exploratory work. A focused Perception agent or playbook might also help if its supported scope and outputs match the task, the required inputs are available, and its work is authorized. Don't assume that any focused option supports every requested query or summary. Check its capabilities before you delegate. One area of work doesn't rule out Perception, just as an analyst's involvement doesn't rule out agent support. If the findings require a broader investigation, reassess the objective and coordination needs.

## Situation three: an analyst follows up on a playbook report

Coordinated playbook output and focused follow-up can complement each other. You don't need to force the entire investigation into one execution approach.

The _Protect against a threat_ playbook from Situation one has run. It produced a coordinated report showing two internet-facing applications present the paths the actor exploits. As an analyst reviews the report, they want to dig into one specific investigation subtree, ask follow-up questions about one indicator of compromise, and run an exploratory KQL query for a related pattern the playbook didn't cover.

**Areas of work the situation touches.** The playbook connected four areas of work (threat intelligence analysis, attack path analysis, posture prioritization, detection engineering). The analyst's follow-up focuses on investigating specific findings from the coordinated report, including an indicator and a possible related activity pattern.

**Diagnosis.** Combine coordinated output with focused follow-up. The playbook has completed the connected workflow, and the analyst uses its report as context for further investigation. Existing investigation tools fit the exploratory questions. A supported focused agent or playbook is another option if its capabilities, inputs, and authorized scope match the follow-up. The completed playbook doesn't automatically cover these new questions or require another coordinated run.

## What the recognition practice is for

Before you move into setup and operational guidance for Perception, practice the full decision: name the objective and areas, assess execution and coordination needs, confirm support and feasibility, and then choose the response. The goal is to match supported, authorized work to your organization's needs, not to turn an area count into a tool choice.
