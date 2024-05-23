
Often, when you work with code, you need to review the project's documentation in addition to libraries and framework documentation. In order to write code or documentation, you must have a good understanding of the codebase. Tasks like fixing bugs and writing tests can be time intensive, but at the same time necessary for most projects. Fortunately, GitHub Copilot has several advanced features that can make these tasks easier and more efficient.

## The basics

When GitHub Copilot is enabled, it provides you with suggestions. These suggestions are called ghost text, and you can either ignore the ghost text or accept it by pressing the Tab key. The suggestions don't require a prompt because GitHub Copilot uses by default the files you have open as context. However, you can provide a prompt using a comment, using the chat window, or using the inline chat within your code. 

## Chatting with GitHub Copilot

GitHub Copilot allows you to have an interactive discussion using the chat feature. In Visual Studio Code, you can click the chat icon on the left sidebar, which will open the chat interface in a dedicate pane. 

In this pane, you can ask questions about the code you're currently working on, or other software-related questions. 

## Using inline chat

Besides the dedicated chat pane, you can use the inline chat, which allows you to interact with GitHub Copilot without leaving your code.

Access the inline chat by using Ctrl+i on Windows or Command+i on a mac. One of the benefits of using the inline chat is that you don't have to switch context by going to a different pane. The suggestions and interactions happen closer to the code.

## Slash commands

Within the chat pane or when using the inline chat, you can use slash commands. These commands allow GitHub Copilot to use a specific intent for quickly solving common development tasks. 

If you type a forward slash in the chat pane or in inline chat, you should see a drop-down menu with all the slash commands available. For example the `/tests` slash command helps you write tests, while the `/docs` command is intended for writing documentation.

Using specific slash commands to create a question is a good way to get better responses without having to write longer prompts.

## Agents

Visual Studio Code has a feature called "agents" that allows you to interact with GitHub Copilot. These agents allow you to ask questions using a specific context. For example the `@terminal` agent helps you chat with GitHub Copilot to interact with the terminal. 

Another agent is `@workspace` which is aware of your entire workspace, allowing you to ask questions about the entire project. To use an agent, prefix your question with the agent, for example: `@workspace how can I package this project?`.
