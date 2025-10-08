
Absolutely! Here's the full content of Unit 1 converted into Markdown format, preserving the original paragraph structure and narrative style:

---

# Unit 1: Why Complex Conditionals Are a Problem

Complex conditionals arise when decision logic in code becomes complicated – for example, deeply nested `if` statements or large compound `if` conditions with many `&&` and `||` parts. Such code might function correctly, but it poses several significant problems.

## Problems associated with complex conditionals

- Reduced Readability: Deep nesting makes code hard to follow at a glance. You often have to scroll horizontally or match many braces to understand the flow. Multiple layers of conditions increase cognitive load, meaning a developer must hold several state checks in mind at once. The intent of the code gets obscured by the complexity of its structure.

- Difficult Maintenance: Code with lots of intertwined conditions is brittle. When requirements change or a bug surfaces, modifying that code is risky and error-prone. A maintainer might introduce a new condition hoping to fix one case, only to break another because the interactions aren’t obvious. Complex conditional logic often violates clean code principles like single responsibility (one function now handles many decision paths) and obscures the intended behavior. As a result, developers may avoid changing it, leading to stagnation or awkward workarounds elsewhere.

- Higher Error Frequency: There is a known correlation between a program’s complexity (measured by metrics like cyclomatic complexity) and its bug rates. Every additional conditional branch creates new pathways through the code that need to be handled correctly. A function with a high cyclomatic complexity (lots of independent paths) is statistically more likely to contain errors or unanticipated edge cases. In other words, complex conditionals tend to be fragile – they might work for the scenarios the original developer thought of, but unexpected combinations of inputs can slip through the cracks.

- Testing Challenges: The more branches and nesting, the more test cases are needed to cover all paths. Thoroughly testing a function with many conditional branches is time-consuming, and it’s easy to miss some logic paths. For example, consider a five-level nested `if`: for full coverage you must trigger every branch at each level – an exponential explosion of test cases. If testing is incomplete, bugs linger. Moreover, when you refactor or extend such code, you must re-run a large battery of tests to ensure nothing broke. Complex conditionals thus reduce confidence in code changes because verifying correctness is harder.

- Poor Team Agility: In a team setting, if one module of code is known to have an overly complex decision logic, new team members struggle to understand it, and even experienced members might tread carefully. Code reviews for such modules are longer and more contentious (“Are we sure we handled all cases here?”). This slows down development and can delay feature releases. It’s not uncommon to see comment blocks or documentation trying to explain a convoluted `if/else` chain – a red flag that the code itself isn’t clear.

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

As a reader, it’s hard to quickly tell what conditions lead to “Access granted” versus various denial messages. The nesting pushes the important logic to the far right, creating an “arrowhead” shape. You have to mentally invert the structure to understand it: first check user not null, then active, then role, then permission – all in reverse due to nesting. This example exhibits all the issues above: it’s tedious to read and reason about, adding a new access rule would require touching multiple places, and you’d need many tests (null user, inactive user, non-admin user, admin without permission, admin with permission, etc.) to cover it all.

## Summary of Issues

Complex conditionals decrease code quality by making code less readable, harder to modify, and more error-prone. They often indicate that a function is doing too much or that logic is not well-structured. Recognizing these problems is the first step; whenever you notice code that is difficult to understand due to nested or elaborate conditionals, it’s a sign that refactoring might be needed.

---

Absolutely! Here's the full content of Unit 2 converted into Markdown format, preserving the original paragraph structure and keeping bullet points where appropriate:

---

# Unit 2: How Complex Conditionals Emerge (and How to Recognize Them)

Rarely does a developer set out to write a convoluted tangle of `if` statements from scratch. Instead, complex conditionals accumulate gradually as a codebase evolves. Understanding this evolutionary process can help you identify these patterns in your own projects (and ideally prevent them early).

