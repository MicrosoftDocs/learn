# Refactoring Large Functions with GitHub Copilot Chat

**Audience:** Lower-intermediate C# developers  
**Purpose:** Learn how to detect and refactor large functions in any codebase using GitHub Copilot Chat (Ask and Agent modes), and ensure correctness through testing.

---

# Unit 1: Understanding the Problem – Large Functions in Different Apps

## What is a “large function”?

A “large function” (or **Long Method**) is a function or method that tries to do too much. It often spans many lines of code and handles multiple tasks or concerns at once. In code smell terminology, it’s a bloater that usually violates the Single Responsibility Principle.

There’s no strict line count definition, but a common guideline is:  
**If a function exceeds ~20 lines, it’s a candidate for refactoring.**  
Many teams set an even lower bar (e.g. 10 lines) as a rule of thumb for code reviews. Length correlates with complexity and maintainability issues.

## Why are large functions bad?

- **Poor readability:** You can’t quickly grasp what a long function is doing because multiple concerns are interwoven.
- **Difficult to maintain:** A change in one part of a large function can unexpectedly affect other parts, leading to bugs.
- **Low reuse:** Useful bits of logic inside a large function can’t be reused elsewhere easily.
- **Hard to test:** Writing unit tests for a 100-line function is tricky – you have to set up all its prerequisites and you can usually only test its end result.
- **Debugging pain:** When a large function fails or throws an exception, the stack trace might just point to that function. You then have to dig through the whole thing to find the issue.

## Real-world scenarios

Large functions crop up in all kinds of applications. An expert developer will notice the same pattern in many forms:

- Monolithic Web Handlers: In web apps, a single controller action or API endpoint might handle validation, business logic, and database calls all together.

- "God" Event Handlers: In desktop or mobile UIs, an event handler (like a button click) might accumulate functionality over time.

- All-in-One Scripts: Console applications or scripts often have a `Main` or a single function that performs a sequence of steps in one block.

- Complex Algorithms in One Go: Sometimes developers write a complex algorithm as one large function – perhaps parsing a file format or computing a result with many steps.

## Problems across types

Regardless of whether the function is in a UI layer, business logic layer, or a utility class, the problems of maintainability and readability persist.

> **NOTE:**
> The presence of comments or region blocks inside a function is a red flag. If you see a function with comments like `// validate inputs`, `// do X`, `// clean up`, etc., it’s a sign the function has multiple distinct sections of logic. Each of those sections could probably be a function of its own.

## Summary

Large functions are not just an aesthetic issue – they slow down development and increase risk. In the next unit, we’ll learn how to recognize these monsters in your codebase (sometimes they hide in plain sight).

---

## Unit 2: Recognizing Large Functions (Manually)

## Why manual recognition matters

Before involving AI assistance, you need to know how to spot large functions and determine if they should be refactored. Experienced developers often develop a sixth sense for this, but there are concrete signs and metrics you can use.

## Code Smells and Symptoms

Here are common indicators that a function is too large or doing too much:

- **Excessive length:** Over 20–30 lines is a smell. Over 80 lines is almost always too long.
- **Deep nesting:** Multiple levels of indentation (loops within loops, nested `if`/`else`/`try` blocks).
- **Too many parameters:** More than 5–6 parameters may indicate the function is aggregating too much logic.
- **Mixed abstraction levels:** High-level operations and low-level details interwoven.
- **Commented sections:** Comments like `// Step 1`, `// Step 2` suggest multiple responsibilities.
- **Repetition of code patterns:** Duplicate logic or repeated blocks that could be extracted.

## Tools for Finding Large Functions

- **IDE features:** Visual Studio’s “Analyze > Calculate Code Metrics” or VS Code extensions.
- **Static analysis tools:** Linters or analyzers (e.g., StyleCop, Roslyn).
- **Manual inspection:** Scroll through files and look for long collapsible blocks.
- **Search for comments or TODOs:** Developers often leave clues like `// this is doing a lot`.

## Common “Shapes” of Large Functions

- **Sequential script:** Performs a series of steps one after another.
- **Flag-driven logic:** Uses `switch` or `if/else` chains to handle multiple modes.
- **Helper-heavy logic:** Contains chunks that could be helper methods.
- **Repeated blocks:** Similar logic repeated for different data sets or conditions.

> **NOTE:**
> Use the “extraction imagination” test: If you can name a block of code as a function, it probably should be one.

## Metrics to Watch

| Metric                  | Threshold | Why it matters                                  |
|------------------------|-----------|-------------------------------------------------|
| Lines of code          | 80+       | Indicates complexity and maintainability risk   |
| Cyclomatic complexity  | 20+       | Many independent paths = harder to test         |
| Parameters             | 6+        | May indicate poor encapsulation or overreach    |

## Not All Long Functions Are Evil

Some long functions are acceptable in specific contexts (e.g., performance-critical code). Use judgment. The goal is to make code easier to work with.

> **NOTE:**
> If a function is hard to split because everything is tightly interwoven, that’s a sign of high coupling. Copilot’s Ask Mode can help untangle it.

