# Unit 5: Refactor Complex Conditionals using GitHub Copilot's Agent Mode

After analyzing the code and formulating a plan in Ask mode, the next step is to implement the refactoring. This is where GitHub Copilot Chat’s Agent mode comes into play. Agent mode allows Copilot to act on your behalf inside the IDE – it can edit files, apply changes, and even run commands as instructed. Essentially, it’s like a junior developer you can ask to carry out the refactoring steps, while you supervise the changes.

## What is Agent mode?

In Agent mode, Copilot can modify your actual codebase. It has access to your workspace and can open files, refactor code, and even execute build or test commands, depending on your prompts. It "reasons" across your project, meaning it can see multiple files if needed and ensure consistency (for example, if you rename a function, Agent mode can update all references to it). Unlike Ask mode’s one-shot Q&A, Agent mode can perform multi-step tasks autonomously: it plans out a series of edits and executes them, only pausing if it needs clarification or confirmation for something potentially risky. It’s powerful, but with that power comes the need for careful instructions and validation.

## Using Agent mode to apply the refactor

Building on the discount calculation example from Unit 4, let’s walk through a typical usage of Agent mode to actually refactor the code. We’ll incorporate the suggestions we got from Ask mode.

### Switch to Agent mode in Copilot Chat

In your IDE (such as VS Code), change the Copilot Chat mode to "Agent". You might see a note indicating that the agent can now run commands and edit files. Ensure you’ve saved your work or are using version control, so you can track changes.

### Prepare your refactoring instructions

Before telling the agent what to do, take a moment to outline the changes (the plan from Ask mode). For our example, let’s say the plan is:

- Introduce guard clauses for invalid states (null order, invalid coupon).
- Extract a method `ApplyCouponDiscount`.
- Simplify the premium member check.
- Remove duplicate logic around holiday sales.

You can choose to give these instructions one at a time or as a batch. Agent mode can handle fairly complex prompts, even with multiple steps, but sometimes doing it step-by-step gives you more oversight.

### Issue a high-level refactoring prompt

You could try a comprehensive prompt like:

```plaintext
Copilot, I need you to refactor the `CalculateDiscount` method in order to simplify complex conditionals. Refactoring should improve readability and maintainability. Consider the following steps:
- Add early returns at the top for any conditions that should short-circuit (like if `order` is null or `coupon` is invalid).  
- Extract the code that validates and applies the coupon into a new function `ApplyCouponDiscount(Order order, Coupon coupon)` and call that from `CalculateDiscount`.  
- Ensure that premium members have their discount applied in one place (currently it’s scattered).  
- Simplify any nested ifs related to holiday sales into clearer logic.  

Please preserve the method’s behavior and outputs.
```

Copilot’s agent will parse this and likely break it into sub-tasks. It might respond in the chat with something like:

```plaintext
Understood. I will:

1. Open the file containing CalculateDiscount.
2. Add guard clauses for null order and invalid coupon.
3. Create a new method ApplyCouponDiscount and move relevant logic there.
4. Adjust premium member discount logic.
5. Simplify holiday sale logic.
```

Then it will start executing.

### Allow the Agent to make changes

Copilot Agent will begin editing your code. You’ll see it opening the `CalculateDiscount` function and making the changes:

- It writes the guard clauses: e.g., at the top, insert `if (order == null) return 0;` and similarly for invalid coupon.
- It creates a new function `ApplyCouponDiscount` either above or below, with the code that was previously nested under coupon handling.
- It finds where premium member discount was applied and consolidates it.
- It refactors the holiday sale logic, possibly converting nested `if` statements into a flatter structure.

Throughout, it may occasionally ask for confirmation. For instance, if there’s ambiguity about how to handle a certain case, it might ask for clarification.

### Review the changes

Once the agent believes it’s done (or it stops after each major step), carefully review the modified code. Check that:

- The guard clauses make sense and aren’t changing functionality.
- The extracted `ApplyCouponDiscount` function has all the necessary logic and is called correctly.
- The premium logic still gives the same outcome as before.
- The structure is indeed simpler (fewer nested ifs, clearer flow).

Copilot’s changes are usually correct if the prompt was clear, but you are the final judge. If something isn’t right, you can either undo that part or instruct the agent further.

### Test the refactored code

Now that the code is changed, it’s crucial to test it to ensure that behavior remains consistent. Ideally, you have unit tests for `CalculateDiscount()`. If so, run them. You can even ask Copilot (in Agent mode) to run a test command.

If tests pass, that’s great validation that your refactor didn’t break anything. If a test fails, examine the failure – it might indicate a subtle change in logic or a scenario you missed.

If you don’t have automated tests, you should do some manual testing. Try a few scenarios that the code covers: e.g., premium member with valid coupon, non-premium without coupon, etc.

### Iterate if needed

If any issues are found in testing, you can use Agent mode to address them. For instance, if you discovered that the refactored code forgot to apply a particular condition, you can prompt Copilot to add it. Or if the new function needs a tweak, ask Copilot to modify it.

Treat Copilot as an assistant – you can keep refining until the code is both clean and correct.

### Finalize and commit the changes

Once satisfied, make sure to save all changes and commit them to version control with an appropriate message (e.g., "Refactored CalculateDiscount for clarity – no logic change").

## Leveraging Ask mode insights

Throughout the Agent mode process, you leveraged the analysis from Ask mode. The suggestions we got earlier essentially became the to-do list for the agent. You might even copy-paste some of those suggestions into the Agent prompt to ensure they’re followed.

This is a great one-two punch: Ask mode for brainstorming and plan, Agent mode for execution. Microsoft’s own guidance suggests starting with Ask mode for understanding, then switching to Agent when you’re ready to make broad changes.

## Benefits of using Agent mode for refactoring

- It can do mechanical but tedious tasks very quickly.
- It updates all references consistently.
- It follows your high-level intent.

## Be cautious and review

Because Agent mode can make sweeping changes, always review what it does. If you spot something, you can ask Copilot in Ask mode about it. If it realizes it made a mistake, you can reintroduce it or fix it manually.

Once the refactoring is done and tested, step back and admire the cleaner code. Your function might now be shorter, more linear, and easier to maintain.

## Summary

This unit showed how to turn a plan into action using Copilot Chat’s Agent mode. By combining your understanding of best practices with Copilot’s automation, you can significantly speed up the refactoring of complex conditionals. It’s like having a capable assistant who can execute the repetitive parts of code cleanup while you make the high-level decisions.
