Project documentation describes the purpose, goals, and requirements of a project. To create project documentation, you need to understand the project structure, its components, and how the components interact with each other.

GitHub Copilot's Chat view is an ideal tool for generating project documentation, because it can analyze the entire project structure and provide high-level overviews of the project. The Chat view can also be used to generate specific types of documentation, such as README files, API references, and other project-related documents.

You can use each of the Chat view modes (Ask, Agent, or Plan) to generate project documentation. Each mode has its own strengths and weaknesses. Project specifications and other constraints affect which mode should be used.

> [!IMPORTANT]
> When you use the Chat view in agent mode, each prompt you enter counts as one premium request, multiplied by the model's multiplier. GitHub Copilot may take several follow-up actions to complete your task, but these follow-up actions don't count toward your premium request usage. Only the prompts you enter are billed. The total premium requests used depends on how many prompts you enter and the model selected.

## Establish project documentation requirements

Documentation types and content requirements depend on the project, the intended consumers, and the standards adopted by the organization.

For example, the README.md could include the following sections:

- Project Title: The name of your project.
- Description: A brief overview of what the project does and why it exists.
- Table of Contents: Optional, but helpful for longer READMEs.
- Installation: Instructions on how to install and set up the project.
- Usage: Examples of how to use the project, including code snippets or screenshots.
- Features: A list of key features or functionality.
- Configuration: Details on any configuration options or environment variables.
- Contributing: Guidelines for contributing to the project.
- License: Any licenses used by the distributed project.
- Credits and acknowledgments: Recognition of contributors, libraries, or resources used.
- Contact: How to reach the maintainers or project team.
- Changelog: A history of changes and updates (sometimes linked to a separate file).

GitHub Copilot Chat can help you generate project documentation that meets the specific needs of your project and its stakeholders.

## Use the Ask agent mode to generate project documentation

The Ask agent mode can be used to analyze a workspace and then generate documentation.

Use the following process to generate project documentation using the Ask agent mode:

1. Identify the documentation requirements and supporting resources.

    - Identify the documentation requirements for your project. Identify the types of documentation and the required document sections.

    - Identify the resources required to generate the documentation. Your code workspace could be the only required resource. However, you may need to add context to the chat for sections like "Contributing", "Credits", and "Contact".

1. Open the Chat view and start a new chat session using the Ask agent mode.

1. Add context to the chat session.

    - You can add context to the chat session by dragging and dropping files from Visual Studio Code's EXPLORER view into the Chat view. You can also use the **Attach Context** button (paperclip icon).
    - You can open external files in the code editor to include resources that aren't part of the workspace and use them to provide more context. For example, you can open markdown files that contain contributor guidelines or contact information and then use the **Attach Context** button to add them to the Chat view context.

1. Enter a series of prompts that investigate your documentation requirements.

    You can use the Ask agent mode to analyze the workspace and build a chat session history that supports your documentation requirements. Describing your goals can help establish context for the chat session. Asking questions that address your requirements helps GitHub Copilot identify the information needed to generate the documentation.

    Refresh the added context as needed.

1. Enter a prompt that asks for suggested project documentation, listing the required sections that you identified in the first step.

    For example: "`@workspace /explain I need help creating a README file that can be used in the GitHub repository for this workspace. The file should be formatted as markdown. The README file needs to include the following sections: Project Title, Description, Table of Contents, Installation, Usage, Features, Configuration, and License.`"

1. Review the suggested project documentation, and refine the results using new prompts if necessary.

1. Move the suggested project documentation into a project documentation file.

    For example, create a README.md file at the root of the workspace, and the insert the suggested content into the file.

    You can use the Ask agent mode to suggest updates for specific sections of your project after creating the document, or use other GitHub Copilot tools to help with updates.

## Use the Plan mode to generate project documentation