- **Incremental Feature Additions**  
  The code often begins with a straightforward decision structure for a simple scenario. Over time, new features or requirements are added. Each time, instead of redesigning the logic, a developer may choose the path of least resistance: just add another `if` or extend the existing conditional. For example, an order processing routine might start by checking `if (order.Total > 100) { applyDiscount(); }`. Later, a special discount for VIP customers gets added as another condition, then a holiday promotion as a nested condition inside that, and so on. Each individual change seems small, but they compound into a complex net of conditions.

- **Edge Case Bug Fixes**  
  Another common source is quick patches for bugs. Suppose QA finds that “if the user’s account is locked and they try a password reset, the system behaves incorrectly.” A developer might address this by inserting a targeted conditional check in the code (“if accountLocked and passwordReset then do X”). This fix works and passes tests. However, it adds another branch to the logic. Over the project’s life, many such edge-case fixes might be piled on, each one adding a bit more nesting or complexity. What started as a simple `if/else` can turn into a multi-branched tree as special cases are bolted on without refactoring.

- **Evolving Requirements**  
  Requirements often grow beyond the original design of the code. Consider a loan approval system that initially checks a few basics (credit score and income) to make a decision. As the business expands, they introduce more rules: special handling for first-time borrowers, conditional approval with collateral, different rules for various loan types, regulatory checks, etc. If the original code isn’t restructured, the natural implementation is to nest more `if` statements: e.g., inside the `if (creditOK)` block, add `if (hasCollateral) ... else ...`, and within that, perhaps another `if` for a regulatory flag. Each new rule increases the nesting or adds new branches at the same level. Over months or years, the loan approval function morphs into a giant method hundreds of lines long, with a tangle of conditions covering every scenario the business has encountered.

- **Lack of Periodic Refactoring**  
  The crucial factor is that these incremental additions aren’t accompanied by cleaning up the code structure. It’s common in fast-paced development to de-prioritize refactoring (“it works, let’s not touch it”). As a result, conditional logic that should perhaps have been redesigned (split into smaller functions, or turned into a configuration table, etc.) remains in an increasingly ungainly form. By the time someone notices how unwieldy it’s become, the function is so fragile that people are reluctant to refactor it – a classic accumulation of technical debt.

## Signs of Overly Complex Conditionals

As a developer, you should be on the lookout for red flags in code that suggest conditional complexity has gotten out of hand:

- **Deep nesting levels**  
  Functions with more than 2–3 levels of nested `if` statements (especially with interleaved `else` blocks) are strong candidates. Visually, the code forms an indented arrow shape to the right, making it hard to align the logic in your mind. If you find yourself counting braces or indentations to figure out which `else` pairs with which `if`, that’s a bad sign.

- **Long chains of else-if or switch cases**  
  A series of `else if (...) { ... } else if (...) { ... } ...` that goes on for dozens of lines may indicate the code is handling many variants in one place. Sometimes a long `switch` statement with many cases can be equivalent. These can often be simplified or broken into smaller pieces (or data-driven mappings) if they represent a lot of static conditions.

- **Complex boolean expressions**  
  Conditionals that combine many terms, for example:  
  `if ((A && B && !C) || (D && (E || !F))) { ... }`  
  such expressions are hard to read and even harder to get right. If you see conditional logic with multiple `&&` and `||` operators mixed with `!` negations, it might benefit from simplification (for instance, by splitting into clearer sub-conditions or using explanatory variables).

- **Repeated checks and code duplication**  
  A subtle indicator is if the same condition or similar code appears in multiple branches. For instance, if you see `if (user.IsAdmin)` in two different parts of an `if/else` ladder, the logic might be restructured to check that once. Or if two branches of a conditional contain a lot of duplicate code with slight differences, that’s a clue the conditional could be refactored to avoid repeating yourself (DRY principle).

- **Use of “flag” variables to control flow**  
  Sometimes developers introduce temporary flags as a workaround for complex logic (e.g., `bool isValid = false; ... if (condition) { isValid = true; } ... if (isValid) { ... }`). While not an `if` nesting per se, it’s often a response to complexity – the code couldn’t easily do what it needed in one pass, so it sets a flag to be checked later. Such patterns can often be eliminated by restructuring conditionals or using early returns.

