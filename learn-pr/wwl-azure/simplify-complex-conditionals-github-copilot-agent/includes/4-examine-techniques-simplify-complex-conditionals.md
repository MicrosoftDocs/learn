# Unit 3: Examine the techniques used to simplify complex conditionals

Refactoring complex conditionals means applying structured techniques to make the code simpler and flatter without altering its behavior. There are several time-tested approaches to achieve this. As an experienced developer might say: "We want to tame the complexity, one step at a time." Below are key techniques to simplify nested or convoluted conditional logic, along with how they help.

## Use guard clauses (early returns) to flatten nesting

A guard clause is a conditional check that immediately exits the function (or otherwise prevents further execution) if a certain condition is met, rather than wrapping the main logic inside an `if`. By handling edge cases or invalid conditions upfront, you avoid deep nesting and make the code’s "happy path" more prominent.

### Examine the benefits of guard clauses

Guard clauses reduce indentation levels dramatically. For example, consider a code block that includes "if X is true", then inside that "if Y is true", then inside that "if Z is true, do something". You can use a guard clause to invert the logic: check for the opposite of X, Y, or Z and exit early. The result is a series of simple one-level checks. This improves readability because the normal flow of the function isn’t buried in many layers of braces. It also aligns with the fail-fast principle – error or stop conditions are handled immediately, so the rest of the function can assume those conditions are false and focus on the main task.

Here is a code sample that illustrates this transformation:

```csharp
// BEFORE: Nested conditions (arrowhead pattern)
void ProcessOrder(Order order) {
    if (order != null) {
        if (order.IsValid) {
            if (!order.HasExpired) {
                Execute(order);
            } else {
                Console.WriteLine("Order expired.");
            }
        } else {
            Console.WriteLine("Order is invalid.");
        }
    } else {
        Console.WriteLine("Order is null.");
    }
}

// AFTER: Using guard clauses to flatten logic
void ProcessOrder(Order order) {
    if (order == null) {
        Console.WriteLine("Order is null.");
        return;
    }
    if (!order.IsValid) {
        Console.WriteLine("Order is invalid.");
        return;
    }
    if (order.HasExpired) {
        Console.WriteLine("Order expired.");
        return;
    }
    Execute(order);
}
```

In the refactored version, each `if` handles a bad-case scenario and returns early. Now the "happy path" (where the order is non-null, valid, and not expired) is at the bottom, with minimal indentation. Each condition is checked sequentially and independently, and the outcome for each failed check is immediately clear. This approach eliminated multiple levels of braces and made the function’s purpose more obvious.

Guard clauses are especially useful for input validation and error handling. One consideration: ensure that returning early (or throwing an exception early) is acceptable in your context. Embracing multiple return points can feel odd if you were taught to have a single return at function end, but modern best practices favor clarity over a single exit point.

Early exits can make code more linear and readable. After applying guard clauses, the remaining code in the function is often simpler since you’ve carved out all the exceptional paths.

## Simplify with Switch statements or pattern matching

Many languages, including C#, offer `switch` statements (and newer pattern matching capabilities) that can replace certain chains of `if/else` with a cleaner declarative structure. A switch/case is often easier to read when you’re checking one variable or expression against many possible values. Pattern matching (available in modern C#) extends this by allowing complex conditions to be handled in a switch-like expression.

### Examine the benefits of switch statements

A `switch` statement can flatten what would otherwise be multiple `else if` branches into a single level construct. It’s a good choice when a variable can take on several discrete states that require different handling. Pattern matching in C# 8+ even allows combining conditions in a more readable way. This reduces repetitive code and improves clarity.

Consider the following code snippet that uses pattern matching in a switch expression:

```csharp
string result = (user.Role, user.HasAccess) switch
{
    ("Admin", true)  => "Access granted",
    ("Admin", false) => "Access denied: no access flag",
    ("Guest", _)     => "Access denied: guests not allowed",
    _                => "Access denied: role not recognized"
};
Console.WriteLine(result);
```

This switch expression handles four scenarios in a very compact form. It’s much more concise than an equivalent `if/else if` ladder and is clearly exhaustive. Each case is separate, so it’s easy to add or modify one without risking the others.

