GitHub Copilot can be used to refactor code in your codebase. You can use the Chat view agents to analyze, plan, and implement code refactoring tasks. The Chat view agents provide a user-friendly interface for managing chat conversations and accessing GitHub Copilot's features. The Chat view includes the following built-in agents:

- **Ask**: Use Ask to ask questions about your codebase or technology concepts. You can use Ask to explain code, suggest revisions or fixes, or provide information related to the codebase.
- **Plan**: Use the Plan agent to create a structured, step-by-step implementation plan before writing any code. When the plan looks right, hand it off to an implementation agent to execute it.
- **Agent**: Use the Agent to start an agentic coding workflow. You can use the Agent to run commands, execute code, or perform other tasks in your workspace.

> [!IMPORTANT]
> When you use the Agent, GitHub Copilot may make multiple premium requests to complete a single task. Premium requests can be used by user-initiated prompts and follow-up actions GitHub Copilot takes on your behalf. The total premium requests used depends on the complexity of the task, the number of steps involved, and the model selected.

## Use Ask to refactor code

You can use Ask to get help with coding tasks, understand tricky concepts, and improve your code. Ask is designed for interactive conversations with GitHub Copilot Chat. You can ask questions, get explanations, or request suggestions in real time.

1. Open the Chat view and select Ask.

1. Add context to the chat.

    Ask supports chat participants, slash commands, and chat variables. You can add the `@workspace` chat participant or `#codebase` to the chat to provide context along with files or folders.

1. Ask questions that help you understand the code that you want to refactor and the changes you want to make.

    For example, you might ask GitHub Copilot to help you understand your existing authentication code how to update the current method using OAuth.

1. Construct a prompt that describes the update that you want to implement.

    Your prompt should include a description of the code feature you want to implement. For example:

    ```plaintext
    @workspace I need to refactor the `EnumHelper` class and remove any code that uses reflection. Use static dictionaries to supply enum description attributes. Use a separate dictionary for each enum. The dictionaries should use values from the `LoanExtensionStatus.cs`, `LoanReturnStatus.cs`, and `MembershipRenewalStatus.cs` files. Explain how to update the EnumHelper class using dictionaries and show me the updated code.
    ```

1. Review the suggested code in the Chat view.

    The response displayed in the Chat view will include a code snippet that you can use to implement the feature. You can enter updated prompts to refine the code or ask for more details.

1. To implement suggested code, you can hover the mouse pointer over the code snippet and then select between the **Apply**, **Insert**, and **Copy** options.

    - **Apply**: Applies the code suggestion to the current file in the editor.
    - **Insert**: Inserts the code suggestion at the current cursor position in the editor.
    - **Copy**: Copies the code suggestion to the clipboard.

1. Test your refactored code to ensure it runs without errors and generates the expected result.

## Use Plan to refactor code

You can use the Plan agent when you want to create a structured, step-by-step implementation plan before making changes. The Plan agent analyzes your codebase, asks clarifying questions, and produces a detailed plan. When the plan looks right, you can hand it off to an implementation agent to execute it.

> [!TIP]
> Use Ask to evaluate the code that you're interested in refactoring and evaluate your options before you start making changes. You can use Plan to create a structured plan and then hand it off to an implementation agent.

1. Open the Chat view and select Plan.

1. Add context to the chat.

    Specify workspace context using `#codebase` and by adding files to the chat.

1. Construct a prompt that describes the code feature that you want to implement.

    Your prompt should include a description of the code feature you want to implement. For example:

    ```plaintext

    #codebase I need to refactor the `EnumHelper` class and remove any code that uses reflection. Use static dictionaries to supply enum description attributes. Use a separate dictionary for each enum. The dictionaries should use values from the `LoanExtensionStatus.cs`, `LoanReturnStatus.cs`, and `MembershipRenewalStatus.cs` files.

    ```

1. Review the structured implementation plan that GitHub Copilot generates.

    The Plan agent creates a step-by-step plan that you can review before any code changes are made.

