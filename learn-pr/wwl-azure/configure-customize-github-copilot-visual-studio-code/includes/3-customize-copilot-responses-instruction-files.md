Custom instruction files provide a way to embed your team's coding standards, architectural decisions, and project-specific guidelines directly into your repository. When Copilot Chat processes a request, it reads these files and incorporates their content into its responses, producing suggestions that align with your project's conventions without requiring you to repeat the same context in every prompt.

## "Always-on" custom instructions

The primary mechanism for repository-level instructions is a Markdown file named `.github/copilot-instructions.md` placed at the root of your repository or workspace. This file provides Copilot with additional context and rules that apply to all Copilot Chat interactions within that project. The instructions are automatically included in every Copilot Chat prompt, acting as always-on guidelines for the AI.

For example, if your `.github/copilot-instructions.md` file specifies "Use PascalCase for class names and camelCase for local variables" or "Always use the repository pattern for data access classes," Copilot incorporates these conventions into its suggestions. This reduces the amount of manual editing needed to align AI-generated code with team guidelines, improving efficiency and consistency across the codebase.

The instructions are written in natural language using Markdown formatting. Each guideline can be its own bullet point or paragraph. Whitespace between instructions is ignored when sent to the model, so you can format the file for readability without affecting how Copilot processes it.

> [!NOTE]
> VS Code also supports `AGENTS.md` files as always-on instructions. An `AGENTS.md` file placed in the root of your workspace works similarly to `copilot-instructions.md` and is useful when you work with multiple AI agents and want a single set of instructions recognized by all of them.

## Path-specific instructions

For projects where different parts of the codebase require different guidelines, you can create file-based instruction files using the `.instructions.md` extension. These files are stored in the `.github/instructions/` directory (or in your user profile for cross-workspace use) and include a YAML frontmatter header with an `applyTo` field that specifies which files or file patterns they apply to.

For instance, a file named `database.instructions.md` with `applyTo: "DataAccess/**/*.cs"` can contain rules that only apply to C# files in the DataAccess folder, such as "Use the repository pattern for data access classes" or "Always include parameterized queries to prevent SQL injection." When Copilot works with files that match the specified pattern, it merges both the repository-wide instructions and the relevant path-specific instructions to produce contextually appropriate suggestions.

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

The `applyTo` field accepts glob patterns. Common patterns include `**/*.cs` to match all C# files, `src/Frontend/**/*.ts` to match TypeScript files in a specific directory, or `**/Tests/**/*.cs` to match test files across the project. When a file's path matches an `applyTo` pattern, Copilot automatically includes those instructions alongside the general repository instructions.

## Organization-level instructions

For enterprises that maintain coding standards across multiple repositories, GitHub supports organization-level instructions. These instructions are defined at the GitHub organization level and are applied across all repositories within the organization. This ensures consistency across teams—for example, a shared secure coding standard or architectural guideline can be enforced organization-wide so that all projects start with the same baseline.

In Visual Studio Code, organization-level instructions are automatically detected when you're signed in to a GitHub account that has access to an organization with custom instructions configured. These instructions appear alongside your personal and workspace instructions in the Chat Instructions menu.

> [!NOTE]
> Personal instructions take the highest priority, followed by repository instructions, and then organization instructions. When multiple types of custom instructions exist, they're all provided to the AI, but higher-priority instructions take precedence when conflicts occur.

## How to create instruction files

Creating custom instruction files involves a few straightforward steps.

### Enable the feature

Verify that custom instructions from `.github` files are enabled in VS Code's Copilot Chat settings. This setting is enabled by default. You can confirm it by checking the `chat.includeApplyingInstructions` setting in VS Code.

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

These instructions are automatically appended to every Copilot Chat prompt in the repository, so they influence all responses without any additional action from the developer.

### Add .instructions.md files (if needed)

To target specific file types or sections of the project, create an `instructions` subfolder under `.github`. Add one or more Markdown files with names ending in `.instructions.md` (such as `logging.instructions.md` or `sql.instructions.md`). At the top of each file, include a YAML header with an `applyTo` field listing the file path patterns (glob patterns) that the instructions should apply to. Then write the specialized instructions in the Markdown body.

For example, a `logging.instructions.md` file could specify `applyTo: "**/*Logger.cs"` and contain guidance on using a specific logging framework in those files. If an active file's path matches the `applyTo` pattern, Copilot combines both the general repository instructions and the relevant path-specific instructions for that context.

### Verification

To confirm that Copilot is using your instructions, check the **References** section of a Copilot Chat response. When custom instructions are applied, the instructions file appears as a cited reference. If the instructions aren't being picked up, verify that the feature is enabled in settings and that the file path and naming follow the expected conventions.

You can also use the chat customization diagnostics view to see all loaded instruction files and any errors. Right-click in the Chat view and select **Diagnostics** to inspect the current state.

## Benefits of custom instructions

Repository-level instructions align AI output with team conventions and reduce the manual editing needed for each suggestion. Here are several ways custom instructions improve the development experience:

- **Naming conventions**: Enforce patterns like "private C# fields must start with an underscore" or "use PascalCase for public properties" across all Copilot suggestions.

- **Library and framework usage**: Specify preferred libraries, such as "Use `Serilog` for logging" or "Use `FluentValidation` for input validation," so Copilot doesn't suggest alternatives your team has decided against.

- **Code comment styles**: Require specific documentation formats, such as "Include XML documentation comments on all public methods" or "Use `//` for inline comments, not `/* */`."

- **Architectural patterns**: Embed decisions like "All data access classes must implement the `IRepository<T>` interface" or "Use dependency injection for all service dependencies."

- **Security and compliance**: Include rules like "Always use parameterized queries for database access" or "Validate all user input at API boundaries."

Path-specific instructions allow for even more targeted guidance. Different rules can apply to frontend versus backend code, test files versus production code, or specific modules with unique requirements. This granularity ensures that suggestions are relevant to the specific area of the codebase the developer is working in.

## Limitations

Custom instruction files have a few important limitations to keep in mind:

- **No effect on inline autocomplete**: Custom instructions apply to Copilot Chat and other high-level requests. They don't influence the basic inline code completions that appear as you type in the editor.

- **Conciseness matters**: Large, unfocused instruction files can lead to diluted or unpredictable results. Keep instructions concise and relevant to the most important guidelines. Focus on rules that aren't already enforced by linters or formatters.

- **No guaranteed compliance**: Instructions guide Copilot's behavior but don't enforce strict rules. The AI considers the instructions alongside other context, so results may sometimes vary from expectations.

## Summary

Custom instruction files provide a structured way to guide Copilot's behavior at the repository, path, and organization levels. By creating a `.github/copilot-instructions.md` file for project-wide standards and optional `.instructions.md` files for path-specific rules, you can align AI-generated suggestions with your team's coding conventions. This reduces manual corrections, improves code consistency, and embeds your team's knowledge directly into the development workflow.
