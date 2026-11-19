
Often, when you work with code, you need to review the project's documentation in addition to libraries and framework documentation. In order to write code or documentation, you must have a good understanding of the codebase. Tasks like fixing bugs and writing tests can be time intensive, but at the same time necessary for most projects. Fortunately, GitHub Copilot has several advanced features that can make these tasks easier and more efficient.

## The basics

When GitHub Copilot is enabled, it provides you with suggestions. These suggestions are called ghost text. You can either ignore the ghost text, or accept it by pressing the **Tab** key. The suggestions don't require a prompt because GitHub Copilot uses the code you're editing, along with related content from other open files, as context. However, you can provide a prompt using a comment, the Chat view, or the inline chat within your code.

## Chatting with GitHub Copilot

GitHub Copilot allows you to have an interactive discussion using the chat feature. To open the Chat view in Visual Studio Code, select **Chat** in the title bar, and then select **Open Chat**. The view normally opens beside the editor, but its position can vary with your layout.

In this view, you can ask questions about the code you're currently working on or other software-related questions.

## Using inline chat

Besides the Chat view, you can use the inline chat. It allows you to interact with GitHub Copilot without leaving your code.

For a focused edit, select the relevant code and press **Ctrl+I** on Windows or **Command+I** on macOS. You can also select **Chat** > **Open Inline Chat**. One of the benefits of using the inline chat is that you don't have to switch context by going to a different pane. The suggestions and interactions happen closer to the code.

If a file belongs to an active chat editing session, the inline chat shortcut can open **Ask in Chat** for that session instead. To practice a separate inline edit, use a file that isn't part of the active session.

## Slash commands

Slash commands start specific workflows in the Chat view. In a new chat, choose **Copilot** as the session target, and then type `/` to see the commands available in that session. Using a slash command is a good way to start a common workflow without having to write a longer prompt.

Available commands depend on the session type, editor version, and installed customizations. Don't assume that a Chat view command is also available in editor inline chat. Use a natural-language request for a focused inline edit.

For example, `/plan` researches a task and proposes an implementation plan. In the Python web API project that you work with later in this module, a planning request might look like this:

```text
/plan Add GET /regions/{region} to return the city names in weather.json. Preserve the existing endpoints and identify the tests needed to verify the change.
```

Review the plan before you implement it. When Copilot presents a **Review Plan** card, select **Open Full Plan** to inspect the proposed files, changes, and tests. Some sessions show **Open Plan** or **Plan summary** instead. Check that the plan preserves the existing endpoints and includes a way to verify the change.

To request corrections, add feedback and select **Submit Feedback**. Review the revised plan before approving it. Select **Approve Plan Only** to keep the plan without starting implementation, or **Implement Plan** when you're ready for the agent to make the changes in the current session.

> [!IMPORTANT]
> **Implement Plan** starts implementation. Plan approval and tool permissions are separate decisions, so review the session's permissions first. After implementation, inspect the changes and run the tests. For this module's exercise, choose **Approve Plan Only**, then implement the route with inline chat as instructed.

## Choose the right agent

In a Copilot Chat session, choose **Ask** to understand code without changing it, or **Agent** to implement a change and work through its verification. For example, you might use **Ask** to learn how an existing route reads its data, and then switch to **Agent** when you're ready to add a route and its tests.

Attach relevant files or output so the response is grounded in your project. Whichever agent you choose, review the result. **Agent** can make changes for you, but you still need to inspect those changes and confirm that they work.