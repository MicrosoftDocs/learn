AI agents are changing how development work gets done. Instead of manually navigating repositories, writing code, and running commands, agents can operate directly within GitHub to complete tasks from start to finish.

GitHub supports agent-driven work through multiple layers. Agents can use GitHub APIs to read repository state and perform actions, GitHub Actions workflows to execute automation in controlled runners, and GitHub Agentic Workflows to describe higher-level repository tasks in Markdown and run them with coding agents under strong guardrails. Rather than bypassing GitHub, agents work through the same systems developers use, including branches, pull requests, issues, and automation.

In this unit, you'll learn:

- How agents interact with GitHub through APIs
- How agents use workflows as execution environments
- How repository changes are created and managed
- What a full agent execution flow looks like on GitHub

## How agents interact with GitHub

GitHub agents, such as Copilot cloud agent, operate within a defined repository and branch context. When you assign a task, for example through an issue or prompt, the agent begins working inside that repository.

Agents can:

- Research and understand the repository
- Plan changes needed to complete a task
- Make code changes on a new branch
- Open a pull request for review

Agents carry out these actions using GitHub platform capabilities such as APIs and workflows.

These actions can be triggered by repository events (such as push or pull request), run on a schedule, or orchestrated through agentic workflows that continuously automate repository tasks over time.

## Using GitHub APIs to perform actions

GitHub provides APIs that allow systems to interact with repositories programmatically.

The APIs enables actions such as:

- Creating branches and commits
- Reading repository data
- Opening and updating pull requests
- Triggering workflows

All API requests must be authenticated using tokens such as personal access tokens, GitHub App tokens, or the GITHUB_TOKEN provided in workflows.

This ensures that every action an agent performs is permission-controlled and auditable.

## How agents create changes in a repository

When an agent makes changes, it follows the same workflow as a developer.
A typical sequence looks like this:

1. Select a base branch
1. Create a new working branch
1. Modify or create files
1. Commit changes
1. Open a pull request

There are separate API operations for each of these steps, including working with Git references, repository contents, and pull requests.

This means agent actions are fully aligned with GitHub’s standard development model.

## Using GitHub Actions as the execution layer

Agents don't execute tasks directly on your machine. Instead, GitHub provides execution environments through workflows powered by GitHub Actions.

A workflow is a YAML-defined process that runs jobs in response to events.

Agents rely on these workflows to:

- Run tests
- Validate changes
- Execute automation tasks
- Deploy applications

Copilot cloud agent operates in a GitHub Actions-powered environment, which means workflows form the foundation of agent execution.

## Traditional workflows vs agentic workflows

Traditional GitHub Actions workflows are usually deterministic and YAML-defined: you explicitly specify each step, trigger, and condition. GitHub Agentic Workflows add a different model for repository automation. They let you describe the desired outcome in Markdown, define guardrails in frontmatter, and execute that intent using a coding agent in GitHub Actions. They're best suited to open-ended but bounded repository tasks such as triage, reporting, documentation maintenance, CI failure analysis, and code improvement. They don't replace CI/CD pipelines; they extend them with what GitHub describes as "Continuous AI."

## What makes an agentic workflow different

A GitHub Agentic Workflow has two main parts:

- Frontmatter for configuration such as triggers, permissions, tools, and safe outputs
- Markdown instructions that describe the job in natural language

The Markdown expresses intent, while the frontmatter defines the boundaries. The workflow is then compiled into a lock file that GitHub Actions executes.

```
on: schedule: daily
permissions: contents: read issues: read pull-requests: read
safe-outputs: create-issue: title-prefix: "[repo-status] " labels: [report]
tools: github:

Daily Repository Status Report
Create a daily report for maintainers.
Include:
Recent activity (issues, PRs, commits)
Key highlights and risks
Recommended next steps
Keep the report concise and link to relevant issues and pull requests.
```

In this example, the frontmatter (between ---) defines how and when the workflow runs, what it can access, and what actions are allowed.

The Markdown below defines the intent of the workflow in natural language. An agent interprets this intent and produces structured outputs, which are then applied through controlled, reviewable steps.

Unlike traditional GitHub Actions workflows, which explicitly define each step, agentic workflows focus on describing outcomes. The agent determines how to achieve the goal within the constraints defined in the frontmatter.

## Triggering and interacting with workflows

Workflows can be triggered in multiple ways:

- Automatically through events such as push or pull request
- Manually using the workflow_dispatch event
- Programmatically through the GitHub API

Agents can rely on these triggers to execute tasks or validate changes after making updates to a repository.

Each workflow run executes jobs in isolated environments, ensuring consistent and secure execution.

## What happens during an agent session

Agent sessions as observable and interactive.

During a session, you can:

- Monitor progress through a session log
- See what actions the agent is taking
- Provide feedback or adjust the task
- Review the final pull request

The agent adapts based on feedback and continues working until the task is complete.

## End-to-end agent execution flow

Putting it all together, a typical agent interaction with GitHub looks like this:

1. A task is assigned through an issue, chat, or CLI
1. The agent selects the repository and base branch
1. The agent analyzes the codebase and plans changes
1. API operations are used to create branches and commits
1. A pull request is opened
1. Workflows run to validate or deploy changes
1. The user reviews, approves, or requests updates

This flow ensures that all agent activity is:

- Scoped to a repository
- Controlled by permissions
- Executed through workflows
- Visible and reviewable

## Key takeaway

Agents on GitHub don't operate outside the platform. They interact through APIs, workflows, and repository structures that enforce permissions, provide execution environments, and enable collaboration through pull requests.

Next, you'll learn how Model Context Protocol (MCP) extends these capabilities by enabling agents to connect to additional tools and services beyond GitHub.