## Recognizing Complexity in Real Projects

To illustrate, let’s revisit our example scenarios and how they might look in a messy codebase:

- The order processing function might have begun with one discount rule; now it has multiple nested `if` blocks, each adding a layer (member discount, then inside that holiday discount, then inside that free shipping conditions, etc.). If you open that function and see indent after indent with business rules buried deep, you’ve hit a complex conditional structure.

- The loan approval function might read like a checklist that’s been encoded as code, but without any abstraction: one long method with `if` after `if` checking every criterion in sequence, with nested blocks for combinations of criteria. If printed out, it could run several pages, with lots of opportunities to miss an `else` pairing or a condition that got added in the wrong place.

Recognizing these symptoms in code is crucial. Whenever you encounter them, it’s a prompt to step back and consider refactoring. In the next unit, we’ll discuss concrete approaches to transform these complex, hard-to-manage conditionals into cleaner, simpler structures. Remember, the goal of refactoring is not to change what the code does (its external behavior) but to change how the code is organized internally to make it more understandable and maintainable.

---

Absolutely! Here's the full content of Unit 3 converted into Markdown format, preserving the original paragraph structure and formatting:

---

# Unit 3: Techniques to Simplify Complex Conditionals

Refactoring complex conditionals means applying structured techniques to make the code simpler and flatter without altering its behavior. There are several time-tested approaches to achieve this. As an experienced developer might say: “We want to tame the complexity, one step at a time.” Below are key techniques to simplify nested or convoluted conditional logic, along with how they help.

## Use Guard Clauses (Early Returns) to Flatten Nesting

**What it is:**  
A guard clause is a conditional check that immediately exits the function (or otherwise prevents further execution) if a certain condition is met, rather than wrapping the main logic inside an `if`. By handling edge cases or invalid conditions upfront, you avoid deep nesting and make the code’s “happy path” more prominent.

**How it helps:**  
Guard clauses reduce indentation levels dramatically. Instead of code that says “if X is true, then inside that if Y is true, then inside that if Z is true, do something,” you invert the logic: check for the opposite of X, Y, or Z and bail out early. The result is a series of simple one-level checks. This improves readability because the normal flow of the function isn’t buried in many layers of braces. It also aligns with the fail-fast principle – error or stop conditions are handled immediately, so the rest of the function can assume those conditions are false and focus on the main task.

**Example (Before and After):**

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

In the refactored version, each `if` handles a bad-case scenario and returns early. Now the “happy path” (where the order is non-null, valid, and not expired) is at the bottom, with minimal indentation. Each condition is checked sequentially and independently, and the outcome for each failed check is immediately clear. This approach eliminated multiple levels of braces and made the function’s purpose more obvious.

Guard clauses are especially useful for input validation and error handling. One consideration: ensure that returning early (or throwing an exception early) is acceptable in your context. Embracing multiple return points can feel odd if you were taught to have a single return at function end, but modern best practices favor clarity over a single exit point.

In summary, early exits make code more linear and readable. After applying guard clauses, the remaining code in the function is often simpler since you’ve carved out all the exceptional paths.

## Simplify with Switch Statements or Pattern Matching

**What it is:**  
Many languages, including C#, offer `switch` statements (and newer pattern matching capabilities) that can replace certain chains of `if/else` with a cleaner declarative structure. A switch/case is often easier to read when you’re checking one variable or expression against many possible values. Pattern matching (available in modern C#) extends this by allowing complex conditions to be handled in a switch-like expression.

**How it helps:**  
A `switch` statement can flatten what would otherwise be multiple `else if` branches into a single level construct. It’s especially handy when a variable can take on several discrete states that require different handling. Pattern matching in C# 8+ even allows combining conditions in a more readable way. This reduces repetitive code and improves clarity.

**Example:**

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

## Decompose and Encapsulate Complex Conditions

