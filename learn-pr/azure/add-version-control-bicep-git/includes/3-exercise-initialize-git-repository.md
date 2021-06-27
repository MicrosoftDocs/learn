You've decided that your workflow could benefit from a version control system, and you're going to try Git. The first step is to install the tools you need, and then to initialize a repository. In this exercise you'll get everything ready so that you can start to work with Git.

During the process, you'll:

> [!div class="checklist"]
> * Install and configure Git.
> * Create and initialize a Git repository.
> * Add a Bicep file to the repository folder and see how the repository's status changes.

## Install Git

You need to [install Git](https://git-scm.com/download). Make sure you choose the correct version based on your operating system.

## Configure Git

You need to run a few commands to configure Git so that it associates your name and email address with your activity. This helps when you use Git to collaborate with others. If you've already configured Git, you can skip these steps and move to the next section.

1. Open Visual Studio Code.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. Verify that Git is installed by entering the following command:

   ```bash
   git --version
   ```

   If you see an error, [make sure you have installed Git](https://git-scm.com/download), restart Visual Studio Code, and try again.

1. Set your name by using the following command. Replace `USER_NAME` with the user name you want to use. Use your first name and last name so that your team members know it's you.

    ```bash
    git config --global user.name "USER_NAME"
    ```

1. Now, use this command to create a `user.email` configuration variable, replacing `USER_EMAIL_ADDRESS` with your email address:

    ```bash
    git config --global user.email "USER_EMAIL_ADDRESS"
    ```

1. Use the following command to configure Git to create a default branch named **main**:

   ```bash
   git config --global init.defaultBranch main
   ```

   You'll learn more about branches later in this module.

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

1. In the Visual Studio Code terminal, create a new folder named *toy-website*:

   ```bash
   mkdir toy-website
   cd toy-website
   ```

1. Using the Visual Studio Code terminal, execute the following command to reopen Visual Studio Code with the *toy-website* folder loaded:

   ```bash
   code --reuse-window .
   ```

   Visual Studio Code reloads. If you're prompted to trust the folder, select **Trust**.

1. In the Visual Studio Code terminal, run the following command to initialize a new Git repository in the folder you just created:

   ```bash
   git init
   ```

   Git displays a message confirming it initialized an empty Git repository.

## Add a Bicep file

1. Create a subfolder named *deploy*. You can do this using Visual Studio Code's file explorer, or you can use the following command in the Visual Studio Code terminal:

   ```bash
   mkdir deploy
   ```

1. In the *deploy* folder, create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following code into *main.bicep*.

   :::code language="bicep" source="code/3-main.bicep" :::

   Notice that this Bicep file contains an App Service plan and app.

1. Save the file.

## Inspect the repository status

Git monitors the repository folder for changes, and you can query Git to see the list of files that have been modified. This is really useful to see what you've done and to verify you haven't accidentally added files or made changes you didn't mean to include. Here, you use both the Git CLI and Visual Studio Code to view the status of your repository.

1. Using the Visual Studio Code terminal, execute the following command:

   ```bash
   git status
   ```

   Look at the results. You see something similar to the following:

   ```output
   On branch main
   
   No commits yet
   
   Untracked files:
     (use "git add <file>..." to include in what will be committed)
           deploy/
   
   nothing added to commit but untracked files present (use "git add" to track)
   ```

1. In Visual Studio Code, open the **Source Control** panel by selecting **View** and then **SCM**.

   TODO screenshot

   Notice that Visual Studio Code shows that the *main.bicep* file in the *deploy* folder has changed.

   The status reported by both Git and Visual Studio Code is the same. That's because both the Git CLI and Visual Studio Code use the same Git engine. You can mix and match the tools you use to work with your repositories, and use different tools based on what suits you best.

> [!NOTE]
> Even though you've saved the file into your repository's folder, Git isn't tracking it yet. You'll learn how Git keeps track of files in the next unit.
