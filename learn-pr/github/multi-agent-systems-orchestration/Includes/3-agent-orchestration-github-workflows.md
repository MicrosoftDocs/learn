Once responsibilities are clear, the focus shifts to how agents coordinate their work. Even well-defined roles can lead to confusion if execution isn't structured. Think about when agents should run, how their work is sequenced, and how outputs move between steps. Expressing this coordination through GitHub workflows keeps the system predictable, observable, and easier to manage as it grows.

In this unit, you'll learn

- How GitHub events coordinate agent behavior 

- How to design sequential and parallel orchestration 

- How to use artifacts for coordination instead of direct communication 

- Why orchestration must remain observable

## What is orchestration in multi-agent systems

Orchestration in multi-agent systems defines how multiple agents coordinate their work within a shared environment. It determines when agents run, how their tasks are sequenced, and how outputs are passed between steps, ensuring that work progresses in a controlled and predictable way rather than happening independently or in conflict.

## How orchestration works in GitHub

In GitHub, orchestration works best when it's expressed through workflows that respond to events. This keeps coordination visible because it happens in pull requests, workflow runs, checks, and logs.

Typical triggers include:

- schedules for periodic work (reporting, dependency checks),

- pull request events for validation and iteration, and

- workflow completion triggers when one step should run after another.

This matters because hidden coordination makes failures impossible to diagnose.

### Sequential orchestration

Some work must happen in a strict sequence. A common pipeline is:

1. The dependency agent opens a PR.
1. CI validates correctness (tests/build).
1. A security validation workflow runs after CI completes.
1. A human reviewer approves.
1. Merge happens only when gates are satisfied.

Example: run security validation after CI completes:

```yml
\# File: .github/workflows/security-validate.yml

name: Security Validation

on:

 workflow_run:

  workflows: [CI Validation]

  types: [completed]

jobs:

 validate:

  runs-on: ubuntu-latest

  steps:

   \- run: echo "Run security validation here."
```

Use this pattern when one agent's output must be validated before another step can proceed.

### Parallel orchestration

Parallel orchestration is appropriate when scope boundaries prevent overlap. For example, a documentation agent and a refactoring agent can work simultaneously if they operate in separate paths. Their outputs still converge through pull request checks and reviews.

The core design requirement for parallel orchestration is isolation: if agents can collide on the same files, parallelism will increase instability rather than throughput.

Example: Fan-Out, Fan-In Orchestration Pattern

To coordinate multiple agents in parallel and then merge their outputs, use the fan-out/fan-in orchestration with needs:.This pattern is tested in the exam and is a best practice for composing analysis/review/merge phases.

```yml
name: multi-agent-orchestration

on:
  workflow_dispatch:

jobs:
  spec_analyzer:
    runs-on: ubuntu-latest
    steps:
      - name: Run spec analyzer
        run: ./executors/spec_analyzer.sh

  risk_reviewer:
    runs-on: ubuntu-latest
    steps:
      - name: Run risk reviewer
        run: ./executors/risk_reviewer.sh

  plan_merger:
    runs-on: ubuntu-latest
    needs: [spec_analyzer, risk_reviewer]   # <--- FANS IN both
    steps:
      - name: Merge analysis and risk outputs
        run: ./executors/plan_merger.sh
      - name: Publish merged plan
        run: echo "publish plan artifact"
    concurrency:
      group: multiagent-${{ github.ref }}   # <-- Ensures no overlapping merge jobs per branch
```

This ensures `plan_merger` waits for both upstream jobs-a classic "fan-in".

### Artifact-based coordination

In multi-agent systems, direct "agent-to-agent communication" is often less reliable than shared, reviewable artifacts. A robust orchestration pattern is to:

1. run an agent with restricted permissions,
1. produce a structured output (plan/report/proposal) as an artifact, and then
1. use a controlled step to apply only the operations your workflow allows.

This pattern creates an explicit boundary between "reasoning" and "writing," and it leaves evidence that reviewers can inspect.

Example: scheduled repository report (artifact + controlled output)

```yml
# File: .github/workflows/daily-repo-report.yml
name: Daily Repo Status Report

on:
  schedule:
    - cron: "0 2 * * *"

permissions:
  contents: read
  issues: write
  pull-requests: read

jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - name: Generate report
        run: |
          echo '{ "summary": "Daily status...", "links": [] }' > report.json

      - name: Upload report artifact
        uses: actions/upload-artifact@v4
        with:
          name: repo-status-report
          path: report.json

      - name: Create issue (controlled output)
        run: |
          echo "Create issue from report.json"
```

### What happens when orchestration is hidden

If coordination happens outside GitHub and doesn't leave evidence in pull requests or workflow runs, reviewers lose the ability to understand why the system behaved the way it did. This makes failures harder to diagnose and reduces trust.

## Key takeaway

Orchestration should be expressed through GitHub Actions events and shared artifacts so the system remains observable. Use sequential orchestration when outputs depend on prior steps. Use parallel orchestration only when agents operate on isolated paths.

Once workflows are coordinated, you must ensure agents don't interfere with each other during execution.