**What it is:** This involves breaking down a complicated conditional into smaller pieces – either by extracting parts of the logic into helper functions (methods) or by using intermediate boolean variables with meaningful names. The idea is to give a name to a sub-condition or to separate the “decision” from the “action” for clarity.

**How it helps:** Decomposing improves readability and reuse. By moving a logical check into a function with a clear name, the `if` statement becomes self-explanatory.

**Example:**

```csharp
if (UserHasAdminPrivileges(user)) {
    // perform action
}

bool UserHasAdminPrivileges(User u) {
    return u.IsAdmin && (u.HasPermission("edit") || u.HasPermission("delete"));
}
```

This refactoring makes the main logic more readable and isolates complexity. It also lets you unit-test that condition logic separately if needed.

Decomposing also applies to the branches of an if. If the code inside an `if` or `else` block is lengthy and not directly about the decision being made, consider moving that code to a method.

**Also, simplify boolean logic:** As part of decomposition, you should look at any overly complex boolean expressions and try to simplify them. Strategies include:

- Applying De Morgan’s laws or logical equivalences to reduce negations and conjunctions.
- Breaking one `if` with multiple conditions into nested ifs or sequential ifs if that reads more clearly.
- Using temporary booleans with descriptive names.

```csharp
bool hasValidCoupon = (coupon != null && coupon.IsValid);
bool eligibleForDiscount = (order.Total > 100 || user.IsPremium);

if (hasValidCoupon && eligibleForDiscount) { ... }
```

This conveys meaning without you having to parse the logic all at once.

In summary, divide and conquer the conditional: each piece should do one thing. The result is code that is easier to read, maintain, and test.

## Consolidate Redundant Logic and Remove “Control Flag” Variables

**What it is:** This step is about cleaning up any duplication or unnecessary state in your conditional logic. Consolidation means if the same condition or computation is performed in multiple places, do it once in one place. Removing control flags means eliminating variables that are used to steer complex flows when they aren’t truly needed.

**How it helps:** Redundant checks often creep in over time. You can merge those so it’s checked only once, simplifying the logical structure and avoiding confusion. It makes the code DRY (Don’t Repeat Yourself) and ensures there’s a single source of truth for that condition.

A control flag variable is often a sign that code was structured in a less-than-ideal way.

**Example:**

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

This could be refactored into a clearer if/else if/else chain, or perhaps separate guarded returns.

Another example of consolidation:

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

In practice, consolidating and removing flags often goes hand-in-hand with the other techniques. The end result is cleaner, more direct logic.

## Apply Polymorphism or the Strategy Pattern for Complex Multi-Branch Logic

**What it is:** Sometimes a long series of conditionals is a sign that you’re manually doing work that object-oriented design could do for you. This is known as replacing conditionals with polymorphism. The Strategy pattern is a similar idea: encapsulating a family of algorithms or behaviors behind an interface, and selecting the appropriate one rather than writing a big conditional to choose which one to use.

**How it helps:** Polymorphism eliminates the conditional entirely by delegating the decision to the object that knows what to do. This yields code that is easier to extend and keeps each piece of logic focused.

**Example:**

```csharp
INotificationSender sender = SenderFactory.GetSender(notification.Type);
sender.Send(notification);
```

No if/else chain needed. If a new notification type comes along, you add a class and update the factory, but you don’t modify the core logic.

The Strategy pattern is similar but usually refers to switching algorithms for a given task.

**When to use:** Polymorphism/strategy refactoring is most beneficial when your conditional logic is dealing with distinct categories of behavior or types. It not only reduces the immediate complexity but also makes the code more extensible for future requirements.

## Consider Data-Driven (Table-Driven) Approaches

**What it is:** In some cases, you can replace complex conditional logic with configuration data or lookup tables. This means using data structures (like dictionaries, arrays, or configuration files) to dictate behavior instead of explicitly coding a chain of `if/else`.

**How it helps:** Data-driven approaches can drastically simplify code by removing explicit conditional logic and replacing it with data lookups.

**Example:**

