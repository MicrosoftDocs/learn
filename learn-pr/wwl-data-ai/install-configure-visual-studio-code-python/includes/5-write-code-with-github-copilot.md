
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=eb64e5a6-a7b4-48b2-87ae-dbb06e81e4fc]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

GitHub Copilot is an AI coding assistant built into VS Code. As you write, it watches your code and offers suggestions—completing lines, filling in functions, and catching common mistakes—all without you having to leave the editor.

## Sign up for GitHub Copilot

To use GitHub Copilot, you need a GitHub account. If you don't have one, sign up at [github.com](https://github.com).

* When you create your GitHub account, select the option to sign up for **Copilot Free**.

You can also choose to subscribe to **GitHub Copilot Pro**. Navigate to **Copilot Settings** in your GitHub account to upgrade your plan.

## Install GitHub Copilot Chat in VS Code

To install the GitHub Copilot extension in VS Code:

1. In VS Code, open the **Extensions** panel (Ctrl+Shift+X).
1. Search for **GitHub Copilot Chat** and install the extension published by **GitHub**.
1. Sign in with your GitHub account when prompted.

## How Copilot helps as you type

Once installed, Copilot works automatically in the background. As you write code, it shows **inline suggestions** in gray text. To accept a suggestion, press **Tab**. To ignore it, just keep typing.

For example, if you start typing:

```python
print("How old are you?")
```

Copilot might suggest:

```python
age = input()
```

## Copilot for quick fixes

When VS Code highlights an error in your code, you often see a light bulb icon (💡) appear. Clicking it may show a **Fix using Copilot** option that suggests a correction for the problem.

## Guide Copilot with comments

You can also write comments in your code to guide Copilot. For example, if you write:

```python
# Prompt the user for their name and greet them
```

When you enter the next line, Copilot automatically suggests code that matches your comment.

## Chatting with Copilot

You can chat with Copilot to ask questions, get explanations, or request code snippets. Open the chat view by selecting the chat icon in the VS Code title bar, or using <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>i</kbd> (Windows/Linux) / <kbd>Control</kbd>+<kbd>Command</kbd>+<kbd>i</kbd> (Mac). You can ask Copilot to explain code, suggest improvements, or even generate new code based on your description.

## What Copilot is—and isn't

Copilot is a useful assistant, but it's not perfect. It generates suggestions based on patterns in code it learns from—which means its suggestions can sometimes be incorrect, incomplete, or not quite right for your situation.

> [!IMPORTANT]
> Always **read and understand** what Copilot suggests before accepting it. You're still the programmer—Copilot is a tool to help you, not a replacement for your own judgment.

::: zone-end
