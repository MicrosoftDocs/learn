# Unit 5: Refactor Low Performance Code using GitHub Copilot's Agent Mode

**Objective:** Use GitHub Copilot Chat in "Agent" mode to refactor low-performing code, implementing improvements identified via Ask mode and profiling, while maintaining code quality and security.

## What is Agent mode?

Agent mode refers to using GitHub Copilot Chat with instructions that cause it to produce or modify code solutions, rather than just analyzing. For example:

- "Refactor this code to use a dictionary for lookups instead of looping."
- "Implement an asynchronous version of this method to avoid blocking."
- "Optimize the algorithm here to reduce time complexity."

When you give such prompts, you're effectively asking GitHub Copilot to take action, not just give insight. GitHub Copilot will typically respond with a code block or series of steps that show the refactored code. In VS Code, GitHub Copilot Chat can even apply the changes (with your confirmation) to the file.

## Apply Ask mode analysis when using Agent mode

Usually, you use Agent mode after doing Ask mode and profiling, so you have a clear idea of what to change:

1. **Pinpoint the change:** Based on Ask mode suggestions, decide what you want to do. For example, "Use `StringBuilder` instead of `+=` in this loop" or "Fetch data in one go outside the loop, store in a collection."
2. **Instruct GitHub Copilot clearly:** The more specific your prompt, the better. If Ask mode already gave a hint ("use a dictionary for lookups"), you can say: *"Apply the suggestion to use a dictionary for lookups in this code."* GitHub Copilot should then rewrite the code accordingly.
3. **Review the output carefully:** Don't just accept the change blindly. Check:
   - Does the new code still do what the old code did (functionality intact)?
   - Did it introduce any new issues (like null checks removed, error handling lost, or thread safety concerns)?
   - Is the new code reasonably clear? If GitHub Copilot's solution is too convoluted, consider refining the prompt or doing a smaller change.

## Common scenarios for refactoring low-performance code

### Scenario 1: Remove redundant work (cache results)

**Before:**

```csharp
foreach (var order in orders)
{
    decimal rate = GetExchangeRate(order.Currency); // network call
    order.TotalLocal = order.TotalUSD * rate;
}
```

Profiling/analysis shows `GetExchangeRate` (which calls an API) is a bottleneck when many orders share the same currency.

**Agent mode prompt:** "Cache exchange rates in this loop to avoid repeated API calls."

**Expected GitHub Copilot action:**

```csharp
var rateCache = new Dictionary<string, decimal>();
foreach (var order in orders)
{
    if (!rateCache.TryGetValue(order.Currency, out decimal rate))
    {
        rate = GetExchangeRate(order.Currency);
        rateCache[order.Currency] = rate;
    }
    order.TotalLocal = order.TotalUSD * rate;
}
```

Now, you verify that:

- The logic is correct (if the cache misses, call API and store, else reuse).
- You consider any edge cases (if `GetExchangeRate` could throw or if currency code could be null – ensure those are handled as needed).
- The code is clear and indeed likely faster.

### Scenario 2: Using better data structures

From Ask mode, our example: replacing a nested loop search with a dictionary for quick lookups.

**Before:**

```csharp
foreach (var student in students)
{
    Grade grade = null;
    foreach (var g in gradesList)
    {
        if (g.StudentId == student.Id)
        {
            grade = g;
            break;
        }
    }
    if (grade != null) ProcessGrade(student, grade);
}
```

**Prompt:** "Use a dictionary to look up grades by StudentId instead of the inner loop."

**GitHub Copilot's refactor:**

```csharp
var gradeByStudent = gradesList.ToDictionary(g => g.StudentId);
foreach (var student in students)
{
    if (gradeByStudent.TryGetValue(student.Id, out Grade grade))
    {
        ProcessGrade(student, grade);
    }
}
```

Check the refactoring:

