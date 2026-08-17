GitHub Copilot CLI brings an agentic coding assistant directly into your terminal. In this exercise, you'll use prebuilt custom agents in GitHub Codespaces to plan, design, build, and validate Mona's Project Pulse dashboard.

You'll coordinate an **Orchestrator**, **Planner**, **Designer**, and **Coder** agent to complete a small software project from planning through validation.

## Who is this for?

This exercise is for developers who have basic familiarity with GitHub and GitHub Copilot and want to learn how to coordinate specialist agents from the terminal.

## What you'll learn

By completing this exercise, you'll learn how to:

- Use GitHub Copilot CLI in GitHub Codespaces.
- Inspect custom agent definitions in `.github/agents/`.
- Ask an Orchestrator agent to coordinate specialist agents.
- Use a Planner agent to create an implementation plan.
- Delegate dashboard design and coding work to specialist agents.
- Run and validate a small dashboard in a Codespace.
- Create a VS Code launch configuration.
- Summarize a coordinated agent handoff.

## What you'll build

You'll build a runnable **Mona's Project Pulse** dashboard with the following files:

- `app/index.html`
- `app/styles.css`
- `app/project-data.json`
- `.vscode/launch.json`

You'll also create planning and handoff documentation under the `docs/` directory.

## Prerequisites

Before you begin, make sure you have:

- A GitHub account with access to GitHub Copilot.
- Access to GitHub Codespaces.
- Basic familiarity with repositories, commits, and Markdown.
- Comfort working in an integrated terminal.

This exercise takes less than one hour to complete.

## Instructions

1. Select the **Start the exercise on GitHub** button at the bottom of this page. It takes you to the public GitHub template repository for the Agent Orchestration exercise.

1. Select the **Start course** button or use the **Use this template** feature in the template repository. This action prompts you to create a new repository.

   We recommend that you create a public repository because private repositories may use GitHub Actions minutes.

1. After you create your repository from the template, wait about 20 seconds and refresh the page so that the first lesson can be prepared.

1. Start a GitHub Codespace for your repository.

1. Open the integrated terminal and use GitHub Copilot CLI to inspect the custom agents in `.github/agents/`.

   Identify the responsibilities of the following agents:

   - **Orchestrator**: Coordinates the work of other agents.
   - **Planner**: Breaks the project into implementation phases.
   - **Designer**: Defines the dashboard's visual structure and user experience.
   - **Coder**: Implements the dashboard files.

1. Ask the Orchestrator to involve the Planner and create a Project Pulse implementation plan.

   Review the plan and confirm that it includes the major phases needed to build and validate the dashboard.

1. Ask the Orchestrator to delegate the dashboard design work to the Designer agent.

   The design should describe a clear, readable project dashboard that includes project health, progress, ownership, activity, and upcoming milestones.

1. Ask the Orchestrator to delegate implementation work to the Coder agent.

   The implementation should create:

   - A semantic HTML page in `app/index.html`.
   - A responsive visual design in `app/styles.css`.
   - Project data in `app/project-data.json`.
   - A VS Code launch configuration in `.vscode/launch.json`.

1. Review the generated files and make sure the dashboard is runnable.

1. Run the dashboard from the Codespace using the provided VS Code launch configuration or a local development server.

1. Validate the final result.

   Check that:

   - The dashboard loads without errors.
   - The layout is readable on different viewport sizes.
   - Project health and progress information is visible.
   - Project data is loaded from `app/project-data.json`.
   - The dashboard includes useful activity and milestone information.
   - The required files are present in the repository.

1. Ask the Orchestrator to summarize the final coordinated handoff.

   The summary should identify the work completed by the Planner, Designer, Coder, and validation steps.

1. Commit your changes and review the completed dashboard.

> [!NOTE]
> You don't need to modify any workflow files to complete this exercise. Altering workflow contents can break the exercise's ability to validate your actions, provide feedback, or grade the results.

## Files to inspect

During the exercise, inspect the following custom agent definitions:

- `.github/agents/orchestrator.agent.md`
- `.github/agents/planner.agent.md`
- `.github/agents/designer.agent.md`
- `.github/agents/coder.agent.md`

The exact filenames may vary slightly depending on the exercise template. Use the terminal or repository explorer to identify the available agent files.

## Expected outcome

When you finish the exercise, your repository should include:

- A working Project Pulse dashboard.
- The dashboard source files under `app/`.
- A VS Code launch configuration under `.vscode/`.
- Planning and handoff notes under `docs/`.
- Evidence that you used GitHub Copilot CLI and coordinated work through custom agents.

## How to start this exercise

Simply copy the exercise to your account, start a Codespace, and give your favorite Octocat, Mona, about 20 seconds to prepare the first lesson. Then refresh the page.

When you finish the exercise, return to this module for:

> [!div class="checklist"]
> - A quick knowledge check.
> - A summary of what you learned.
> - A badge for completing this module.

> [!div class="nextstepaction"]
> [Start the exercise on GitHub](https://github.com/skills/agent-orchestration-build-your-ai-dream-team#agent-orchestration-build-your-ai-dream-team)
