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
