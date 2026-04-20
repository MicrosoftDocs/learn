The Chat view in Visual Studio Code provides three built-in agents that can be used to create unit tests: Ask, Plan, and Agent. Each agent has its own strengths, and the best agent to use depends on the specific task at hand.

## Configure your chat session

When you start a chat session, three choices shape how the AI responds:

- **Agent type**: determines where the agent runs. Select a type from the **Agent Target** dropdown in the Chat view. Select **Local** to run the agent interactively in the editor with full access to your workspace, tools, and models. Other options include Copilot CLI, Cloud, and third-party providers.
- **Agent**: determines the role or persona of the AI. Select an agent from the **agent picker** in the Chat view. The three built-in local agents are Ask, Plan, and Agent.
- **Permission level**: controls how much autonomy the agent has for invoking tools and terminal commands. Options are **Default Approvals**, **Bypass Approvals**, and **Autopilot**.

The Ask, Plan, and Agent agents are designed to work with local agent targets, and each agent is optimized for different types of interactions:

- The **Ask** agent is optimized for asking questions about your code projects, coding topics, and general technology concepts.
- The **Plan** agent is optimized for creating a structured, step-by-step implementation plan before writing any code.
- The **Agent** is optimized for autonomous coding workflows that span multiple files and terminal commands.

> [!IMPORTANT]
> When you use the Chat view with the Agent, GitHub Copilot may make multiple premium requests to complete a single task. Premium requests can be used by user-initiated prompts and follow-up actions GitHub Copilot takes on your behalf. The total premium requests used depends on the complexity of the task, the number of steps involved, and the model selected.

## Use the Ask agent to create unit tests

The Ask agent can be used to analyze a workspace and then create unit tests. The Ask agent is useful when you want to create tests for multiple functions or methods in a file, or when you want to create tests for an entire file.

To create unit tests using the Ask agent, follow these steps:

1. Open the file that contains the code you want to test.

1. Open the Chat view and start a new chat session using the Ask agent.

1. Add context to the chat session.

    - You can add context to the chat session by dragging and dropping files from Visual Studio Code's EXPLORER view into the Chat view. You can also use the **Add Context** button.
    - You can open external files in the code editor to include resources that aren't part of the workspace and use them to provide specific context. For example, you can open markdown files that contain contributor guidelines or contact information and then use the **Add Context** button to add them to the Chat view context.
    - You can use Copilot Chat with your project context to guide prompts and generate more relevant suggestions. This is especially useful when creating tests for multiple functions or methods in a file, or when generating tests for an entire file.

1. Enter a prompt that asks for unit tests for the code in the file.

    - For example: "`I need to create unit tests for the code in this file. The tests should be written in Python and use the unittest framework. Please generate the tests and explain how they work.`"

1. Review the suggested unit tests, and refine the results using updated prompts if necessary.

1. Move the suggested unit tests into a test file.

    - For example, create a test file in the same directory as the code file, and then insert the suggested unit tests into the file.
    - You can use the Ask agent to suggest updates for specific tests after creating the test file, or use other GitHub Copilot tools to help with updates.
    - You can also use the **Apply in Editor** button to apply the suggested unit tests directly to the code file.

1. Save the test file.

    - Test files are typically saved to a separate "tests" directory in a project that's configured for unit tests. Your options depend on your project's structure and testing framework.
    - You can use the Ask agent to suggest updates for specific tests after creating the test file, or use other GitHub Copilot tools to help with updates.

1. Run the tests to ensure they pass and verify the functionality of your code.

1. If necessary, refine the tests by adding more test cases or modifying existing ones.

1. Save the file again after making any changes to the tests.

## Use the Plan agent to plan unit tests

The Plan agent can be used to create a detailed implementation plan for your unit tests before writing any code. The Plan agent researches your task comprehensively, asks clarifying questions, and produces a step-by-step plan. Once the plan is reviewed and approved, you can hand it off to the Agent for implementation.

To plan unit tests using the Plan agent, follow these steps:

1. Open the file that contains the code you want to test.

1. Open the Chat view and start a new chat session using the Plan agent. You can select **Plan** from the agents dropdown, or type `/plan` followed by your task description.

1. Enter a prompt that describes the unit tests you want to create.

    - For example: "`I need to create unit tests for the code in this file. The tests should be written in Python and use the unittest framework. Create a test file in the same directory as the code file.`"

1. Answer any clarifying questions the Plan agent asks after researching your task.

    - The Plan agent may ask questions to resolve ambiguities before drafting the plan.

1. Preview the proposed plan draft and provide feedback for iteration.

    - The Plan agent provides a high-level summary, a breakdown of steps, verification steps for testing, and documented decisions made during planning.
    - Stay in the Plan agent to refine your plan before implementation. You can iterate multiple times to clarify requirements, adjust scope, or provide additional context.

1. Once finalized, use the buttons to start implementation of the plan or to open the plan in the editor for further review.

    - You can choose to implement the plan in the same chat session, or start a background or cloud agent session to work on the implementation autonomously.
    - When starting to implement the plan, you can still provide clarifying instructions, like "Start with the UI", or "only step 1 and 2".

## Use the Agent to create unit tests

The Agent can be used to automate tasks within your unit testing process. For example, you can use the Agent to scaffold a test project, create test files, run tests, generate test reports, or perform other tasks related to unit testing. The Agent is best for creating unit tests that require a more in-depth understanding of the project.

To create unit tests using the Agent, follow these steps:

1. Open the file that contains the code you want to test.

1. Open the Chat view and start a new chat session using the **Agent**.

1. Let the Agent determine the context.

    When using the Agent, GitHub Copilot automatically determines the relevant context and files to edit. You can also add context explicitly using the **Add Context** button or by dragging files into the Chat view.

1. Optionally, select the Tools icon to configure which tools can be used for responding to your request.

    - You can select the tools that you want to use for responding to your request. For example, you can select the **Test Explorer** tool to run tests or the **Terminal** tool to run commands.
    - You can also select the **GitHub Copilot** tool to use GitHub Copilot's code generation capabilities.

1. Enter a prompt that defines the intended tasks.

    - For example: "`Ensure that a suitable unit tests project is prepared for the selected code file. Create a test file in the unit test project that includes unit tests for all methods in the selected file. Unit tests should be written in C# and use the xUnit framework. Run the tests to ensure expected results.`"

1. Monitor the progress of the Agent as it performs the tasks.

    - Confirm tool invocations and terminal commands. You can confirm or reject the tool invocations and terminal commands that the Agent suggests. For example, you can confirm the command to run the tests or the command to generate a test report.
    - Interrupt the Agent if necessary. You can interrupt the Agent if you want to stop the tasks that it's performing. For example, you can interrupt the Agent if you want to change the context or if you want to change the tools that are being used.

1. Review the files that the Agent created or updated during the specified tasks, and then keep or discard updates.

    - You can use new prompts to correct or enhance specific tests if necessary.

## Summary

GitHub Copilot's Chat view provides three built-in agents that can be used to create unit tests: Ask, Plan, and Agent. Each agent has its own strengths, and the best agent to use depends on the specific task at hand. The Ask agent is optimized for asking questions about your code projects, coding topics, and general technology concepts. The Plan agent is optimized for creating a structured, step-by-step implementation plan before writing any code. The Agent is optimized for starting an agentic coding workflow.
