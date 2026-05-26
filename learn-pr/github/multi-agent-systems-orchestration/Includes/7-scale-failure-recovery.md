Coordination failures occur when multiple agents or workflows do not progress or interact as intended within the system. These failures can take several forms, including partial execution where tasks do not complete fully, stalled workflows that stop progressing, conflicting pull requests that interfere with each other, and repeated runs that fail to converge. Recognizing these patterns is essential for diagnosing issues and designing systems that can recover safely.

In this unit, you'll learn

- How to identify coordination failures 

- How to diagnose failures using GitHub evidence 

- How to apply recovery strategies such as retry and rollback 

- Why reliable systems are designed for failure

## Multi-agent failures are often coordination failures

Multi-agent systems must be designed to fail safely. Even if each agent is individually capable, the overall system can stall or become unstable when work overlaps, workflows flap, or approvals don’t arrive.

Common failure modes include:

- partial execution (PR exists, but evidence or validation is missing),

- stalled workflows (checks fail repeatedly or approvals never arrive),

- conflicting outputs (PRs compete and block each other),

- flapping (workflows rerun repeatedly with no convergence).

## How failures are diagnosed and resolved in GitHub

A well-designed system is not just capable of running-it is also diagnosable when things go wrong. GitHub provides native artifacts that allow teams to trace failures and understand their causes.

### Diagnose using GitHub-native evidence

A well-designed system can be debugged using:

- PR timelines (what changed and when),

- required check results (what failed and how often),

- workflow run history (patterns of failures and cancellations), and

- artifacts (reports and logs explaining outcomes).

### Apply recovery strategies: bounded retries, rollback, escalation

Reliable systems assume failure and define recovery paths:

- Bounded retries: an agent can revise a PR branch to fix failures, but only within limits to prevent endless loops.

- Escalation threshold: if the same required check fails twice, stop automated iteration and escalate to a human with links and a concise summary.

- Rollback readiness: prefer small, scoped PRs to make rollback safe; revert changes when risk increases.

### Monitor and troubleshoot agent failures in real time

#### Live monitoring of agent sessions

You can live-stream agent session logs using the GitHub CLI:

```bash

gh agent-task view --log --follow

```

Use this command to debug a stalled or long-running agent run in real time.

#### Interpreting policy-blocked actions (preToolUse hook)

If an agent attempt triggers a validation or security block before execution:

```md

Error: Command blocked by policy

Reason: destructive_operation_detected

[agent] Escalating to human review...

```

This pre-execution (preToolUse) hook ensures risky actions, like deleting infrastructure, trigger a human handoff.

### Understand how agent configuration affects orchestration

#### Agent frontmatter: configuration effects

| **Setting**                     | **Effect**                                         |
| ------------------------------- | -------------------------------------------------- |
| disable-model-invocation:  true | Cannot be  invoked as a subagent via orchestration |
| user-invocable:  false          | Not  selectable directly by users in chat/UI       |

A `disable-model-invocation: true` agent cannot be called as a subagent, which can cause orchestration failures.

### Control high-risk execution paths

### Gate high-risk execution with environments

For high-risk actions such as production deployments, GitHub environments provide an approval gate:

```yml

environment:

 name: production

```

#### Allowing Copilot Agent to bypass ruleset protections (when needed)

If Copilot coding agent is blocked by a repository rule (for example, "require signed commits" on protected branches), you can add Copilot as a bypass actor—allowing automation on agent branches but enforcing protection for human users:

Example:

A ruleset enforces signed commits for all pushes. Copilot agent cannot sign commits, so pushes to `copilot/*` branches are blocked. Fix: In the repository's Branches/Rulesets settings, locate your ruleset. Add "GitHub Copilot" as a bypass actor for that ruleset.

This allows Copilot on automation branches while enforcing signed commits for other contributors.

### Coordinate agents through subagents and handoffs

#### Defining, adding, and invoking subagents

To chain agents, specify allowed subagents in the parent agent’s YAML frontmatter and use `handoffs` to invoke them.

```yml

# planner.agent.md

---

agents: [implementer, code-review]

handoffs:

  - label: Start Implementation

    agent: implementer

    send: true

    model: GPT-5.2

  - label: Run Review

    agent: code-review

  prompt: Review the code changes made in the previous step.
```

- `agents`: lists allowed subagents for this agent to orchestrate

- `handoffs`: configures transitions, optionally auto-submitting a prompt (send: true) or using a custom model

- Handoffs resolve to subagents by `name`: attribute in agent YAML or by matching filename.

## Why failure design matters

Failures are not exceptions in multi-agent systems-they are expected. The difference between stable and unstable systems is whether failure is accounted for in the design.

### What happens when systems assume success

A system that assumes success will fail unpredictably. Without defined recovery paths:

- workflows loop endlessly 

- failures compound across agents 

- human intervention becomes reactive 

Designing for success alone leads to fragile systems.

### Why this matters for decision-making

To build reliable systems:

- assume failure at every stage 

- define clear retry limits 

- escalate when automation cannot converge 

- design changes to be reversible 

Failure-aware design improves stability, trust, and long-term operability.

## Key takeaway

Reliable multi-agent systems are built for failure detection, recovery, and safe iteration.

You now have a GitHub-native approach for coordinating multiple agents safely: responsibilities and scope boundaries, event-driven orchestration, isolation, arbitration, observability, and recovery. 