Plan mode is best for creating a detailed implementation plan before generating project documentation. The Plan mode analyzes the codebase, identifies documentation requirements, and produces a step-by-step plan. Once the plan is approved, you can hand it off to agent mode for execution.

Use the following process to generate project documentation, such as a README.md file, using the Plan mode:

1. Identify the documentation requirements and supporting resources.

1. Open the Chat view and start a new chat session using the Plan mode.

1. Enter a prompt that describes your documentation task.

    For example: "I need to create a README file and supporting documentation for this project. The README should include: Project Title, Description, Table of Contents, Installation, Usage, Features, Configuration, and License."

1. Review the implementation plan.

    After a few moments, the Plan agent outputs a plan in the Chat view. The plan provides a high-level summary and a breakdown of steps, including any open questions for clarification. You can iterate multiple times to clarify requirements, adjust scope, or answer questions.

1. Once the plan is complete, select **Start Implementation** to hand off the plan to agent mode, or select **Open in Editor** to save the plan as a Markdown file for later use.

    When you select **Start Implementation**, GitHub Copilot switches to agent mode and begins implementing the documentation based on the approved plan. Review the generated documentation files and accept or discard the changes.

## Use the agent mode to generate project documentation

Agent mode is best for generating project documentation that requires an in-depth understanding of the project. Agent mode analyzes the entire project structure before it generates project documentation. By gathering information from multiple files and folders, agent mode can describe complex relationships and include links between documents.

Use the following process to generate project documentation, such as README.md file, using the agent mode:

1. Identify the documentation requirements and supporting resources.

1. Open the Chat view and start a new chat session using the agent mode.

1. Add context to the chat session.

    Chat participants aren't available in agent mode, so you can't specify `@workspace` as part of your prompt. However, you can add context to the chat session using `#codebase` and by adding workspace files and folders to the chat context. External files can be opened in Visual Studio Code and then added to the chat context using the **Attach Context** button.

1. Enter a prompt to create the intended project documentation.

    For example: "Generate a collection of project documentation files. Create or update the workspace README.md file for this repository. Create or update the UsageExamples.md file. Create or update the ChangeLog.md file. Include links between the documentation files, cross-reference classes and methods, and ensure consistency across the documents."

1. Review the document files and then save or discard the updates.

    Update the file using prompts to correct or enhance specific sections if necessary.

### Agent mode capabilities

There are several documentation tasks where agent mode is the best choice.

1. Multi-file and cross-file documentation generation.

    - Agent mode can analyze the entire project structure, gather information from multiple files and folders, and generate documentation that links and summarizes content across the codebase. For example, generating a full API reference or a README that describes all major components.

1. Automated project analysis and summarization.

    - Agent mode can perform tasks like summarizing the architecture, identifying main classes/services, and producing diagrams or tables that require understanding relationships between files and components.

1. Dynamic content generation (for example, usage examples, class tables)

    - Agent mode can scan the project to generate usage examples, class responsibility tables, or lists of public APIs.

1. Batch documentation tasks.

    - Agent mode can execute a sequence of documentation tasks (for example, update README, create CONTRIBUTING.md, generate API docs, update changelog) in one workflow.

1. Intelligent linking and navigation.

    - Agent mode can create links between documentation files, cross-reference classes and methods, and ensure consistency across docs.

Agent mode is ideal for project-wide, multi-file, and context-aware documentation tasks that require analysis, synthesis, and coordination.

## Summary

GitHub Copilot can help you generate project documentation that meets the specific needs of your project and its stakeholders. The Chat view can be used to generate project documentation in three different modes: Ask, Agent, and Plan. Each mode has its own strengths and weaknesses, and the best mode to use depends on the specific task at hand. The Ask agent mode is best for asking questions about your codebase or technology concepts. The Agent mode is best for generating project documentation that requires an in-depth understanding of the project. The Plan mode is best for creating a detailed implementation plan before generating documentation, which can then be handed off to Agent mode for execution.
