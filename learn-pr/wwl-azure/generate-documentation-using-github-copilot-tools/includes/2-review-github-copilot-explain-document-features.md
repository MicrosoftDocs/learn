GitHub Copilot makes it easier for developers to work with complex or unfamiliar code. In Visual Studio Code, developers have direct access to GitHub Copilot features that analyze, explain, or document code.

## Analyze and explain code using GitHub Copilot

The following GitHub Copilot features can be used to analyze and explain code:

- Ask mode: Use the Chat view in ask mode to analyze your entire workspace and ask questions about coding topics, technology concepts, and general programming practices.

- Inline Chat: Start an inline chat session directly from the editor to ask about specific code sections.

- Smart Actions: Run the Explain smart action to explain selected code without even having to write a prompt.

- Quick Chat: Ask a quick question and get back into what you're doing.

## Generate inline code documentation using GitHub Copilot

The following GitHub Copilot features can be used to generate inline code documentation:

- Ask mode: Use the Ask agent mode to suggest inline code documentation for a code file, class, or method. Review the suggested inline documentation in the Chat view. Request updates as needed in the chat conversation. Once you're satisfied with the proposed documentation, you can insert the suggested documentation into the corresponding code file.

- Plan mode: Use the Plan mode to create a detailed implementation plan for your documentation tasks. The Plan mode can be used to analyze the codebase, identify documentation requirements, and produce a step-by-step plan. Once the plan is approved, you can hand it off to Agent mode for execution.

- Agent mode: Use the Agent mode to autonomously generate inline code documentation for specified code projects, files, classes, or methods. Have the agent perform other tasks during or after the documentation process. Accept or reject the updates when the agent has completed the assigned tasks.

- Inline chat - Use an inline chat session to work directly in the code editor. The inline chat is useful when you want to document specific code (classes, methods, or code blocks) without leaving the editor. You can provide specific instructions in the prompt or use the `/doc` slash command without specific information if you want. Updates are displayed in the code editor and can be accepted or rejected. You can also choose the option to rerun the prompt with or without updates.

- Generate Docs smart action: Use the Generate Docs smart action to generate inline code documentation for a selected class, method, or code block. The Generate Docs smart action is useful when you don't have specific requirements that would require a prompt. Updates are displayed in the code editor and can be accepted or rejected. You can also rerun the smart action.

## Generate project documentation using GitHub Copilot

The following GitHub Copilot features can be used to generate project documentation:

- Chat view in Ask agent mode: Use the Ask agent to analyze the codebase and gain an understanding of the code projects, files, and classes. The Ask agent can be used to preview suggested project documentation. Review suggestions and request updates or other details as needed. Insert the suggested documentation into a project documentation file (README.md).

- Chat view in Plan agent mode: Create a detailed implementation plan for project documentation, then hand off to agent mode for execution.

- Chat view in Agent mode: Generate a collection of project documentation files: create/update the README.md, create/update the UsageExamples.md, and create/update the ChangeLog.md. Include links between the documentation files, cross-reference classes and methods, and ensure consistency across docs.

> [!IMPORTANT]
> When you use the Chat view in agent mode, each prompt you enter counts as one premium request, multiplied by the model's multiplier. GitHub Copilot may take several follow-up actions to complete your task, but these follow-up actions don't count toward your premium request usage. Only the prompts you enter are billed. The total premium requests used depends on how many prompts you enter and the model selected. The Free Plan for GitHub Copilot gets 50 premium requests per month. Check plan descriptions for more details about premium request limits for each GitHub Copilot subscription.

## Summary

GitHub Copilot helps you analyze and document your code quickly and accurately. The chat view, inline chat, quick chat, and smart action features provide various levels of interaction directly within the Visual Studio Code environment.
