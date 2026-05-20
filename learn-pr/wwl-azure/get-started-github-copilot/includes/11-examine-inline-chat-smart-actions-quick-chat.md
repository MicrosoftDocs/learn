In addition to the Chat view, GitHub Copilot provides several other ways to interact with the AI pair programmer. These include smart actions, Quick Chat, and Inline Chat.

## Smart actions

Some tasks are so common that they can be automated. Visual Studio Code provides GitHub Copilot smart actions that allow you to complete certain tasks without having to write a prompt. Smart actions are predefined actions that you can run directly from the Visual Studio Code editor to perform common coding tasks quickly and easily.

The following smart actions are available:

- **Explain**: Generates a natural language description of the selected code. This is useful for understanding unfamiliar code or explaining it to others.
- **Review**: Provides a code review of the selected code. Helps identify bugs, performance bottlenecks, and security vulnerabilities.

- **Fix**: Suggests a fix for the selected code. Useful when you encounter an error or issue and need guidance on how to resolve it.

To access smart actions, right-click in the code editor. The context menu includes a section for GitHub Copilot smart actions. The available smart actions may vary based on the context of your code selection. For example, if you select code that contains an error, the **Fix** smart action should be included in the context menu.

Smart actions aren't limited to the right-click menu. GitHub Copilot also surfaces smart actions as sparkle (✨) icons elsewhere in Visual Studio Code. For example, the sparkle icon appears under the following conditions:

- In the Test Explorer to fix failing tests.
- In the terminal gutter after a failed command.
- In the Source Control view to generate commit messages.
- When you rename a symbol with F2 to suggest AI-generated names.

## Quick Chat

Quick Chat provides a lightweight chat panel at the top of the editor for short questions and interactions. It lets you get a quick answer without opening the full Chat view or leaving your coding context.

To open Quick Chat, use the **Ctrl+Shift+Alt+L** keyboard shortcut or select **Quick Chat** from the **Chat** menu in the Visual Studio Code title bar.

Type your prompt and press Enter. Quick Chat supports the same `#`-mentions for adding context as the full Chat view. If the conversation grows, select **Open in Chat View** to continue in the full Chat view.

## Inline Chat

The inline chat feature enables you to generate or edit code directly in the editor or get help with shell commands within the integrated terminal. Inline chat allows you to stay in the flow of your work without having to switch to a separate Chat view.

Use inline chat when you want to make quick, targeted edits within the visible code context. For multi-step tasks, multi-file changes, or broader codebase exploration, use the Chat view instead.

## Summary

In addition to the Chat view, Visual Studio Code provides several ways to interact with GitHub Copilot's AI pair programmer. Smart actions, Quick Chat, and Inline Chat provide useful alternatives under specific conditions. By using these features, you can enhance your productivity and get more value out of GitHub Copilot.
