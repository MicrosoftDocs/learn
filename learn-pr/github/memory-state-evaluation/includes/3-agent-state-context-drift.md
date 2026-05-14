Memory helps an agent understand what matters. State tracks what has been done, what decisions were made, and what remains.

In GitHub workflows, state is not stored in a single place. It is represented through artifacts such as issues, pull requests, commits, workflow runs, and logs. These artifacts act as persistent memory, allowing the agent to retain context and continue work across sessions without losing progress.

In this unit, you'll learn:

- How to capture task progress and decisions as durable artifacts 

- How to resume agent work without repeating steps 

- How to detect and correct context drift 

- How to define memory expiration, pruning, and reset rules 

## Capture task progress as durable state

Agent state should be stored in locations that are persistent and easy to review.

In GitHub, this typically means:

- Defining requirements and acceptance criteria in an issue 

- Opening a pull request to track implementation 

- Using commits to represent incremental progress 

- Using workflow runs to capture validation results 

For example:

- Create an issue with clear acceptance criteria 

- Assign the task to an agent 

- Have the agent create a branch and open a pull request 

- Let workflows run on each push to validate changes 

Together, these artifacts act as persistent memory, providing a complete view of what the agent has done, what decisions were made, and what still needs to be completed.

## Use pull requests as a state anchor

Pull requests are the central place to track state during agent workflows.

A pull request should include:

- A clear description of the task 

- Acceptance criteria (or a link to the issue) 

- A summary of the plan or approach 

- Updates as the work progresses 

In practice:

- Use the pull request description to capture the current plan 

- Update the description when decisions change 

- Reference commits and workflow runs directly in the PR 

GitHub aggregates commits, checks, and discussions in the pull request, making it the primary place to track progress and decisions.

## Resume work without repeating steps

Agent workflows may pause or move between environments. To resume work correctly, the agent should rely on stored state instead of starting over.

A typical resume flow looks like:

1. Open the existing pull request 

1. Review the description and linked issue 

1. Check commits already made 

1. Review workflow results under the “Checks” tab 

1. Continue from the latest state 

Because GitHub preserves commit history and workflow runs, the agent can identify completed work and avoid duplication.

## Detect context drift

Context drift occurs when the agent’s actions no longer align with the original goal or prior decisions.

In GitHub workflows, drift can be identified by checking:

- Whether pull request changes satisfy acceptance criteria 

- Whether commits contradict earlier decisions 

- Whether workflow checks are failing or missing 

## Correct context drift

To correct drift, the agent should be re-aligned with the source of truth.

In practice:

- Re-read the issue or pull request description 

- Compare current changes with acceptance criteria 

- Update the pull request description if needed 

- Re-run workflows or push new commits to trigger validation 

GitHub allows workflow runs to be re-executed and surfaces results through the Checks tab, making it easier to verify alignment.

## Manage memory over time

Agent memory should be maintained to ensure it remains accurate and useful.

### Expiration

Some memory should only be retained for a limited time.

In GitHub:

- Workflow logs and artifacts are **retained for 90 days by default and automatically deleted afterward** 

- Retention can be configured at the repository, organization, or enterprise level 

- Public repositories typically allow 1-90 days, while private repositories can extend retention up to 400 days

### Pruning

Outdated or unnecessary artifacts should be removed.

In practice:

- Delete workflow artifacts manually from the Actions tab 

- Remove unused or stale workflow runs 

- Avoid storing large or redundant outputs 

GitHub allows manual deletion of artifacts, and deleted artifacts cannot be restored 

### Summarization

Detailed execution history can be reduced into summaries.

For example:

- Update the pull request description with final decisions 

- Reference key commits instead of duplicating details 

- Link to workflow runs instead of storing full logs 

This preserves traceability while keeping memory manageable.

### Reset rules

In some cases, memory should be reset to avoid incorrect carryover.

This may be necessary when:

- Requirements in the issue change significantly 

- A new implementation approach is chosen 

- Previous assumptions are no longer valid 

In practice:

- Update or rewrite the pull request description 

- Close and recreate a pull request if needed 

- Clearly document the new direction before continuing 

## Maintain consistency over time

Consistent state management ensures that:

- Work progresses without duplication 

- Decisions remain aligned across sessions 

- Outputs can be verified using workflow results 

GitHub also supports required status checks on pull requests, ensuring workflows must pass before changes are merged.

## Key takeaway

Agent state represents progress, decisions, and results. By using GitHub artifacts such as pull requests, workflow runs, and logs as persistent memory, agents can resume work reliably and stay aligned with the original goal. Managing expiration, pruning, and reset rules ensures that memory remains accurate and relevant over time, while detecting and correcting context drift keeps workflows consistent.