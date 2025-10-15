# Unit 1: Review the impact of complex conditionals

Code containing complex conditionals might function correctly, but it poses several problems.

## Problems associated with complex conditionals

- Reduced Readability: Deep nesting makes code hard to follow at a glance. You often have to scroll horizontally or match many braces to understand the flow. Multiple layers of conditions increase cognitive load, meaning a developer must hold several state checks in mind at once. The intent of the code gets obscured by the complexity of its structure.

- Difficult Maintenance: Code with lots of intertwined conditions is brittle. When requirements change or a bug surfaces, modifying that code is risky and error-prone. A maintainer might introduce a new condition hoping to fix one case, only to break another because the interactions aren’t obvious. Complex conditional logic often violates clean code principles like single responsibility (one function now handles many decision paths) and obscures the intended behavior. As a result, developers may avoid changing it, leading to stagnation or awkward workarounds elsewhere.

- Higher Error Frequency: There is a known correlation between a program’s complexity (measured by metrics like cyclomatic complexity) and its bug rates. Every additional conditional branch creates new pathways through the code that need to be handled correctly. A function with a high cyclomatic complexity (lots of independent paths) is statistically more likely to contain errors or unanticipated edge cases. In other words, complex conditionals tend to be fragile – they might work for the scenarios the original developer thought of, but unexpected combinations of inputs can slip through the cracks.

- Testing Challenges: The more branches and nesting, the more test cases are needed to cover all paths. Thoroughly testing a function with many conditional branches is time-consuming, and it’s easy to miss some logic paths. For example, consider a five-level nested `if`: for full coverage you must trigger every branch at each level – an exponential explosion of test cases. If testing is incomplete, bugs linger. Moreover, when you refactor or extend such code, you must re-run a large battery of tests to ensure nothing broke. Complex conditionals thus reduce confidence in code changes because verifying correctness is harder.

- Poor Team Agility: In a team setting, if one module of code is known to have an overly complex decision logic, new team members struggle to understand it, and even experienced members might tread carefully. Code reviews for such modules are longer and more contentious ("Are we sure we handled all cases here?"). This slows down development and can delay feature releases. It’s not uncommon to see comment blocks or documentation trying to explain a convoluted `if/else` chain – a red flag that the code itself isn’t clear.

Consider the following "arrow code" example:

```csharp
// Pseudocode example of deeply nested conditionals ("arrow code")
if (user != null) {
    if (user.IsActive) {
        if (user.Role == "Admin") {
            if (user.HasPermission("View")) {
                Console.WriteLine("Access granted");
            } else {
                Console.WriteLine("Permission denied");
            }
        } else {
            Console.WriteLine("Role not authorized");
        }
    } else {
        Console.WriteLine("User is not active");
    }
} else {
    Console.WriteLine("User not found");
}
```

When you review this code sample for the first time, it takes a minute to determine the conditions that lead to "Access granted" versus the various denial messages. The nesting pushes the important logic to the far right, creating an "arrowhead" shape. You have to mentally invert the structure to understand it: first check user not null, then active, then role, then permission – all in reverse due to nesting. This example exhibits all the issues above: it’s tedious to read and reason about, adding a new access rule would require touching multiple places, and you’d need many tests (null user, inactive user, non-admin user, admin without permission, admin with permission, etc.) to cover it all.

## Summary

Complex conditionals decrease code quality by making code less readable, harder to modify, and more error-prone. Complex conditionals often indicate that a function is doing too much or that logic is not well-structured. Recognizing these problems is the first step; whenever you notice code that is difficult to understand due to nested or elaborate conditionals, it’s a sign that refactoring might be needed.
