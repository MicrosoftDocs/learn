Using GitHub Copilot's Ask mode in Visual Studio Code is like having a knowledgeable colleague who can answer questions about your codebase, the environment, .NET and external libraries, and best practices. The Ask mode doesn't modify your code directly, but it does provide explanations, insights, and suggestions that you can use to improve your code.

GitHub Copilot's Ask mode is particularly useful when dealing with large functions that are complex and hard to understand. By asking targeted questions, you can break down the function into manageable parts, identify areas for improvement, and plan your refactor effectively.

## General use cases for GitHub Copilot's Ask mode

GitHub Copilot's Ask mode is integrated into Visual Studio Code through the GitHub Copilot Chat extension. You can activate Ask mode by opening the chat panel and typing your questions in natural language. Here are some common use cases for Ask mode:

- **Explain/summarize code:** Generate a natural language breakdown of what the code does. You can ask GitHub Copilot to summarize an entire codebase or any class, method, or code block.
- **Identify logical sections:** Often returns a numbered list of distinct tasks or steps the code performs.
- **Highlight problems:** May point out repetition or complexity.
- **Answer specific questions:** “What does this loop do?” or “Why are these parameters needed?”
- **Suggest refactoring approaches:** “You could extract these steps into separate functions…”

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

        - "Can you summarize what this function does?"
        - "List the distinct tasks this function performs."
        - "How can I refactor this function to be shorter?"
        - "How can I reduce the cyclomatic complexity of this function?"

    1. **Review GitHub Copilot’s response** in the chat panel:

        - Apply your understanding of the codebase and applicable business rules to validate GitHub Copilot’s analysis.
        - Look for actionable insights in the response. For example, you might find specific tasks or code sections that could be extracted into separate functions.

    1. **Ask follow-ups:**

        - "Explain the error handling in more detail."
        - "Is this function following the single responsibility principle?"
        - "How can I reduce the cyclomatic complexity of this function?"

    1. **Plan your refactor:**

        - Use the insights to outline a refactoring strategy.
        - Decide which parts to extract into separate functions or classes.

## Tips for using Ask mode effectively

To get the most benefit from GitHub Copilot's Ask mode, consider the following tips:

- **Be specific:** Ask about particular sections if needed.
- **Keep context visible:** Ensure Copilot can “see” the whole function. Add related files to the chat context if necessary.
- **Don’t blindly trust suggestions:** Use your judgment.
- **Use Ask Mode output as a blueprint:** Plan your refactor based on its breakdown.

> [!NOTE]
> Experienced developers can use Ask mode as a second opinion and to validate their own plans for refactoring large functions. If GitHub Copilot identifies the same functions that you identified, you know that you're on the right track. If GitHub Copilot suggests refactoring alternative or additional functions, you can use GitHub Copilot's insights to evaluate what you might have missed.

## Summary

GitHub Copilot's Ask mode is a powerful tool for analyzing and understanding large functions. By asking targeted questions, you can break down complex code, identify areas for improvement, and plan your refactor effectively. Use Ask mode as a planning assistant before you start refactoring to ensure a well-thought-out approach.
