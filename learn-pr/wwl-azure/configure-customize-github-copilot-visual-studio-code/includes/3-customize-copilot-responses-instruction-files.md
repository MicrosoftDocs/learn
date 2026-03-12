Custom instruction files provide a way to embed your team's coding standards, architectural decisions, and project-specific guidelines directly into your repository. When GitHub Copilot Chat processes a request, it reads these files and incorporates their content into its responses, producing suggestions that align with your project's conventions without requiring you to repeat the same context in every prompt.

## "Always-on" custom instructions

The primary mechanism for repository-level instructions is a Markdown file named `.github/copilot-instructions.md` placed at the root of your repository or workspace. This file provides GitHub Copilot with extra context and rules that apply to all GitHub Copilot Chat interactions within that project. The instructions are automatically included in every GitHub Copilot Chat prompt, acting as always-on guidelines for the AI.

For example, if your `.github/copilot-instructions.md` file specifies "Use PascalCase for class names and camelCase for local variables" or "Always use the repository pattern for data access classes," GitHub Copilot incorporates these conventions into its suggestions. This capability reduces the amount of manual editing needed to align AI-generated code with team guidelines, improving efficiency and consistency across the codebase.

The instructions are written in natural language using Markdown formatting. Each guideline can be its own bullet point or paragraph. Whitespace between instructions is ignored when sent to the model, so you can format the file for readability without affecting how GitHub Copilot processes it.

You can use the `/init` slash command in GitHub Copilot Chat to automatically generate a `copilot-instructions.md` file for your project. GitHub Copilot analyzes your workspace and produces a starter instruction file tailored to your project's language, framework, and structure.

> [!NOTE]
> Visual Studio Code also supports `AGENTS.md` and `CLAUDE.md` files as always-on instructions. An `AGENTS.md` file placed in the root of your workspace works similarly to `copilot-instructions.md` and is useful when you work with multiple AI agents and want a single set of instructions recognized by all of them. `CLAUDE.md` files follow the same pattern. Additionally, nested `AGENTS.md` files can be placed in subdirectories to provide context-specific instructions that apply only when GitHub Copilot operates on files within that directory or its children.

## Path-specific instructions

For projects where different parts of the codebase require different guidelines, you can create file-based instruction files using the `.instructions.md` extension. These files are stored in the `.github/instructions/` directory (or in your user profile for cross-workspace use) and include a YAML frontmatter header with an `applyTo` field that specifies which files or file patterns they apply to.

For instance, a file named `database.instructions.md` with `applyTo: "DataAccess/**/*.cs"` can contain rules that only apply to C# files in the DataAccess folder, such as "Use the repository pattern for data access classes" or "Always include parameterized queries to prevent SQL injection." When GitHub Copilot works with files that match the specified pattern, it merges both the repository-wide instructions and the relevant path-specific instructions to produce contextually appropriate suggestions.

The following example shows a path-specific instructions file with YAML frontmatter:

```markdown
---
name: 'C# Backend Standards'
description: 'Coding conventions for C# backend files'
applyTo: 'src/Backend/**/*.cs'
---
# C# backend coding standards
- Use PascalCase for public members and camelCase for private fields.
- Prefix private fields with an underscore (e.g., _orderService).
- Use async/await for all I/O-bound operations.
- Include XML documentation comments on all public methods.
```

The YAML frontmatter supports the following fields:

- **applyTo**: A glob pattern that determines which files trigger the instructions. Common patterns include `**/*.cs` to match all C# files, `src/Frontend/**/*.ts` to match TypeScript files in a specific directory, or `**/Tests/**/*.cs` to match test files across the project. When a file's path matches an `applyTo` pattern, GitHub Copilot automatically includes those instructions alongside the general repository instructions.

- **description**: A natural language description of what the instructions cover. GitHub Copilot uses this field for semantic matching—when you ask a question in chat, GitHub Copilot evaluates the description to determine whether the instructions are relevant to the current context, even if no file matching the `applyTo` pattern is open. For example, a description of "Guidelines for database migration scripts" helps GitHub Copilot include those instructions when you ask about database migrations.

- **name**: A display name for the instruction set that appears in the Chat Instructions menu and diagnostics view.

## Organization-level instructions

For enterprises that maintain coding standards across multiple repositories, GitHub supports organization-level instructions. These instructions are defined at the GitHub organization level and are applied across all repositories within the organization. This behavior ensures consistency across teams—for example, a shared secure coding standard or architectural guideline can be enforced organization-wide so that all projects start with the same baseline.