```csharp
var fees = new Dictionary<string, decimal> {
    {"US", 5}, {"EU", 7}, {"ASIA", 10}, {"OTHER", 15}
};
fee = fees.ContainsKey(region) ? fees[region] : defaultFee;
```

The conditional disappears; the code is shorter and adding a new region is just adding an entry to the dictionary.

## Recap of Simplification Techniques

- Guard Clauses / Early Returns
- Switch/Pattern Matching
- Extract Functions / Variables
- Merge Duplicates & Remove Flags
- Polymorphism/Strategy
- Data-Driven Tables

Often, a combination of methods works best. The payoff is multifold: readability improves, maintainability improves, and testability improves.

---

Absolutely! Here's the full content of Unit 4 converted into Markdown format, preserving the original paragraph structure and formatting:

---

# Unit 4: Analyzing Complex Logic with GitHub Copilot Chat (Ask Mode)

Identifying and planning a refactor is often half the battle. GitHub Copilot Chat’s Ask mode can help you examine a piece of complex code and figure out how to simplify it. Ask mode is a conversational Q&A interface with AI: you ask questions or request suggestions, and Copilot answers using the context you provide, without directly modifying your code. It’s like having a knowledgeable colleague who can read your code and give advice.

## What is Ask Mode?

In Ask mode, Copilot Chat does not make changes to your files. It can read the code you’ve selected or that’s visible in the editor and respond with explanations, insights, or code examples in text form. Think of it as a smart mentor: you highlight a confusing function or a giant `if` statement and ask, “How can I simplify this?” Copilot will analyze that code and come back with suggestions. It might propose refactoring steps (e.g., “introduce an early return here” or “extract this block into a function”), or point out redundancies. Importantly, it’s focused on answering your question without doing anything itself to the codebase. This makes it a safe way to explore ideas because you retain full control – you can ask “what if we did X?” and see the answer before deciding to implement anything.

## Using Ask Mode to Plan a Refactor

Here’s a typical workflow for using Ask mode on a complex conditional:

### Open the Problematic Code

Navigate to the file and function that contains the complex conditional logic you intend to refactor. For example, suppose you have a method `CalculateDiscount()` that has grown huge with many nested conditions.

### Highlight or Select the Relevant Code (Optional but Helpful)

By selecting the specific block of code (the nested `if` statements, for instance), you give Copilot a clear focus. Copilot will use this selection as context for answering.

### Ask for an Explanation of the Code

Start simple. For instance:  
> “Copilot, can you explain what this `CalculateDiscount` method is doing?”

In Ask mode, Copilot will read through the code and produce an explanation in plain English. This step is useful to ensure you (and the AI) fully understand the current logic before changing it. The explanation might come back like:  
> “This method calculates a discount for an order. First, it checks if the user is a premium member; if so, it sets baseDiscount to 10%. Then it checks if a coupon code is provided. If a coupon exists, it validates the coupon’s expiration date, applying an extra discount if valid. It also has special cases for holiday sales and bulk orders…”

Seeing this summary confirms the code’s intent and may already highlight where the logic is convoluted.

### 4. Ask Pointed Questions About Complexity

Now you can get analytical. Some useful questions:

- “Are there any redundant or repeated checks in this code?”
- “Which parts of this logic are making it complex?”
- “What edge cases does this code handle?”
- “Do you see any way to restructure this to reduce nesting?”

Copilot could point out, for example:  
> “The nested `if` inside the coupon section adds complexity. Also, there is an `if` five levels deep for holiday sales – consider simplifying that.”

### Ask for Refactoring Suggestions

Now the key question:  
> “How can I simplify or refactor this conditional logic?”

Copilot, in Ask mode, might respond with a list of suggestions. For example:

- Use guard clauses to handle the cases where no discount applies (e.g., if coupon is invalid, return early).
- Extract the coupon validation and discount calculation into its own function for clarity.
- Combine the two separate premium member checks into one place to avoid duplication.
- Use a switch or dictionary for the holiday sale multipliers instead of if/else.

