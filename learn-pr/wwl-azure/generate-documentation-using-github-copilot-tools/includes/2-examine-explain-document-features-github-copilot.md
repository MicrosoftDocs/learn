GitHub Copilot Chat makes it easier for developers to work with a complex or unfamiliar codebase. Developers use GitHub Copilot Chat throughout the development process to understand and document code.

## Access GitHub Copilot Chat in Visual Studio Code

Visual Studio Code provides easy access to the following GitHub Copilot Chat features:

- **Inline chat**: Start an inline chat conversation directly from the editor for help while you're coding.
- **Chat view**: Have an AI assistant on the side to help you at any time.
- **Quick Chat**: Ask a quick question and get back into what you're doing.
- **Smart actions**: Run smart actions to complete certain tasks without even having to write a prompt.

The inline chat, chat view, and quick chat features enable you to ask questions and get help from GitHub Copilot Chat without leaving the Visual Studio Code environment. The **Explain This** and **Generate Docs** smart actions enable you to generate explanations and documentation for your code with just a few clicks. These features make it easy to get help from GitHub Copilot Chat while you're working on your code.

Providing GitHub Copilot Chat with questions that include a clear scope and intent improves the generated responses. You can use *chat participants*, *slash commands*, and *chat variables* to supplement the natural language text in your questions. The context and intent provided by these specialized descriptors helps GitHub Copilot Chat generate more accurate and useful responses.

When writing questions or prompts for GitHub Copilot Chat, consider the following tips:

- Chat participants, such as `@workspace` or `@terminal`, help GitHub Copilot Chat understand the larger context of your question.
- Slash commands, such as `/explain`, help GitHub Copilot Chat understand the intent of your question.
- Chat variables, such as `#file` or `#editor`, help GitHub Copilot Chat understand where it can find specific information pertaining to your question.

GitHub Copilot Chat performs better when you use an appropriate combination of chat participants, slash commands, and chat variables in your questions. For example, you can use `@workspace` to indicate that the context is your workspace files, `/explain` to indicate you want an explanation, and `#file`, `#editor` or `#selection` to provide a specific area of interest. Not every question requires a combination of these descriptors, but using them appropriately can help GitHub Copilot Chat to generate the intended response.

## Generate explanations using GitHub Copilot Chat

Explanations are useful when you encounter complex or unfamiliar code and need to understand how it works. Developers often encounter complex algorithms, regular expressions, or other code that's difficult to understand at first glance. GitHub Copilot Chat can generate explanations of selected code blocks, files, or the entire workspace. Explanations help developers understand the purpose and behavior of the code, making it easier to work with and maintain. Explanations are also useful for nontechnical stakeholders who need to understand how the code works.

GitHub Copilot Chat helps explain selected code by generating natural language descriptions of the code's functionality and purpose. For example, if you select the method of a class you need to implement, GitHub Copilot Chat can generate an explanation that uses natural language text and code snippets to describe what the method does and how to implement it. The explanation can include the method's input parameters and return values, its dependencies, and the purpose it serves in the larger application.

There are several ways to generate an explanation of selected code using GitHub Copilot Chat. For example, after selecting code in the editor, you can generate an explanation using the following methods:

- You can open an inline chat and use `/explain` in your prompt.
- You can use the `Explain This` smart action.
- You can open the Chat view and use `/explain #selection` in your prompt.

GitHub Copilot Chat can also be used to generate explanations that address a broader scope. For example, you can use `@workspace` in the chat view to generate an explanation for an entire workspace. Responses can include a summary of the project, its purpose, and other information that's relevant to the workspace. You can also generate an explanation of a specific project file in the workspace by using the `#file` chat variable to specify a filename. Workspace explanations can help you to understand a project and its goals. Developers who are joining a project can use workspace explanations to accelerate their onboarding process.

Some examples of questions you can ask Copilot Chat to generate explanations include:

- Chat view: `@workspace Explain this project`
- Chat view: `@workspace /explain Explain the dependencies of this project`
- Chat view: `@workspace /explain #file:program.cs Explain how this file is used in the project`
- Inline chat: `/explain #selection Explain how this method works`
- Inline chat: `/explain Explain this code block`

## Generate documentation using GitHub Copilot Chat

Documentation is typically used for the following purposes:

- Inline documentation that's used to describe the contents of a code file. Inline documentation is intended for developers and testers who work on the code.
- External project documentation that's used to provide an overview of the project. External documentation is intended for executive stakeholders, project managers, and end users. Developers and testers can also benefit from external documentation.

### Generate inline documentation

Good inline documentation improves the readability and maintainability of a codebase, making it easier for developers to understand and work with. However, writing inline documentation can be time-consuming, especially for a complex codebase.

GitHub Copilot Chat generates inline documentation quickly and accurately. Using GitHub Copilot Chat to document common items like classes and class components can save you valuable time.

To generate inline documentation, you have the following options:

- Construct a natural language prompt to generate the desired documentation.
- Enter the `/doc` command in the inline chat to generate comments that describe the selected code.
- Use the `Generate Docs` smart action to generate comments that describe the selected code.

GitHub Copilot Chat generates inline documentation that explains the code’s functionality and purpose.

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
