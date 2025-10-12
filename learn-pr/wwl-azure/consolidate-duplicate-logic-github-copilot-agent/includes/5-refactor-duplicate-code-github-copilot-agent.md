Agent Mode is a feature of GitHub Copilot Chat that allows developers to perform refactorings and code modifications with the assistance of AI. In Agent Mode, Copilot Chat can suggest code changes, automate repetitive tasks, and provide guidance for improving code quality. By using Agent Mode, developers can streamline their refactoring process and enhance productivity.

## Compare Ask and Agent modes

While Ask mode focuses on analyzing code and providing insights, Agent mode goes a step further by performing tasks that modify code autonomously. The two modes complement each other and can be used together to accelerate development and improve code quality.

| Ask mode (explanations) | Agent mode (actions) |
|----------------|---------------------|
| **Goal:** Answer questions, explain, advise. | **Goal:** Execute tasks (write code, refactor, etc.). |
| **Scope:** Uses context from open files or provided text. No changes made. | **Scope:** Can access the whole workspace and make multiple changes across files. |
| **When to Use:** Understanding code, quick help, prototypes. | **When to Use:** Applying repetitive or multi-step changes, generating new code, refactoring. |
| **Risk:** Low (read-only). | **Risk:** Higher (makes changes; need to validate). |

## Effective prompts for Agent mode

To make the most of Agent mode, developers should provide clear and specific prompts. For example: "Extract the duplicate email validation logic from the UserService.ValidateEmail() and OrderService.ValidateCustomerEmail() methods. Create a shared EmailValidator.IsValid() method in a new EmailValidator class. Refactor the existing methods to use the new validator." By providing detailed instructions, developers can guide Agent mode to perform the desired refactorings and achieve the desired code quality improvements.

Here's a list of best practices:

- Be specific: Clearly specify what you need the agent to do. If you have a specific approach that you want the agent to use, describe it. Precisely phrased tasks generate better results.

- One step at a time: GitHub Copilot Agent can plan multi-phase implementations for assigned tasks. However, breaking down large and complex tasks into smaller, more manageable tasks is a better approach. For example, rather than asking the agent to refactor an entire module, you can ask it to create a helper function in one task, then ask it to remove duplicate code and refactor the original methods in a subsequent task. Smaller tasks yield better control and help developers manage changes incrementally.

- Use comments in prompts: If needed, include comments in code like `// TODO: use OrderHelper here` and then ask Copilot to help fix that TODO. Sometimes anchoring instructions in the code helps contextualize the change.

- Monitor progress and verify results: Monitor the agent's progress in the chat panel. If necessary, you can cancel the task. Once the agent completes the task, use the code editor to review each edit individually. GitHub Copilot displays a list of each updated file in the chat panel. Be sure to open each file and review the updates. Treat this process like a code review. If something’s off, you can ask the agent to fix it or make the changes manually. If the results aren't what you expected, you can always revert the changes and try again with a more specific prompt.

## When not to use Agent mode

GitHub Copilot's Agent mode is a powerful tool that can accelerate your development process. However, there are situations where it's better to perform tasks manually. For complex refactorings or critical code changes, developers might find that they need to rely on their own expertise and judgment. Agent mode is best suited for repetitive and straightforward refactoring tasks, where automation can save time and effort. Understanding the limitations of Agent mode helps developers make informed decisions about when to use it and when to rely on their own expertise.

## Summary

Using Agent mode for refactoring offers several benefits. It saves time and effort by automating repetitive tasks, improves code quality by suggesting best practices, and enhances productivity by streamlining the refactoring process. By using Agent mode, developers can create cleaner, more maintainable code and focus on higher-level tasks that require their expertise.
