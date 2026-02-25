Individual custom agents are powerful on their own, but their full potential emerges when you connect them in sequence to handle complex, multi-step development tasks. Handoffs enable one agent to suggest the next step with another agent, carrying over the conversation context and providing a seamless transition between specialized roles.

## What are handoffs?

A handoff is a mechanism that allows one custom agent to propose a transition to another agent after completing its part of a task. When an agent finishes its response, it can present a handoff button—a suggested "next action"—that, when selected, switches the chat to a target agent and optionally prefills a prompt to continue the workflow.

For example, a Planner agent could produce a detailed implementation plan and then display a "Start Implementation" button. When the developer selects this button, GitHub Copilot Chat switches to an Implementer agent that receives the plan as context along with a prompt like "Now implement your suggested plan." The developer reviews the plan before selecting the button, maintaining control over the workflow while the agents handle the specialized work.

This approach creates a structured multi-agent workflow where each agent handles a specific phase of the development process. The developer oversees each transition, ensuring quality and correctness at every step. Handoffs don't execute automatically by default—they require the developer to select the handoff button, which keeps the human in the loop.

## Configuring handoffs

To set up a handoff, add a `handoffs` section to the YAML frontmatter of a custom agent's `.agent.md` file. Each handoff entry specifies the connection between the current agent and the target agent.

A handoff entry includes the following fields:

- **label**: The text displayed on the handoff button (for example, "Start Implementation" or "Run Tests").

- **agent**: The name or identifier of the target agent to switch to. This name must match the filename (without the `.agent.md` extension) or the `name` field of the target agent.

- **prompt**: An optional message to send to the next agent. This prompt provides context or instructions for the target agent, such as "Now implement your suggested plan." or "Review the code changes made in the previous step."

- **send**: A boolean value that controls whether the prompt is submitted automatically. When set to `false` (the default), the prompt is prefilled in the chat input for the developer to review and edit before sending. When set to `true`, the prompt is submitted immediately, and the target agent begins working right away.

- **model**: An optional field that specifies a particular AI model to use when the handoff executes. The format is `Model Name (vendor)`, such as `GPT-4.1 (OpenAI)` or `Claude Sonnet 4 (Anthropic)`. This field is useful when different stages of a workflow benefit from different model capabilities—for example, using a reasoning model for planning and a faster model for implementation.

The following YAML snippet shows a Planner agent configured with a handoff to an Implementer agent:

```yaml
---
description: Generates high-level implementation plans without writing code
tools: ['search', 'read', 'fetch']
handoffs:
  - label: Start Implementation
    agent: implementer
    prompt: Now implement the plan outlined above.
    send: false
---
```

When the Planner agent completes its response, a "Start Implementation" button appears in the chat. Selecting this button switches to the Implementer agent, carries over the conversation history (including the plan), and prefills the prompt text for the developer to review.

An agent can define multiple handoffs to offer different next steps. For instance, a Planner agent might offer both "Start Implementation" and "Write Tests First" buttons, letting the developer choose the appropriate path based on the situation.

## Reviewing and accepting handoffs

Handoffs always involve an explicit user action—selecting the handoff button—unless the `send` field is set to `true`. This design ensures the developer stays in control of the workflow and can review each agent's output before moving to the next step.

Each agent in a chain operates within its own defined tool set and instruction set. This environment provides guardrails at each step of the workflow. For example:

- A **Planning agent** with only `read` and `search` tools can gather information and propose plans but can't accidentally modify code.
- An **Implementation agent** with `read`, `edit`, and `terminal` tools can write code and run build commands but follows the specific coding guidelines in its instructions.
- A **Review agent** with only `read` and `search` tools can analyze the generated code but can't modify it, ensuring its review is purely advisory.

These role-specific constraints make multi-step processes more reliable by preventing unintended actions at each phase. The developer reviews the output at each handoff point and only proceeds when satisfied with the result.

## Common multi-step workflows

