# Unit 2: Examine the characteristics of complex conditionals

Developers don't set out to write a convoluted tangle of `if` statements from scratch. Instead, complex conditionals accumulate gradually as a codebase evolves. Understanding this evolutionary process can help you identify these patterns in your own projects (and ideally prevent them early).

## How complex conditionals emerge

Complex conditionals often arise from a combination of factors:

- **Incremental feature additions**: The code often begins with a straightforward decision structure for a simple scenario. Over time, new features or requirements are added. Each time, instead of redesigning the logic, a developer might choose the path of least resistance: just add another `if` or extend the existing conditional. For example, an order processing routine might start by checking `if (order.Total > 100) { applyDiscount(); }`. Later, a special discount for VIP customers gets added as another condition, then a holiday promotion is added as a nested condition inside the VIP discount, and so on. Each individual change seems small, but they compound into a complex net of conditions.

- **Edge case bug fixes**: Another common source is quick patches for bugs. Suppose a quality assurance review generates a ticket that describes the following issue: "if the user’s account is locked and they try a password reset, the system behaves incorrectly." A developer might address this issue by inserting a targeted conditional check in the code. For example, code that implements the following logic: "if accountLocked and passwordReset then do X." This fix works and the code passes associated tests. However, it adds another branch to the logic. Over the project’s life, many such edge-case fixes might be piled on, each one adding a bit more nesting or complexity. What started as a simple `if/else` can turn into a multi-branched tree as special cases are bolted on without refactoring.

- **Evolving requirements**: Requirements often grow beyond the original design of the code. Consider a loan approval system that makes an initial decision by checking a few basic metrics (credit score and income). As the business expands, they introduce more rules: special handling for first-time borrowers, conditional approval with collateral, different rules for various loan types, regulatory checks, etc. If the original code isn’t restructured, the natural inclination is to nest more `if` statements. For example, inside the `if (creditOK)` block, add `if (hasCollateral) ... else ...`, and within that block, perhaps another `if` for a regulatory flag. Each new rule increases the nesting or adds new branches at the same level. Over months or years, the loan approval function morphs into a giant method that's hundreds of lines long, with a tangle of conditions covering every scenario encountered by the business.

- **Lack of periodic refactoring**: Code complexity issues develop when incremental additions occur without reviews that clean up the code structure. It’s common in fast-paced development to deprioritize refactoring ("it works, let’s not touch it"). As a result, conditional logic that should be redesigned (split into smaller functions, or turned into a configuration table, etc.) remains in an increasingly ungainly form. By the time someone notices how unwieldy the code is, the function is so fragile that people are reluctant to refactor it – a classic accumulation of technical debt.

## Signs of overly complex conditionals

As a developer, you should be on the lookout for red flags in code that suggest conditional complexity is out of hand:

- **Deep nesting levels**: Functions with more than 2–3 levels of nested `if` statements (especially with interleaved `else` blocks) are strong candidates. Visually, the code forms an indented arrow shape to the right, making it hard to align the logic in your mind. If you find yourself counting braces or indentations to figure out which `else` pairs with which `if`, that’s a bad sign.

- **Long chains of else-if or switch cases**: A series of `else if (...) { ... } else if (...) { ... } ...` that goes on for dozens of lines can indicate the code is handling many variants in one place. Sometimes a long `switch` statement with many cases can be equivalent. These structures can often be simplified or broken into smaller pieces (or data-driven mappings) if they represent numerous static conditions.

- **Complex boolean expressions**: Conditionals that combine many terms, for example: `if ((A && B && !C) || (D && (E || !F))) { ... }` such expressions are hard to read and even harder to get right. If you see conditional logic with multiple `&&` and `||` operators mixed with `!` negations, it might benefit from simplification (for instance, by splitting into clearer subconditions or using explanatory variables).

- **Complex boolean expressions**: Conditionals that combine many terms, for example: `if ((A && B && !C) || (D && (E || !F))) { ... }` such expressions are hard to read and even harder to get right. If you see conditional logic with multiple `&&` and `||` operators mixed with `!` negations, it might benefit from simplification (for instance, by splitting into clearer subconditions or using explanatory variables).

- **Repeated checks and code duplication**: Look for cases where the same condition or similar code appears in multiple branches. For instance, if you see `if (user.IsAdmin)` in two different parts of an `if/else` ladder, you might be able to evaluate the condition in a single location if you restructure the logic. You might also find two branches of a conditional that contain similar code logic with slight differences. If you notice this pattern, the conditional could be refactored to avoid the duplication.

- **Use of "flag" variables to control flow**: Sometimes developers introduce temporary flags as a workaround for complex logic (for example, `bool isValid = false; ... if (condition) { isValid = true; } ... if (isValid) { ... }`). While using flags isn't the same as nesting conditionals, it’s often a response to complexity – the code couldn’t easily do what it needed in one pass, so it sets a flag to be checked later. You might be able to eliminate this pattern by restructuring conditionals or using early returns.

## Summary

Complex conditionals often arise from incremental changes, bug fixes, and evolving requirements without accompanying refactoring. Signs of overly complex conditionals include deep nesting, long chains of conditions, complex boolean expressions, repeated checks, and the use of flag variables. Recognizing these patterns is the first step toward improving code quality through refactoring.