In Visual Studio Code, organization-level instructions are automatically detected when you're signed in to a GitHub account that has access to an organization with custom instructions configured. These instructions appear alongside your personal and workspace instructions in the Chat Instructions menu.

> [!NOTE]
> When multiple types of custom instructions exist, GitHub Copilot includes all of them but follows a priority order when resolving conflicts. The full instruction priority chain, from highest to lowest, is:
> 1. Instructions entered manually in the Chat Instructions menu or pinned to the conversation.
> 1. `.instructions.md` files (path-specific instructions).
> 1. `.github/copilot-instructions.md` (repository-wide instructions).
> 1. `AGENTS.md` or `CLAUDE.md` files.
> 1. Organization-level instructions configured by a GitHub organization administrator.
>
> Higher-priority instructions take precedence when conflicts occur.

## How to create instruction files

Creating custom instruction files involves a few straightforward steps.

### Enable the feature

Verify that custom instructions from `.github` files are enabled in Visual Studio Code's GitHub Copilot Chat settings. This setting is enabled by default. You can confirm it by checking the `chat.includeApplyingInstructions` setting in Visual Studio Code.

### Add .github/copilot-instructions.md

In your repository's root, create a `.github` folder if one doesn't already exist. Inside this folder, create a file named `copilot-instructions.md`. Write your guidelines in natural language using Markdown formatting. For example:

```markdown
# Project coding guidelines
- Use PascalCase for class names and public members.
- Prefix private fields with an underscore (e.g., _logger).
- Follow the repository pattern for all data access operations.
- Use async/await for I/O-bound operations.
- Include error handling with try-catch blocks for all external API calls.
- Add XML documentation comments on all public methods and classes.
```

These instructions are automatically appended to every GitHub Copilot Chat prompt in the repository, so they influence all responses without any extra action from the developer.

### Add .instructions.md files (if needed)

To target specific file types or sections of the project, create an `instructions` subfolder under `.github`. Add one or more Markdown files with names ending in `.instructions.md` (such as `logging.instructions.md` or `sql.instructions.md`). At the top of each file, include a YAML header with an `applyTo` field listing the file path patterns (glob patterns) that the instructions should apply to. Then write the specialized instructions in the Markdown body.

For example, a `logging.instructions.md` file could specify `applyTo: "**/*Logger.cs"` and contain guidance on using a specific logging framework in those files. If an active file's path matches the `applyTo` pattern, GitHub Copilot combines both the general repository instructions and the relevant path-specific instructions for that context.

### Verification

To confirm that GitHub Copilot is using your instructions, check the **References** section of a GitHub Copilot Chat response. When custom instructions are applied, the instructions file appears as a cited reference. If the instructions aren't being picked up, verify that the feature is enabled in settings and that the file path and naming follow the expected conventions.

You can also use the chat customization diagnostics view to see all loaded instruction files and any errors. Right-click in the Chat view and select **Diagnostics** to inspect the current state.

## Benefits of custom instructions

Repository-level instructions align AI output with team conventions and reduce the manual editing needed for each suggestion. Here are several ways custom instructions improve the development experience:

- **Naming conventions**: Enforce patterns like "private C# fields must start with an underscore" or "use PascalCase for public properties" across all GitHub Copilot suggestions.

- **Library and framework usage**: Specify preferred libraries, such as "Use `Serilog` for logging" or "Use `FluentValidation` for input validation," so GitHub Copilot doesn't suggest alternatives your team chooses not to use.

- **Code comment styles**: Require specific documentation formats, such as "Include XML documentation comments on all public methods" or "Use `//` for inline comments, not `/* */`."

- **Architectural patterns**: Embed decisions like "All data access classes must implement the `IRepository<T>` interface" or "Use dependency injection for all service dependencies."

- **Security and compliance**: Include rules like "Always use parameterized queries for database access" or "Validate all user input at API boundaries."

Path-specific instructions allow for even more targeted guidance. Different rules can apply to frontend versus backend code, test files versus production code, or specific modules with unique requirements. This granularity ensures that suggestions are relevant to the specific area of the codebase the developer is working in.

## Tips for writing effective instructions

Well-crafted instructions produce significantly better results. Here are tips for getting the most out of custom instruction files:

- **Explain the reasoning behind rules**. Instead of just "prefix private fields with `_`," write "Prefix private fields with `_` to distinguish them from parameters and local variables at a glance." When GitHub Copilot understands why a rule exists, it applies the rule more consistently and can extend the principle to similar situations.

