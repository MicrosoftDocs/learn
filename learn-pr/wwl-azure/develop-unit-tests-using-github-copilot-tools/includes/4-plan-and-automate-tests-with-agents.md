The Ask agent is ideal for generating tests one prompt at a time, but larger testing tasks often require multiple steps: deciding what to test, scaffolding a test project, generating tests across several files, and running the resulting suite. The **Plan** and **Agent** agents in the Chat view are designed for that level of work. Use the Plan agent to design a test strategy before any code is written, then hand the approved plan to the Agent for autonomous implementation.

## Compare the Ask, Plan, and Agent agents

The Chat view provides three built-in local agents. Each one is optimized for a different type of testing task.

| Agent | Best for | Typical use in unit testing |
|---|---|---|
| **Ask** | Single-prompt responses about your code | Generate tests for a file or selection. |
| **Plan** | Structured, step-by-step implementation plans | Design a test strategy before writing tests. |
| **Agent** | Autonomous, multi-file coding workflows | Scaffold a test project, create tests across files, and run them. |

Choose an agent by selecting it from the agent picker in the Chat view. You can switch agents at any time during a session.

> [!IMPORTANT]
> When you use the Chat view with the Agent, GitHub Copilot might make multiple premium requests to complete a single task. Premium requests are used by both user-initiated prompts and the follow-up actions the agent takes on your behalf. The total premium requests used depends on the complexity of the task, the number of steps, and the model you select.

## Use the Plan agent to design a test strategy

The Plan agent produces a detailed implementation plan before any code is written. The agent researches your task, asks clarifying questions, and proposes a step-by-step plan that you can review, refine, and hand off to the Agent.

To plan a set of unit tests:

1. Open the file or files that contain the code you want to test.

1. Open the Chat view and select **Plan** from the agent picker. Alternatively, type `/plan` followed by your task description.

1. Enter a prompt that describes the tests you want to create. For example:

    `I need unit tests for the methods in the Calculator class. Use xUnit. Include tests for success, failure, and boundary conditions. Place the new tests in the Calculator.Tests project.`

1. Answer any clarifying questions.

    The Plan agent might ask about test framework preferences, naming conventions, or how to handle dependencies before drafting the plan.

1. Review the proposed plan.

    The plan typically includes a high-level summary, a breakdown of steps, verification steps for running the tests, and documented decisions. Iterate with the Plan agent until the plan reflects what you want to build.

1. Hand off the plan for implementation.

    When the plan is final, select the option to start implementation. You can implement the plan in the same chat session, or you can start a background or cloud session to work on the implementation autonomously. You can also open the plan in the editor for further review.

The Plan agent is especially useful when your testing task spans multiple files, requires new test classes or fixtures, or needs to align with team conventions that aren't already captured in instructions.

## Use the Agent to automate test workflows

The Agent automates multi-step tasks across your workspace. For unit testing, you can use the Agent to scaffold a test project, create test files, run the resulting tests, generate test reports, or fix issues that surface during a test run.

To use the Agent to create and run unit tests:

1. Open the file that contains the code you want to test.

1. Open the Chat view and select **Agent** from the agent picker.

1. Let the Agent determine the context.

    When you use the Agent, GitHub Copilot automatically identifies the relevant files. You can also attach additional context with the **Add Context** button or by dragging files into the Chat view.

1. Optionally, select the **Tools** icon to choose the tools the Agent is allowed to use for the task.

    Useful tools for testing tasks include the file editing tools, the terminal tool for running `dotnet test`, and any extension-provided test tools.

1. Enter a prompt that defines the task. For example:

    `Ensure that a suitable unit test project is prepared for the selected code file. Create a test file in the unit test project that includes unit tests for all methods in the selected file. Unit tests should be written in C# and use the xUnit framework. Run the tests to ensure expected results.`

1. Monitor the Agent as it works.

    - Confirm or reject the tool invocations and terminal commands the Agent suggests. For example, you can confirm the command to run the tests or to generate a test report.
    - Interrupt the Agent if you need to change the context, switch tools, or adjust the scope of the task.

1. Review the files the Agent created or updated, and then keep or discard the changes.

    Use follow-up prompts to refine specific tests if necessary.

## Decide when to use Plan, Agent, or both

Use the following guidance to choose between the agents:

- **Use the Plan agent first** when the testing work involves ambiguity, multiple files, or team conventions that need to be confirmed. The plan becomes a contract you can review before any code is written.
- **Use the Agent directly** when the task is well defined and you want GitHub Copilot to scaffold, generate, and run tests without an intermediate planning step.
- **Use Plan and then hand off to Agent** when you want a reviewable plan plus autonomous implementation. This combination gives you the most control over scope while still automating the work.
