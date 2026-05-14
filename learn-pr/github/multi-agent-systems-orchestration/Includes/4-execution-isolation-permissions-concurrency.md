Execution isolation is the practice of separating agent activity so that each agent operates within its own controlled scope. It ensures that agents do not interfere with each other, do not share execution context such as branches, workflows, or permissions, and do not create unstable or unpredictable behavior when running in parallel.

In this unit, you'll learn

- How to isolate execution using branches and workflows 

- How to apply least-privilege permissions 

- How to use concurrency to prevent overlapping runs 

- Why isolation is required for system stability

### Why isolation matters in multi-agent systems

Isolation is not only about preventing merge conflicts. It is also about preventing instability. When multiple agents share the same execution context-such as a branch, a workflow, or broad write permissions-failures become harder to diagnose and the system becomes more likely to thrash through repeated runs.

Isolation makes concurrency safe and attribution clear. This matters because shared execution context leads to unstable and unpredictable systems.

## How isolation works in GitHub

### Branch isolatio

Each agent should open a PR from a dedicated branch such as:

- `agent/dependency/<ticket>`

- `agent/refactor/<ticket>`

- `agent/security/<ticket>`

This makes changes bounded and helps reviewers understand intent and scope.

### Workflow isolation

Give each agent a dedicated workflow (or a dedicated job with distinct permissions) so triggers, permissions, and outputs are easy to reason about. This reduces accidental coupling when workflows evolve over time.

Once workflows are separated, permissions must also be scoped to prevent unintended access.

### Permission isolation

Workflow permissions should be reduced to the minimum needed. GitHub documents workflow syntax, including permissions.

Example permissions for a workflow that updates PR metadata but should not push arbitrary commits:

```yml
permissions:
  contents: read
  pull-requests: write
```

Even with scoped permissions, workflows can still overlap in time. Concurrency controls address this.

### Concurrency controls

When a PR is updated frequently, workflows can overlap. Concurrency controls cancel outdated runs and reduce noise. Concurrency is documented in the workflow syntax and is also covered in a dedicated guide.

- [Workflow syntax for GitHub Actions](https://docs.github.com/actions/using-workflows/workflow-syntax-for-github-actions)

- [Control the concurrency of workflows and jobs](https://docs.github.com/en/actions/how-tos/writing-workflows/choosing-when-your-workflow-runs/control-the-concurrency-of-workflows-and-jobs)

Use workflow-level concurrency to prevent overlapping runs on the same branch while allowing parallel execution across different workflows.

```yml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

#### Configure Workflow-Level Concurrency for Safe Parallel Execution

When multiple agent sessions may push to the same repository or PR, you must prevent workflow runs from colliding on the same branch, while still allowing jobs to run in parallel across *different* branches or workflows. Use a properly-scoped concurrency group on the workflow:

```yml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

- `group: ${{ github.workflow }}-${{ github.ref }}`: Ensures that runs are isolated per workflow and per branch.

- `cancel-in-progress: true`: Automatically cancels previous, overlapping runs on the same branch for the same workflow, so only the newest run continues.

> [!Note]
> Setting only `${{ github.ref }}` without workflow makes concurrency global to the branch, potentially blocking unrelated workflows from running.

Why not job-level or matrix-based concurrency? 

Job-level `concurrency` only applies within a workflow run, not across runs. Using `strategy.matrix` controls intra-run parallelism, not parallelism across triggers or agent sessions.

### What happens without isolation

If multiple agents share the same branch or workflow context, you can end up with interleaved commits, ambiguous ownership, and repeated failures. This makes rollback and auditing significantly harder.

#### Copilot Agent Modes: Parallelism Capabilities

Not all agent invocation modes support parallel tasks:

| **Agent Mode** | **Parallel Sessions  Across Multiple Tasks?** |
| -------------- | --------------------------------------------- |
| Copilot Cloud  | Yes                                           |
| Copilot CLI    | Yes                                           |
| Local          | No (serial  only, one at a time)              |

## Key takeaway

Isolation is the foundation for multi-agent stability. Use concurrency controls when workflows trigger frequently, especially on pull request updates.

Isolation reduces interference, but it does not eliminate conflicts. In the next unit, you will learn how to detect conflicts early and resolve them predictably using GitHub-native arbitration controls such as merge validation checks and CODEOWNERS.