## Set up the project locally

Here, you load the _Space Game_ project in Visual Studio Code, configure Git, clone your repository locally, and set the upstream remote so that you can download starter code.

> [!NOTE]
> If you're already set up with the [mslearn-tailspin-spacegame-web](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web?azure-portal=true) project locally, you can move to the next section.

### Open the integrated terminal

Visual Studio Code comes with an integrated terminal, so you can edit files and work from the command line all from one place.

1. Start Visual Studio Code.
1. On the **View** menu, select **Terminal**.
1. In the drop-down list, select **bash**. If you're familiar with another Unix shell that you prefer to use, such as Zsh, select that shell instead.

    :::image type="content" source="../../shared/media/vscode-terminal-bash.png" alt-text="A screenshot of Visual Studio Code showing the location of the Bash shell.":::

    The terminal window lets you choose any shell that's installed on your system, like Bash, Zsh, and PowerShell.

    Here you'll use Bash. Git for Windows provides Git Bash, which makes it easy to run Git commands.

    [!include[](../../shared/includes/troubleshoot-code-terminal.md)]

1. Run the `cd` command to navigate to the directory you want to work from, like your home directory (`~`). You can choose a different directory if you want.

    ```bash
    cd ~
    ```

### Configure Git

If you're new to Git and GitHub, you first need to run a few commands to associate your identity with Git and authenticate with GitHub.

[Set up Git](https://help.github.com/articles/set-up-git?azure-portal=true) explains the process in greater detail.

At a minimum, you'll need to complete the following steps. Run these commands from the integrated terminal:

1. [Set your username](https://help.github.com/articles/setting-your-username-in-git?azure-portal=true).
1. [Set your commit email address](https://help.github.com/articles/setting-your-commit-email-address-in-git?azure-portal=true).
1. [Cache your GitHub password](https://help.github.com/articles/caching-your-github-password-in-git?azure-portal=true).

> [!NOTE]
> If you're already using two-factor authentication with GitHub, [create a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line?azure-portal=true) and use your token in place of your password when prompted later.
>
> Treat your access token like you would a password. Keep it in a safe place.

### Set up your project in Visual Studio Code

In this part, you clone your fork locally so that you can make changes and build out your pipeline configuration.

### Clone your fork locally

You now have a copy of the *Space Game* web project in your GitHub account. Now you'll download, or *clone*, a copy to your computer so you can work with it.

A clone, just like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify they work as you expect, and then upload those changes back to GitHub. You can also synchronize your local copy with changes other authenticated users have made to GitHub's copy of your repository.

To clone the *Space Game* web project to your computer:

1. Go to your fork of the *Space Game* web project (**mslearn-tailspin-spacegame-web**) on [GitHub](https://github.com?azure-portal=true).
1. Select **Code**. Then, from the **HTTPS** tab, select the button next to the URL that's shown to copy the URL to your clipboard.

    :::image type="content" source="../../shared/media/github-clone-button.png" alt-text="Locating the URL and copy button from the GitHub repository.":::
1. In Visual Studio Code, go to the terminal window.
1. In the terminal, move to the directory you want to work from, like your home directory (`~`). You can choose a different directory if you want.

    ```bash
    cd ~
    ```

1. Run the `git clone` command. Replace the URL that's shown here with the contents of your clipboard:

    ```bash
    git clone https://github.com/your-name/mslearn-tailspin-spacegame-web.git
    ```

1. Move to the `mslearn-tailspin-spacegame-web` directory. This is the root directory of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web
    ```

### Set the upstream remote

A *remote* is a Git repository where team members collaborate (like a repository on GitHub). Here you list your remotes and add a remote that points to Microsoft's copy of the repository so that you can get the latest sample code.

1. Run this `git remote` command to list your remotes:

    ```bash
    git remote -v
    ```

    You see that you have both fetch (download) and push (upload) access to your repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    ```

    *Origin* specifies your repository on GitHub. When you fork code from another repository, it's common to name the original remote (the one you forked from) as *upstream*.

1. Run this `git remote add` command to create a remote named *upstream* that points to the Microsoft repository:

    ```bash
    git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git
    ```

1. Run `git remote` a second time to see the changes:

    ```bash
    git remote -v
    ```

    You see that you still have both fetch (download) and push (upload) access to your repository. You also now have fetch and push access to the Microsoft repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web.git (push)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git (fetch)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web.git (push)
    ```

### Open the project in the file explorer

In Visual Studio Code, your terminal window points to the root directory of the *Space Game* web project. To view its structure and work with files, from the file explorer, you'll now open the project.

1. The easiest way to open the project is to reopen Visual Studio Code in the current directory. To do so, run the following command from the integrated terminal:

    ```bash
    code -r .
    ```

    You see the directory and file tree in the file explorer.
1. Reopen the integrated terminal. The terminal places you at the root of your web project.

If the `code` command fails, you need to add Visual Studio Code to your system PATH. To do so:

1. In Visual Studio Code, select <kbd>F1</kbd> or select **View** > **Command Palette** to access the command palette.
1. In the command palette, enter *Shell Command: Install 'code' command in PATH*.
1. Repeat the previous procedure to open the project in the file explorer.

You're now set up to work with the _Space Game_ source code and your Azure Pipelines configuration from your local development environment.
