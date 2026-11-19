---
no_index_ks: true
---

A session waiting for input needs attention, but approval isn't always the right response. Read what the agent is asking for and why before deciding whether the work should proceed.

## Decide whether proposed work belongs in the investigation

Consider a session investigating possible credential theft:

| Session detail | Available information |
| --- | --- |
| Team request | Investigate suspicious activity involving one account during an agreed time period. |
| Starting evidence | The incident includes suspicious sign-ins for that account. No connection to other accounts has been established. |
| Agent request | Broaden the work to endpoint activity for other accounts, without explaining how they relate to the incident. |
| Authorization | Incident analysis is approved. Changes to accounts or devices require separate authorization. |

Before choosing a response, decide what the agent needs to explain and which work can continue.

Keep the investigation running, but clarify the proposed scope before approving it. Ask which evidence connects the other accounts to this incident. Endpoint activity could be relevant to credential theft, so a different data source isn't, by itself, a reason to reject the work. The missing connection is what needs attention.

If the connection remains unsupported, redirect the work to the account and time period in the request. Ask the agent to explain how any endpoint findings relate to the incident before expanding the analysis.

The investigation is still needed. Before approving a proposal to disable an account or isolate a device, review the evidence, likely impact, and required authorization. Approval to investigate doesn't authorize those changes.

## Use the response options for the request

General approval requests use Approve, Reject, and Suggest an alternative. The Threat Intelligence Agent's initial task plan uses Approve, Deny and redirect, and Ask a question.

For a general approval request:

- **Approve**: Allow proposed work that is justified and within your authority.
- **Reject**: Skip the proposed action while other useful work can continue.
- **Suggest an alternative**: Give specific guidance when the work is needed but the approach needs correction.

To review an initial extraction plan:

1. Open the waiting session from Perception > Sessions and locate the initial plan in the conversation. Check that it addresses the approved article URL, reported indicators, and attacker behaviors.
2. Select Approve if the plan fits the request. Use Ask a question if the plan is unclear, or Deny and redirect if it needs correction. For example, redirect an unrequested protection assessment back to extraction and review.
3. After a question or redirection, read the response or revised plan before approving it. Once you approve a suitable plan, confirm that the session resumes work and the task activity updates.

Record any clarification or redirection that changes what the team can expect from the result. If the agent can't follow the guidance because tools or data are missing, keep that limit with the session notes.

See Approve, reject, or stop agentic work for general requests and Approve the task plan for the extraction plan.

## Stop a session that should no longer run

Stop the session when the work is no longer needed or can't usefully continue, such as when it duplicates completed work or repeatedly fails to make progress:

1. Open the session detail page and select Stop.
2. Read the warning and confirm that ending all ongoing work is appropriate.
3. Select Stop session and confirm the Stopped status.

> [!WARNING]
> Stopping can't be undone. A stopped session can't resume. If the work is still needed and the approach can be corrected, redirect the agent instead.

Leave a note explaining why you stopped the session and who handles any remaining work. If another attempt is needed, start a new session with the corrected input or request.
