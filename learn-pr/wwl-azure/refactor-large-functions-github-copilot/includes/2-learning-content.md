A “large function” (or **Long Method**) is a function or method that tries to do too much. It often spans many lines of code and handles multiple tasks or concerns at once. In code smell terminology, it’s a bloater that usually violates the Single Responsibility Principle.

There’s no strict line count definition, but a common guideline is: **If a function exceeds ~20 lines, it’s a candidate for refactoring.**  

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
