Using GitHub Copilot's Agent mode is like having an assistant who's always there to help you develop and maintain your code.

In Agent mode, you assign tasks to GitHub Copilot using natural language prompts in the chat panel. GitHub Copilot begins by analyzing your codebase, using the assigned task to establish the necessary context. The agent generates a plan for accomplishing the task and displays the list of subtasks that it will implement. It then opens and edits the associated files in the code editor. All of this is completed autonomously by the agent, which provides a running commentary in the chat panel so that you can monitor its progress. If necessary, the agent will ask for clarification, additional information, or permission to proceed with a specific action. Once the agent has completed the task, you can review the edits and approve (or reject) the individual changes. You remain in control throughout the process.

## Best practices

- Break refactoring into small steps.
- Review each change carefully.
- Compile and test after each step.

## Common refactoring commands

- “Extract this code into a new private method named `ValidateOrder` that returns a bool.”
- “Replace repeated tax calculation logic with a helper method `CalculateTax`.”
- “Refactor this `if/else` chain into a switch expression.”
- “Move the pricing calculations into a new method `ComputeTotals(order)`.”

## Example workflow

1. Extract the first segment

    “Extract the input validation at the top of `ProcessOrder` into a new method `ValidateOrder(order)` returning bool.”

1. Extract the second segment

    “Move the pricing calculations into a new method `ComputeTotals(order)` that updates `order.Total`.”

1. Handle remaining logic

    Extract saving and notification logic similarly or leave in the main function if it’s now short and clear.

1. Clean up

    Rename variables, remove unused code, and ensure consistency.

## Leveraging Ask mode suggestions

Use Ask Mode’s breakdown to guide Agent mode:

- Extract each step as described.
- Use suggested function names.
- Confirm logic matches original.

> 💡 **Expert Insight:** Treat Agent Mode like a junior dev.  
> Give clear instructions, review their work, and correct as needed.

## What to watch for

- **Logic preservation:** Ensure no behavior is changed.
- **Parameter handling:** Copilot may forget to pass a needed variable.
- **Naming and access modifiers:** Confirm they match your codebase style.
- **Missed lines:** If Copilot skips a line, manually move it or ask again.

## If Agent mode gets confused

- Undo the change or revert the file.
- Try a smaller step or more precise prompt.
- Fix minor issues manually or ask Copilot to correct them.

## Example Outcome

Before:

```csharp

public void ProcessOrder(Order order) {
    // 120 lines of logic
}

```

After:

```csharp

public void ProcessOrder(Order order) {
    if (!ValidateOrder(order)) return;
    ComputeTotals(order);
    SaveToDatabase(order);
    SendConfirmation(order);
}

```

Each helper method contains what was once a section of the big function.
The main function now reads like a high-level outline.

## Summary

Agent Mode helps you execute your refactoring plan quickly and safely.
Use it step-by-step, guided by Ask Mode’s analysis.
