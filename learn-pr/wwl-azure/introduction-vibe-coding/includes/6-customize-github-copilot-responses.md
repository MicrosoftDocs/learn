GitHub Copilot Chat can generate responses and code that match your coding practices and project requirements when given the right context. Instead of repeatedly adding this information in every chat prompt, you can store this context in files and automatically include it in every chat request.

There are three main ways to customize AI responses in Visual Studio Code:

- **Custom instructions**: Define common guidelines for tasks like generating code, performing code reviews, or generating commit messages. These describe how tasks should be performed and can specify coding practices, preferred technologies, security rules, or commit message formats.

- **Prompt files**: Define reusable prompts for common tasks. These standalone prompts describe what should be done and can include scaffolding components, performing code reviews, creating step-by-step guides, or generating implementation plans.

- **Custom chat modes**: Define how chat operates, which tools it can use, and how it interacts with the codebase. Examples include planning modes with read-only access, research modes that access external resources, or role-specific modes like front-end development.

## Custom instructions

Custom instructions enable you to describe guidelines that get responses matching your specific coding practices and tech stack. Instead of manually including this context in every chat query, custom instructions automatically incorporate this information with every chat request.

> [!NOTE]
> Custom instructions are not taken into account for code completions.

### Types of custom instructions

Visual Studio Code supports three ways to define custom instructions:

| Type | Description | Use Cases |
|------|-------------|-----------|
| `.github/copilot-instructions.md` | Single Markdown file in workspace, automatically included in all requests, cross-editor support. | General coding practices, preferred technologies, project-wide requirements. |
| `.instructions.md files` | Multiple Markdown files with glob pattern support, workspace or user profile storage. | Task-specific instructions, granular control over when instructions apply. |
| Visual Studio Code settings | Instructions in user/workspace settings for specific scenarios. | Code generation, test generation, commit messages, code reviews, PR descriptions. |

You can combine these approaches, but avoid conflicting instructions as no priority order is applied.

### Custom instructions examples

General coding guidelines:

```md
---
applyTo: "**"
---
# Project coding standards

## Naming Conventions
- Use PascalCase for component names, interfaces, and type aliases.
- Use camelCase for variables, functions, and methods.
- Prefix private class members with underscore (_).
- Use ALL_CAPS for constants.

## Error Handling
- Use try/catch blocks for async operations.
- Implement proper error boundaries in React components.
- Always log errors with contextual information.
```

TypeScript and React guidelines:

```md
---
applyTo: "**/*.ts,**/*.tsx"
---
# TypeScript and React standards

Apply the [general coding guidelines](./general-coding.instructions.md) to all code.

## TypeScript Guidelines
- Use TypeScript for all new code.
- Follow functional programming principles where possible.
- Use interfaces for data structures and type definitions.
- Prefer immutable data (const, readonly).
- Use optional chaining (?.) and nullish coalescing (??) operators.

## React Guidelines
- Use functional components with hooks.
- Follow the React hooks rules (no conditional hooks).
- Use React.FC type for components with children.
- Keep components small and focused.
- Use CSS modules for component styling.
```

### Use .github/copilot-instructions.md file

Store custom instructions in a `.github/copilot-instructions.md` file at your workspace root to describe coding practices, preferred technologies, and project requirements. These instructions apply only to the workspace and are automatically included in every chat request.

Setup steps:

1. Verify that `github.copilot.chat.codeGeneration.useInstructionFiles` is enabled (on by default in recent versions of Visual Studio Code).
1. Create `.github/copilot-instructions.md` at workspace root.
1. Describe instructions using natural language and Markdown format.

> [!NOTE]
> This file works across Visual Studio Code, Visual Studio, and GitHub.com.

### Use .instructions.md files

Create multiple `.instructions.md` files for specific tasks, programming languages, frameworks, or project types. These can be automatically applied based on file patterns or manually attached to chat prompts.

File locations:

- **Workspace files**: Stored in `.github/instructions` folder, available only within the workspace.
- **User files**: Stored in Visual Studio Code profile, available across multiple workspaces and synced via Settings Sync.

File structure:

```md
---
description: "Brief description of the instructions file"
applyTo: "**/*.ts,**/*.tsx"  # Glob pattern for automatic application
---
# Instructions content in Markdown format
```

Create and use instructions files:

1. Run `Chat: New Instructions File` from Command Palette.
1. Choose workspace or user location.
1. Enter name and author instructions in Markdown.
1. Use `Chat: Configure Instructions` to edit existing files.

Manual attachment:

- In Chat view: Add Context > Instructions
- Command Palette: `Chat: Attach Instructions`

