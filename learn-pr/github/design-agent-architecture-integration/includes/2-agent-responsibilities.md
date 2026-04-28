In this unit, you will learn:

- Why mapping agent responsibilities to SDLC stages improves reliability 
- How SDLC stages map to GitHub artifacts and control surfaces 
- Define architectural boundaries for agent behavior to reduce risk and improve auditability

## Why responsibility mapping matters

Agent systems should not operate across the entire SDLC without restriction. When an agent is treated like a general-purpose developer, it becomes difficult to reason about its behavior, limit its impact, or audit outcomes.

A more reliable approach is to map the agent to specific lifecycle stages where GitHub can enforce boundaries. Most teams start by scoping agents to the implementation and validation stages, where pull requests and workflows provide natural control points.

## Mapping SDLC stages to GitHub artifacts

The SDLC can be simplified into planning, implementation, validation, and deployment. Each stage maps to a different GitHub "surface" where work and evidence can be recorded.

| **SDLC stage** | **Typical agent  responsibility in GitHub**                 | **Primary  artifact**                                         |
| -------------- | ----------------------------------------------------------- | ------------------------------------------------------------- |
| Planning       | Draft scope, plan steps, define success criteria            | GitHub Issues, pull request descriptions/comments, Agents tab |
| Implementation | Create branch, make changes, open/update PR                 | Branch, commits, pull request                                 |
| Validation     | Run checks, attach artifacts, iterate on failures           | Workflow runs, checks, artifacts                              |
| Deployment     | Usually restricted; require approvals for sensitive actions | Environments and deployment approvals                         |


## Define architectural boundaries for agent behavior to reduce risk and improve auditability

- Scope early to reduce blast radius: limit which directories an agent can modify by policy and ownership.
- Treat workflow and infra changes as higher risk than application code changes.
- Prefer PR-based work even for automation; avoid direct-to-default-branch changes.

A common design boundary is: agents propose; humans and policy accept. The agent can prepare work and submit it through a pull request, but repository policy and human reviewers decide whether that work is merged or deployed.

## Practical example in GitHub

A dependency remediation agent is scoped to implementation:

1. The agent detects a vulnerable dependency (for example, from a security alert or an issue).
1. The agent creates a branch.
1. The agent updates the dependency and lockfile.
1. The agent opens a pull request that includes a structured plan and expected success signals.

At that point, the agent's scoped responsibility can be considered complete. Validation and acceptance happen through checks, reviews, and policy controls.