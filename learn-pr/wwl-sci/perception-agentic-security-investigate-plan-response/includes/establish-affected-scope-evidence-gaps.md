---
no_index_ks: true
---

The incident lists a workstation, a file server, and an account. Before planning the same response for all three, check why each appears and what the investigation shows about it.

## Separate affected entities from investigation leads

In the INC-318 example, endpoint evidence confirms malicious execution on WS-17. A network sign-in record shows account acct-17 authenticating from that workstation to FS-03. The server's endpoint activity remains unavailable.

The workstation is affected by observed malicious activity. The sign-in makes the account and server relevant to the investigation. Use account activity and server events to assess credential impact and execution on the server.

Record these relationships in the incident notes so the responder can see why a device needs containment or further investigation:

| Scope description | Evidence needed | Response implication |
| --- | --- | --- |
| Affected by observed malicious activity. | Events show the relevant execution, access, or change. | Evaluate containment or remediation for that entity. |
| Related and requiring investigation. | A relevant relationship exists, but impact isn't established. | Assign the specific evidence check needed. |
| Unassessed because evidence is unavailable. | A required source, time period, or resource isn't covered. | Record the gap and arrange access or another investigation route. |

These are descriptions for your investigation notes, not additional Perception verdict values. Preserve the agent's actual classifications separately.

For FS-03, the incident notes could read: "Account acct-17 authenticates from WS-17. Server activity after the sign-in is unassessed because the required endpoint events are unavailable." Here, unassessed means the activity couldn't be examined. The question of server impact remains unresolved, and the report's claim of server compromise is unconfirmed.

## Distinguish absent findings from absent coverage

Before accepting "No malicious process is found on FS-03," check what the agent could inspect:

- The products and workloads supplying the evidence.
- The accounts, devices, and applications included in scope.
- The time period covered by the available events.
- The failed or unfinished tasks that affect the question.

In this example, the agent lacks access to the server's Defender for Endpoint device group. Record FS-03 as unassessed and arrange the evidence review. Keep the confirmed WS-17 finding in the response plan.

Keep negative findings bounded: "No further matching activity is found in the reviewed endpoint events for the stated period." Avoid "No other resources are affected" unless the assessed scope and evidence justify that conclusion.

## Turn each consequential gap into follow-up

Give the next investigator a specific task: the question to answer, the evidence to obtain, and the response that depends on the result.

For INC-318, the gap record could read:

> **Question**: What activity follows the successful sign-in to FS-03, and does it show malicious execution?
>
> **Missing evidence**: Server endpoint events for the incident period aren't available to this session.
>
> **Owner**: The investigator obtains the server events. The administrator managing agent access checks the scope assignment.
>
> **Response affected**: Server containment remains under review. Prompt workstation containment can proceed under the approved procedure.

One person can handle both tasks. Record who takes responsibility for each.

Once access is corrected, obtain new server evidence, record what happens after the sign-in, and update the server's entry in the incident notes and response plan. Assign a separate review of acct-17 activity to assess account impact and any account-specific response needs.

Escalate time-sensitive gaps through the incident-response process. A connection from a device with active malicious execution makes FS-03 urgent, and its impact stays unassessed until the new evidence is reviewed.
