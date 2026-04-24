As agents become more capable, it can be tempting to imagine responsibility shifts to the system. It does not. Agentic systems may execute work, but humans remain accountable for outcomes and for the controls that govern execution.

## In this unit, you'll learn

- Who is accountable for agent actions and outcomes 

- What common risks and anti-patterns appear in agent systems 

- How GitHub controls mitigate these risks 

- Why traceability and observability are required for trustworthy systems

## Responsibility does not move with execution

When an agent creates a pull request, revises code, or responds to feedback, it participates in the workflow, but it does not assume ownership of outcomes. The accountable parties are still the people and teams who:

- Defined the task

- Set permissions

- Choose and configured controls

- Approved the resulting change

A pull request review model makes this explicit: the system can propose, but humans decide what is accepted.

## Common risks and anti-patterns

Early-stage agent systems commonly fail in predictable ways:

- Planless execution
 The agent begins changing code without a clear, inspectable approach.

- Over-permissioned agents
 The agent (or its workflow token/tooling credentials) has broader access than necessary.

- Hidden reasoning
 The workflow exposes only outputs (the diff) without intermediate artifacts (plan, assumptions, decision points, execution context).

- Blind trust in automation
 Passing CI matters, but checks only validate what they're designed to detect. A passing build does not automatically mean the change is complete, appropriate, or low risk.

### Implementation mapping: risk → GitHub mitigation

| **Risk / anti-pattern**   | **What it looks like in  GitHub**                   | **Mitigation using  GitHub controls**                        |
| ------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| Planless execution        | PR has a diff but no plan or rationale              | Require a plan section via PR template; require review before merge |
| Over-permissioned agents  | Workflows can write to repo, access secrets broadly | Least-privilege GITHUB_TOKEN; environments with required reviewers; restrict who can trigger workflows |
| Hidden reasoning          | No assumptions/scope/decision trail                 | Require plan and link workflow runs and record decisions in PR comments |
| Blind trust in automation | "CI passed, ship it" mindset                        | Combine checks with CODEOWNERS, required reviews, and risk-based approvals |

## Traceability and observability

To supervise an agent well, you need more than a final diff-you need a trail. In GitHub, that trail can include:

- Pull requests and commit history

- Review comments and approvals

- Workflow runs and uploaded artifacts (test reports, logs)

- Code scanning uploads and alerts

- Secret scanning alerts and push protection events

- Organization audit log events (availability and access depends on org/enterprise configuration)

The goal isn't only compliance. It is operational understanding: when something fails, you need to know what changed, who approved it, what evidence existed, and what happened next.

### Minimum audit trail for agent contributions

- A stated goal (issue link or PR description)

- An inspectable plan (PR plan section or file)

- A bounded change set (branch and commits)

- Automated evidence (workflow run and artifacts)

- Human judgment (review and approval)

- A clear outcome (merge, revert, or escalation)

Suppose the agent's vulnerability fix passes CI but later causes a regression. The key question isn't only whether the agent made a mistake-it's whether the system made the mistake understandable and preventable:

- Was there a visible plan and scope?

- Were the right reviewers requested (and did they approve)?

- Did the checks match the risk of the change?

- Is the audit trail sufficient to reconstruct what happened?

Agentic systems change who performs work, but not who owns outcomes. Human teams remain accountable, which is why they must design against common anti-patterns and require strong traceability through GitHub-native artifacts and logs.

Once you understand how responsibility works, the final step is to decide how agent work should be judged. In the next unit, you'll apply the contributor model to agent-generated output.