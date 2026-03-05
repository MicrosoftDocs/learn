Custom agents are specialized AI assistants that you configure for particular roles or workflows in Visual Studio Code. Each agent encapsulates a set of instructions and tool permissions that steer GitHub Copilot's behavior to act as a specific type of expert. When you select a custom agent in GitHub Copilot Chat, the AI adopts that agent's persona, follows its guidelines, and uses only the tools you assigned to it.

## What are custom GitHub Copilot agents?

A custom agent is a tailored configuration that transforms GitHub Copilot Chat into a role-specific assistant. Instead of relying on general-purpose behavior, a custom agent operates according to instructions and constraints that you define. For example, you might create a "Security Reviewer" agent that analyzes code for vulnerabilities, a "Test Writer" agent that focuses on generating unit tests, or a "Planner" agent that produces implementation plans without modifying any files.

Custom agents were introduced as an advanced feature in Visual Studio Code (available as of Visual Studio Code release 1.106, previously known as "custom chat modes"). They give developers fine-grained control over how the AI operates in different development contexts. Each agent appears in the GitHub Copilot Chat agents dropdown, where you can select it to switch the AI's mode at any time.

Custom agents can be stored in two locations:

- **Workspace agents**: Stored in the `.github/agents/` folder of your repository. These agents are shared with your team through version control, ensuring everyone on the project has access to the same specialized assistants.

- **User profile agents**: Stored in your Visual Studio Code user profile's prompts folder. These agents are personal and available across all your workspaces, useful for agents that reflect your individual workflow preferences.

## Examine how custom agents work

A custom agent is a Markdown file with a `.agent.md` extension. Visual Studio Code automatically detects any `.agent.md` files in your workspace's `.github/agents/` folder (or in your user profile) and loads them as available agents in the GitHub Copilot Chat interface.

Each agent file consists of two parts:

- **A YAML frontmatter header**: This section specifies metadata including the agent's name, a description that appears in the chat interface, the tools it can use, an optional model preference, and handoff configurations for connecting to other agents.

- **A Markdown body**: This section contains the agent's instructions and context. The content is prepended to every user prompt whenever the agent is active, guiding how GitHub Copilot interprets and responds to requests. You write these instructions in the same natural language style used for custom instruction files.

### Agent frontmatter fields

The YAML frontmatter supports the following fields for configuring agent behavior:

| Field | Description |
|---|---|
| `description` | A short description displayed as placeholder text in the chat input when the agent is selected. |
| `name` | An optional display name. If omitted, the filename (without `.agent.md`) is used. |
| `tools` | An array of tools the agent can use, such as `['read', 'edit', 'search']`. Omitting this field gives access to all available tools. |
| `model` | A preferred AI model. Can be a single model ID string or an array of model IDs for fallback (for example, `['o4-mini', 'gpt-4.1']`). |
| `agents` | An array of agent names that can be invoked as subagents by this agent. |
| `handoffs` | An array of handoff configurations that define transitions to other agents (covered in the next unit). |
| `argument-hint` | Hint text displayed in the chat input, describing what the user should type as input to the agent. |
| `user-invokable` | A boolean that controls whether the agent appears in the agents dropdown. Set to `false` to create agents that can only be called as subagents by other agents. Defaults to `true`. |
| `disable-model-invocation` | When set to `true`, the agent doesn't send prompts to the language model. Useful for agents that perform actions solely through tools. |
| `target` | Specifies the execution environment for the agent: `client` (runs in Visual Studio Code, the default) or `cloud` (runs in the cloud). |
| `mcp-servers` | An object defining MCP (Model Context Protocol) servers that the agent should have access to. MCP servers extend agent capabilities by connecting to external tools and data sources. |

The following example shows the structure of a custom agent file using several of these fields:

```markdown
---
description: Reviews code for security vulnerabilities and suggests improvements
tools: ['search', 'read']
---
# Security Reviewer

You are a senior security engineer. When the user provides code or asks you to review files, analyze the code for common security vulnerabilities including:

- SQL injection
- Cross-site scripting (XSS)
- Authentication and authorization flaws
- Insecure data handling
- Hardcoded credentials or secrets

Provide your findings as a structured list with severity levels (Critical, High, Medium, Low). For each finding, explain the vulnerability, show the affected code, and suggest a secure alternative.

Do not modify any files. Your role is advisory only.
```