Even without pattern matching, using a `switch` or dictionary for multiple discrete values can shorten and clarify code. The key is recognizing when a series of conditions is really checking the same thing and opting for a switch or pattern match to handle it.

## Decompose and encapsulate complex conditions

Decomposition involves breaking down a complicated conditional into smaller pieces. Decomposition can be achieved by extracting parts of the logic into helper functions (methods) or by using intermediate boolean variables with meaningful names. The idea is to give a name to a sub-condition or to separate the "decision" from the "action" for clarity.

### Examine the benefits of decomposition

Decomposing improves readability and reuse. By moving a logical check into a function with a clear name, the `if` statement becomes self-explanatory.

Consider the following code sample that demonstrates decomposition:

```csharp
// BEFORE: Moderately complex conditional that's hard to parse
public class DocumentService 
{
    public bool CanAccessDocument(User user, Document document)
    {
        if (user != null && user.IsActive && document != null && 
            !document.IsDeleted && 
            (document.IsPublic || 
             (document.OwnerId == user.Id) || 
             (user.Role == "Admin") || 
             (user.Role == "Manager" && document.Department == user.Department) ||
             (document.SharedUsers != null && document.SharedUsers.Contains(user.Id) && 
              document.ShareExpiry > DateTime.Now)))
        {
            return true;
        }
        return false;
    }
}

// AFTER: Decomposed with clear, meaningful method names
public class DocumentService 
{
    public bool CanAccessDocument(User user, Document document)
    {
        if (!IsValidRequest(user, document))
            return false;

        return HasDocumentAccess(user, document);
    }

    private bool IsValidRequest(User user, Document document)
    {
        return user != null && 
               user.IsActive && 
               document != null && 
               !document.IsDeleted;
    }

    private bool HasDocumentAccess(User user, Document document)
    {
        return document.IsPublic || 
               IsDocumentOwner(user, document) || 
               HasAdminAccess(user) || 
               HasDepartmentAccess(user, document) || 
               HasSharedAccess(user, document);
    }

    private bool IsDocumentOwner(User user, Document document)
    {
        return document.OwnerId == user.Id;
    }

    private bool HasAdminAccess(User user)
    {
        return user.Role == "Admin";
    }

    private bool HasDepartmentAccess(User user, Document document)
    {
        return user.Role == "Manager" && 
               document.Department == user.Department;
    }

    private bool HasSharedAccess(User user, Document document)
    {
        return document.SharedUsers != null && 
               document.SharedUsers.Contains(user.Id) && 
               document.ShareExpiry > DateTime.Now;
    }
}
```

This refactoring breaks down the complex conditional into smaller, well-named methods. Each method encapsulates a specific piece of logic, making the main `CanAccessDocument` method much easier to read and understand at a glance. The intent of each check is clear from the method names, and the overall structure is flatter.

Refactoring the sample code results in the following benefits:

- Clear intent: Each method name explains exactly what it's checking (`IsDocumentOwner`, `HasAdminAccess`, etc.)

- Easy to modify: Need to change admin logic? Just modify `HasAdminAccess`. Want to add a new sharing rule? Add it to `HasSharedAccess`.

- Testable: You can unit test each access rule independently without setting up complex scenarios.

- Readable flow: The main method now reads like English: "Is this a valid request? If so, does the user have document access?"

- Maintainable: Adding new access rules (like "Editor" role) is straightforward without touching existing logic.

> [!TIP]
> When you decompose and encapsulate logic, you should look at any overly complex boolean expressions and try to simplify them.

Decomposition is a "divide and conquer" approach that breaks down complex logic into smaller, manageable pieces. The result is code that is easier to read, maintain, and test.

## Consolidate redundant logic and remove "control flag" variables

Consolidation is used to clean up any duplication or unnecessary state in your conditional logic.

Consolidation techniques include:

- Consolidate redundant logic: If the same condition or computation is performed in multiple places, do it once in one place.
- Remove control flags: Removing control flags means eliminating variables that are used to steer complex flows when they aren’t truly needed.

