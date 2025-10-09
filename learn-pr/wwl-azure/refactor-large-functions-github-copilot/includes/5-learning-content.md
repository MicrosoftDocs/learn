GitHub Copilot Chat’s Agent Mode allows the AI to edit your code based on your instructions.  
It’s like telling a junior developer, “Extract a method here” or “Rename this variable,” and watching it happen.

You remain in control: Agent Mode will show you the changes and ask for confirmation.

## Preparing for Agent Mode

- **Have a plan:** Know which parts of the function you want to extract and what to name them.
- **Save your work:** Use source control or backups before making changes.
- **Select context carefully:** Highlight the code block or open the file to give Copilot visibility.

## Best Practices

- Break refactoring into small steps.
- Review each change carefully.
- Compile and test after each step.

## Common Refactoring Commands

- “Extract this code into a new private method named `ValidateOrder` that returns a bool.”
- “Replace repeated tax calculation logic with a helper method `CalculateTax`.”
- “Refactor this `if/else` chain into a switch expression.”
- “Move the pricing calculations into a new method `ComputeTotals(order)`.”

## Example Workflow

1. Extract the first segment

    “Extract the input validation at the top of `ProcessOrder` into a new method `ValidateOrder(order)` returning bool.”

1. Extract the second segment

    “Move the pricing calculations into a new method `ComputeTotals(order)` that updates `order.Total`.”

1. Handle remaining logic

    Extract saving and notification logic similarly or leave in the main function if it’s now short and clear.

1. Clean up

    Rename variables, remove unused code, and ensure consistency.

## Leveraging Ask Mode Output

Use Ask Mode’s breakdown to guide Agent Mode:

- Extract each step as described.
- Use suggested function names.
- Confirm logic matches original.

> 💡 **Expert Insight:** Treat Agent Mode like a junior dev.  
> Give clear instructions, review their work, and correct as needed.

## What to Watch For

- **Logic preservation:** Ensure no behavior is changed.
- **Parameter handling:** Copilot may forget to pass a needed variable.
- **Naming and access modifiers:** Confirm they match your codebase style.
- **Missed lines:** If Copilot skips a line, manually move it or ask again.

## If Agent Mode Gets Confused

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
