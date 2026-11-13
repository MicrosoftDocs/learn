---
no_index_ks: true
---

A malicious file runs on a workstation, and a related file server appears in the incident. The investigation needs to show how they connect and whether the server is affected.

## Start with what needs explaining

An alert identifies activity that needs attention. The investigation follows the related evidence to show what happens before and after that activity, which resources are affected, and what requires a response.

Consider fictional incident INC-318. Its alerts include a reported attachment and malicious execution on workstation WS-17. File server FS-03 also appears in the incident, but the initial notes leave its involvement open.

For this incident, the investigation question is: "Did the attachment lead to execution on WS-17, did related activity reach FS-03, and what containment is justified now?" Keep that question with the incident. It gives you something specific to check as findings arrive, rather than accepting a report because it contains a detailed timeline.

The requested answer also guides the workflow:

| Needed outcome | Suitable workflow | Input and boundary |
| --- | --- | --- |
| Classify a supported alert and understand the rationale. | Triage alert, using the Triage Agent. | A supported Defender alert ID. Check the supported alert types. |
| Explain detected activity, related entities, and response needs. | Investigate attack, using the Attack Investigation Agent. | A single Defender alert or incident ID. Prior triage isn't required. |

For INC-318, malicious execution is already evident. Investigate attack fits the need to understand its progression and extent.

If a triage result exists, read its reasoning and the current incident state. The Triage Agent can classify and resolve false-positive alerts. For malicious alerts, it records a true-positive classification and leaves the associated incident open for investigation. Use that result as context for examining the wider attack. Check the supported alert types before choosing triage for other activity.

## Build the account from connected evidence

When you run the playbook, the session records the input, agent work, messages, and outputs. The investigation report brings the findings together, but the references behind its claims show how the agent reaches its conclusions.

For INC-318, the investigation needs to link the delivered attachment to malicious execution on WS-17. Check that the timeline connects those events and records their order.

## Let the evidence establish the affected scope

The investigation starts from one alert or incident. Related evidence can lead to other devices, accounts, or applications, extending the scope as the connections become clear. Follow those connections within the agreed investigation boundaries.

For INC-318, a network sign-in record shows account acct-17 authenticating from WS-17 to FS-03. That confirms authentication to the server. Account activity and server events are needed to explain how the account is used and what happens afterward.

The workstation has confirmed malicious execution, while the server's role still needs investigation. If relevant evidence is unavailable, keep the unanswered question visible and assign follow-up.

In your notes, separate observed activity, possible impact, and missing evidence. The responder needs to know why a resource appears in the report and how much the investigation shows about it.

## Carry the findings into the response

The latest endpoint evidence still shows the malicious process running on WS-17. That finding can justify prompt containment under the approved response procedure while an investigator obtains the missing server evidence.

Treating both devices as compromised could prompt an unnecessary server interruption. Waiting for the entire server investigation could leave the workstation's malicious activity running. Assign the supported response and the unresolved investigation work separately, with an owner for each.

Pair each recommended action with an owner and a completion check. For workstation isolation, that means retaining the action result and confirming containment. The handoff needs to say what is known, what remains open, and who acts next.