It might even sketch out brief pseudo-code or show how a piece of the code would look after applying these ideas.

### Iterate with Follow-Up Questions

You can drill down on any suggestion:

- “Which conditions in this function would be good guard clauses?”
- “Can you show me what an extracted function might look like for the coupon calculation?”
- “What different discount scenarios does this code account for?”

Through this dialogue, Copilot helps form a refactoring plan. By the end of the Ask mode exploration, you might have a list of specific changes to implement, such as:

- Add an early return for invalid coupons.
- Move holiday discount calculation to a separate function.
- Remove duplicate check on `IsPremium` by doing it once at the top.
- Use a single combined condition for bulk orders instead of two nested ifs.

This plan outlines how to apply the techniques from Unit 3 to your particular code.

## Treat Suggestions as Guidance

While Copilot’s suggestions are often good, they’re not infallible. Treat them as guidance, not absolute truth. For instance, Copilot might suggest a change that would slightly alter behavior if it misinterpreted the code. Always double-check any critical logic changes.

At this stage (Ask mode), you haven’t changed anything yet – you’re gathering information – which is great because you can evaluate freely.

## Summary

By leveraging Ask mode, you’ve effectively performed a thorough code review of the complex condition with AI assistance. You should now have:

- A solid understanding of what the code does (thanks to explanations).
- A set of recommended refactoring steps to simplify it.
- Possibly even example snippets or outlines for how the refactored code might look.

---

# Unit 5: Refactoring Complex Conditionals with GitHub Copilot Chat (Agent Mode)

After analyzing the code and formulating a plan in Ask mode, the next step is to implement the refactoring. This is where GitHub Copilot Chat’s Agent mode comes into play. Agent mode allows Copilot to act on your behalf inside the IDE – it can edit files, apply changes, and even run commands as instructed. Essentially, it’s like a junior developer you can ask to carry out the refactoring steps, while you supervise the changes.

## What is Agent Mode?

In Agent mode, Copilot can modify your actual codebase. It has access to your workspace and can open files, refactor code, and even execute build or test commands, depending on your prompts. It “reasons” across your project, meaning it can see multiple files if needed and ensure consistency (for example, if you rename a function, Agent mode can update all references to it). Unlike Ask mode’s one-shot Q&A, Agent mode can perform multi-step tasks autonomously: it plans out a series of edits and executes them, only pausing if it needs clarification or confirmation for something potentially risky. It’s powerful, but with that power comes the need for careful instructions and validation.

## Using Agent Mode to Apply the Refactor

Building on the discount calculation example from Unit 4, let’s walk through a typical usage of Agent mode to actually refactor the code. We’ll incorporate the suggestions we got from Ask mode.

### Switch to Agent Mode in Copilot Chat

In your IDE (such as VS Code), change the Copilot Chat mode to “Agent”. You might see a note indicating that the agent can now run commands and edit files. Ensure you’ve saved your work or are using version control, so you can track changes.

### Prepare Your Refactoring Instructions

Before telling the agent what to do, take a moment to outline the changes (the plan from Ask mode). For our example, let’s say the plan is:

- Introduce guard clauses for invalid states (null order, invalid coupon).
- Extract a method `ApplyCouponDiscount`.
- Simplify the premium member check.
- Remove duplicate logic around holiday sales.

You can choose to give these instructions one at a time or as a batch. Agent mode can handle fairly complex prompts, even with multiple steps, but sometimes doing it step-by-step gives you more oversight.

### Issue a High-Level Refactoring Prompt

You could try a comprehensive prompt like:

> “Copilot, refactor the `CalculateDiscount` method as follows:  
> - Add early returns at the top for any conditions that should short-circuit (like if `order` is null or `coupon` is invalid).  
> - Extract the code that validates and applies the coupon into a new function `ApplyCouponDiscount(Order order, Coupon coupon)` and call that from `CalculateDiscount`.  
> - Ensure that premium members have their discount applied in one place (currently it’s scattered).  
> - Simplify any nested ifs related to holiday sales into clearer logic.  
> Please preserve the method’s behavior and outputs.”