- Did GitHub Copilot choose appropriate names and keep the logic the same?
- Ensure that `.ToDictionary` is okay (it will throw if there are duplicate keys; if that's a possibility, we might need a different approach).
- This one-liner creation is neat, but if `gradesList` is huge, building the dictionary has a cost too. However, it's one-time upfront vs the nested loop cost which was students * gradesList – likely much larger overall.

### Scenario 3: Asynchronous refactoring

You identified that a method `SendEmailConfirmation` is doing `Thread.Sleep(2000)` to simulate email sending, blocking the main thread. You want to make it async.

**Prompt:** "Rewrite SendEmailConfirmation to be asynchronous using Task.Delay instead of Thread.Sleep."

**GitHub Copilot's action:**

```csharp
public async Task SendEmailConfirmationAsync(Order order)
{
    Console.WriteLine("Sending confirmation...");
    await Task.Delay(2000); // simulate async delay
    Console.WriteLine("Email sent.");
}
```

It would also remind you to change calls to `await SendEmailConfirmationAsync`. You then incorporate those changes.

Now, ensure:

- You didn't forget to adjust callers to await this new async method.
- Remove or mark obsolete the old sync method.
- The code still does essentially the same thing (aside from being non-blocking).

## Maintain code quality and security during refactoring

While performance is the focus, we must not degrade code quality or introduce vulnerabilities.

### Code quality

If GitHub Copilot's suggestion is too complex or uses non-idiomatic code, you can iterate. For instance, if it wrote a very optimized but cryptic bit of code, consider asking for a simpler version: "That looks complex, can you simplify it even if it's slightly less optimal? I want it easier to read." Often, you can find a sweet spot.

### Comments

If the optimized code is doing something not obvious (like caching or using a tricky algorithm), add a comment. GitHub Copilot can even help: "Add a comment explaining why we use a dictionary cache here," and it might generate a concise explanation.

### Security considerations

Most performance optimizations won't impact security directly, but be mindful:

- If you bypass validations or shorten encryption iterations for speed, that's likely unacceptable.
- If you introduce caching of sensitive data, ensure it's handled properly.
- GitHub Copilot might sometimes suggest using `unsafe` code or pointer arithmetic for extreme optimization. Avoid unsafe code unless absolutely necessary and you understand the implications.
- If making code asynchronous, be cautious about thread safety. GitHub Copilot might not automatically handle synchronization issues. Always consider: does this change require locks or concurrent collections now?

### Code testing

After refactoring, run your test suite or at least the scenarios you used for baseline. Make sure results are correct. If GitHub Copilot introduced a subtle bug, tests will catch it and you can adjust.

## Use GitHub Copilot throughout the refactoring process

GitHub Copilot can assist in multiple ways beyond just spitting out the first refactoring:

- **Step-by-step guidance:** Break down complex optimizations into smaller steps.
- **Edge case checks:** Ask GitHub Copilot, "Does this refactored function handle all edge cases like the original?"
- **Comparison of approaches:** Ask, "Is the new approach more efficient and why?" to validate the change or highlight trade-offs.

## Verify performance improvement

After refactoring with GitHub Copilot's help, don't forget to measure again. This closes the loop:

- If the improvement is as expected, fantastic.
- If improvement is marginal or nonexistent, re-evaluate.
- Sometimes, an optimization can even degrade performance if used in the wrong context.

### Example recap

- We cached exchange rates → Processing orders went from 5 seconds to 1 second for 1000 orders with mixed currencies.
- We replaced nested loops with a dictionary → A test with 10,000 students and 10,000 grades went from ~0.5 sec to ~0.05 sec.
- We made email sending async → The code is now ready for better scalability.

These outcomes demonstrate the payoff of the identify-and-refactor workflow, accelerated by GitHub Copilot at each step.

## Ensure code maintainability

Before concluding, put yourself in a future maintainer's shoes. You've made some parts of the code more complex (but faster). Is it documented and understandable?

- If you introduced a new structure, is it clearly named and explained?
- If you added an asynchronous flow, is it properly propagated and communicated?
- Are there any configurations or thresholds to consider?

In essence, treat GitHub Copilot's code as you would a teammate's code review suggestions: integrate them thoughtfully, test them, and polish any rough edges.

## Summary

GitHub Copilot's Agent mode is a powerful ally in refactoring low-performance code. By leveraging its ability to generate optimized code based on your specific prompts, you can efficiently implement improvements identified through profiling and Ask mode analysis. Always ensure that the refactored code maintains functionality, clarity, and security. Review and test thoroughly to validate performance gains and uphold code quality. With a methodical approach and GitHub Copilot's assistance, you can enhance your codebase's performance while keeping it maintainable and robust.
