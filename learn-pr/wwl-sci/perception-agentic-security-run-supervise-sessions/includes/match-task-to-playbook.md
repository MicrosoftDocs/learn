---
no_index_ks: true
---

Several playbooks can sound relevant to the same request. Before choosing one, check what the team needs to know and what information you have to start the work.

## Clarify what the team is asking

"Analyze this threat" could mean extracting intelligence from a technical threat report or checking how the threat affects the organization. Those requests need different analysis. Ask which question needs answering before selecting the playbook.

Compare the request with the information needed to answer it:

| Request | Playbook | Expected result | Required input |
| --- | --- | --- | --- |
| Extract useful intelligence from this report. | Extract threat intelligence | Structured threat findings and hunting queries. | A threat intelligence article URL, threat actor profile, or threat intelligence report. |
| Reconstruct what happened in this incident. | Investigate attack | A verdict, timeline, affected entities, and recommended next steps. | A single alert or incident ID from the Defender portal. |
| Show how an attacker could move through this environment. | Identify attack paths | Attack paths, choke points, and remediation recommendations. | An Azure subscription. |
| Tell us what posture issues to fix first. | Plan for posture remediation | A prioritized remediation plan. | None; the playbook uses existing posture signals. |
| Assess how this new threat affects our defenses. | Protect against a threat | Coordinated attack path analysis, posture findings, prioritized remediation, and detection rules. | A threat intelligence article. |

## Check the playbook before choosing it

On Perception > Playbooks, compare the description, required input, and participating agents with the team's request. Confirm that the expected result answers the question without adding work the team hasn't requested.

For extraction from an MDTI article URL, select the Extract threat intelligence row to open its detail pane. Check that Required inputs accepts the article URL and Agents lists the Threat Intelligence Agent. Retain the source reference with the session record.

The distinction depends on the analysis needed, not just the report's contents. Extract threat intelligence can include enriched indicators, environmental relevance, and hunting queries based on available Defender XDR telemetry. Those results can guide further investigation. They don't replace Protect against a threat, which coordinates analysis of exposure, defensive gaps, and recommended protections.

## Choose where to start the session

Use Perception > Playbooks when you want to inspect the workflow before starting. You can also start an applicable playbook from an incident detail page or a Threat intelligence > Threat analytics article when the relevant item is already open.

If you describe the outcome you need in Perception > Chat, review the proposed playbook card and Input selected before selecting Run playbook. A suggested workflow or inferred source still needs to match the request.
