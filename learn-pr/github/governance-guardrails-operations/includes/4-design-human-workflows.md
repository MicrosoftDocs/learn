Even with strong controls, there are moments where human judgment is still essential. The goal isn't to add friction everywhere, but to introduce oversight where it matters most. By placing humans at key decision points, you can maintain control over high-impact actions while allowing low-risk work to move quickly.

In this unit, you’ll learn:

- What human-in-the-loop governance is and where it should be applied
- How to design approval workflows for high-risk actions
- How to gate deployments and control execution timing
- How to reduce governance fatigue while maintaining oversight

## What is human-in-the-loop governance?

Agents can generate changes quickly, but human judgment is still required for high-risk decisions. The goal isn't to slow down workflows, but to apply human oversight where it matters.

## How human-in-the-loop workflows work

Human-in-the-loop workflows define how agent-generated work is reviewed, validated, and approved before execution.

- Agent creates PR (including plan and risk level)
- Checks validate changes
- CODEOWNERS auto-requested where necessary
- Merge allowed after approvals/checks

> [!Tip]
> Put humans at decision points (merge, deploy, secret access), not at every step (analysis, formatting, routine checks).

### Gate production deployments

Production deployments should be gated to ensure changes are reviewed and explicitly approved before impacting live systems.

Example: Environment approval for production

```yml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
    steps:
      - run: ./deploy.sh
```

Decision guidance: Production approvals should be explicit, auditable, and owned by accountable roles.

### Prevent overlapping deployments

Production deployments shouldn't overlap. Preventing concurrent deployments reduces race conditions, conflicting releases, and inconsistent system states.

```yml
concurrency:
  group: production
  cancel-in-progress: true
```

Decision guidance: Serialize production deploys to keep release behavior predictable and auditable.

### Apply tool-based approval boundaries

Human approval should be applied selectively:

- low-risk actions (reading, searching) can be automated
- medium/high-risk actions (editing, execution) should require approval

Example: Preserve velocity for read/search while keeping edit/execute approval-gated

```bash
copilot agent run CodeAgent --allow-tool 'read,search'
```

Why this matters: This pattern removes friction for low-risk tools while ensuring high-risk tools remain available but require explicit approval at the time of use.

### Avoid governance fatigue

Governance should be designed to reduce friction, so teams can maintain oversight without slowing down everyday work.

To reduce governance fatigue, focus on practical steps that make review easier and faster:

- require evidence (tests, scans, artifacts) so review is fast
- route reviews via CODEOWNERS so reviewers have context
- keep PRs small and scoped
- require a rollback plan for high-impact changes

## Why human oversight matters

Agents can execute tasks quickly, but they don't carry responsibility for outcomes. Humans provide the judgment needed to evaluate risk, context, and trade-offs—especially for decisions that can't be fully validated through automated checks.

Apply human oversight selectively at key decision points, such as merge, deployment, and access to sensitive resources, rather than throughout the entire workflow. This ensures control without introducing unnecessary friction.

## Key takeaway

Human control should be targeted and intentional. Apply oversight at high-impact decision points—such as merge, deployment, and access to sensitive resources—while allowing low-risk work to proceed automatically. This balance preserves speed without sacrificing accountability or control.

Approvals protect decisions, but permissions define what agents can access. Next, you'll apply least-privilege controls.