### Examine the opportunities for consolidation

When performing a code review, look for repeated conditions or actions that can be merged. Also, identify any boolean flags that are set and checked later to control flow. These flags can often be removed by restructuring the logic into a clearer sequence of checks.

A control flag variable is often a sign that code was structured in a less-than-ideal way. Consider the following code sample:

```csharp
bool processed = false;
if (condition1) {
    DoTask();
    processed = true;
}
if (!processed && condition2) {
    DoTask();
    processed = true;
}
if (!processed) {
    DoDefaultTask();
}
```

This sample code could be refactored into a clearer `if - else if - else` chain, or perhaps separate guarded returns. For example:

```csharp
if (condition1) {
    DoTask();
} else if (condition2) {
    DoTask();
} else {
    DoDefaultTask();
}
```

Here's another example of consolidation:

```csharp
// Before consolidation
if (x > 0) {
    result = Math.Log(x);
} else {
    result = Math.Log(x);
    Logger.Warn("x was non-positive");
}

// After consolidation
if (x <= 0) {
    Logger.Warn("x was non-positive");
}
result = Math.Log(x);
```

Redundant conditional checks are often introduced inadvertently over time. Consolidating conditional logic helps to make your code DRY (Don’t Repeat Yourself) and ensures there’s a single source of truth for that condition.

## Apply polymorphism for complex multi-branch logic

A long series of conditionals is often a sign that you’re manually doing work that object-oriented design could do for you. This is known as replacing conditionals with polymorphism.

> [!NOTE]
> The Strategy pattern implements a similar idea: encapsulating a family of algorithms or behaviors behind an interface, and selecting the appropriate one rather than writing a big conditional to choose which one to use.

### Examine the benefits of polymorphism

Polymorphism eliminates the conditional entirely by delegating the decision to the object that knows what to do. This yields code that is easier to extend and keeps each piece of logic focused.

Consider the following code sample that uses polymorphism:

```csharp
INotificationSender sender = SenderFactory.GetSender(notification.Type);
sender.Send(notification);
```

No `if - else` chain is needed. If a new notification type is required, you add a class and update the factory, but you don’t modify the core logic.

The Strategy pattern is similar but usually refers to switching algorithms for a given task.

### Examine when to use polymorphism

Implementing Polymorphism (or the Strategy pattern) is most beneficial when your conditional logic is dealing with distinct categories of behavior or types. It not only reduces the immediate complexity but also makes the code more extensible for future requirements.

## Consider data-driven (table-driven) approaches

In some cases, you can replace complex conditional logic with configuration data or lookup tables. This means using data structures (like dictionaries, arrays, or configuration files) to dictate behavior instead of explicitly coding a chain of `if/else`.

### Examine the benefits of data-driven design

Data-driven approaches can drastically simplify code by removing explicit conditional logic and replacing it with data lookups.

Consider the following code sample that uses a dictionary for lookups:

```csharp
var fees = new Dictionary<string, decimal> {
    {"US", 5}, {"EU", 7}, {"ASIA", 10}, {"OTHER", 15}
};
fee = fees.ContainsKey(region) ? fees[region] : defaultFee;
```

Using a dictionary to map regions to fees eliminates a long series of `if/else if` statements. The resulting code is shorter and adding a new region can be done by adding an entry to the dictionary.

## Recap of simplification techniques

Here’s a summary of the main techniques to simplify complex conditionals:

- Guard clauses / early returns
- Switch/pattern matching
- Extract functions / variables
- Merge duplicates & remove flags
- Polymorphism
- Data-driven tables

Often, a combination of methods works best. The payoff is multifold: readability improves, maintainability improves, and testability improves.

## Summary

Refactoring complex conditionals is a multi-step process. Start by flattening nested structures with guard clauses, then look for opportunities to use switch statements or pattern matching. Decompose complex conditions into smaller methods with clear names. Consolidate redundant logic and eliminate control flags. For very complex decision trees, consider polymorphism or data-driven designs. Each technique contributes to making the code cleaner, more understandable, and easier to maintain. The goal is to transform tangled conditionals into straightforward logic that clearly expresses intent.
