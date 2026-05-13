Agent workflows often span multiple tools and environments. An agent may start work in an IDE, continue through a CLI, and complete tasks in a GitHub-hosted environment. To maintain consistency, memory and state must be shared in a way that works across all of these surfaces.

In GitHub workflows, continuity is achieved by relying on durable artifacts and consistent sources of truth rather than temporary session context.

## In this unit, you'll learn:

- How to share agent state across tools and environments 

- How to prevent conflicting context

- How to prevent stale context 

## Sharing agent state across tools

Agent state should be shared using durable references, not copied context.

In GitHub, this means relying on:

- Pull request numbers and branch names 

- Commit SHAs 

- Workflow run links 

- Issue and pull request URLs 

These references allow any tool or environment to retrieve the same state.

In practice:

- Start work from an issue and create a pull request 

- Use the pull request as the central reference 

- Access the same pull request from the IDE, CLI, or GitHub UI 

- Use commit history and workflow runs to understand progress 

Because all environments can access the same repository data, the agent can maintain continuity without needing to transfer session context.

## Using GitHub as the source of truth

To maintain consistency, all important information should exist in one place.

In GitHub workflows:

- Requirements live in issues 

- Decisions and progress live in pull requests 

- Validation rules live in repository instructions 

- Execution results live in workflow runs and artifacts 

In practice:

- Avoid storing critical information only in prompts or chat history 

- Always write important updates to issues or pull requests 

- Ensure that workflows produce visible results in the repository 

Using GitHub as the source of truth ensures that all tools and environments operate on the same state.

## Preventing conflicting context

Conflicting context occurs when the same information exists in multiple places with different values.

To prevent this:

- Define a single source of truth for each type of information 

- Avoid duplicating requirements or decisions across multiple locations 

- Update the original source instead of creating new copies 

For example:

- Don't redefine acceptance criteria in multiple prompts 

- Update the issue or pull request instead of storing new versions elsewhere 

This ensures that the agent always retrieves consistent information.

## Preventing stale context

Stale context occurs when outdated information is used during execution.

In GitHub workflows, this can happen when:

- A pull request is outdated compared to the base branch 

- Workflow results no longer reflect the current code 

- Requirements have changed but weren't updated 

To prevent this:

- Ensure branches are up to date with the base branch before continuing work 

- Review the latest commits and workflow runs before making changes 

- Update issues and pull requests when requirements change 

GitHub enforces some of this automatically through features like required status checks and branch protection rules, which may require branches to be up to date before merging.

Ensuring continuity with workflows and validation

Workflows play a key role in maintaining continuity.

In practice:

- Configure workflows to run on pull requests and pushes 

- Use workflow results as the source of validation 

- Re-run workflows when changes are made 

- Use the “Checks” tab to verify the latest state 

Because workflows run in controlled environments and produce consistent outputs, they provide a reliable way to validate state across tools.

Maintaining continuity across environments

When switching between environments, the agent should always re-anchor to GitHub state.

A typical flow looks like:

- Start work in an IDE using a repository 

- Open or reference an existing pull request 

- Continue work through CLI or automation 

- Validate changes using GitHub workflows 

- Review and finalize work in the pull request 

By always returning to GitHub artifacts, the agent avoids losing context or diverging from prior work.

## Key takeaway

Continuity in agent workflows depends on shared, durable state. By using GitHub artifacts as the source of truth and referencing them consistently across tools and environments, agents can maintain alignment, avoid conflicting or stale context, and continue work reliably across sessions.