## Summary

You should now be able to identify the usual suspects in your codebase:

- Overly long methods  
- Signs pointing to multiple responsibilities  
- Metrics to quantify them  

---

# Unit 3: Using GitHub Copilot Chat – Ask Mode

## What is Ask Mode?

GitHub Copilot Chat’s Ask Mode is like having a knowledgeable colleague you can ask about your code. It does not modify your code (read-only), but it can:

- Interpret
- Summarize
- Suggest improvements
- Answer questions

This is incredibly useful for understanding a large function and planning a refactor.

## What Ask Mode Can Do

- **Summarize code:** Plain English breakdown of what the function does.
- **Identify logical sections:** Often returns a numbered list of steps.
- **Highlight problems:** May point out repetition or complexity.
- **Answer specific questions:** “What does this loop do?” or “Why are these parameters needed?”
- **Suggest refactoring approaches:** “You could extract these steps into separate functions…”

## How to Use Ask Mode

1. **Open the file** with the large function in VS Code.

1. **Highlight the function** or place your cursor inside it.

1. **Ask a question** in natural language:

   - “Can you summarize what this function does?”
   - “List the distinct tasks this function performs.”
   - “How can I refactor this function to be shorter?”

1. **Review Copilot’s answer:**

   - Look for logical breakdowns.
   - Identify candidate blocks for extraction.

1. **Ask follow-ups:**

   - “Explain the error handling in more detail.”
   - “Is this function following the single responsibility principle?”

## Example Prompt and Response

Prompt:

```plaintext
This function parses a file and then does several calculations. It's over 100 lines. How can I refactor it?”
```

Response:  

```plaintext
It looks like the function has distinct phases:  

1. Read and validate file data.
2. Compute statistics (sum, average, etc.).
3. Format and output results.

You could extract those into separate functions: `ParseFile`, `ComputeStats`, `PrintResults`.”
```

## Tips for Effective Use

- **Be specific:** Ask about particular sections if needed.
- **Keep context visible:** Ensure Copilot can “see” the whole function.
- **Don’t blindly trust suggestions:** Use your judgment.
- **Use Ask Mode output as a blueprint:** Plan your refactor based on its breakdown.

> 💡 **Expert Insight:** Ask Mode is your second opinion.  
> I use it to validate my plan. If Copilot describes the same sections I identified, I know I’m on the right track. If it finds more, I reconsider what I missed.

## Summary

Ask Mode helps you analyze and understand large functions.  
It’s your planning assistant before you start refactoring.  
Next, we’ll use Agent Mode to execute the refactor based on this analysis.

---

# Unit 4: Refactoring in Action – Agent Mode

## What is Agent Mode?

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

---

# Unit 5: Testing and Verification – Ensuring the Refactored Code Works

## Why testing matters

Refactoring is supposed to change internal structure without changing external behavior.  
To be confident in this, we must test the code after refactoring.

### Benefits of testing after refactoring

- Catch regressions.
- Ensure correctness.
- Verify performance (if relevant).
- Confirm that behavior is unchanged.

## Testing Strategies

1. Rerun existing unit tests

    - If tests already exist for the function or its behavior, run them.  
    - They should pass exactly as before.

1. Write new tests for critical paths

    If no tests exist, add a few to cover:

    - Normal use cases.
    - Edge cases.
    - Error conditions.

1. Compare outputs or side effects

    Run the same inputs through both versions (old vs new) and compare:

    - Return values.
    - Console output.
    - Logs.
    - Database changes.

1. Use Copilot to generate tests

    - Follow your company guidelines for test projects and unit testing.
    - Construct a prompt to generate unit tests. For example: “Generate unit tests for the `ProcessOrder` method.”
    - Review and run the generated tests to validate functionality.

## Run the Application End-to-End

If the function is part of a larger app:

- Trigger the functionality manually.
- Confirm expected behavior in UI or API.
- Check logs, emails, database records, etc.

## Regression Checklist

After refactoring, verify the following haven’t changed:

- Outputs (return values, generated data).
- State changes (object fields, database records).
- Exceptions for error conditions.
- Performance (optional, if relevant).

## Quality Checks

Beyond correctness, do a quick quality pass:

- **Naming:** Are new function names clear and consistent?
- **Documentation:** Update or remove outdated comments.
- **Dead code removal:** Eliminate unused variables or parameters.
- **Consistency:** Ensure new functions fit the class/module design.

## When to Roll Back

If tests reveal serious issues:

- Revert to the original code.
- Attempt the refactoring again in smaller steps.
- Use version control to compare and recover.

## Final Thought

Refactoring isn’t complete until:

- All tests pass.
- Code is cleaner.
- Behavior is unchanged.

> **TIP:**
> Always run tests after each refactor step.  
> If something breaks, fix it immediately or roll back.  
> Copilot can help generate or fix tests, but you need to stay in control.

## Summary

Testing ensures your refactoring is safe and successful.  
It validates that your code still works and gives you confidence to move forward.  
With Copilot’s help, testing can be faster and more thorough.

---
