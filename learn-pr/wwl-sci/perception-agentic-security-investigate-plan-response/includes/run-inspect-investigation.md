---
no_index_ks: true
---

As session findings arrive, compare them with the workstation and server questions for the incident. Note what the investigation answers and what still needs follow-up.

## Confirm readiness and start the investigation

In the INC-318 example, the incident is created today, within the agent's 30-day input window. The question is whether a reported attachment leads to malicious execution on WS-17 and whether related activity affects file server FS-03. Use a real incident's ID when applying the procedure in your environment.

The Attack Investigation Agent accepts a single Defender alert or incident ID, not a batch of IDs. Choose the incident when its grouped alerts give the relevant context, or use a relevant alert as the starting point.

Check the input's age. The agent supports inputs up to 30 days old, even when older incidents remain visible in the portal. If the input is older, use a newer related alert or incident if one exists. Otherwise, route the older activity through your organization's investigation process rather than substituting an unrelated recent item.

Review existing investigations before starting another session. Record the question, selected ID, known context, and agreed investigation boundaries with the incident so another responder can follow the work without duplicating it.

With the required services, agent configuration, and account access in place, start the investigation:

- In the Microsoft Defender portal, open Perception > Playbooks, select Investigate attack, and review Required inputs and Agents.
- Select New session, enter the selected incident ID, and select Start session.
- Open the session from Perception > Sessions. Confirm that Inputs contains the intended ID, and add the session ID from Session details to the incident record.

See Work with playbooks in Perception for the session-start controls.

## Inspect progress and answer specific requests

The session chat contains progress updates and a place to ask the agent questions. In Contents, use Tasks to inspect agent activity and Inputs to check the starting input. Some views use Progress for task activity and Artifacts for reports, rather than Tasks and Outputs.

In the INC-318 example, the activity record shows a successful network sign-in from WS-17 to FS-03 using account acct-17. A separate task can't retrieve the server's endpoint activity because the agent lacks access to its device group. The sign-in makes the server relevant, while the failed retrieval leaves its subsequent activity unassessed.

Record the sign-in and failed retrieval together, with their task references. That gives the reviewer both the observed connection and the question that still needs server evidence.

You can also ask about a specific gap in the session chat: "Which evidence connects FS-03 to this incident, and what can you establish about activity on the server?" Check that the answer cites the network sign-in and identifies which server events are available for review.

After you provide guidance or respond to a request, check the agent's answer and confirm that the updated task record shows the requested analysis.

If the session can't retrieve the input, note the exact ID, session reference, and error. Check the input's age and ask the person responsible for agent access to review the relevant workload and scope. Don't change permissions based only on a generic retrieval error. The agent troubleshooting guidance explains the checks.

## Open the report and identify what it answers

In Outputs, select the investigation report to read it, and select Download if you need a saved copy. The report is a Markdown file. Attach its reference and the session reference to the incident so another responder can trace the findings.

Use its sections to locate the answers:

| Report section | Review purpose |
| --- | --- |
| Executive summary and incident verdict | Identify the main conclusion and its rationale. |
| Attack timeline | Trace the proposed progression through events. |
| Affected entities | Check which users, devices, and applications are involved. |
| MITRE ATT&CK techniques and indicators of compromise | Verify the behaviors and indicators behind the analysis. |
| Recommended next steps | Identify proposed containment, remediation, and prevention work. |

Before handing over the report, record which parts of the investigation question it answers and which need follow-up. Link those conclusions to the supporting tasks and evidence.

See Work with a session for the session layout and controls.
