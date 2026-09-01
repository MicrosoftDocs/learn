A situation lands on your desk. Experienced analysts already ask which areas of work a situation touches, even if they don't phrase it that way. **Name the areas of work the situation touches and count them. That's how you recognize whether a coordinated playbook is the right response.** Practicing that skill on three situations, each drawn from a real pattern SOCs see week to week, is what turns the framework into a working reflex.

## The recognition question

Work through these steps before reading each situation's diagnosis.

1. **Name the areas of work.** Which of the six does the immediate need touch: threat intelligence analysis, alert triage, incident investigation, detection engineering, attack path analysis, posture prioritization?
1. **Count them.** One area with an analyst inside it, several areas that need coordination, or a coordinated playbook running with a single analyst also working inside one of the areas?
1. **Pick the likely shape.** Work that stays inside one area (handle it inside your existing tools), a coordinated playbook across several areas (a Project Perception playbook), or both at once.
1. **Confirm an available agent or playbook supports the objective.** Check the **Playbooks** page in Perception to confirm one covers the objective and the work involved.

Once you name the areas, the likely shape usually becomes clear.

## Situation one: a new threat actor advisory

A threat intelligence advisory arrives about a previously unnamed state-linked actor observed targeting organizations in your sector. Leadership needs a same-day read on whether the environment is exposed, which specific paths would be exploited if that actor targeted your organization, what should be remediated first, and where detection coverage needs to close.

**Areas of work the situation touches.** Threat intelligence analysis, attack path analysis, posture prioritization, detection engineering. That's four areas of work across all three teams of agents: Blue, Red, Green, Blue.

**Diagnosis.** Coordinate across the four areas. The value isn't any single area running well. It's the four running as one continuous workflow with the handoffs closed. This is what the _Protect against a threat_ playbook is built for: Threat Intelligence Agent, then Recon Agent, then Posture Prioritization Agent, then Detection Authoring Agent, with security context carrying findings between them.

## Situation two: an analyst triaging a specific alert

An analyst is triaging a suspicious sign-in alert on a VIP account. They want a fast summary of the alert stack, a KQL query to check for related activity elsewhere in the tenant, and a read on the account's recent behavior.

**Areas of work the situation touches.** Alert triage. Summarizing the alert stack, running the KQL check for related activity, and pulling the account's recent behavior are all part of the same triage task.

**Diagnosis.** Work that stays inside one area. This is one analyst inside alert triage doing what alert triage always involves: reading the alert stack, following one related lead, understanding one account's behavior. That's the shape you handle inside your existing alert-triage tools, not with a coordinated playbook. The Security Alert Triage Agent could also work autonomously inside alert triage, but the situation describes an analyst in the driver's seat on one specific alert, not an autonomous agent classifying a queue. If the triage finding later escalates into a broader investigation across areas, that's a different situation.

## Situation three: a playbook running while an analyst digs into a finding

This third shape looks like the first two combined, but it's a distinct category. Coordinated playbook output and single-analyst work regularly run alongside each other in real investigations. Without naming this shape, you'll try to force real situations into one of the first two and mis-diagnose.

The _Protect against a threat_ playbook from Situation one has run. It produced a coordinated report showing two internet-facing applications present the paths the actor exploits. As an analyst reviews the report, they want to dig into one specific investigation subtree, ask follow-up questions about one indicator of compromise, and run an exploratory KQL query for a related pattern the playbook didn't cover.

**Areas of work the situation touches.** The playbook connected four areas of work (threat intelligence analysis, attack path analysis, posture prioritization, detection engineering). The analyst's manual follow-up sits inside incident investigation, where digging into subtrees, chasing indicators, and crafting exploratory queries are all normal tasks.

**Diagnosis.** Both at once. Project Perception is coordinating across those four areas through the playbook. The analyst is working inside incident investigation, which is one area, using whatever incident-investigation tools they normally rely on. This is the normal shape of a mature SOC investigation: a coordinated playbook running while an analyst works inside one area by hand. The playbook's coordination doesn't replace the inside-one-area work. The two run alongside each other.

## What the recognition practice is for

Before you move into setup and operational guidance for Perception, run the recognition against what's in front of you. Name the areas of work, count them, pick the likely shape, and confirm an available agent or playbook supports the objective. The right response usually falls out of the diagnosis.
