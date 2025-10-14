A "large function" (or "long method") is a function or method that tries to do too much. Large functions often require scrolling to view the code and handle multiple tasks or concerns.

There’s no strict line count definition for a large function. The most common guidelines suggest using 40-50 lines as a threshold where you should consider scrutinizing. However, there are also guidelines that suggest a threshold of 20 lines.

## Why are large functions bad?

- **Poor readability:** You can’t quickly grasp what a large function is doing because multiple concerns are interwoven.
- **Difficult to maintain:** A change in one part of a large function can unexpectedly affect other parts, leading to bugs.
- **Low reuse:** Useful bits of logic inside a large function can’t be reused elsewhere easily.
- **Hard to test:** Writing unit tests for a 100-line function is tricky. You have to set up all its prerequisites, and you might only be able to test the end result.
- **Debugging pain:** When a large function fails or throws an exception, the stack trace might just point to that function. You then have to dig through the whole thing to find the issue.

## Real-world scenarios

Large functions crop up in all kinds of applications. An expert developer might notice the same pattern in many forms:

- **Monolithic web handlers**: In web apps, a single controller action or API endpoint might handle validation, business logic, and database calls all together.
- **"God" event handlers**: In desktop or mobile UIs, an event handler (like selecting a button) might accumulate functionality over time.
- **All-in-one scripts**: Console applications or scripts often have a `Main` or a single function that performs a sequence of steps in one block.
- **Complex algorithms in one go**: Sometimes developers write a complex algorithm as one large function – perhaps parsing a file format or computing a result with many steps.

## Problems across types

Regardless of whether the function is in a UI layer, business logic layer, or a utility class, the problems of maintainability and readability persist. Large functions in any layer can lead to:

- **Tight coupling:** Changes in one part of the function can affect other parts, making it hard to isolate changes.
- **Reduced cohesion:** The function tries to do too many things, making it hard to understand its purpose.
- **Increased complexity:** The more logic packed into a single function, the harder it is to follow the flow of execution.
- **Testing challenges:** Unit tests become more complex and less effective when trying to cover all the functionality in a large function.

## Summary

Large functions aren't just an aesthetic issue – they slow down development and increase risk. Large functions make it harder to understand, maintain, test, and reuse logic. When a developer is able to recognize the signs of large functions and understand their impact, they can take steps to refactor them into smaller, single-purpose functions that are easier to work with.
