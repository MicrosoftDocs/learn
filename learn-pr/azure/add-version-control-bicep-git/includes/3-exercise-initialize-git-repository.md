You've decided that your workflow could benefit from a version control system, and you're going to try Git. The first step is to install the tools you need, and then to initialize a repository. In this exercise you'll get everything ready so that you can start to work with Git.

During the process, you'll:

> [!div class="checklist"]
> * Install and configure Git.
> * Create and initialize a Git repository.
> * Add a Bicep file to the repository folder and see how the repository's status changes.

## Install Git

[Install Git](https://git-scm.com/download)

## Configure Git

1. Open terminal
1. Configure Git commit name and email address

<!-- TODO see https://docs.microsoft.com/en-us/learn/modules/intro-to-git/2-exercise-configure-git?ns-enrollment-type=LearningPath&ns-enrollment-id=learn.student-evangelism.intro-to-vc-git -->

## Create and initialize a Git repository

1. Create a folder for your repository. TODO

1. In the Visual Studio Code 

1. Run `git init`

1. Using the Visual Studio Code terminal, execute the following command to reopen Visual Studio Code with your repository's folder loaded:

   ```bash
   code --reuse-window .
   ```

   Visual Studio Code reloads.

## Add a Bicep file

You've been working with Bicep enough that you have built up a collection of files for different scenarios. Here, you add a single Bicep file to your repository, but the same approach can be used when you have more templates to add in the future.

1. Create a subfolder named *deploy*. You can do this using Visual Studio Code's file explorer, or you can use the following command in the Visual Studio Code terminal:

   ```bash
   mkdir deploy
   ```

1. In the *deploy* folder, create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following code into *main.bicep*.

   :::code language="bicep" source="code/3-main.bicep" :::

1. Save the file.

## Inspect the repository status

Git monitors the repository folder for changes, and you can query Git to see the list of files that have been modified. This is really useful to see what you've done and to verify you haven't accidentally added files or made changes you didn't mean to include. Here, you use both the Git CLI and Visual Studio Code to view the status of your repository.

1. Using the Visual Studio Code terminal, execute the following command:

   ```bash
   git status
   ```

   Look at the results. TODO

1. TODO Look at VS Code's 'changes' panel.

   Notice that the status reported by both tools is the same. That's because both the Git CLI and Visual Studio Code use the same Git engine. You can mix and match the tools you use to work with your repositories, and use different tools based on what suits you best.

> [!NOTE]
> Even though you've saved the file into your repository's folder, Git isn't tracking it yet. You'll learn how Git keeps track of files in the next unit.