Copilot’s agent will parse this and likely break it into sub-tasks. It might respond in the chat with something like:  
> “Understood. I will 1) open the file containing CalculateDiscount, 2) add guard clauses for null order and invalid coupon, 3) create a new method ApplyCouponDiscount and move relevant logic there, 4) adjust premium member discount logic, 5) simplify holiday sale logic.”

Then it will start executing.

### Allow the Agent to Make Changes

Copilot Agent will begin editing your code. You’ll see it opening the `CalculateDiscount` function and making the changes:

- It writes the guard clauses: e.g., at the top, insert `if (order == null) return 0;` and similarly for invalid coupon.
- It creates a new function `ApplyCouponDiscount` either above or below, with the code that was previously nested under coupon handling.
- It finds where premium member discount was applied and consolidates it.
- It refactors the holiday sale logic, possibly converting nested `if` statements into a flatter structure.

Throughout, it may occasionally ask for confirmation. For instance, if there’s ambiguity about how to handle a certain case, it might ask for clarification.

### Review the Changes

Once the agent believes it’s done (or it stops after each major step), carefully review the modified code. Check that:

- The guard clauses make sense and aren’t changing functionality.
- The extracted `ApplyCouponDiscount` function has all the necessary logic and is called correctly.
- The premium logic still gives the same outcome as before.
- The structure is indeed simpler (fewer nested ifs, clearer flow).

Copilot’s changes are usually correct if the prompt was clear, but you are the final judge. If something isn’t right, you can either undo that part or instruct the agent further.

### Test the Refactored Code

Now that the code is changed, it’s crucial to test it to ensure that behavior remains consistent. Ideally, you have unit tests for `CalculateDiscount()`. If so, run them. You can even ask Copilot (in Agent mode) to run a test command.

If tests pass, that’s great validation that your refactor didn’t break anything. If a test fails, examine the failure – it might indicate a subtle change in logic or a scenario you missed.

If you don’t have automated tests, you should do some manual testing. Try a few scenarios that the code covers: e.g., premium member with valid coupon, non-premium without coupon, etc.

### Iterate if Needed

If any issues are found in testing, you can use Agent mode to address them. For instance, if you discovered that the refactored code forgot to apply a particular condition, you can prompt Copilot to add it. Or if the new function needs a tweak, ask Copilot to modify it.

Treat Copilot as an assistant – you can keep refining until the code is both clean and correct.

### Finalize and Commit the Changes

Once satisfied, make sure to save all changes and commit them to version control with an appropriate message (e.g., “Refactored CalculateDiscount for clarity – no logic change”).

## Leveraging Ask Mode Insights

Throughout the Agent mode process, you leveraged the analysis from Ask mode. The suggestions we got earlier essentially became the to-do list for the agent. You might even copy-paste some of those suggestions into the Agent prompt to ensure they’re followed.

This is a great one-two punch: Ask mode for brainstorming and plan, Agent mode for execution. Microsoft’s own guidance suggests starting with Ask mode for understanding, then switching to Agent when you’re ready to make broad changes.

## Benefits of Using Agent Mode for Refactoring

- It can do mechanical but tedious tasks very quickly.
- It updates all references consistently.
- It follows your high-level intent.

## Be Cautious and Review

Because Agent mode can make sweeping changes, always review what it does. If you spot something, you can ask Copilot in Ask mode about it. If it realizes it made a mistake, you can reintroduce it or fix it manually.

Once the refactoring is done and tested, step back and admire the cleaner code. Your function might now be shorter, more linear, and easier to maintain.

## Summary

This unit showed how to turn a plan into action using Copilot Chat’s Agent mode. By combining your understanding of best practices with Copilot’s automation, you can significantly speed up the refactoring of complex conditionals. It’s like having a capable assistant who can execute the repetitive parts of code cleanup while you make the high-level decisions.
