Using GitHub Copilot's Ask mode is like having a knowledgeable colleague who's always available to answer your questions. GitHub Copilot can answer questions about your codebase, code libraries, best practices, and your development environment. The Ask mode doesn't modify your code directly, but it does provide explanations, insights, and suggestions that you can use to improve your code.

GitHub Copilot's Ask mode is useful when dealing with large functions that are complex and hard to understand. By asking targeted questions, you can break down a large function into manageable parts, identify areas for improvement, and plan your code refactoring efforts effectively.

## General use cases for GitHub Copilot's Ask mode

GitHub Copilot's Ask mode is integrated into Visual Studio Code through the GitHub Copilot Chat extension. You can start a conversation in the Ask mode by opening the chat panel and typing your questions in natural language. Here are some common use cases for Ask mode:

- **Explain/summarize code:** Generate a natural language breakdown of what the code does. You can ask GitHub Copilot to summarize an entire codebase or any class, method, or code block.
- **Identify logical sections:** Often returns a numbered list of distinct tasks or steps the code performs.
- **Highlight problems:** Might point out repetition or complexity.
- **Answer specific questions:** "What does this loop do?" or "Why are these parameters needed?"
- **Suggest refactoring approaches:** "You could extract these steps into separate functions…"

## Identify and evaluate large functions using GitHub Copilot's Ask mode

There are several scenarios where Ask mode can help with identifying and analyzing large functions:

- **Identifying potentially problematic large functions:** Ask Copilot to find functions that exceed a certain line count or complexity threshold.
- **Understanding functionality:** Ask what the function does at a high level.
- **Breaking down logic:** Request a step-by-step explanation of the function's logic.
- **Identifying issues:** Inquire about potential problems or code smells.
- **Refactoring suggestions:** Seek advice on how to refactor the function for better readability and maintainability.
- **Exploring alternatives:** Ask for different ways to implement the same functionality.
- **Learning best practices:** Request coding best practices related to the function's purpose.

Here’s a high-level process that uses GitHub Copilot to identify and analyze large functions:

1. Identify problematic large functions: Use Ask mode to identify functions that exceed specified thresholds.

1. Review GitHub Copilot's findings: Analyze the list of identified functions and prioritize them based on complexity and impact. Use your judgment to select functions that would benefit most from refactoring.

1. Evaluate a specific large function: Use Ask mode to analyze the function in detail.

    1. **Ask a question** using a natural language prompt, such as:

        - "Analyze the selected function and provide a high-level summary of its purpose and main responsibilities. Include any concerns about complexity or maintainability that you notice."
        - "Break down the selected function into its distinct logical tasks or responsibilities. For each task, indicate which lines of code are involved and whether each task could be extracted into a separate function."
        - "Identify specific refactoring opportunities in the selected function. Suggest which code blocks could be extracted into separate methods, what those methods should be named, and what parameters they would need."
        - "Analyze the cyclomatic complexity of the selected function. Identify the decision points (if statements, loops, switch cases) that contribute most to complexity and suggest specific strategies to reduce it, such as guard clauses, early returns, or strategy patterns."
        - "Evaluate the selected function against SOLID principles. Which principles does it violate and how?"
        - "Identify any code smells in the selected function, such as long parameter lists, nested conditionals, or repeated code patterns. Provide specific examples."
        - "Suggest a step-by-step refactoring plan for the selected function, prioritizing the changes that would have the most impact on readability and maintainability."

    1. **Review GitHub Copilot’s response** in the chat panel:

        1. Apply your understanding of the codebase and applicable business rules. Use your own knowledge to verify GitHub Copilot’s analysis.

        1. Look for actionable insights in the response. For example, you might find specific tasks or code sections that could be extracted into separate functions.

    1. **Ask follow-ups:**

        - "Review the error handling patterns in the selected function. Are there opportunities to consolidate error handling, improve error messages, or extract error handling into reusable components?"
        - "Assess the selected function against the Single Responsibility Principle. If it has multiple responsibilities, identify each one and suggest how they could be separated into focused, single-purpose functions."
        - "Review the suggested refactoring plan for the selected function. Are there any security, performance, or maintainability implications that I need to consider? Explain."

    1. **Plan your refactor:**

        1. Use the insights to outline a refactoring strategy.

        1. Decide which parts to extract into separate functions or classes.

## Tips for using Ask mode effectively

To get the most benefit from GitHub Copilot's Ask mode, consider the following tips:

- **Be specific:** Ask about particular sections if needed.
- **Keep context visible:** Ensure that GitHub Copilot can "see" the whole function. Add related files to the chat context if necessary.
- **Don’t blindly trust suggestions:** Use your judgment.
- **Use Ask Mode output as a blueprint:** Plan your code refactoring efforts based on GitHub Copilot's breakdown.

> [!NOTE]
> Experienced developers can use Ask mode as a second opinion and to validate their own plans for refactoring large functions. If GitHub Copilot identifies the same functions that you identified, you know that you're on the right track. If GitHub Copilot suggests refactoring other functions, you can use GitHub Copilot's insights to evaluate what you missed.

## Summary

GitHub Copilot's Ask mode is a powerful tool for analyzing and understanding large functions. By asking targeted questions, you can break down complex code, identify areas for improvement, and plan your code refactoring project effectively. Use Ask mode as a planning assistant before you start refactoring to ensure a well-thought-out approach.