Automatic application: Use `applyTo` metadata with glob patterns (`**` for all requests, specific patterns for targeted application)

### Specify custom instructions in settings

Configure custom instructions in Visual Studio Code settings for specific scenarios:

| Scenario | Setting |
|----------|---------|
| Code generation | `github.copilot.chat.codeGeneration.instructions` |
| Test generation | `github.copilot.chat.testGeneration.instructions` |
| Code review | `github.copilot.chat.reviewSelection.instructions` |
| Commit messages | `github.copilot.chat.commitMessageGeneration.instructions` |
| PR titles/descriptions | `github.copilot.chat.pullRequestDescriptionGeneration.instructions` |

Define instructions as text or reference external files:

```json
"github.copilot.chat.codeGeneration.instructions": [
  {
    "text": "Always add a comment: 'Generated by Copilot'."
  },
  {
    "text": "In TypeScript always use underscore for private field names."
  },
  {
    "file": "general.instructions.md"
  },
  {
    "file": "db.instructions.md"
  }
]
```

### Best practices for custom instructions

- **Keep instructions concise**: Each instruction should be a single, simple statement.
- **Avoid external references**: Don't refer to external coding standards or resources.
- **Organize by topic**: Split instructions into multiple files for better organization.
- **Enable team sharing**: Store instructions in version-controlled files for team collaboration.
- **Use targeted application**: Leverage `applyTo` property for file-specific instructions.
- **Reference efficiently**: Reference custom instructions in prompt files to avoid duplication.

## Prompt files

Prompt files are reusable, standalone task prompts stored as `.prompt.md` files. Unlike custom instructions — which describe *how* GitHub Copilot should respond — prompt files describe *what* should be done for a specific task. You run them on demand rather than having them automatically apply to every request.

Prompt files are well-suited to recurring vibe coding workflows: scaffolding a new component, generating a first draft of a product requirements document, running a code review pass, or kicking off a session with your project context already loaded.

### Create a prompt file

Store prompt files in the `.github/prompts/` folder in your workspace. The file name becomes the prompt name.

File structure:

```md
---
mode: "ask"
description: "Generate a product requirements document for a new feature"
---
# Generate a PRD

Create a product requirements document for the described feature.

Include the following sections:
- Product summary
- Target audience
- Core features (prioritized by must-have / should-have / could-have)
- Out of scope
- Technical requirements

Feature description: ${input:Feature description}
```

### Run a prompt file

- **Command Palette**: Run `Chat: Run Prompt` and select the file.
- **Chat input**: Type `#` in the Chat view and select the prompt file by name.

Prompt files support `mode` values of `ask`, `edit`, and `agent`. They can also reference your custom instructions files using Markdown link syntax to avoid duplicating content across files.

## Custom chat modes

Custom chat modes let you configure how the GitHub Copilot Chat panel operates for a specific workflow. You define which tools are available, how the AI interacts with your codebase, and what role it should play — without modifying your custom instructions.

For vibe coding, this is especially useful for separating the *planning* phase from the *building* phase. A planning mode can restrict GitHub Copilot to read-only analysis so it proposes designs without making changes, while an implementation mode unlocks full editing tools.

### Create a custom chat mode

Store custom chat mode files in the `.github/chatmodes/` folder in your workspace.

File structure:

```md
---
description: "Plan mode: read-only analysis and architecture decisions"
tools: []
---
You are a software architect in planning mode. Analyze the codebase, identify patterns, suggest designs, and answer questions — but do not make any code changes.
```

Common chat mode configurations for vibe coding:

| Mode | Tools | Use case |
|------|-------|----------|
| Planning | None (read-only) | Architecture decisions, feature design, PRD review |
| Research | Web search | Investigating libraries, comparing approaches |
| Implementation | Full tool access | Writing and editing code, running commands |
| Review | Read-only | Code review, security audit, performance check |

### Use a custom chat mode

Select the mode from the chat mode picker in the Chat view toolbar. The mode persists for the session until you switch.

## Summary

Customizing GitHub Copilot responses lets you shape AI assistance to fit your specific workflow. Custom instructions — using `.github/copilot-instructions.md` files, `.instructions.md` files, or Visual Studio Code settings — define *how* GitHub Copilot should respond, encoding your coding practices, standards, and preferences. Prompt files define *what* should be done for recurring tasks, giving you reusable prompts you can run on demand. Custom chat modes configure *how the chat session operates*, letting you switch between planning, research, implementation, and review workflows without changing your underlying instructions. Together, these three tools help you build a consistent vibe coding environment where GitHub Copilot understands your project from the start.
