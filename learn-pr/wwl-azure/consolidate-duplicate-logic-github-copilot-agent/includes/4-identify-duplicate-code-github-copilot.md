GitHub Copilot Chat is an AI-powered tool that assists developers by providing code suggestions and answering questions. It can analyze code, identify patterns, and offer insights to improve code quality. By leveraging Copilot Chat, developers can streamline their workflow and enhance productivity.

GitHub Copilot Chat operates in different modes, each tailored to specific tasks.

- **Ask Mode**: Designed for querying and understanding code without making changes.
- **Edit Mode**: Allows users to suggest specific edits to the code.
- **Agent Mode**: Enables Copilot to perform actions such as editing code, creating files, and running tests.

The two primary modes are Ask mode and Agent mode. Ask mode is designed for querying and understanding code without making changes, while Agent mode allows Copilot to perform actions such as editing code, creating files, and running tests. This unit focuses on the Agent mode, which is particularly useful for tasks like refactoring and consolidating duplicate code.

## Why use Ask mode?

In Ask mode, Copilot Chat analyzes the codebase and answers questions without altering the code. Developers can use Ask mode to gain insights into the code, understand its structure, identify potential issues, and explain how different parts of the codebase interact

## Identifying duplicate code with Ask mode

Ask mode can be a powerful tool for identifying duplicate code. Developers can ask specific questions to pinpoint areas of duplication, such as "Review the class file open in the editor. Which functions have similar logic? Explain the opportunities to consolidate any duplicate code." Copilot Chat will analyze the code, identify potential instances of duplicate code, and explain the options for consolidation/refactoring.

Provide strategies or example prompts beyond the lab scenario:

- Comparative Questions: e.g., “Compare class A and class B for similar methods.” Copilot can outline differences and similarities.
- Code Search Queries: e.g., “Where else in this project is CalculateShipping defined?” This is something Copilot might answer if that symbol appears multiple times.
- Understanding Output: If the project was run with verbose logs, one could even ask “I see both OrderProcessor and ReturnProcessor printing ‘Calculating shipping…’. Is that code duplicated?” Copilot can connect the dots between log output and code.
- Emphasize that Ask mode can save time combing through code manually. It’s especially handy in large codebases where duplicate code might not be side-by-side.

## Interpreting Copilot’s Answers

When using Ask mode, it is important to critically read and interpret Copilot’s answers. Developers should verify the suggestions provided by Copilot Chat and ensure that they align with the overall code structure and design principles. By combining Copilot’s insights with their own expertise, developers can make informed decisions about consolidating duplicate code.

Consider the following guidelines:

- If Copilot says two methods are similar, it’s probably right – but verify by looking at those methods or asking follow-up questions.
- If Copilot misses something you strongly suspect, try rephrasing the question or opening the relevant files to give it more context.

## Beyond Duplication – Other Ask Mode Uses

While Ask mode is valuable for identifying duplicate code, it can also be used for other purposes. Developers can ask questions about code functionality, dependencies, and best practices. Copilot Chat can provide insights into code optimization, performance improvements, and potential refactoring opportunities. By leveraging Ask mode, developers can gain a deeper understanding of their codebase and improve overall code quality.