- **Include short code examples**. Pair guidelines with brief code snippets showing the expected pattern. For instance, follow "Use the factory pattern for complex object creation" with a two-line example. Concrete examples reduce ambiguity.

- **Focus on non-obvious rules**. Don't repeat what linters and formatters already enforce. Instead, document the conventions that only your team knows—like which libraries to prefer, which patterns to follow for error handling, or which architectural boundaries exist between modules.

- **Keep instructions concise and specific**. Overly long or vague instruction files dilute GitHub Copilot's attention. Each instruction should express one clear rule. Remove instructions that overlap or contradict each other.

- **Separate concerns using path-specific files**. Use `.instructions.md` files with `applyTo` patterns to keep backend and frontend rules separate, test logic distinct from production code, and infrastructure scripts isolated from application code.

## Prompt files

In addition to instruction files that provide always-on context, Visual Studio Code supports **prompt files**—reusable prompt templates stored as `.prompt.md` files that you can invoke as slash commands in GitHub Copilot Chat.

While instruction files shape how GitHub Copilot responds, prompt files define what to ask. A prompt file contains a prewritten prompt—with optional variable placeholders—that you can run on demand to execute a common task consistently. For example, you might create a prompt file that generates a code review checklist, creates a unit test for the current file, or produces API documentation in a specific format.

### How prompt files work

Prompt files use the `.prompt.md` extension and can be stored in the `.github/prompts/` folder of your workspace (shared with your team through version control) or in your Visual Studio Code user profile (personal, available across all workspaces). Each file contains an optional YAML frontmatter header and a Markdown body with the prompt text.

The following example shows a prompt file that generates unit tests:

```markdown
---
description: 'Generate unit tests for the current file'
agent: 'copilot'
tools: ['search', 'read']
---
# Generate Unit Tests

Analyze the code in the active file and generate comprehensive unit tests.

For each public method or function:
1. Write a test for the expected behavior (happy path).
2. Write tests for edge cases and error conditions.
3. Use the project's existing test framework and naming conventions.

Output the tests as a complete, runnable test file.
```

The YAML frontmatter for prompt files supports these fields:

| Field | Description |
|---|---|
| `description` | A natural language description of what the prompt does. Appears in the slash command picker. |
| `name` | An optional display name. If omitted, the filename is used. |
| `agent` | The agent that should handle the prompt (for example, `copilot`). |
| `model` | An optional model preference for this prompt. |
| `tools` | Tools the prompt should have access to when executed. |

### Using prompt files

Once created, prompt files appear as slash commands in the GitHub Copilot Chat input. Type `/` followed by the prompt file's name (without the `.prompt.md` extension) to select and run it. For example, a file named `generate-tests.prompt.md` becomes the `/generate-tests` command.

Prompt files support variable placeholders using the `${variable}` syntax. The variable `${file}` refers to the currently active file, and `${selection}` refers to the current text selection. You can also define custom variables that prompt the user for input when the prompt file is executed.

> [!NOTE]
> To enable prompt files, verify that the `chat.promptFiles` setting is turned on in Visual Studio Code. When enabled, your `.prompt.md` files are automatically detected and registered as available slash commands.

## Limitations

Custom instruction files have a few important limitations to keep in mind:

- **No effect on inline autocomplete**: Custom instructions apply to GitHub Copilot Chat and other high-level requests. They don't influence the basic inline code completions that appear as you type in the editor.

- **Conciseness matters**: Large, unfocused instruction files can lead to diluted or unpredictable results. Keep instructions concise and relevant to the most important guidelines. Focus on rules that aren't already enforced by linters or formatters.

- **No guaranteed compliance**: Instructions guide GitHub Copilot's behavior but don't enforce strict rules. The AI considers the instructions alongside other context, so results might sometimes vary from expectations.

## Summary

Custom instruction files and prompt files provide a structured way to guide GitHub Copilot's behavior at the repository, path, and organization levels. By creating a `.github/copilot-instructions.md` file for project-wide standards, optional `.instructions.md` files for path-specific rules, and `.prompt.md` files for reusable prompt templates, you can align AI-generated suggestions with your team's coding conventions. When you write effective instructions—with reasoning, examples, and focused scope—it maximizes the value of these customization features. Together, these tools reduce manual corrections, improve code consistency, and embed your team's knowledge directly into the development workflow.
