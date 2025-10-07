Agent Mode is a feature of GitHub Copilot Chat that allows developers to perform refactorings and code modifications with the assistance of AI. In Agent Mode, Copilot Chat can suggest code changes, automate repetitive tasks, and provide guidance for improving code quality. By leveraging Agent Mode, developers can streamline their refactoring process and enhance productivity.

## Compare Ask and Agent modes

While Ask mode focuses on analyzing code and providing insights, Agent Mode goes a step further by suggesting and performing code modifications. In Ask mode, developers can ask questions and receive answers, whereas in Agent Mode, developers can receive code suggestions and automate refactoring tasks. Both modes complement each other and can be used together to improve code quality.

| Ask Mode (Q&A) | Agent Mode (Action) |
|----------------|---------------------|
| **Goal:** Answer questions, explain, advise. | **Goal:** Execute tasks (write code, refactor, etc.). |
| **Scope:** Uses context from open files or provided text. No changes made. | **Scope:** Can access the whole workspace and make multiple changes across files. |
| **When to Use:** Understanding code, quick help, prototypes. | **When to Use:** Applying repetitive or multi-step changes, generating new code, refactoring. |
| **Risk:** Low (read-only). | **Risk:** Higher (makes changes; need to validate). |

## Effective prompts for Agent mode

To make the most of Agent Mode, developers should provide clear and specific prompts. For example, they can ask Agent Mode to "Consolidate duplicate code in this file" or "Refactor this function to improve readability." By providing detailed instructions, developers can guide Agent Mode to perform the desired refactorings and achieve the desired code quality improvements.

Here is a list of best practices:

- Be Specific: Tell it what to do and sometimes even how. e.g., “Create a new static class X with method Y that does Z.” The more precise your request, the closer the result will match your intention. Vague: “refactor duplicates” vs. Specific: “replace duplicate methods with calls to a new helper function.”
- One Step at a Time: Although Agent can plan multi-step solutions, as learners it’s best to break tasks down. E.g., first create the helper, then separately remove duplicate code. This not only yields better control but also helps them digest changes incrementally.
- Verify after Each Step: Encourage them to check the Diff or changes Copilot made. In VS Code, Copilot will often show the diff or list file changes in the chat. Review those like a code review. If something’s off, they can Undo (Ctrl+Z) or instruct Copilot to correct it.
- Use Comments in Prompts: If needed, they can write a comment in code like // TODO: use OrderHelper here and then ask Copilot to help fix that TODO. Sometimes anchoring instructions in the code helps contextualize the change.
- Limit Scope if Necessary: If the project were huge, you might open only certain folders or mention specific file names in the prompt to avoid undesired widespread changes. (Our case is small, so not an issue, but this is a pro tip for real scenarios.)

## Example refactoring walkthrough

Here's a walk through of a simple scenario to illustrate the flow of using Agent Mode for refactoring. Suppose you have a codebase with multiple instances of duplicate code for calculating discounts. In Agent Mode, you can ask Copilot Chat to identify and consolidate the duplicate code. Copilot Chat will analyze the code, suggest a refactored version, and provide step-by-step instructions for integrating the changes. By following the suggestions, developers can eliminate duplicate code and improve code maintainability.

## When not to use Agent mode

While Agent Mode is a powerful tool, there are situations where it is better to perform tasks manually. For complex refactorings or critical code changes, developers should rely on their expertise and judgment. Agent Mode is best suited for repetitive and straightforward refactoring tasks, where automation can save time and effort. By understanding the limitations of Agent Mode, developers can make informed decisions about when to use it and when to rely on manual refactoring.

## Reaping the benefits

Using Agent Mode for refactoring offers several benefits. It saves time and effort by automating repetitive tasks, improves code quality by suggesting best practices, and enhances productivity by streamlining the refactoring process. By leveraging Agent Mode, developers can create cleaner, more maintainable code and focus on higher-level tasks that require their expertise.
