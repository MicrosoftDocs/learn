Once an agent can take actions and connect to tools, the next question is where and how those actions are executed.

Execution context defines the boundaries within which an agent operates. This includes the repository it can access, the branch it works on, the workflow that runs its tasks, and the permissions it's granted.

Without a clearly defined execution context, agent behavior becomes unpredictable and unsafe.

In this unit, you'll learn:

- What execution context means in GitHub
- How repository and branch scope define boundaries
- How workflows isolate execution
- How permissions enforce control over agent actions

## What is execution context?

Execution context is the set of constraints that define where an agent operates and what it can access.

In GitHub, execution context includes:

- The repository the agent is working in
- The branch the agent is targeting
- The workflow that is executing tasks
- The permissions granted to that workflow

This context determines both visibility and capability.

## Repository scope

Agents always operate within a repository. They can only read and modify code within that repository. They interact with issues, pull requests, and workflows tied to it. They don't have access to other repositories unless explicitly granted.

Repository scope is the first boundary that limits agent behavior.

## How repository scope is configured

For agents such as the Copilot cloud agent, this boundary is explicitly configured at the repository level.

To configure this:

1. Open your repository on GitHub
1. Click Settings
1. In the sidebar, under Code & automation, click Copilot
1. Select Cloud agent
1. Enable and configure the agent for that repository
1. Save your configuration

Once configured, the agent is scoped to that repository and can't operate outside of it.

## Custom agent scope within a repository

Custom agents operate within the same repository boundary but can further refine their scope through configuration.

Inside a custom agent file (for example, .github/agents/security-reviewer.agent.md), scope is defined using fields such as:

- applyTo → limits which files or directories the agent focuses on
- ools → defines what actions the agent can perform

Example:

```
applyTo:
    - '**/*.js'
    - 'src/auth/**' tools:
    - read_file
    - search_files
```

**To configure a custom agent**:

1. Create the .github/agents/ directory in your repository
1. Add an agent file with the .agent.md extension
1. Define its scope using applyTo and tools
1. Commit and push the file

This allows the agent to focus only on specific parts of the repository and operate with limited capabilities.

### How this fits into execution context

Repository scope defines where the agent operates, while custom agent configuration defines what the agent can access and do within that boundary.
Together, they create layered control.

## Branch-based isolation

Agents don't work directly on the main branch.

Instead, they:

- Create a new branch from the branch ypu selected
- Make changes within that branch
- Open a pull request targeting a base branch

This isolates changes and ensures that all modifications go through review before being merged.

Branch-based isolation is a key safety mechanism.

## Configure an agent to use branch-based scope

To set up a Copilot Cloud agent to operate with a branch-based scope, follow these steps:

1. Selecting a Base Branch:
    - Access the Agents Page: Navigate to the Agents page in your GitHub repository.
1. Choose the Base Branch: When delegating tasks to the Copilot coding agent, you can select a specific base branch. This allows the agent to create a new branch based on your selected branch instead of the default branch (usually "main").

Custom agents operate within a repository, but they don't control branch behavior directly. Branch-based scope is determined by the system that executes the agent.

### How it works

When used with a cloud agent:

- The system automatically creates a branch
- Applies changes
- Opens a pull request

When used in workflows (CI):

- The workflow determines the branch
- The agent runs within that branch context

### What custom agents control

Custom agents define:

- What files they focus on (applyTo)
- What actions they can perform (tools)
- How they behave (instructions)

But they don't define:

- Branch creation
- Pull request behavior
- Execution isolation

Branch-based scope is always enforced by the execution context, not the custom agent itself.

## Enable an agent to perform autonomous actions, including creating branches and pull requests

Agents can perform autonomous actions within a repository once they're enabled and given a task.

Steps:

1. Enable the agent for the repository.
    - Go to Settings → Copilot → Cloud agent
    - Enable the agent, select the repository
1. Assign a task to the agent.
    - From an issue, Copilot Chat, or the agents interface
    - Example: fix a bug, implement a feature