When a developer selects this agent in GitHub Copilot Chat, all interactions use these instructions. The agent "knows" it should focus on security analysis and won't attempt to edit files because its instructions and tool set restrict it to read-only operations.

## Define agent capabilities with tools

The `tools` field in the YAML frontmatter controls what actions the agent can perform. Tools determine whether the agent can read files, edit code, search the codebase, run terminal commands, or access other capabilities. By tailoring the tool list, you ensure each agent only performs actions relevant to its role.

Common tools include:

| Tool | Description |
|---|---|
| `read` | Read file contents from the workspace |
| `edit` | Modify files in the workspace |
| `search` | Search across workspace files |
| `fetch` | Retrieve content from URLs |
| `terminal` | Run commands in the terminal |
| `agent` | Invoke other agents as subagents |

If you omit the `tools` field entirely, the agent defaults to having access to all standard tools. However, explicitly listing tools is a best practice because it creates clear boundaries for the agent's behavior. A Planning agent that shouldn't modify code should specify only `['search', 'read', 'fetch']`, while an Implementation agent that needs to write code would include `['search', 'read', 'edit', 'terminal']`.

> [!NOTE]
> If a tool listed in the agent's configuration isn't available in the current environment, it's silently ignored. This means you can define agents with tools that might only be available in certain setups without causing errors.

## Subagents

The `agents` field in the YAML frontmatter lets an agent invoke other agents as subagents. A subagent is an agent that another agent calls to handle a subtask, then incorporates the result into its own response. This behavior is different from a handoff, which transfers control to the user; a subagent call happens within the agent's processing and returns the result to the calling agent automatically.

For example, a "Lead Developer" agent could invoke a "Security Reviewer" subagent to check a code snippet, receive the findings, and then incorporate those findings into its final response—all within a single interaction.

To configure subagents, list the subagent names in the `agents` field:

```yaml
---
description: Lead developer agent that coordinates with specialists
tools: ['search', 'read', 'edit']
agents: ['security-reviewer', 'test-writer']
---
```

Agents that are intended only for use as subagents can set `user-invokable: false` so they don't appear in the agents dropdown, keeping the interface clean.

> [!NOTE]
> To use subagents, include the `agent` tool in the calling agent's `tools` list (or omit the `tools` field entirely to enable all tools). The `agent` tool enables one agent to call another programmatically during its response.

## Organization-level agents

For teams that maintain shared agents across multiple repositories, GitHub supports organization-level agents. These agents are configured at the GitHub organization level and automatically appear alongside workspace and user-profile agents in Visual Studio Code when you're signed in to a GitHub account with access to the organization.

Organization-level agents ensure consistency across teams. For example, a security team can publish a shared "Security Reviewer" agent that every repository in the organization can use, guaranteeing that the same security review criteria are applied everywhere without requiring each repository to define its own agent.

## Agent format compatibility

Visual Studio Code recognizes agent files in the `.agent.md` format as the primary configuration. Additionally, Visual Studio Code supports Claude-style agent files that follow the Claude Code agent format. If you already have agent configurations from Claude Code, they work in Visual Studio Code's GitHub Copilot Chat without modification. This cross-compatibility simplifies migration for teams that use multiple AI tools.

## Built-in vs. custom agents

Visual Studio Code includes several built-in agents that provide general-purpose configurations for chat. These agents include the default "GitHub Copilot" agent and specialized agents for common tasks. Custom agents extend this system by letting you define your own roles with project-specific instructions and tool configurations.

Custom agents appear in the GitHub Copilot Chat agents dropdown alongside the built-in agents. You can switch between any agent at any time to change how the AI operates. This flexibility allows you to move between different modes of work—planning, coding, reviewing, testing—without leaving the GitHub Copilot Chat interface.

The key advantage of custom agents over built-in agents is specificity. A built-in code review agent applies general best practices, while your custom "Code Reviewer" agent can apply your team's specific review checklist, reference your project's architectural decisions, and focus on the patterns and anti-patterns that matter most in your codebase.

## Steps to create a custom agent

Follow these steps to create a custom agent in Visual Studio Code:

