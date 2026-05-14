After your test project contains a few test cases, GitHub Copilot can help you extend coverage and resolve failures without leaving Visual Studio Code. Ghost text suggestions add additional test cases inside the file you're editing, while the Test Explorer and the `/fixTestFailure` slash command help you diagnose and fix failing tests. Together, these features close the loop on the unit testing workflow that you started in the Chat view.

## Extend test coverage with ghost text suggestions

Ghost text is the inline code completion that appears as you type in the editor. When a test file already contains a few test cases, GitHub Copilot uses the existing patterns to suggest similar test cases for additional scenarios. This is the fastest way to extend coverage once your initial tests are in place.

To extend a test file with ghost text:

1. Open a test file that contains at least one or two complete test cases.

1. Position the cursor at the end of the last test case and press **Enter** to start a new line.

1. Start typing a new test method or write a descriptive comment such as `// Test that ProcessOrder throws when the order total is negative`.

    GitHub Copilot displays a ghost text suggestion that completes the test method based on the surrounding code, the imports, and the existing test patterns.

1. Press **Tab** to accept the suggestion, or press **Esc** to dismiss it.

1. Refine the accepted suggestion as needed. You can continue to type to extend the test, or you can trigger the next ghost text suggestion by pressing **Enter**.

Ghost text works best when:

- The test file already shows the pattern you want GitHub Copilot to follow (for example, Arrange-Act-Assert structure or a parameterized test attribute).
- The method under test is referenced in the file through a `using` directive or an imported namespace.
- Your comment clearly states the scenario you want to test.

> [!TIP]
> Use ghost text to add edge cases to an existing test class quickly. For more substantial work, such as creating an entirely new test class, return to the Chat view and use the Ask, Plan, or Agent agents.

## Fix failing tests from Test Explorer

When a test fails, Test Explorer provides a one-click entry point into GitHub Copilot.

1. Run your tests from Test Explorer or from the green play button next to a test method.

1. In Test Explorer, hover over a failing test.

1. Select the **Fix Test Failure** button (sparkle icon).

    GitHub Copilot opens a chat session, attaches the failing test and its output as context, and proposes a fix.

1. Review the proposed fix.

    The suggestion can update the application code, the test code, or both, depending on the cause of the failure.

1. Apply or discard the suggestion.

    Use **Keep** to apply the suggested changes, or use **Undo** to discard them. Rerun the test to confirm the fix.

## Fix failing tests with `/fixTestFailure`

You can also start the fix workflow from the Chat view, which is useful when you want to attach extra context or when you're working through several failing tests at once.

1. Open the Chat view.

1. Enter the `/fixTestFailure` slash command.

1. Optionally, attach additional context such as related source files or recent terminal output.

1. Follow GitHub Copilot's suggestions to fix the failing test, then rerun the test to confirm the fix.

## Let the Agent monitor and fix failures automatically

When you use the **Agent** to run tests, it monitors the test output, identifies failures, and automatically attempts to fix and rerun the tests. This is useful when you're scaffolding a new test project or making large changes that affect many tests at once.

To use the Agent for automatic test maintenance:

1. Open the Chat view and select **Agent** from the agent picker.

1. Provide a prompt that includes running the tests, such as: `Run the xUnit tests in the Calculator.Tests project. If any tests fail, propose and apply fixes, then rerun the tests until they pass.`

1. Confirm or reject the tool invocations and terminal commands the Agent suggests.

1. Review the changes the Agent applied before accepting them.

## Choose the right tool for the job

Use the following guidance to decide which feature to use:

- **Ghost text** is best when you want to add more test cases to an existing test file that already shows the pattern.
- **Fix Test Failure in Test Explorer** is best when a single test fails and you want a fast, focused fix.
- **`/fixTestFailure` in the Chat view** is best when you want to attach extra context or work through several failures.
- **Agent-driven test runs** are best when you want GitHub Copilot to run tests, diagnose failures, and apply fixes across multiple files in one session.

Together, these tools complete the unit testing workflow. The Chat view, Plan agent, and Agent generate the initial tests; ghost text fills in additional coverage; and the fix-test-failure features keep the suite green as your code evolves.
