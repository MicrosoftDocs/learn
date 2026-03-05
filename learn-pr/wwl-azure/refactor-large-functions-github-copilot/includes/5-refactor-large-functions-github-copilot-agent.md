Using GitHub Copilot's Agent mode is like having an assistant who's always there to help you develop and maintain your code.

In Agent mode, you assign tasks to GitHub Copilot using natural language prompts in the chat panel. GitHub Copilot begins by analyzing your codebase, using the assigned task to establish the necessary context. The agent generates a plan for accomplishing the task and displays the list of the required subtasks. It then opens and edits the associated files in the code editor. The agent completes the analysis, planning, and implementation autonomously and provides a running commentary in the chat panel so that you can monitor its progress. If necessary, the agent asks for clarification, additional information, or permission to proceed with a specific action. Once the agent completes the task, you can review the edits and approve (or reject) the individual changes. You remain in control throughout the process.

## Best practices

Consider these tips to get the most out of Agent mode:

- Break refactoring into small steps.
- Review each change carefully.
- Compile and test after each step.

## Common refactoring commands

Here are some example prompts for common refactoring tasks:

- "Extract the selected validation code into a new private method named `ValidateOrder` that takes an Order parameter and returns a bool. Ensure all validation logic is moved and the original call site uses the return value appropriately."
- "Review the selected code. Identify and extract all repeated tax calculation logic into a new private static method `CalculateTax` that takes the necessary parameters (amount, taxRate, region) and returns the calculated tax amount. Replace all duplicate calculations with calls to this method."
- "Review the selected code. Convert this if/else chain into a modern switch expression, ensuring all cases are covered and the logic remains equivalent. Use pattern matching where appropriate and maintain the same return type."
- "Review the selected code. Extract all pricing and total calculations into a new private method `ComputeTotals` that takes an Order parameter, performs all calculations, and updates the order's total properties. Ensure no calculation logic remains in the original method."

## Example workflow

Assume you have a large function `ProcessOrder` that handles order processing, including validation, pricing calculations, saving to the database, and sending notifications. The function is over 200 lines long and needs to be broken down.

You might use the following steps to refactor the function:

1. Extract the first segment:

    "Extract the input validation at the top of `ProcessOrder` into a new method `ValidateOrder(order)` returning bool."

1. Extract the second segment:

    "Move the pricing calculations into a new method `ComputeTotals(order)` that updates `order.Total`."

1. Handle remaining logic:

    Extract saving and notification logic similarly or leave in the main function if it’s now short and clear.

1. Clean up:

    Rename variables, remove unused code, and ensure consistency.

## Apply Ask mode suggestions

Use Ask Mode’s breakdown to guide Agent mode:

- Review the plan proposed by Ask mode and your follow-up questions.
- Formulate a final refactoring plan for Agent mode.
- Use the analysis from Ask mode to create a series of clear, specific prompts for Agent mode. Use suggested function names and parameter lists in your prompts where appropriate.

> [!TIP]
> Treat Agent mode like a junior developer on your team. Give clear instructions, review their work, and correct as needed.

## What to watch for during your review

Always review the changes made by the agent. Consider the following checklist:

- **Logic preservation:** Ensure no behavior is changed.
- **Parameter handling:** Copilot might forget to pass a needed variable.
- **Naming and access modifiers:** Confirm they match your codebase style.
- **Missed lines:** If Copilot skips a line, manually move it or ask again.

## Manage unexpected results

When the agent generates a result that isn’t what you expected:

- Undo the change or revert the file.
- Try a smaller step or more precise prompt.
- Fix minor issues manually or ask Copilot to correct them.

## Summary

Using GitHub Copilot's Agent mode streamlines the process of refactoring large functions. By breaking down the task into manageable steps and using natural language prompts, you maintain control while allowing the agent to handle the heavy lifting. Always review changes carefully to ensure code quality and logic integrity.
