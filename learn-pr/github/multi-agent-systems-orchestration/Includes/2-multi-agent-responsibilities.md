A multi-agent system only works well when each agent has a clear role. Without defined responsibilities, agents can overlap, duplicate work, or create conflicting changes. Start by thinking about how work is divided across the system-what each agent is responsible for, where those boundaries exist, and how that work becomes visible and reviewable in GitHub.

In this unit, you'll learn

- How to define responsibility boundaries for agents 

- How to map responsibilities to GitHub artifacts 

- Why clear responsibilities improve reliability

## What are the responsibilities in a multi-agent system

### Why responsibility mapping matters

Multi-agent failures are often predictable. When responsibilities overlap, the system produces duplicated work, conflicting pull requests, and unclear ownership. A strong design prevents these outcomes by assigning each agent a narrow role, limiting scope by path and artifact type, and defining completion signals that can be verified through GitHub checks and review outcomes.

### Responsibility boundary model

In GitHub, it is usually safest to design multi-agent systems around a consistent boundary: agents propose; humans and policy accept. Agents can open pull requests and produce evidence. Repository policy and reviewers determine whether changes can merge.

## How responsibilities are defined and enforced in GitHub

### Map agent responsibilities to SDLC stages and GitHub artifacts

| **SDLC stage** | **Multi-agent  responsibility**              | **GitHub  artifact that makes it reviewable** |
| -------------- | -------------------------------------------- | --------------------------------------------- |
| Planning       | Define goal, scope,  success criteria, risks | PR plan section or PLAN.md                    |
| Implementation | Make changes in an  isolated branch          | branch + commits + PR                         |
| Validation     | Produce evidence and  results                | Actions runs + checks + artifacts             |
| Acceptance     | Apply policy and  human judgment             | CODEOWNERS + reviews  + required checks       |
| Deployment     | Gate high-risk  execution                    | environments +  approvals                     |

For example, the dependency agent updates lockfiles only, while the refactoring agent modifies `src/.` This prevents overlap and reduces conflict.

### Define scope boundaries

A stable starting point is to define "what each agent is allowed to change."

- The dependency agent may modify dependency manifests and lockfiles. It should avoid changing application behavior unless explicitly required to keep changes minimal and reviewable.

- The refactoring agent may modify `src/` but should not modify dependency manifests, lockfiles, or workflows. This prevents refactoring from becoming an unbounded change that collides with other automation.

- The security agent may validate outcomes and produce reports that reference checks and scan results. It may propose changes, but it should not broaden scope into refactoring unless the task is explicitly to fix a security issue in code.

### What happens when responsibilities are not defined

If multiple agents act as general developers across the entire repository, including workflows and infrastructure, it leads to repeated collisions, inconsistent review of routing, and uncontrolled risk.

## Key takeaway

Multi-agent design starts by defining responsibilities that are specific enough to enforce through GitHub-native boundaries.

Once responsibilities are clearly defined, the next step is to coordinate when agents run and how their work is sequenced.
