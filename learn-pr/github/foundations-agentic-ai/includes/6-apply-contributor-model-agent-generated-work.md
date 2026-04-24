A reliable way to evaluate agent output is to stop treating it as categorically different from normal development work. Instead, treat it as a contribution.

## In this unit, you'll learn

- How the contributor model applies to agent-generated pull requests 

- How to evaluate agent contributions using standard development criteria 

- What a high-quality, well-supervised agent contribution looks like

## The contributor model

In GitHub, a pull request is the natural unit of contribution. Whether the author is a human developer or an agent, the pull request should answer the same questions:

- Does the change solve the intended problem?

- Is the scope appropriate and explained?

- Do required checks and validations pass?

- Are the right owners reviewing the affected areas?

- Does the change align with standards, architecture, and policy?

This model avoids two opposite errors:

- Excessive suspicion: rejecting work because "AI wrote it."

- Excessive trust: accepting work because automation produced it.

The contributor model says: evaluate the work by the standards of the workflow, not by the novelty of the author.

### Practical review rubric for agent PRs

When you review an agent PR, check:

- Intent: Is there a clear goal and a visible plan?

- Scope: Are the files changed aligned with the plan?

- Evidence: Do required checks pass? Are logs/artifacts available if needed?

- Ownership: Did the CODEOWNERS review sensitive areas (when configured)?

- Policy: Does it comply with rulesets/branch rules/environments (when configured)?

- Fallback: Is rollback or escalation clear for high-risk changes?

## Evaluating agent-generated pull requests

When the agent submits a pull request, updates a dependency and modifies configuration files under a contributor model; you don't ask only whether the code compiles. You ask whether:

- the extra changes are justified,

- the checks cover the risk introduced,

- the right owners reviewed the affected areas, and

- the change aligns with repository and deployment policies.

## What good looks like

A well-supervised agent contribution is:

- Understandable (clear goal and plan)

- Bounded (scoped changeset, least privilege)

- Reviewable (right owners involved, evidence present)

- Policy-compliant (rulesets/branch rules/environments respected)

- Reconstructable (audit trail supports post-hoc analysis)

This is not a special standard for AI. It's the standard of a healthy engineering workflow applied consistently.

Treating agents as contributors helps preserve engineering discipline. It keeps evaluation grounded in pull requests, checks, reviews, repository policy, and human judgment rather than in hype or fear.