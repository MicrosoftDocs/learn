Identifying complex conditionals that can and should be simplified isn't always easy. Planning how to refactor your code can be even more difficult.

Developers can use GitHub Copilot’s Ask mode to refactor complex conditionals and improve code quality.

## What is Ask mode?

GitHub Copilot’s Ask mode is a conversational chat interface. You ask questions and GitHub Copilot answers using the context that you provide. It’s like having a knowledgeable colleague who can read your code and give advice. For example, you can use Ask mode to explain what a function does, identify potential issues, or suggest improvements.

Ask mode responds with explanations, insights, or code examples that you can use to improve your code. In Ask mode, GitHub Copilot doesn't make any changes to your code files.

## Analyze complex conditionals using Ask mode

You can use Ask mode to identify and analyze complex conditionals in your code. GitHub Copilot can help you understand the conditional logic, identify potential issues, and evaluate opportunities for improvement.

### Strategies for analyzing complex conditionals

Here are some strategies for using Ask mode to analyze complex conditionals:

- **Explain the code**: Ask GitHub Copilot to explain what the complex conditional does. This question helps ensure you understand the current logic before making changes.

- **Identify complexity**: Ask GitHub Copilot to identify which parts of the conditional are making it complex. This question can help you pinpoint areas to focus on.

- **Find edge cases**: Ask GitHub Copilot to identify any edge cases or potential bugs in the conditional logic. This question can help you ensure that your refactored code handles all scenarios.

- **Suggest refactoring**: Ask GitHub Copilot for suggestions on how to simplify or refactor the conditional logic. GitHub Copilot might suggest using guard clauses, extracting methods, or other techniques to improve clarity.

- **Ask for examples**: If you're unsure how to implement a suggestion, ask GitHub Copilot for code examples. This question can help you understand how to apply the advice in your specific context.

- **Explore risks**: Ask GitHub Copilot about potential risks or side effects of refactoring the conditional logic. This question can help you avoid introducing new bugs.

- **Iterate**: Use follow-up questions to drill down on specific suggestions or areas of concern. An iterative approach can help you refine your understanding and plan your approach more effectively.

### Ask mode prompts for complex conditionals

The prompts that you use to analyze complex conditionals should reflect your specific code and goals. However, here are some suggested best practices to consider:

- Focus on specific analysis techniques rather than generic requests for help.
- Reference established practices like SOLID principles, design patterns, and coding conventions.
- Include quality metrics like cyclomatic complexity and code smells.
- Emphasize testing and risk mitigation, which are crucial for safe refactoring.
- Promote best practices for secure, maintainable, and readable code.
- Encourage systematic thinking about business requirements and technical implementation.
- When applicable, address performance considerations that are important for production code.

#### Establish the required chat context

When using Ask mode, it's important to provide sufficient context for GitHub Copilot to understand the code you're analyzing. Here are some tips:

- Use the **Add Context** button in the chat interface to include relevant files or folders from your codebase.
- Include relevant code snippets or examples that illustrate your points.
- Describe the specific goals you have for the analysis (for example, simplifying logic, identifying bugs).
- Mention any constraints or requirements that are important for the analysis (for example, performance considerations, coding standards).

Here are some examples of natural language text that you can include in your prompt when analyzing complex conditionals:

#### Understanding and analysis

- "Analyze the selected conditional logic and explain what each branch does."
- "What is the cyclomatic complexity of the selected conditional block and why?"
- "Review the selected conditional and identify the main conditions being evaluated and their relationships."
- "What business rules or requirements does the selected conditional logic implement?"

#### Quality assessment

- "Evaluate the selected conditional for potential maintainability issues."
- "Are there any code smells or anti-patterns in the selected conditional logic?"
- "Review the selected conditional and identify the edge cases or error conditions that might not be properly handled."
- "Does the selected conditional follow SOLID principles? If not, how could it be improved?"

#### Refactoring opportunities

- "Suggest specific refactoring techniques to simplify the selected conditional (guard clauses, polymorphism, strategy pattern, etc.)."
- "How could I break the selected complex conditional into smaller, more focused functions?"
- "What design patterns could help eliminate or reduce the complexity of the selected conditional?"
- "Show me how to apply the 'fail fast' principle to the selected conditional logic."

#### Testing and risk assessment

