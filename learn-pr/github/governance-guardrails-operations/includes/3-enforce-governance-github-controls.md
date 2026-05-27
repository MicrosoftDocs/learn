Once those boundaries are in place, the next step is making sure they're consistently applied. It isn't enough to define rules—those decisions need to be enforced in a way that can't be bypassed. GitHub provides the controls to turn governance into something concrete, so every action is validated and aligned with your policies.

In this unit, you'll learn:

- What enforcement controls are and how they apply in GitHub
- How to enforce policies using rulesets, checks, and environments
- How to route ownership using CODEOWNERS
- How to implement guardrails and layered enforcement

## What are enforcement controls?

- Rulesets / branch protection
- Required checks
- CODEOWNERS
- Environments
- Guardrail workflows

## How enforcement works in GitHub

GitHub enforces governance by applying rules and controls directly within the development workflow. These controls ensure that agent actions are validated, reviewed, and blocked when they don't meet defined policies.

### Apply rulesets and branch protection

For protected branches such as `main`, enforce:

- PR required to merge
- required checks must pass
- required approving reviews (per risk)
- require CODEOWNERS review (for sensitive paths)
- restrict direct pushes
- block force pushes and branch deletion

Example: PR checks trigger

```yml
on:
  pull_request:
    branches: [main]
```

### Use required checks as validation

Required checks should map to your governance goals:

- build and unit tests (quality)
- security scans (risk)
- policy checks (for workflows/infra changes)

Decision guidance: Treat renaming or removing required checks as high risk. If checks drift, governance drifts

### Route ownership using CODEOWNERS

```
/security/          @security-team
/infra/             @platform-team
/.github/workflows/ @platform-team
*                   @core-team
```

Decision guidance: Make sure "require CODEOWNERS review" is enabled, or CODEOWNERS becomes advisory only.

### Gate deployments with environments

Use environments to:

- require reviewers for production deploys
- restrict production secrets to production environment only
- maintain a clear deployment and approval record

Decision guidance: If a workflow accesses production secrets, treat it as critical risk and gate it.

### Enforceable guardrails for local agent execution (Copilot CLI hooks)

If your organization uses repository-scoped configuration for local agents, enforce deny rules that block dangerous commands before execution.

This turns policy into a technical control, reducing the risk of unintended or destructive actions.

Example: Copilot CLI preToolUse hook that blocks high-risk commands

```json
{
  "hook": "preToolUse",
  "tools": ["shell(bash)"],
  "rules": [
    { "match": "sudo", "permissionDecision": "deny" },
    { "match": "rm -rf /", "permissionDecision": "deny" },
    { "match": "curl .*\\|\\s*bash", "permissionDecision": "deny" }
  ]
}
```

Decision guidance: Use enforceable hooks for blocking. Logging and banners are helpful, but they don't prevent execution.

### Add defense-in-depth workflows

Some organizations add a guardrail check to ensure that:

- Agent-authored PRs can't merge automatically
- Approvals are counted only from human users, not bots
- Review requirements can't be satisfied by automation identities

Example: Guardrail workflow that blocks Copilot-authored PRs and requires human approval

```yml
name: agent-guardrails

on:
  pull_request:
    branches: ["main"]

permissions:
  contents: read

jobs:
  enforce-human-review:
    runs-on: ubuntu-latest
    steps:
      - name: Fail if PR is authored by Copilot agent
        if: ${{ github.event.pull_request.user.login == 'github-copilot[bot]' }}
        run: |
          echo "PRs authored by github-copilot[bot] must be opened/owned by a human."
          exit 1

      - name: Require at least one human approval
        uses: actions/github-script@v7
        with:
          script: |
            const owner = context.repo.owner;
            const repo = context.repo.repo;
            const pull_number = context.payload.pull_request.number;

            const reviews = await github.rest.pulls.listReviews({ owner, repo, pull_number });

            const approvedByHuman = reviews.data.some(r =>
              r.state === "APPROVED" &&
              r.user &&
              r.user.type === "User" &&
              r.user.login !== "github-copilot[bot]"
            );

            if (!approvedByHuman) {
              core.setFailed("Human approval is required before merge.");
            }
```

Decision guidance: This is defense in depth. You still want branch protections and CODEOWNERS, but guardrail workflows can enforce rules that aren't expressible via settings alone.

### Apply layered enforcement model

Governance should operate across multiple layers:

- pre-action constraints (permissions)
- in-action validation (checks)
- post-action traceability (logs, artifacts)

If a control isn't enforced by the platform, it should be treated as optional.

## Why enforcement must be automated

Agents operate at scale and speed. Governance that relies on human behavior alone will fail under these conditions. Enforcement must be built into the system so unsafe actions are blocked before they occur.

> [!Important]
> "Controls in docs only" is an anti-pattern. If the platform can't enforce it, it will be bypassed.

## Key takeaway

Governance in GitHub is enforced through policy, not trust. By combining rulesets, checks, ownership, and environment gates, you ensure that every action is validated and can't bypass defined controls—making agent behavior consistent, auditable, and safe at scale.

Enforcement controls block unsafe actions, but high-risk decisions still require human judgment. Next, you'll design human-in-the-loop workflows.
