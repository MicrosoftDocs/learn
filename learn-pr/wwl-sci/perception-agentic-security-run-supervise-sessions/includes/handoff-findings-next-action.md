---
no_index_ks: true
---

The review is finished, but the next person needs more than a link to the report. Leave enough detail to show which findings can be used, what is still unresolved, and who takes the next action.

## State what the findings support

State how the team can use the findings you checked. Source-reported indicators might be ready to use as investigation leads, for example, but they don't justify containment. Avoid a blanket statement that the report is "ready to use."

Make unresolved work actionable. Say what needs correction or further evidence and name who handles it. If the review raises a new security question, obtain approval for the additional scope before starting that work.

## Leave a clear handoff

Record the handoff in the team's existing case, ticket, or shared work record. Include:

- Original request.
- Session and relevant output references.
- Findings checked and what they support.
- Remaining questions or limits.
- Next action and owner.

For extraction, link the article URL, session, and report. State whether the checked findings support investigation leads or require further review, and assign an owner to unresolved work.

For the fictional Cedar Example report, a handoff could read:

> Reviewed Training article A using Extract threat intelligence to identify indicators and attacker behaviors. The download URL matches the source. Attribution remains provisional.

- **Use**: The source-reported download URL is an initial investigation lead. Keep its source reference.
- **Limits**: Behavior analysis is incomplete because the report omits the PowerShell behavior. The report provides no evidence of the organization's protection.
- **Exclude**: The additional domain and protection claim have no supporting evidence.
- **Next action**: The threat intelligence analyst checks the source and relevance of the additional domain and resolves the missing technique analysis. The security operations lead decides whether a wider protection assessment is needed.

An incident handoff might instead highlight a checked timeline, missing device evidence, and the person collecting that evidence. A posture handoff might identify recommendations ready for planning and resources that couldn't be assessed. Include what the next person needs to proceed without treating incomplete analysis as complete.

If no further action is needed, record why and note any remaining limits.
