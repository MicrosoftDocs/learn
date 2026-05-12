The Chat view in Visual Studio Code is the primary way to generate unit tests with GitHub Copilot. From the Chat view, you can configure a test framework, generate tests for a file or selection, and refine the results until the tests match your project's conventions. This unit focuses on using the Chat view with the **Ask** agent and slash commands to produce unit tests on demand.

## Open the Chat view

Open the Chat view using either of the following options:

- Press **Ctrl** + **Alt** + **I** (Windows/Linux) or **Cmd** + **Alt** + **I** (macOS).
- Select the GitHub Copilot icon in the title bar and then select **Open Chat**.

The Chat view opens in the Secondary Side Bar and provides three configuration choices that affect every prompt you send:

- **Agent Target**: Where the agent runs. Select **Local** to run the agent interactively in the editor with full access to your workspace, tools, and models.
- **Agent**: The role the AI takes for the session. The built-in local agents are **Ask**, **Plan**, and **Agent**. Use **Ask** for generating tests directly from prompts.
- **Permission level**: How much autonomy the agent has when invoking tools and terminal commands. Options are **Default Approvals**, **Bypass Approvals**, and **Autopilot**.

For most unit test generation work, the **Ask** agent with **Default Approvals** is the right starting point.

## Set up a testing framework with `/setupTests`

If your project doesn't yet have a test framework configured, GitHub Copilot can recommend one and walk you through the configuration steps.

1. Open the Chat view.

1. Enter the `/setupTests` command in the chat input field.

1. Follow GitHub Copilot's guidance to install packages, add a test project, and recommend Visual Studio Code testing extensions.

`/setupTests` is most useful when you're starting a new test project or onboarding a project that doesn't yet include tests.

## Generate tests with `/tests`

The `/tests` slash command generates unit tests for the code that's currently active in the editor. GitHub Copilot detects the existing test framework and coding style and produces tests that match.

To generate tests for an entire file:

1. Open the application code file you want to test.

1. Open the Chat view.

1. In the chat input field, enter `/tests` followed by any additional guidance. For example: `/tests Generate unit tests for the methods in this file. Include success, failure, and edge cases.`

1. Review the generated tests.

    GitHub Copilot appends the tests to an existing test file when one is available, or creates a new test file if one doesn't exist.

1. Select **Keep** or **Undo** to accept or discard the suggested tests.

To generate tests for a specific method or block of code:

1. Open the application code file.

1. Select the method or block you want to test.

1. In the Chat view, enter `/tests` followed by guidance that references the selection. For example: `/tests Generate unit tests for the selected method. Validate both success and failure, and include edge cases.`

1. Review and keep or discard the suggested tests.

## Generate tests with a natural-language prompt

You don't have to use a slash command. The Ask agent generates tests from natural-language prompts when you include enough context. Examples:

- "Generate xUnit tests for the methods in this file."
- "Write unit tests for the `CalculateDiscount` method, including edge cases for negative values and zero."
- "Create integration tests for the data access layer in this module."

## Add context to your prompts

The quality of the generated tests depends on the context you provide. Use one or more of the following options to attach context to a Chat view prompt:

- **Add Context** button: Open a Quick Pick to add files, folders, symbols, or the current editor selection.
- **Drag and drop**: Drag files from the Explorer view, or drag an editor tab, onto the Chat view to attach the contents.
- **`#` mentions**: Type `#` followed by a file, folder, or symbol name to add it as context. Use `#selection` to attach the current editor selection, or `#codebase` to let GitHub Copilot search the workspace for relevant context.
- **External files**: Open markdown files (for example, contributor guidelines or test conventions) in the editor and attach them through **Add Context**. The Ask agent uses the content to shape the generated tests.

For example, if a single method is visible in the editor, you can ask: `Write a unit test for the method in #editor`. If multiple methods are visible or the target method extends beyond the visible area, select the code first and ask: `#selection write unit tests for the selected code`.

## Apply suggested tests to a test file

After GitHub Copilot suggests tests, you can move them into a test project in one of two ways:

- **Apply in Editor**: From the chat response, select **Apply in Editor** to insert the suggested code at the current cursor position in an open test file.
- **Copy and paste**: Copy the suggested code from the chat response into the target test file. Use this option when you want to review and reorganize the tests as you add them.

Save the test file after adding the tests, then build the test project to ensure that the new tests compile.

## Personalize test generation with custom instructions

If your organization has specific testing requirements, you can customize how GitHub Copilot generates tests so the output matches your standards. Custom instructions let you:

- Specify preferred testing frameworks (for example, xUnit instead of NUnit).
- Define naming conventions for test classes and methods.
- Set code structure preferences such as the Arrange-Act-Assert pattern.
- Request specific test patterns, such as parameterized tests for boundary values.

Store custom instructions in a `*.instructions.md` file in your workspace. Use the `applyTo` metadata field to apply the instructions only to test files. For example, an `applyTo: tests/**` value scopes the instructions to files in the `tests/` directory. Sharing the file in source control gives every developer on the team the same testing context.

> [!IMPORTANT]
> Generated test cases might not cover every scenario. Manual review and code review are still required to ensure the quality of your tests.