- "What test cases would I need to ensure the selected conditional logic works correctly after refactoring?"
- "What are the risks of refactoring the selected conditional, and how can I mitigate them?"
- "How can I verify that refactored code maintains the same behavior as the original?"
- "Review your suggested approaches for refactoring the selected conditional. What are performance implications associated with each of the suggested approaches?"

#### Best practices application

- "Does the selected conditional follow Microsoft's C# coding conventions? What improvements are needed?"
- "How can I make the selected conditional more readable and self-documenting?"
- "What naming improvements would make the selected conditional logic clearer?"
- "How can I reduce cognitive load when reading the selected conditional?"

## Ask mode workflow for complex conditionals

The following workflow demonstrates how to use Ask mode on a complex conditional:

1. **Open the problematic code**

    Navigate to the file and function that contains the complex conditional logic you intend to refactor. For example, suppose you have a method `CalculateDiscount()` that expanded over time with many nested conditions.

1. **Select the relevant code**

    By selecting the specific block of code (the nested `if` statements, for instance), you give Copilot a clear focus. Copilot uses this selection as context for answering.

1. **Ask for an explanation of the code**

    Start simple. For instance:

    "Copilot, can you explain what this `CalculateDiscount` method is doing?"

    In Ask mode, Copilot reads through the code and produce an explanation in plain English. This step is useful to ensure you (and GitHub Copilot) fully understand the current logic before changing it. The explanation might come back like:

    "This method calculates a discount for an order. First, it checks if the user is a premium member; if so, it sets baseDiscount to 10%. Then it checks if a coupon code is provided. If a coupon exists, it validates the coupon's expiration date, applying an extra discount if valid. It also has special cases for holiday sales and bulk orders…"

    Use the explanation to confirm the code's intent. The explanation might even identify where the logic is convoluted.

1. **Ask pointed questions about complexity**

    Now you can get analytical. For instance:

    - "Are there any redundant or repeated checks in this code?"
    - "Which parts of this logic are making it complex?"
    - "What edge cases does this code handle?"

    Use GitHub Copilot's responses to identify opportunities for improvement. For example:

    "The nested `if` inside the coupon section adds complexity. Also, there's an `if` five levels deep for holiday sales – consider simplifying that."

    Use the feedback to continue your analysis.

1. **Ask for refactoring suggestions**

    Now the key question:  

    "How can I simplify or refactor this conditional logic?"

    Copilot, in Ask mode, might respond with a list of suggestions. For example:

    - Use guard clauses to handle the cases where no discount applies (for example, if coupon is invalid, return early).
    - Extract the coupon validation and discount calculation into its own function for clarity.
    - Combine the two separate premium member checks into one place to avoid duplication.
    - Use a switch or dictionary for the holiday sale multipliers instead of if/else.

    It might even sketch out brief pseudo-code or show how a piece of the code would look after applying these ideas.

1. **Iterate with follow-up questions**

    You can drill down on any suggestion:

    - "Which conditions in this function would be good guard clauses?"
    - "Can you show me what an extracted function might look like for the coupon calculation?"
    - "What different discount scenarios does this code account for?"

    Through this dialogue, GitHub Copilot helps form a refactoring plan. By the end of the Ask mode exploration, you might have a list of specific changes to implement, such as:

    - Add an early return for invalid coupons.
    - Move holiday discount calculation to a separate function.
    - Remove duplicate check on `IsPremium` by doing it once at the top.
    - Use a single combined condition for bulk orders instead of two nested `if` statements.

This structured approach helps ensure that any refactoring maintains the original intent while improving code clarity and maintainability.

## Treat GitHub Copilot suggestions as guidance

While GitHub Copilot’s suggestions are often good, they’re not infallible. Treat them as guidance, not absolute truth. For instance, GitHub Copilot might suggest a change that would slightly alter behavior if it misinterpreted the code. Always double-check any critical logic changes.

Since Ask mode doesn't modify your code, you're free to explore different approaches and evaluate suggestions without any risk.

## Summary

Using GitHub Copilot's Ask mode is a powerful way to analyze and plan the refactoring of complex conditionals. By engaging in a conversational manner, you can gain insights into the existing logic, identify pain points, and receive tailored suggestions for simplification. This approach helps ensure that any refactoring maintains the original intent while improving code clarity and maintainability.
