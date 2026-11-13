---
no_index_ks: true
---

Review the fictional incident below to see what the evidence supports and which response actions are justified. No live session or portal access is needed.

## Review the evidence and sample report

Use only the supplied evidence to review this sample report.

The investigation question is: "What malicious activity occurred, which devices are affected, and what response is justified now?"

Evidence record for incident INC-742

All event times use UTC on the same day. The incident was created today. The current review time is 10:10.

| Reference | Evidence |
| --- | --- |
| E1 | At 10:00, a document process on WS-42 starts a script process. The script creates and executes a file that endpoint evidence identifies as malicious. |
| E2 | At 10:02, that malicious process makes an outbound connection. The record includes transferred byte counts, but no file names or transferred content. |
| E3 | At 10:03, WS-42 attempts a remote connection to FS-08. The recorded attempt fails. |
| E4 | The session can't retrieve endpoint activity for FS-08 because the agent lacks access to its device group. No other destination evidence is supplied. |
| E5 | At 10:08, endpoint evidence still shows the malicious process running on WS-42. The response record contains no completed containment or remediation action. |
| E6 | The assigned responder has authority to isolate WS-42 under the approved incident procedure. The device owner confirms it is eligible for that action. |

Session record excerpt

| Session item | Recorded result |
| --- | --- |
| Inputs | Incident INC-742. |
| Tasks | Workstation activity review completes. Server endpoint retrieval fails with a device-group access error. |
| Outputs | An investigation report is available. |

Sample investigation report

> **Verdict**: True positive. Malicious execution is confirmed on WS-42.
>
> **Attack story**: A document process starts a script that creates and executes a malicious file. Initial access and credential impact remain unresolved.
>
> **Data impact**: The outbound connection and transferred byte counts confirm file exfiltration.
>
> **Scope**: WS-42 is affected. FS-08 is unaffected because the recorded remote connection fails.
>
> **Next steps**: Isolate WS-42 under the approved procedure and investigate account impact.
>
> **Response status**: Keep the incident open for containment, remediation, and recovery checks. No completed response action is recorded.

Review the report against the evidence:

- Which findings can be retained, and which claims need correction?
- How should the incident record describe the two devices and the coverage gap?
- Which response should proceed now, and what follow-up is still needed?
- Which session items explain the server coverage, and what should the investigator do next?

## Compare the claims with the evidence

Keep the supported findings and workstation response. Correct the exfiltration and server-impact claims:

| Report claim | Review result | Reason |
| --- | --- | --- |
| Malicious execution occurs on WS-42. | Keep. | E1 and E5 support the finding. |
| A document process starts the script that executes the malicious file. | Keep. | E1 records the process chain. |
| Files are exfiltrated. | Record transferred content as unresolved. | E2 supplies byte counts. Content evidence is needed to identify transferred files. |
| FS-08 is unaffected. | Record it as related, with impact unassessed. | E3 covers one failed attempt. E4 leaves destination activity unavailable. |
| Isolate WS-42 under the approved procedure. | Proceed and verify the result. | E1, E5, and E6 show the threat and authority to act. |
| Keep the incident open for response and recovery checks. | Keep. | E5 records active malicious execution with no completed response. |

Initial access and credential impact remain open, as the report states. Keep those questions in the follow-up alongside the two corrected findings.

The session input confirms that the intended incident was used. The failed server-retrieval task explains the coverage gap, even though a report is available in Outputs. Note the task error, arrange access follow-up, and obtain server evidence before concluding that the server is unaffected.

## Update the response when new evidence arrives

At 10:20 UTC, the investigator receives the following updates. Server endpoint events are now available after the access correction.

| Reference | Event time (UTC) | New evidence or response result |
| --- | --- | --- |
| E7 | 10:06 | Server events record malicious file execution on FS-08 following a separate successful connection from WS-42. This is additional activity beyond the failed attempt in E3. |
| E8 | 10:12 | The responder confirms that isolation of WS-42 succeeds. |
| E9 | 10:18 | A server endpoint update shows the malicious process still active on FS-08. |

Server containment requires approval from the incident lead and a service-impact check with the server owner. Neither is recorded yet.

Update the server's scope description and response priority using the new evidence. What can proceed under the existing authority, and what approval and outcome checks are still needed?

The new execution evidence shows server compromise and moves FS-08 from unassessed to affected. The earlier access gap left its status unknown. Escalate its containment promptly, obtain the required approval and impact check, and assign execution and verification. Record the completed workstation isolation separately. Initial access, credential impact, and transferred content still need follow-up.

## Prepare the incident handoff

Draft a brief handoff using the updated evidence. Include confirmed findings, remaining limits, prioritized actions, owners, approval requirements, and completion checks. Then compare it with the example:

> **Findings**: Incident INC-742 has confirmed malicious execution on WS-42 and FS-08. Workstation isolation succeeds at 10:12 UTC. Server evidence records execution at 10:06 and an active malicious process at 10:18. The incident record links the evidence, session, original report, and subsequent updates.
>
> **Limits**: Initial access, credential impact, and transferred content remain unresolved. Server containment is awaiting approval and a service-impact check.
>
> **Actions and owners**: The incident lead reviews server containment urgently, and the server owner checks service impact. Once approval and the impact check are recorded, the responder executes containment and verifies its result. The investigator continues account and transfer review. The workstation owner and responder arrange remediation and recovery checks.
>
> **Next review**: Check the server approval and containment status promptly through the incident-response process. Confirm the execution result and reassess continuing malicious activity. Keep the incident open for unresolved impact, remediation, and recovery checks.
