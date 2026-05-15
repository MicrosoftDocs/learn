With decision points defined, it becomes important to think about what agents can actually access and do. Permissions shape those boundaries. By limiting access to only what is needed, you reduce the chances of unintended consequences and keep the system easier to manage and recover from.

In this unit, you’ll learn:

- What least-privilege execution is and why it defines risk
- How to configure workflow and job-level permissions
- How to scope access to secrets and workflows

## What is least-privilege execution?

Least-privilege execution means agents are given only the minimum permissions required to complete a specific task, and nothing more. This limits what an agent can access or modify at any given time.

Broad tokens amplify incidents and increase the potential impact of mistakes. By restricting permissions to only what is necessary—and elevating access only when required—you reduce blast radius and help ensure failures remain contained and easier to recover from.

## How least privilege is implemented

Least privilege is implemented by carefully scoping permissions at the workflow and job level, ensuring agents only have access to what they need for each step.

### Set minimal defaults

Example: workflow permissions

```yml
permissions:
  contents: read
  pull-requests: write
```

Only allow write where required, and document why. Default to read-only access and elevate permissions only when required.

### Elevate permissions only where needed

Set a read-only default at the workflow level, then elevate write permissions only for the job that must write.

```yml
permissions:
  contents: read

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - run: echo "Read-only analysis"

  update_artifacts:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - uses: actions/checkout@v5
      - run: echo "Write operations happen here"
```

Decision guidance: Granting pull-requests: write should be treated as elevated capability. Use it only when the workflow must create/update PRs.

### Apply additional controls

- Restrict secrets access using environments
- Isolate workflows so high-risk jobs don’t share permissions with low-risk jobs
- Minimize third-party actions and pin versions when possible

## Why permissions define risk

Permissions determine what an agent is actually capable of doing, regardless of intent. Broad tokens can amplify small mistakes into large failures by allowing unintended changes across the system. By applying least privilege, you limit the scope of what an agent can affect, reducing blast radius and making issues easier to contain and recover from.

## Key takeaway

Permissions define the true boundary of agent power. They determine what an agent can actually do in the system, regardless of intent or instructions. By keeping permissions minimal and scoped, you reduce risk, contain failures, and maintain control as systems scale.

Even well-controlled systems must produce evidence. Next, you'll ensure all actions are observable and auditable.
