GitHub Copilot Chat can be used at various points in the development process to help developers generate documentation. In addition, when a developer is working with unfamiliar code, GitHub Copilot Chat can provide explanations of selected code blocks or files. Explanations are useful for developers who are interested in the code's behavior or for nontechnical stakeholders who need to understand how the code works.

## Access GitHub Copilot Chat in Visual Studio Code

Visual Studio Code provides easy access to the following GitHub Copilot Chat features:

- **Inline chat**: Start an inline chat conversation directly from the editor for help while you're coding.
- **Chat view**: Have an AI assistant on the side to help you at any time.
- **Quick Chat**: Ask a quick question and get back into what you're doing.
- **Smart actions**: Run smart actions to complete certain tasks without even having to write a prompt.

The inline chat, chat view, and quick chat features allow you to ask questions and get help from GitHub Copilot Chat without leaving the Visual Studio Code environment. These features make it easy to get help and information from GitHub Copilot Chat while you're working on your code.

Providing GitHub Copilot Chat with questions that include a clear scope and intent improves the generated responses. GitHub Copilot Chat uses chat participants, slash commands, and chat variables to understand the context of your question and generate relevant responses. By using these specialized descriptors, you can help GitHub Copilot Chat generate more accurate and useful responses.

- Chat participants, such as `@workspace` or `@terminal`, help GitHub Copilot Chat understand the larger context of your question.
- Slash commands, such as `/explain`, help GitHub Copilot Chat understand the intent of your question.
- Chat variables, such as `#file` or `#editor`, help GitHub Copilot Chat understand where it can find specific information pertaining to your question.

GitHub Copilot Chat performs better when you use an appropriate combination of chat participants, slash commands, and chat variables in your questions. For example, you can use `@workspace` to indicate that the context is your workspace files, `/explain` to indicate you want an explanation, and `#file`, `#editor` or `#selection` to provide a specific area of interest. Not every question requires a combination of these descriptors, but using them appropriately can help GitHub Copilot Chat to generate the intended response.

## Generate explanations using GitHub Copilot Chat

Explanations are useful for developers who are working with unfamiliar code and need to understand how it works. GitHub Copilot Chat can generate explanations of selected code blocks, files, or the entire workspace. Explanations can be useful for developers who are interested in the code's behavior and for nontechnical stakeholders who need to understand how the code works.

GitHub Copilot Chat can help explain selected code by generating natural language descriptions of the code's functionality and purpose. For example, if you select a function or code block in the code editor, GitHub Copilot Chat can generate a natural language description of what the code does and how it fits into the overall system. This can include information such as the function's input and output parameters, its dependencies, and its purpose in the larger application.

If you select a block of code in the editor, you have several options for viewing a natural language description of selected code. For example you can use the following methods to generate explanations for selected code blocks:

- You can open an inline chat and use `/explain` in your prompt.
- You can use the `Explain This` smart action.
- You can open the Chat view and use `/explain #selection` in your prompt.

Getting explanations can be useful for understanding complex algorithms, regular expressions, or other code that may be difficult to understand at first glance. By generating explanations, GitHub Copilot Chat can help you understand the code's behavior and purpose, making it easier to work with and maintain.

In the Chat view (or Quick Chat window), you can use the `@workspace` chat participant followed by a natural language description to generate an explanation for an entire workspace. Responses can include a summary of the project, its purpose, and any other relevant information. You can also generate an explanation of a specific project file in the workspace by using the `#file` chat variable to specify a filename. By generating explanations for the workspace, you can create a high-level overview that helps other developers understand the project and its goals. This can be useful for onboarding new team members, sharing information with stakeholders, or documenting the project for future reference.

Some examples of questions you can ask Copilot Chat to generate explanations include:

- `@workspace Explain this project`
- `@workspace /explain Explain the dependencies of this project`
- `@workspace /explain #file:program.cs Explain how this file is used in the project`

## Generate documentation using GitHub Copilot Chat

Documentation is typically used for the following purposes:

- Inline documentation that's used to describe code files, components, or code blocks. Inline documentation is intended for developers and testers who work on the code.
- External project documentation that's used to prepare overviews, summaries, and reports. External documentation is intended for executive stakeholders, project managers, and end users. Developers and testers can also benefit from external documentation.

### Generate inline documentation

GitHub Copilot Chat can help you document your code by generating inline code comments. To generate inline documentation, you have the following options:

- construct a natural language prompt to generate the desired documentation.
- Enter the `/doc` command in the inline chat to generate comments that describe the selected code.
- Use the `Generate Docs` smart action to generate comments that describe the selected code.

Generating code comments can be useful for documenting your classes, methods, and properties, or complex algorithms that may be difficult to understand at first glance. Having GitHub Copilot Chat generate documentation can help you to create more readable and maintainable code that's easier for other developers to understand and work with.

### External project documentation

You can use `@workspace` followed by a natural language description to generate documentation for an entire workspace. This can include a summary of the project, its purpose, and any other relevant information. By generating documentation for the workspace, you can create a high-level overview that helps other developers understand the project and its goals.

Some examples of questions you can ask Copilot Chat to generate documentation include:

- `@workspace Generate a project summary that can be used at an executive briefing`
- `@workspace Generate a readme markdown document that can be used as a repo description`

## Review and correct GitHub Copilot Chat's output

GitHub Copilot Chat generates explanations and documentation based on the code you provide and the questions you ask. While GitHub Copilot Chat can generate accurate and useful responses, it's important to review and correct the generated output to ensure its accuracy and completeness.

When reviewing GitHub Copilot Chat's output, consider the following items:

- Check the generated explanations and documentation for accuracy and completeness.
- Verify that the generated output aligns with the code you provided and the questions you asked.
- For documentation, correct any errors or inaccuracies in the generated output to ensure that it accurately reflects the code's behavior and purpose.
- Add additional information or context to the generated output to provide more comprehensive documentation.

## Summary

GitHub Copilot Chat provides features that can help you generate explanations and documentation for your code. By using the inline chat, chat view, quick chat, and smart actions, you can ask questions and get help from GitHub Copilot Chat without leaving the Visual Studio Code environment. By providing clear questions with appropriate chat participants, slash commands, and chat variables, you can help GitHub Copilot Chat generate more accurate and useful responses.
