In this unit, you will learn:

- Discover the evidence and artifacts that are required for agent work 

- How to control tools, MCP integrations, and secrets safely 

- How hooks enforce guardrails and audit logging 

- How to design for reliability using retries, escalation, and least privilege

## Required evidence and artifacts for agents

An agent system must produce visible artifacts for every meaningful action. Without artifacts, you cannot reliably review behavior, debug failures, or perform post-hoc analysis.

In GitHub, observability is achieved through artifacts such as:

- pull requests and PR timelines,

- commits and branch history,

- workflow runs and job logs,

- required checks and scan results, and

- uploaded workflow artifacts (for example, test reports).

### Minimum observability set 

A well-designed agent task should produce visible, reviewable evidence using GitHub-native artifacts:

- a structured plan, typically included in a pull request description or discussion 

- a bounded pull request and commit history 

- workflow run links for required checks 

- uploaded artifacts (for example, logs or reports) 

- review outcomes (approvals or changes requested)

### Upload workflow artifacts for review and debugging

Uploading artifacts makes evidence durable and reviewable, even when logs scroll away.

We recommend the best practice of including links to workflow runs and relevant artifacts in the PR under an "Evidence" section so reviewers can quickly validate outcomes.

```yml
- name: Upload test results
  uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: results/
```

### Reliability assumes failure

Reliable systems assume that failure will occur. Agents will misunderstand tasks, tests will fail, and changes will conflict with existing behavior. Your architecture should detect failures early and provide safe recovery paths.

A practical reliability pattern includes:

- Retries: the agent can update the branch when checks fail.

- Escalation: persistent failures are summarized and handed off to a human.

- Rollback readiness: high-risk changes include rollback notes and scope limits.

### Safe iteration policy 

Use a predictable policy for iteration:

- If a required check fails, the agent may revise the PR branch and rerun checks.

- If the same required check fails twice, escalate to a human reviewer with:

  - what failed,

  - what was attempted,

  - what evidence exists, and

  - what the suggested next step is.

This policy helps prevent infinite loops and makes failures actionable.

### Observability as a required architectural feature

A minimum observability set for autonomous work should include:

- a visible plan artifact,

- a PR + commit history,

- workflow run links for required checks,

- durable artifacts (logs/reports/traces),

- review outcomes and approvals.

### Make evidence traceable to execution and code state

Teach a naming/metadata principle:

- Evidence should be traceable to a specific workflow run and a specific commit.

This helps audits and debugging: you can answer "which run produced this artifact, and against what code state?"

### Share evidence across jobs using artifacts

Teach the pattern:

- Upload artifacts where they are produced

- Download them where they are reviewed or deployed

This keeps outputs inspectable and usable without committing generated files back to the repo.

## How to control tools, MCP integrations, and secrets safely

Agent profile configuration provides three kinds of control:
- Capability boundary: which tools are allowed (prefer allowlists)
- Visibility boundary: whether the agent is user-selectable in interactive UI
- Delegation boundary: which subagents can be invoked and how handoffs occur
  
Design guidance:
- Use read-only toolsets for planning and review agents.
- Restrict implementation tools to execution agents.
- Treat changes to tool allowlists as a governance-sensitive change.

### MCP servers: extend tools safely

MCP servers extend tool capability. Teach these patterns:

- Transport shape: some MCP servers are remote endpoints; others are local processes.
- Authentication: tokens should be injected at runtime via protected secret boundaries.
- Namespace control: prefer enabling a narrow tool subset rather than broad wildcards.

Operational guidance:

- Adding or expanding MCP tools increases blast radius and should be reviewed like a high-risk dependency.

### Secrets and environment constraints (keep secrets out of repo content)

Do not place secrets in:

- instructions files,
- committed configuration files,
- or workflow YAML in plain text.

Instead:

- Use protected secret boundaries intended for runtime injection,
- Pass secrets only to the components that need them,
- Scope secret availability (for example, by environment) to reduce exposure.

Teach the principle:

- "The agent's runtime environment has its own secret boundary; don't assume it automatically inherits repository CI secrets."

## How hooks enforce guardrails and audit logging

In GitHub Copilot agents, hooks are defined as configuration files stored in the repository (for example, under .github/hooks/). Each hook specifies when it runs and what action it performs. 

Hooks execute custom commands at specific points during agent execution. This allows teams to enforce policies, validate actions, and capture audit data automatically. 

A simplified example:

```json
{
  "name": "block-high-risk-command",
  "trigger": "pre-tool-use",
  "run": "if [[ \"$TOOL\" == \"delete\" ]]; then echo 'Blocked unsafe command'; exit 1; fi"
}
```

### How this works

- The hook runs before a tool is executed (pre-tool-use) 

- It inspects the requested action 

- If the action matches a blocked pattern, execution is stopped 

### Common hook patterns

- **Pre-action hooks**
  Validate or block unsafe actions before execution 

- **Post-action hooks**
  Log tool usage, outputs, or decisions for auditing 

- **Error hooks**
  Capture failures and trigger escalation or alerting 

### What hooks enable

- Enforcing security policies (for example, blocking unsafe commands) 

- Adding audit logs for compliance and debugging 

- Integrating with external systems (alerts, monitoring, approvals) 

- Hooks provide enforceable control points that operate independently of the model's reasoning. Instead of relying on instructions, they ensure that certain rules are always applied during execution.

## How to design for reliability using retries, escalation, and least privilege

As we spoke about earlier, agents will eventually fail, but we can build systems that can catch these failures and ensure human intervention catches it, for example here are a couple of ways to ensure failures are caught:

- Bounded retries for transient failures

- Escalation paths for repeated failures

- Rollback readiness for high-risk changes

- Least-privilege permissions to reduce blast radius

### Rollback-safe pattern to teach:

- Operate on explicit references (commit/tag) when deploying sensitive configuration, rather than "latest on a branch."

### Least privilege reminder:

- Restrict workflow permissions by default and elevate only where needed.

### Least-privilege workflow permissions

Least privilege reduces risk when something goes wrong. It also prevents over-permissioned automation from becoming an architectural vulnerability.

```yml
permissions:
  contents: read
  pull-requests: write
```

This configuration allows automation to read repository content and update PR context (comments, statuses) while preventing broad write access by default.