1. When the plan looks right, hand it off to an implementation agent to execute it.

    You can hand off the plan to the Agent to apply the changes to your codebase.

1. Review the suggested edits in the code editor.

1. Accept or discard the suggested edits.

    You can navigate through the edits using the up and down arrows. You can Keep (accept) or Undo (discard) the suggested edits individually using the popup menu that appears over each edit. You can also accept or reject all of the edits at once using the **Keep** and **Undo** buttons at the bottom of the editor tab (or Chat view).

1. Test your refactored code to ensure it runs without errors and generates the expected result.

## Use the Agent to refactor code

You can use the Agent when you want to automate the process of refactoring code. The Agent acts as an autonomous agent that can take actions on your behalf. You can ask GitHub Copilot to perform specific tasks, and it generates code based on your requests.

With the Agent, you can use natural language to specify a high-level task, and let GitHub Copilot autonomously reason about the request, plan the work needed, and apply the changes to your codebase. The Agent uses a combination of code editing and tool invocation to accomplish the task you specified. As it processes your request, it monitors the outcome of edits and tools, and iterates to resolve any issues that arise.

> [!IMPORTANT]
> When you use the Agent, GitHub Copilot may make multiple premium requests to complete a single task. Premium requests can be used by user-initiated prompts and follow-up actions GitHub Copilot takes on your behalf. The total premium requests used depends on the complexity of the task, the number of steps involved, and the model selected.

1. Open the Chat view and select Agent.

1. Construct a prompt that describes the task you want GitHub Copilot to perform.

    Suppose you have a code project that uses two or more processes/techniques to accomplish the same task. You can ask GitHub Copilot to refactor you code using a single approach to improve consistency, maintainability, and performance.

    For example:

    ```plaintext

    Review the LINQ code used in the JsonData and JsonLoanRepository classes. Refactor the methods in the JsonPatronRepository class using LINQ queries. Ensure that existing code functionality is maintained.

    ```

1. Agent might invoke multiple tools to accomplish different tasks. Optionally, select the Tools icon to configure which tools can be used for responding to your request.

1. Confirm tool invocations and terminal commands.

    Before GitHub Copilot runs a terminal command or a tool that isn't built in, it requests confirmation to continue. Confirmation is required because tools might run locally on your machine and perform actions that modify files or data.

1. GitHub Copilot detects issues and problems in code edits and terminal commands and will iterate and perform actions to resolve them.

    > [!IMPORTANT]
    > Although GitHub Copilot is capable of self-healing, it might not always be able to resolve issues on its own. You can pause the process and provide more context to help GitHub Copilot understand the problem. You can also cancel the process and start over with a new prompt.

1. Review the suggested edits and accept or discard the suggested edits.

1. Test your refactored code to ensure it generates the expected result.

    The Agent should resolve issues on its own, but you should still test the code to ensure it works as expected.

    You can revert edits made by the Agent using the **Undo** button in the Chat view. You can also use the **Revert** option in the editor to revert changes made by the Agent.

## When to choose the Agent over Plan

Consider the following criteria to choose between Plan and Agent:

- Planning: Plan creates a structured, step-by-step implementation plan before writing any code. The Agent autonomously determines the relevant context and files to edit and begins making changes directly.
- Task complexity: The Agent is better suited for complex tasks that require both code edits and the invocation of tools or terminal commands.
- Duration: The Agent uses multiple steps to process a request, so it might take longer to generate a response. For example, to determine the relevant context and files to edit, determine the plan of action, and more.
- Self-healing: The Agent evaluates the outcome of the generated edits and might iterate multiple times to resolve intermediate issues.
- Request quota: When you're using the Agent mode, depending on the complexity of the task, one prompt might result in many requests to the backend.

## Summary

GitHub Copilot can be used to refactor code in your codebase. You can use the Chat view agents to analyze, plan, and implement code refactoring tasks. The Chat view includes three built-in agents: Ask, Plan, and Agent. You can use Ask to ask questions about your codebase or technology concepts. You can use Plan to create a structured implementation plan before writing code. You can use the Agent to start an agentic coding workflow.
