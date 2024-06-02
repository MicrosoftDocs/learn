## Set up the project locally

Here you load the _Space Game_ project in Visual Studio Code, configure Git, clone your repository locally, and set the upstream remote so that you can download starter code.

> [!NOTE]
> If you're already set up with the [mslearn-tailspin-spacegame-web-deploy](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy?azure-portal=true) project locally, you can move to the next section.

### Open the integrated terminal

Visual Studio Code comes with an integrated terminal. Here you both edit files and work from the command line.

1. Start Visual Studio Code.
1. On the **View** menu, select **Terminal**.
1. In the dropdown list, select **Git Bash**. If you're familiar with another Unix shell that you prefer to use, select that shell instead.

    :::image type="content" source="../../shared/media/vscode-terminal-git-bash.png" alt-text="A screenshot of Visual Studio Code showing the location of the Git Bash shell.":::

    In the terminal window, you can choose any shell that's installed on your system. For example, you can choose Git Bash, or PowerShell, or another shell.

    Here you'll use Git Bash, part of Git for Windows, which makes it easy to run Git commands.

    [!include[](../../shared/includes/troubleshoot-code-terminal.md)]

1. Run the `cd` command to go to the directory where you want to work. Choose your home directory (`~`) or a different directory if you want.

    ```bash
    cd ~
    ```

### Configure Git

If you're new to Git and GitHub, first run a few commands to associate your identity with Git and authenticate with GitHub. For more information, see [Set up Git](https://help.github.com/articles/set-up-git?azure-portal=true).

At a minimum, you need to complete the following steps. Run the commands from the integrated terminal.

1. [Set your username](https://help.github.com/articles/setting-your-username-in-git?azure-portal=true).
1. [Set your commit email address](https://help.github.com/articles/setting-your-commit-email-address-in-git?azure-portal=true).
1. [Cache your GitHub password](https://help.github.com/articles/caching-your-github-password-in-git?azure-portal=true).

> [!NOTE]
> If you already use two-factor authentication with GitHub, [create a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line?azure-portal=true). When you're prompted, use your token in place of your password.
>
> Treat your access token like a password. Keep it in a safe place.

### Set up your project in Visual Studio Code

In the [Build applications with Azure DevOps](../../../paths/build-applications-with-azure-devops/index.yml?azure-portal=true) learning path, you forked and then cloned a Git repository. The repository contains the source code for the _Space Game_ website. Your fork was connected to your projects in Azure DevOps so that the build runs when you push changes to GitHub.

> [!IMPORTANT]
> In this learning path, we switch to a different Git repository, [mslearn-tailspin-spacegame-web-deploy](https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy?azure-portal=true). When you ran the template to set up your Azure DevOps project, the process forked the repository automatically for you.

In this part, you clone your fork locally so that you can change and build out your pipeline configuration.

### Clone your fork locally

You now have a copy of the *Space Game* web project in your GitHub account. Now you'll download, or *clone*, a copy to your computer so you can work with it.

A clone, just like a fork, is a copy of a repository. When you clone a repository, you can make changes, verify that they work as you expect, and then upload those changes to GitHub. You can also synchronize your local copy with changes that other authenticated users have made to the GitHub copy of your repository.

To clone the *Space Game* web project to your computer:

1. Go to your fork of the *Space Game* web project (**mslearn-tailspin-spacegame-web-deploy**) on [GitHub](https://github.com?azure-portal=true).
1. Select **Code**. Then, from the **HTTPS** tab, select the button next to the URL that's shown to copy the URL to your clipboard.

    :::image type="content" source="../../shared/media/github-clone-button.png" alt-text="Screenshot that shows how to locate the URL and copy button from the GitHub repository.":::
1. In Visual Studio Code, go to the terminal window.
1. In the terminal, move to the directory where you want to work. Choose your home directory (`~`) or a different directory if you want.

    ```bash
    cd ~
    ```

1. Run the `git clone` command. Replace the URL that's shown here with the contents of your clipboard:

    ```bash
    git clone https://github.com/your-name/mslearn-tailspin-spacegame-web-deploy.git
    ```

1. Move to the `mslearn-tailspin-spacegame-web-deploy` directory. This is the root directory of your repository.

    ```bash
    cd mslearn-tailspin-spacegame-web-deploy
    ```

### Set the upstream remote

A *remote* is a Git repository where team members collaborate (like a repository on GitHub). Here you list your remotes and add a remote that points to Microsoft's copy of the repository so that you can get the latest sample code.

1. Run this `git remote` command to list your remotes:

    ```bash
    git remote -v
    ```

    You see that you have both fetch (download) and push (upload) access to your repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (push)
    ```

    *Origin* specifies your repository on GitHub. When you fork code from another repository, the original remote (the one you forked from) is often named *upstream*.

1. Run this `git remote add` command to create a remote named *upstream* that points to the Microsoft repository:

    ```bash
    git remote add upstream https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy.git
    ```

1. Run `git remote` again to see the changes:

    ```bash
    git remote -v
    ```

    You see that you still have both fetch (download) access and push (upload) access to your repository. You also now have fetch access to the Microsoft repository:

    ```output
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (fetch)
    origin  https://github.com/username/mslearn-tailspin-spacegame-web-deploy.git (push)
    upstream        https://github.com/MicrosoftDocs/mslearn-tailspin-spacegame-web-deploy.git (fetch)
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
