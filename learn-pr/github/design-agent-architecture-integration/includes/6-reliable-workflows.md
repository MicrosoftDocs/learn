In this unit, you'll learn:

- How to pass data through workflows using step and job outputs 

- How to use GitHub contexts for configuration and control 

- How to design workflows with safe triggers and defensive gating 

- How to ensure workflows run only in the correct context 

- How to build reliable workflows using structured data and event logic

## Autonomy must be designed, not assumed

Different tasks carry different risks. A good agent architecture uses policy to express different autonomy levels rather than applying the same rules everywhere.

A simple risk-based autonomy model might look like this:

| **Task type** | **Example paths**                    | **Risk level** | **Autonomy  design**                                         |
| ------------- | ------------------------------------ | -------------- | ------------------------------------------------------------ |
| Low           | docs/, formatting                    | Low            | merge can be automated using GitHub automerge after required checks (and reviews, if configured) pass |
| Medium        | src/, dependency bumps               | Medium         | PR required + checks + at least one review                     |
| High          | infra/, .github/workflows/           | High           | CODEOWNERS + multiple reviews + stricter rulesets            |
| Critical      | production deploys settings, secrets | Critical       | environment approvals; agent prepares but can't execute      |

## Implementation: environment approvals for high-risk execution

Environments provide a strong control point for risky actions such as deployments and access to protected secrets. If an environment is configured with required reviewers, a job targeting that environment will pause until approval is granted.

```yml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: production
    steps:
      - run: echo "Deploying to production..."
```

This design allows the agent to prepare changes while preventing it from executing production-impacting actions independently.

## **Outputs are workflow contracts (step outputs vs job outputs vs env)**

When a workflow generates information that downstream steps or jobs must consume, treat that data as an explicit output rather than "just logs."

Teach and apply these principles:

- Step outputs pass values between steps in the same job.

- Job outputs pass values across jobs (through job dependencies).

- Environment variables configure runtime behavior but shouldn't replace outputs for structured data flow.

Illustrative pattern (mechanics shown, but not exam-shaped):

```yml
- id: generate_plan
  run: |
    echo "plan=high level steps..." >> "$GITHUB_OUTPUT"

- run: |
    echo "Plan: ${{ steps.generate_plan.outputs.plan }}"
```

For cross-job sharing, publish a job output and reference it from a dependent job:

```yml
jobs:
  plan:
    outputs:
      plan: ${{ steps.generate_plan.outputs.plan }}
    steps:
      - id: generate_plan
        run: echo "plan=..." >> "$GITHUB_OUTPUT"

  implement:
    needs: plan
    steps:
      - run: echo "Using plan: ${{ needs.plan.outputs.plan }}"
```

## Contexts: GitHub vs vars vs env

Use the right context for the right purpose:

- github.* → event metadata and runtime decisions ("what triggered this run?")

- vars.* → centrally managed configuration values designed to be reused

- env.* → job-level environment variables and runtime configuration

## Safe triggering and defensive gating

Even when workflows are designed for PRs, repositories often have multiple triggers. Add defensive gating so "PR-only" behavior doesn't accidentally run without a PR context.

General pattern to teach:

- Use job-level conditions to ensure PR-dependent actions only run when the run is tied to a PR event.

### Defensive gating for pull request-only behavior

Even if a workflow is intended to run only for pull requests, it may still be triggered by other events (for example, push, workflow_dispatch, or schedule). Without additional safeguards, PR-specific steps-such as commenting on a pull request or evaluating changes-can fail or behave unexpectedly.

You can prevent this by adding a **job-level condition** that ensures the workflow only runs when it's associated with a pull request.

```yml
name: PR Validation

on:
  pull_request:
    branches: [ main ]
  workflow_dispatch: # allows manual runs, but still gated below

jobs:
  validate-pr:
    # Defensive gating: only run if this is actually a PR context
    if: github.event_name == 'pull_request'

    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Run tests
        run: npm test

      - name: Comment on PR
        run: echo "Validation complete"
```

## Key takeaway: Workflow reliability improves when plans and signals are treated as structured outputs and guarded by event-aware logic.

Next, you'll operate agents safely by making runs auditable, controlling tools and secrets, and building hooks-based guardrails and reliability patterns.