The following scenarios demonstrate how chaining custom agents can improve productivity across different development activities.

### Planning → Implementation

Use a Planner agent to analyze requirements and produce a detailed implementation plan for a new feature. The plan identifies which files need changes, outlines the implementation steps, and highlights potential risks. A handoff then switches to an Implementer agent that writes the code according to the plan, following the project's custom instruction files for coding standards.

This workflow mirrors how senior engineers plan work before implementation begins, using AI for both stages while keeping the developer in control of the transition.

### Implementation → Code Review

After code is generated, whether by a human developer or an AI agent, a handoff can switch to a Code Review agent. The review agent evaluates the new code's quality, checking for bugs, security issues, style violations, and missing edge cases. The review agent can then either provide feedback for manual fixes or hand off to a "Fixer" agent that applies corrections, subject to developer approval.

### Write Failing Tests → Write Code to Pass

Apply Test-Driven Development (TDD) using a two-agent chain. First, a Test Generator agent creates failing unit tests for a specified requirement. The developer reviews the tests to confirm they capture the intended behavior. A handoff then switches to an Implementer agent that writes the minimal code needed to make those tests pass. This chain enforces a red-green testing cycle with AI assistance, producing both the tests and the implementation.

### Debugging and Patching

For bug-fix scenarios, a Debugging agent reads error logs, examines failing tests, and analyzes the relevant code to hypothesize the cause of the issue. Once the diagnosis is complete, a handoff switches to a Patching agent with editing permissions to apply the fix. A final handoff could invoke a Testing agent to run the test suite and verify the issue is resolved.

### Refactoring or Upgrading

Use a Planning agent to analyze an existing codebase and outline a refactoring or migration plan—for example, upgrading a C# project from an older .NET version to .NET 8. The plan identifies which files, APIs, and patterns need to change. A handoff switches to an Upgrade agent that performs the code modifications across files according to the plan. A final handoff to a Review agent checks the updated code for issues introduced during the migration.

> [!NOTE]
> These workflows reflect how development teams can delegate a sequence of tasks—plan, code, test, review—to different specialized AI helpers while supervising each step. The result is a more efficient workflow where repetitive or complex tasks are handled by the AI, freeing the developer to focus on decision-making and verification.

## Agent execution environments

By default, custom agents run on the client (inside Visual Studio Code). However, agents can also be configured to run in the cloud by setting `target: cloud` in the agent's YAML frontmatter. Cloud agents execute remotely and are better suited for long-running tasks—such as building an entire feature or running a comprehensive test suite—that would otherwise keep your local Visual Studio Code instance occupied. Background agents are a related concept: they run independently without blocking the chat interface, allowing you to continue working while the agent processes a task.

## GitHub Copilot hooks

GitHub Copilot hooks enable you to execute custom shell commands at strategic points in an agent's workflow. Hooks are defined in your Visual Studio Code settings (not in agent files) and trigger before or after specific events, such as before GitHub Copilot saves a file or after it runs a terminal command. For example, you can configure a hook to run a linter automatically after GitHub Copilot edits a file, ensuring that AI-generated code always meets your formatting standards before being saved.

Hooks extend the automation capabilities of multi-agent workflows by adding lifecycle-based actions that complement the agent's own instructions and tools.

> [!NOTE]
> Hooks are a preview feature and their configuration format might change. They're configured in Visual Studio Code settings under `github.copilot.chat.hooks` and support events like `postSaveFile`, `preRunTerminalCommand`, and `postRunTerminalCommand`.

## Summary

Handoffs connect multiple custom agents into guided sequential workflows, enabling multi-step development tasks where each agent handles a specific phase. By configuring handoffs in the YAML frontmatter of agent files, you can create chains that transition from planning to implementation, implementation to review, or any other sequence that matches your team's development process. Each handoff keeps the developer in control, with the option to review and approve before proceeding to the next step. Other capabilities like cloud agents, background execution, and GitHub Copilot hooks extend these workflows with remote processing and lifecycle automation.
