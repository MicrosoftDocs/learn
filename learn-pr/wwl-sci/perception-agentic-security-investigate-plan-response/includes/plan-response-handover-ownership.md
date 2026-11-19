---
no_index_ks: true
---

The next responder needs to know which action comes first, who handles it, and how to check the result.

## Prioritize actions by what they address

For INC-318, start with the active malicious process on WS-17. The assigned responder has authority to isolate the workstation under the approved procedure, and the device owner confirms it is eligible. Containment can proceed while an investigator checks the related server and account.

The Attack Investigation Agent's recommendations cover containment, remediation, and prevention. Use those purposes to organize the work:

- Containment limits continuing harm or spread.
- Remediation addresses the compromise or condition that enables it.
- Prevention reduces the likelihood or impact of similar activity.

Use the server and account review to assess whether further containment is needed. If the incident procedure calls for containment before compromise is confirmed, record the risk being addressed and who approves the action.

For any action involving acct-17, state the evidence and risk it addresses. That gives the person approving or executing the action a clear basis for reviewing its target and impact.

## Specify actions that someone can carry out and verify

A recommendation such as "isolate the affected devices" leaves the responder to decide which devices and why. Make the action specific enough to carry out:

- **Target and purpose**: The entity and the harm or condition the action addresses.
- **Evidence**: The finding and reference supporting the action.
- **Owner**: The person responsible for execution and follow-up.
- **Authority and impact**: Required approval and relevant service consequences.
- **Completion check**: The result that demonstrates the action ran and achieved its intended outcome.

For INC-318, a compact plan keeps immediate containment and evidence collection visible:

| Priority and purpose | Evidence and target | Ownership and checks |
| --- | --- | --- |
| Urgent containment. | Active malicious execution on WS-17. | The responder isolates the device under the approved procedure and verifies the recorded result. |
| Urgent scope follow-up. | Successful sign-in to FS-03; server endpoint events unavailable. | The investigator reviews server and account activity and reassesses response needs. |
| Remediation and recovery. | Confirmed malicious execution on WS-17. | Device owner and responder agree on cleanup or rebuild and the checks required before return to service. |
| Prevention follow-up. | The attachment-to-execution chain on WS-17. | The investigator and relevant control owner review why the attachment reaches execution. The control owner identifies any needed changes and verifies their effectiveness. |

If an agent requests approval for an action during a session, review its target, rationale, and impact before responding. Limit approval to that request, then verify the execution result through the task and operational evidence.

## Hand over findings and open decisions

Use the existing incident record to hand over the reviewed findings. Include the incident, session, and report references so another responder can trace the evidence without relying on a copied summary.

State which actions are proposed, approved, underway, completed, or awaiting verification, and which remain for the next responder.

For INC-318, a handoff before response execution could read:

> **Findings**: The delivered attachment leads to malicious execution on WS-17, still active at 09:26 UTC. Account acct-17 authenticates from that workstation to FS-03.
>
> **Limits**: Server endpoint activity is unavailable to this session. Malicious execution on FS-03 and credential theft remain unconfirmed. The incident record links the evidence, session, and original report.
>
> **Actions and ownership**: The responder isolates WS-17 under the approved procedure and records the result. The investigator checks server and account activity. The administrator managing agent access arranges correction of the server's device-group access gap.
>
> **Next review**: Check the workstation isolation result as soon as the action completes. Update the server and account response decisions when the missing evidence is reviewed. No response completion is recorded at this handoff.

## Check response outcomes before incident closure

After the responder isolates WS-17, check the action result and any continuing malicious activity. Add the verified outcome to the incident record.

Record failures or partial results and assign follow-up. If an action is submitted but remains pending, keep that status visible rather than marking containment complete.

For Defender device actions, review the action details in Action center and retain the result with the incident. See Take response actions on a device for the action controls, requirements, and activity review.

Keep open any consequential scope or impact question that still blocks the closure criteria in your incident-response process.
