Start by considering what actions an agent should be able to take—and where clear boundaries need to exist. Not all actions carry the same level of risk, and treating them the same can either slow things down or create unnecessary exposure. By grounding autonomy in risk, you create a clear foundation for how agents operate in a safe and predictable way.

In this unit, you'll learn:

- What risk-based autonomy is and why it must be constrained by risk
- How to classify actions and define autonomy levels
- How to enforce risk-based execution using GitHub workflows
- How to scope autonomy through tool access and progressive rollout

## What is risk-based autonomy?

Risk-based autonomy means allowing agents to act within boundaries that match the impact and reversibility of their actions. Low-risk tasks can run automatically, while higher-risk actions require validation, approvals, or stricter controls to prevent unintended consequences.

### Why autonomy must be risk-based

Not all actions have equal impact. Updating documentation is reversible, while deploying infrastructure changes can have system-wide consequences.

Risk depends not only on the action itself, but also on:

- where the change is applied
- how easily it can be reversed
- how quickly it affects users or systems

For example, editing a README file has minimal impact, while modifying `.github/workflows/` affects the entire pipeline.

### Autonomy levels

A useful autonomy model for agentic systems:

- Read-only autonomy: Agent can inspect, summarize, classify, and recommend changes, but can't modify anything.
- Propose-only autonomy: Agent can create branches and pull requests, but can't merge or deploy.
- Execute with guardrails: Agent can run pre-approved workflows (tests, builds, staging deploys) within defined limits.
- Human-authorized execution: Agent can perform high-impact actions only after a human approves (production deploy, workflow changes, secret access).

> [!TIP]
> Autonomy isn't one setting. You’ll usually combine controls across PR rules, environments, workflow permissions, and tool access.

## How risk-based autonomy is implemented

### Risk classification model

| Risk level | Example actions | Recommended control |
| ---------- | ---------- | ---------- |
| Low | docs, formatting | full automation |
| Medium | dependency updates, safe refactors | PR + required checks |
| High | infra changes, workflow changes | CODEOWNERS + explicit approvals + stronger checks |
| Critical | production deploy, production secrets access | environment gate + explicit reviewers + audit evidence required |

Use full automation only when failures are reversible. Require approval when actions are irreversible or affect production systems.

>[!IMPORTANT]
>Treat changes to `.github/workflows/`, `infra/`, and `security/` as high risk by default. These are "small diff, big consequence" areas.

### Implementation: Risk-based execution

When an agent produces a plan with a risk rating, that rating should determine how the system responds.

- Low-risk plans can run automatically
- Medium-risk plans require validation through PRs and checks
- High-risk plans require explicit human approval

This ensures that decisions are enforced consistently and not dependent on interpretation.

Example: Route execution based on plan risk

```yml
name: agent-plan-apply

on:
  workflow_dispatch:

jobs:
  plan:
    runs-on: ubuntu-latest
    outputs:
      risk: ${{ steps.read.outputs.risk }}
    steps:
      - uses: actions/checkout@v4
      - name: Download plan artifact
        uses: actions/download-artifact@v4
        with:
          name: plan
          path: out
      - id: read
        name: Read risk from plan.json
        run: |
          echo "risk=$(jq -r .risk out/plan.json)" >> "$GITHUB_OUTPUT"

  apply:
    needs: plan
    runs-on: ubuntu-latest
    environment: approval-required
    if: ${{ needs.plan.outputs.risk != 'low' }}
    steps:
      - name: Apply agent plan
        run: ./scripts/apply.sh out/plan.json

  apply_auto:
    needs: plan
    runs-on: ubuntu-latest
    if: ${{ needs.plan.outputs.risk == 'low' }}
    steps:
      - name: Apply agent plan (auto)
        run: ./scripts/apply.sh out/plan.json
```

Decision guidance: Don’t rely on narrative explanations of risk. Use a machine-readable signal and enforce routing.

### Scope autonomy through tool access

When using terminal-based agents (such as Copilot CLI), tool access becomes the primary governance boundary.

Read-only actions, such as inspecting the repository state, can be allowed by default. However, write operations, command execution, and privileged actions should remain gated unless explicitly required.

Decision guidance: Match tool access to consequence. Low-risk tasks shouldn't inherit high-risk capabilities.

Example: Low-risk, read-only Copilot CLI task scoped to Git access only

```bash
copilot -p "Summarize the last 10 commits and highlight breaking changes." --allow-tool 'shell(git)'
```

Why this matters: This pattern helps you support read-only analysis (like commit summarization) without granting broad write capability or auto-approving unrelated tools.

### Apply progressive autonomy

Teams often begin with strict controls and gradually relax them as agent behavior proves reliable. This allows autonomy to scale safely over time.

Safe progression example:

- Phase 1: agent can only open PRs, can't merge
- Phase 2: agent can merge low-risk PRs after checks
- Phase 3: agent can deploy to staging automatically
- Phase 4: agent can deploy to production only through environment approval

## Why risk-based autonomy matters

Risk-based autonomy ensures that agent behavior matches the real impact of the actions being performed. It helps prevent high-impact mistakes by gating irreversible or sensitive changes, allows low-risk tasks to run automatically for efficiency, and ensures consistent decision-making by enforcing the same rules across all actions rather than relying on individual judgment.

## Key takeaway

Autonomy must be explicitly defined and constrained by risk. Apply full automation only to low-risk, reversible tasks, and require validation or approval for higher-risk actions. This ensures agent behavior remains predictable, controlled, and safe as systems scale.

Once risk and autonomy boundaries are defined, the next step is to enforce them using GitHub controls.
