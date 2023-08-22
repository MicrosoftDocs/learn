During your journey as a developer, there's always _that_ moment when you end up asking yourself:

## Open project in development container


A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=278117471)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespaces/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that Node.js is installed in your environment:

    ```bash
    node --version
    ```
1. Close the terminal.
1. The remaining exercises in this project take place in the context of this development container.

#### [Visual Studio Code](#tab/visual-studio-code)
The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code requires [Docker](https://docs.docker.com/) to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.
1. Open **Visual Studio Code** in the context of an empty directory.
1. Ensure that you have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in Visual Studio Code.
1. Open a new terminal in the editor.
    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::
1. Clone the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository into the current directory.
    ```bash
    git clone https://github.com/MicrosoftDocs/node-essentials.git .
    ```
1. Open the folder into which you cloned the GitHub repository.
1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.
    :::image type="content" source="../media/codespaces/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::
    > [!TIP]
    > Visual Studio Code might automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/codespaces/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::
1. Validate that Node.js is installed in your environment:
    ```bash
    node --version
    ```
1. Close the terminal.
1. The remaining exercises in this project take place in the context of this development container.

---

## Why isn't my code working?

During your work on the Tailwind Traders retail application, you'll most likely be confronted with this situation a few times. When there's a bug in the program, everyone usually has their own way of dealing with the problem.

You've probably already tried one or more of these debugging approaches yourself:

- Try running your program again because it *should* work.
- Explain your issue to your colleague.
- Read through your code again to find out the issue.
- Take a walk outside.
- Spam a few `console.log('here')` in your code.

While you might have various degrees of success with these methods, there's one other approach commonly regarded as being more often successful: using a debugger. But what's a debugger exactly?

A debugger is a software tool used to observe and control the execution flow of your program with an analytical approach. The design goal is to help find the root cause of a bug and help you resolve it. It works by either hosting your program in its own execution process, or running as a separate process that's attached to your running program, like Node.js.

Debuggers come in different flavors. Some work directly from the command line, while others come with a graphical user interface. In this module, we'll use both the built-in command-line debugger that comes with Node.js, and the integrated graphical debugger of Visual Studio Code.

## Why use a debugger?

If you're not running your code through a debugger, that means you're probably *guessing* what's happening in your program. The primary benefit of using a debugger is that you can *watch* your program running. You can follow your program execution one line of code at a time. In this way, you avoid the chance of guessing wrong.

Every debugger has its own set of features. The two most important features that come with almost all debuggers are:

- Control of your program execution. You can pause your program and run it step by step, which allows you to see which code is executed and how it affects your program's state.
- Observation of your program's state. For example, you can look at your variables' value and function parameters at any point during your code execution.

Mastering debugger usage is an important skill for a developer that's often overlooked. It makes you more efficient at hunting bugs in your code. It can also help you quickly understand how a program works.

Let's discover that in the next section.
