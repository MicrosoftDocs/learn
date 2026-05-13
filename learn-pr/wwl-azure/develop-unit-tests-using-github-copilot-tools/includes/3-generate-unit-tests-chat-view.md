The Chat view in Visual Studio Code is the primary place to generate unit tests with GitHub Copilot. From the Chat view, you can configure a test framework, generate tests for a file or selection, and refine the results until the tests match your project's conventions. This unit focuses on **Agent mode**, which writes generated tests directly into a test file, can run the resulting tests, and iterates on failures—all from a single chat prompt. You can also use **Ask mode** beforehand to explore your testing options without making any file changes.

## Open the Chat view

Open the Chat view using either of the following options:

- Press **Ctrl** + **Alt** + **I** (Windows/Linux) or **Cmd** + **Alt** + **I** (macOS).
- Select the GitHub Copilot icon in the title bar and then select **Toggle Chat**.

The Chat view opens in the Secondary Side Bar and provides three configuration choices that affect every prompt you send:

- **Agent Target**: Where the agent runs. Select **Local** to run the agent interactively in the editor with full access to your workspace, tools, and models.
- **Agent**: The role the AI takes for the session. The built-in local agents are **Ask**, **Plan**, and **Agent**.
- **Permission level**: How much autonomy the agent has when invoking tools and terminal commands. Options are **Default Approvals**, **Bypass Approvals**, and **Autopilot**.

For unit test generation, the recommended starting point is the **Agent** with **Default Approvals**. Agent mode can edit files, run terminal commands, and rerun tests, so it can take a prompt like "generate tests for this method" and produce a working test file you only need to review. Default Approvals keeps you in the loop by asking you to confirm each tool invocation.

## Optionally, use Ask mode to explore testing options first

Ask mode answers questions in chat without modifying files or invoking tools. That makes it a good fit when you want to plan an approach before you let the Agent change anything. Use Ask mode when you want to:

- Compare candidate test cases for a complex method before committing to a structure.
- Identify edge cases and boundary conditions worth covering.
- Get a recommendation for a test framework or assertion style.
- See an example test in chat without writing it to disk.

To use Ask mode for analysis:

1. Open the Chat view and select **Ask** from the agent picker.

1. Attach the relevant file or selection as context (for example, with `#selection` or by dragging a file in).

1. Ask an analysis question. For example: `What edge cases should I cover when testing the CalculateDiscount method? List the scenarios and explain why each one matters.`

1. Review the response, then switch the agent picker to **Agent** to generate the actual tests.

## Set up a testing framework with `/setupTests`

If your project doesn't yet have a test framework configured, GitHub Copilot can recommend one and walk you through the configuration steps. The `/setupTests` slash command works in any agent, but Agent mode can also install packages and create the test project for you.

1. Open the Chat view and select **Agent** from the agent picker.

1. Enter the `/setupTests` command in the chat input field.

1. Confirm the tool invocations and terminal commands the Agent suggests to install packages, scaffold the test project, and recommend Visual Studio Code testing extensions.

`/setupTests` is most useful when you're starting a new test project or onboarding a project that doesn't yet include tests.

## Generate tests with `/tests`

The `/tests` slash command generates unit tests for the code that's currently active in the editor. In Agent mode, the generated tests are written directly into an appropriate test file. GitHub Copilot detects the existing test framework and coding style and produces tests that match.

To generate tests for an entire file:

1. Open the application code file you want to test.

1. Open the Chat view and confirm that **Agent** is selected.

1. In the chat input field, enter `/tests` followed by any additional guidance. For example: `/tests Generate unit tests for the methods in this file. Include success, failure, and edge cases.`

1. Confirm the tool invocations the Agent uses to read context, write the tests, and (optionally) run them.

1. Review the changes the Agent applied.

    The Agent appends tests to an existing test file when one is available, or creates a new test file in the appropriate location. The diff appears in the editor so you can verify each change.

1. Select **Keep** or **Undo** to accept or discard the changes.

To generate tests for a specific method or block of code:

1. Open the application code file.

1. Select the method or block you want to test.

1. In the Chat view, enter `/tests` followed by guidance that references the selection. For example: `/tests Generate unit tests for the selected method. Validate both success and failure, and include edge cases.`

1. Review and keep or discard the resulting changes.

## Generate tests with a natural-language prompt

You don't have to use a slash command. The Agent generates tests from natural-language prompts when you include enough context. Examples:

- "Generate xUnit tests for the methods in this file and add them to the Calculator.Tests project."
- "Write unit tests for the `CalculateDiscount` method, including edge cases for negative values and zero. Run the tests after writing them."
- "Create integration tests for the data access layer in this module."

Because the Agent can run commands, you can include verification steps in the same prompt. Asking the Agent to run the tests after writing them lets it catch and fix obvious failures before handing the work back to you.

## Add context to your prompts

The quality of the generated tests depends on the context you provide. Use one or more of the following options to attach context to a Chat view prompt:

- **Add Context** button: Open a Quick Pick to add files, folders, symbols, or the current editor selection.
- **Drag and drop**: Drag files from the Explorer view, or drag an editor tab, onto the Chat view to attach the contents.
- **`#` mentions**: Type `#` followed by a file, folder, or symbol name to add it as context. Use `#selection` to attach the current editor selection, or `#codebase` to let GitHub Copilot search the workspace for relevant context.
- **External files**: Open markdown files (for example, contributor guidelines or test conventions) in the editor and attach them through **Add Context**. The Agent uses the content to shape the generated tests.

For example, if a single method is visible in the editor, you can ask: `Write a unit test for the method in #editor`. If multiple methods are visible or the target method extends beyond the visible area, select the code first and ask: `#selection write unit tests for the selected code`.

## Review and refine the Agent's changes

Even though the Agent writes tests directly into your test project, you stay in control:

- **Review the diff**: Each file the Agent changes opens in the editor with the proposed edits highlighted. Walk through the diff before accepting it.
- **Keep or Undo**: Use **Keep** to accept the changes, or **Undo** to revert them. You can also revert individual hunks from the editor.
- **Build and run**: After keeping the changes, build the test project and run the tests from Test Explorer or the terminal to confirm everything compiles and passes.
- **Iterate**: Use follow-up prompts in the same chat session to refine specific tests, add more cases, or rename methods.

## Personalize test generation with custom instructions

If your organization has specific testing requirements, you can customize how GitHub Copilot generates tests so the output matches your standards. Custom instructions let you:

- Specify preferred testing frameworks (for example, xUnit instead of NUnit).
- Define naming conventions for test classes and methods.
- Set code structure preferences such as the Arrange-Act-Assert pattern.
- Request specific test patterns, such as parameterized tests for boundary values.

Store custom instructions in a `*.instructions.md` file in your workspace. Use the `applyTo` metadata field to apply the instructions only to test files. For example, an `applyTo: tests/**` value scopes the instructions to files in the `tests/` directory. Sharing the file in source control gives every developer on the team the same testing context.

> [!IMPORTANT]
> Generated test cases might not cover every scenario. Manual review and code review are still required to ensure the quality of your tests.