1. **Open the agents menu**: In the GitHub Copilot Chat pane, open the agents dropdown (which normally shows the current agent name). Select **Configure Custom Agents** and then choose **Create new custom agent**. Alternatively, run the `Chat: New Custom Agent` command from the Command Palette (Ctrl+Shift+P).

1. **Choose the scope**: Select where to store the agent file. Choose **Workspace** to create the file in `.github/agents/` (making it available to your team through version control), or choose **User profile** to make it personal and available across all your workspaces.

1. **Name the agent**: Enter a descriptive file name for the agent. This name appears as the default name in the agents dropdown. Use a name that clearly indicates the agent's role, such as `planner`, `code-reviewer`, or `test-writer`.

1. **Define the agent metadata**: In the YAML frontmatter of the newly created `.agent.md` file, configure the agent's properties. Set a `description` (this text appears as placeholder text in the chat input when the agent is selected), specify the `tools` the agent should have access to, and optionally set a preferred `model` or configure `handoffs` to other agents.

1. **Write the agent's instructions**: In the body of the file below the YAML frontmatter, provide the custom instructions for the agent. These instructions define the agent's persona, expertise, and behavioral guidelines. Write them in Markdown using clear, specific language that tells the AI how to approach tasks, what to focus on, and what constraints to follow.

1. **Save and activate**: Save the file. The custom agent appears immediately in the GitHub Copilot Chat agents dropdown (assuming `user-invokable` is `true`, which is the default). Select the agent to begin using it.

> [!TIP]
> You can type `/agents` in GitHub Copilot Chat as a quick shortcut to view and switch between all available agents, including built-in, workspace, user-profile, and organization-level agents.

## Agent skills

Agent skills are a related but distinct concept from custom agents. While agents define a persona with instructions and tools, **agent skills** (defined in `SKILL.md` files) describe specific capabilities or areas of expertise that an agent can draw on. Skills provide structured metadata about what an agent knows and can do. Visual Studio Code supports skills as part of its broader customization system. Skills are typically defined in your workspace and automatically detected by GitHub Copilot to enhance agent responses with specialized knowledge.

## Examples of custom agents

The following examples illustrate how to define agents for common development roles.

### "Planner" agent

A Planner agent focuses on analyzing requirements and generating implementation plans without modifying any code. It uses only read-only tools and includes a handoff to an Implementation agent for when the plan is ready to execute.

```markdown
---
description: Generates high-level implementation plans without writing code
tools: ['search', 'read', 'fetch']
handoffs:
  - label: Start Implementation
    agent: implementer
    prompt: Now implement the plan outlined above.
    send: false
---
# Planner

You are a senior software architect. When the user describes a feature or change, analyze the request and generate a detailed implementation plan.

Your plan should include:
1. A summary of the feature requirements.
2. A list of files that need to be created or modified.
3. Step-by-step implementation tasks in logical order.
4. Any potential risks or considerations.

Do not write or modify any code. Focus on planning only. Ask clarifying questions if the requirements are ambiguous.
```

### "Code Reviewer" agent

A Code Reviewer agent examines code for quality issues, security vulnerabilities, and adherence to best practices. It uses read and search tools but doesn't edit files directly.

```markdown
---
description: Reviews code for bugs, security issues, and style compliance
tools: ['search', 'read']
---
# Code Reviewer

You are an experienced code reviewer. When the user asks you to review code, examine it for:

- Bugs and logical errors
- Security vulnerabilities (SQL injection, XSS, authentication flaws)
- Performance issues
- Naming convention violations
- Missing error handling
- Code duplication

Present your findings as a structured review with severity levels. For each issue, explain the problem, show the affected code, and suggest an improvement. End with an overall assessment of code quality.
```

These examples can be adapted to match your team's specific needs. The key principle is to define clear instructions that focus the agent on a specific task and configure the tool list to match the agent's responsibilities.

## Summary

Custom agents in Visual Studio Code let you define specialized AI personas with tailored instructions and tool permissions. By creating `.agent.md` files in your workspace or user profile, you can build agents for specific development roles—planning, implementation, review, testing, and more. Each agent operates within the boundaries you define, using only the tools you allow and following the instructions you provide. Advanced features like subagents, organization-level agents, and MCP server integration extend what agents can accomplish. These capabilities give you precise control over how GitHub Copilot behaves in different stages of your development workflow.