1. Allow the agent to execute the task.

    The agent will:
    - Create a branch
    - Make code changes
    - Commit and push updates
1. Review and finalize.

Once you're satisfied with the code changes and results, trigger a pull request. You can request changes in the pull request, or go ahead and merge.

The agent works autonomously within the repository by creating branches, modifying code, and opening pull requests, while still operating within a controlled and reviewable workflow.

## Workflow boundaries

Execution happens inside workflows powered by GitHub Actions. Each workflow defines what triggers execution, what steps are performed, and what environment the code runs in. Workflows act as controlled execution containers. They ensure that tasks run in a clean environment, execution is repeatable, and logs and results are captured. Workflows are also how agent behavior is executed in CI environments.

## Permission boundaries

Permissions define what an agent can do within its execution context.

Workflows are assigned permissions through tokens, such as the GITHUB_TOKEN.

These permissions can allow or restrict:

- Reading repository contents
- Writing code
- Creating pull requests
- Accessing secrets
- Triggering workflows

Permissions should always be explicitly defined and minimized.

## Guardrails in GitHub Agentic Workflows

GitHub Agentic Workflows are designed with defense in depth. Key controls include:

- Read-only tokens by default so the agent can inspect repository state without directly changing it
- Safe outputs that let the agent propose actions while a separate gated step decides what is allowed
- Zero secrets in the agent process, keeping sensitive credentials out of the runtime used by the coding agent
- Sandboxed, containerized execution
- Network isolation and allowlisted outbound access
- Threat detection that scans proposed outputs before any write action is applied

This model helps reduce the risks of overprivileged agents, prompt injection, and unintended repository changes.

## Why boundaries matter

Execution context is what makes agent systems safe.

By combining:

- Repository scope
- Branch isolation
- Workflow execution
- Permission control

GitHub ensures that agents operate within clear, enforceable limits.
This prevents:

- Uncontrolled changes to production code
- Access to unintended resources
- Unsafe or unreviewed execution

## How agents are invoked through workflows

To run agent-driven tasks as part of CI, you invoke them inside a workflow. In this setup, the workflow becomes the execution boundary, and the agent runs within the runner using defined steps and permissions.

Steps:

1. Create or open a workflow file in your repository: ```.github/workflows/agent-task.yml```
1. Define when the workflow should run:

    ```
    on:
     workflow_dispatch: 
    schedule: - cron: '0 9 * * *' 
    ```

    You can also use events like push or pull_request depending on your use case.
1. Set workflow permissions:

    ```
    permissions: 
        contents: read
    ```

    Adjust permissions based on what the workflow needs to do.

1. Define a job and runner:

    ```
    jobs: 
    	agent-task: 
    		runs-on: ubuntu-latest 
    
    ```

1. Check out the repository:

    ```
    uses: actions/checkout@v4
    ```

1. Set up Node.js:

    ```
    uses: actions/setup-node@v4 
    with: node-version: '18' 
    ```

1. Provide authentication:

    ```
    env: COPILOT_GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    ```

1. Run the agent task:

    ```
    run: | npx @github/copilot-cli 
    -p "Summarize recent changes in this repository" 
    --no-ask-user (Optional) 
    ```

1. Use a custom agent:

    ```
    run: | npx @github/copilot-cli 
    --agent security-reviewer 
    -p "Review this code for vulnerabilities" 
    --no-ask-user
    ```

The workflow becomes the controlled execution path for the agent. The task runs on a defined runner, with a defined trigger, inside a defined repository context, and with only the permissions granted to that workflow.

## Branch scope and workflow execution

Workflows run against a specific branch.

Since agents make changes on a branch:

- Workflow execution is scoped to that branch
- Changes are isolated from the default branch
- Validation occurs before merging

This ensures that agent activity remains contained within a controlled execution scope.

## Key takeaway

Execution context defines where agents operate. Boundaries such as repository scope, branch isolation, workflows, and permissions ensure that agent actions remain controlled, predictable, and safe.

Next, you'll learn how to design safe execution paths, including retries, rollbacks, and escalation mechanisms.
