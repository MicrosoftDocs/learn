In this unit, you'll learn:

- How pull requests act as architectural control points for agent execution 

- How to enforce plan validation with required checks status checks

- How to use CODEOWNERS and reviews to route and approve changes 

### Pull requests are architectural control points

Pull requests are the primary control mechanism for agent execution in GitHub. Instead of allowing direct changes to protected branches, well-designed architectures route agent changes through pull requests and enforce merge requirements through policy.

A common safe workflow looks like this:

Agent creates branch

    ↓

Agent opens pull request (includes plan)

    ↓

Required reviews validate approach

    ↓

GitHub Actions run required checks

    ↓

All checks pass + approvals complete

    ↓

Pull request can be merged

This structure ensures that execution is gated by both automation and human review.

## Implementation: PR template that requires a structured plan

A pull request template ensures that every agent PR provides consistent plan and evidence sections.

```md
<!-- File: .github/pull_request_template.md -->

## Plan (required)
- **Goal:**
- **Scope (paths/files):**
- **Steps:**
  1.
  2.
  3.
- **Success criteria (verifiable):**
  - [ ] Required checks pass
  - [ ] Security signals reviewed (as applicable)
- **Risks + mitigations:**
- **Rollback / escalation plan:**

## Evidence
- Workflow run(s):
- Scan results (if applicable):

## Review checklist
- [ ] Plan reviewed and approved
- [ ] Required reviews satisfied
- [ ] Required checks satisfied
```

## Enforcing plan validation with required checks status checks

In addition to templates, you can enforce plan gating as a required status check. This turns a process expectation ("include a plan") into a system guarantee.

```yml
# File: .github/workflows/plan-gate.yml
name: Plan Gate

on:
  pull_request:
    branches: [ main ]

jobs:
  require-plan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Require plan artifact
        run: |
          if [ ! -f "Github/pull_request_template.md" ]; then
            echo "Github/pull_request_template.md is required for this pull request."
            exit 1
          fi
          echo "Github/pull_request_template.md found."
```
**Implementation note:**

A repository administrator can mark Plan Gate as a required status check using rulesets/branch protection, ensuring PRs can't merge unless the plan exists.

GitHub can require explicit approval before workflows run on agent-generated changes.

## Using CODEOWNERS to ensure safety

CODEOWNERS ensures that changes to sensitive areas go to the right reviewers automatically.

```text
# File: CODEOWNERS

/security/ @security-team
/.github/workflows/ @platform-team
/infra/ @platform-team
* @core-team
```

This ensures that a plan and changeset affecting high-risk paths can't be merged without visibility from the right experts (when combined with required review policies).

## Be wary of execution without validation

If an agent can bypass required checks or merge without reviews, the architecture loses its primary safety mechanisms. This is less a model problem and more a workflow design failure.

**Key takeaway:** Pull requests aren't just collaboration tools-they are enforcement mechanisms.

Next, you'll define how much autonomy the agent should have based on the risk of the task.