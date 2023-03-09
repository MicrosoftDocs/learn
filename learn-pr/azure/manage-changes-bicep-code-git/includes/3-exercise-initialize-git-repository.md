You've decided that your workflow could benefit from a version control system, and you're going to try Git. In this exercise, you'll get everything ready so that you can start to work with Git.

During the process, you'll:

> [!div class="checklist"]
>
> - Install and configure Git.
> - Create and initialize a Git repository.
> - Add a Bicep file to the repository folder and see how the repository's status changes.

> [!NOTE]
> Visual Studio Code is a powerful editor, and it has many different ways of achieving the same thing. Almost every action has keyboard shortcuts. There are often several ways to perform common actions by using the user interface too. This module will guide you to perform the actions by using one approach. Feel free to use a different approach if you want.

## Install Git

1. [Install Git](https://git-scm.com/download). Choose the correct version based on your operating system.

1. If you already have Visual Studio Code open, restart it so that it detects your Git installation.

## Configure Git

You need to run a few commands to configure Git so that it associates your name and email address with your activity. This identification helps when you use Git to collaborate with others. If you've already configured Git, you can skip these steps and move to the next section.

1. Open Visual Studio Code.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Verify that Git is installed by entering the following command:

   ```bash
   git --version
   ```

   If you see an error, [make sure you've installed Git](https://git-scm.com/download), restart Visual Studio Code, and try again.

1. Set your name by using the following command. Replace `USER_NAME` with the username that you want to use. Use your first name and last name so that your team members know it's you.

    ```bash
    git config --global user.name "USER_NAME"
    ```

1. Set your email address by using the following command. Replace `USER_EMAIL_ADDRESS` with your email address.

    ```bash
    git config --global user.email "USER_EMAIL_ADDRESS"
    ```

1. Run the following command to check that your changes worked:

    ```bash
    git config --list
    ```

1. Confirm that the output includes two lines that are similar to the following example. Your name and email address will be different from what's shown in the example.

    ```output
    user.name=User Name
    user.email=user-name@contoso.com
    ```

## Create and initialize a Git repository

1. In the Visual Studio Code terminal, create a new folder named _toy-website_:

   ```bash
   mkdir toy-website
   cd toy-website
   ```

1. By using the Visual Studio Code terminal, run the following command to reopen Visual Studio Code with the _toy-website_ folder loaded:

   ```bash
   code --reuse-window .
   ```

   Visual Studio Code reloads. If you're prompted to trust the folder, select **Yes, I trust the authors**.

1. In the Visual Studio Code terminal, run the following command to initialize a new Git repository in the _toy-website_ folder that you created:

   ```bash
   git init
   ```

   Git displays a message confirming that it initialized an empty Git repository.

## Add a Bicep file

1. Create a subfolder named _deploy_. You can create the folder using **Explorer** in Visual Studio Code, or you can use the following command in the Visual Studio Code terminal:

   ```bash
   mkdir deploy
   ```

1. In the _deploy_ folder, create a new file called _main.bicep_.

1. Open and save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select the keyboard shortcut <kbd>Ctrl+S</kbd> for Windows (<kbd>⌘+S</kbd> for macOS). Be sure to remember where you save the file. For example, you might want to create a _scripts_ folder to save it in.

1. Copy the following code into _main.bicep_.

   :::code language="bicep" source="code/3-main.bicep" :::

   This Bicep file contains two parameters but doesn't define any resources yet.

1. Save the file.

> [!NOTE]
> Even though you've saved the file into your repository's folder, Git isn't _tracking_ it yet. You'll learn how Git keeps track of files in the next unit.

## Inspect the repository status by using the CLI

Git monitors the repository folder for changes. You can query Git to see the list of files that have been modified. This feature is useful to see what you've done and to verify you haven't accidentally added files or made changes that you didn't mean to include. You can use both the Git CLI and Visual Studio Code to view the status of your repository.

1. By using the Visual Studio Code terminal, run the following command:

   ```bash
   git status
   ```

1. Look at the results. They're similar to the following example:

   ```output
   On branch main

   No commits yet

   Untracked files:
     (use "git add <file>..." to include in what will be committed)
           deploy/

   nothing added to commit but untracked files present (use "git add" to track)
   ```

   This text tells you four pieces of information:

   - You're currently on the _main_ branch. You'll learn about branches shortly.
   - There have been no commits to this repository. You'll learn about commits in the next unit.
   - There are untracked files in the _deploy_ folder.
   - You haven't told Git to add any files to be tracked by the repository yet.

1. Look at the first line of the output from the preceding step. If it shows a branch name that's different from _main_, run the following command to rename your branch to _main_:

   ```bash
   git branch -M main
   ```

   This command ensures you can follow along with the remaining exercises in this module.

## Inspect the repository status by using Visual Studio Code

Visual Studio Code shows the same information that the `git status` command provides, but it integrates the information into the Visual Studio Code interface.

1. In Visual Studio Code, select **View** > **Source Control**, or select <kbd>Ctrl+Shift+G</kbd> on the keyboard.

   **Source Control** opens.

   :::image type="content" source="../media/3-vscode-source-control.png" alt-text="Screenshot of Visual Studio Code that shows Source Control, with one change on the icon badge and the main.bicep file listed as a changed file." border="true":::

   Visual Studio Code shows that the _main.bicep_ file in the _deploy_ folder has changed. Additionally, the **Source Control** icon has a badge that shows the number **1**, which indicates one untracked file.

1. The status bar appears at the bottom of Visual Studio Code. It provides useful information and functionality. Toward the left side, the status bar shows the word _main_:

   :::image type="content" source="../media/3-vscode-status-bar.png" alt-text="Screenshot of the Visual Studio Code status bar that shows the branch name as main." border="true":::

   This word indicates that you're currently on the _main_ branch. You'll learn about branches shortly.

The status reported by Git and Visual Studio Code is the same because the Git CLI and Visual Studio Code use the same Git engine. You can mix and match the tools that you use to work with your repositories. You can use different tools based on what suits you best.
