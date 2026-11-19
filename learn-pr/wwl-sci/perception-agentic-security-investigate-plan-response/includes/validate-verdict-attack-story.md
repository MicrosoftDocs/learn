---
no_index_ks: true
---

The report connects a delivered attachment to malicious execution on a workstation, then describes activity involving a file server. Check the evidence behind those connections to identify the findings ready for response and the questions needing more investigation.

## Check the reasoning behind the verdict

In the INC-318 example, the report gives a true-positive verdict and describes activity on workstation WS-17 and file server FS-03. Find out which findings justify containment and which need further evidence.

The Attack Investigation Agent report includes a verdict such as true positive, false positive, or benign, with supporting reasoning. Use the session and report together to review claims that affect the response:

- Open the investigation session from Perception > Sessions. In Contents > Tasks, review completed work, failures, and unavailable evidence.
- In Outputs, open the investigation report and locate Incident verdict. Read the verdict and its rationale.
- In Attack timeline, choose a claim that affects the response and inspect its supporting evidence. Compare entities, timestamps, time zones, and the events linking one activity to the next.
- If a connection is missing, ask about it in the session chat. Inspect the answer and any supporting references, and retain unanswered questions for follow-up.
- Record the checked finding, its evidence references, and any remaining uncertainty in the incident notes. Keep the session and report references with that review.

The session guide describes the controls, and the Attack Investigation Agent documentation describes the report sections and required accuracy review.

A false-positive or benign verdict also needs an explanation that accounts for the suspicious events. To accept an administrative task as the explanation for a command, check that its task record, actor, device, and timing match the observed activity.

## Trace connections through the timeline

For INC-318, check the attachment-to-execution link and the reported spread to the server.

Example evidence for INC-318

All times use UTC on the same day.

| Reference | Recorded observation |
| --- | --- |
| E1, 09:12 UTC | An attachment is delivered to an employee's mailbox. |
| E2, 09:18 UTC | File-open evidence links the attachment from E1 to a document process on WS-17. That process starts a script that creates a file. |
| E3, 09:19 UTC | The new file runs on WS-17; endpoint evidence identifies it as malicious. |
| E4, 09:21 UTC | A network sign-in record shows successful authentication from WS-17 to FS-03 using account acct-17. |
| E5 | Endpoint activity for FS-03 is unavailable to this investigation. |
| E6, 09:26 UTC | The latest endpoint update still shows the malicious process running on WS-17. |

A sample report concludes: "The malicious attachment leads to execution on WS-17. Credential theft enables lateral movement and malicious execution on FS-03."

Which parts of the claim are supported by the evidence, and which remain unresolved?

The first part is supported. E2 links the delivered attachment to the document process, and E3 records the resulting malicious execution. The evidence connects the events directly instead of inferring a link from timing.

A successful sign-in confirms authentication to FS-03 using acct-17. Showing how credentials are obtained or what runs on the server requires account and server evidence. E5 records the server's endpoint activity as unavailable, so those parts of the attack story remain open.

A checked summary is: "The delivered attachment leads to malicious execution on WS-17, where the process remains active at 09:26 UTC. Account acct-17 authenticates from WS-17 to FS-03. Credential theft and malicious execution on the server remain unconfirmed."

The confirmed workstation execution justifies prompt containment. The claim of wider compromise still needs server and account evidence.

## Follow up claims that need more evidence

Ask about the specific unsupported transition in the session chat: "Which evidence shows malicious execution on FS-03 after the network sign-in? If server activity is unavailable, state what still needs examination."

Use the answer's references to check whether it adds relevant account or endpoint evidence. If the source remains unavailable, record the open question and arrange server review through the incident process.

Apply the same checks to MITRE ATT&CK mappings and indicators of compromise. A technique label should match the observed behavior. Use indicator enrichment as context, then check the environment events to establish where the indicator appears and what activity accompanies it.

Retain the original report and record reviewed corrections separately in the incident notes or handoff. Confirm any needed incident-classification change through the incident-management process.
