Now that you have a GitHub account and the learn-git repo created, it's time to install software that will make interacting with your GitHub repository simpler. You'll need to install Visual Studio Code first, then install Git, and then configure Visual Studio Code.

## Install Visual Studio Code

1.  Go to [https://code.visualstudio.com/Download](https://code.visualstudio.com/Download?azure-portal=true).
2.  Download Visual Studio Code for your operating system.
3.  Install Visual Studio Code with the default options.

> [!IMPORTANT]
> You must complete the installation of Visual Studio Code before you start the Git install, or some of the options in Git won't be available to select.

Now that Visual Studio Code is installed, it will be available as a selection during Git installation. Continue by installing Git.

## Install Git

1.  Go to [https://git-scm.com/downloads](https://git-scm.com/downloads?azure-portal=true)
2.  Download Git for your operating system.
3.  Install Git with the following custom selections - all other selections can be left as the default.
4.  Choosing the default editor used by Git - Set to **Use Visual Studio Code as Git's default editor**.
    
    :::image type="content" source="../media/git-default-editor-1792f2bc.png" alt-text="Screenshot of the default editor selection during Git install.":::
    
5.  Adjusting the name of the initial branch in new repositories - Set to **Override the default branch name for new repositories** and enter **main** in the text box.
    
    :::image type="content" source="../media/git-initial-branch-139dc84a.png" alt-text="Screenshot of the initial branch default being set to main during Git install.":::
    

> [!NOTE]
> Only steps 4 and 5 require custom settings. The rest of the Git installation can be completed with default values.

## Configure Visual Studio Code

For most of this project, you'll be using the terminal window of Visual Studio Code to run commands from the Git command line. Being familiar with the command line can greatly improve your Git experience. Rather than having to navigate different menus and recall where to locate different settings, you can do everything from the terminal window.

### Open the terminal window

1.  Launch **Visual Studio Code**.
2.  On the menu bar, select **Terminal &gt; New Terminal** or use the hotkey combination **CTRL \`** (control backtick) to open the terminal in Visual Studio Code.
3.  Change the terminal type to **Git Bash**.

> [!NOTE]
> By default, Visual Studio Code will always open the terminal window in PowerShell mode. You can change that default with the **Select Default Profile** option on the same menu where you changed to Git Bash.

### Configure Git settings and directories

Now we'll use a combination of batch commands and Git commands to create a Git repository folder and set our global username and email. In the terminal window, run the following commands.

| **Command**                                           | **Action**                                                                                                                                          |
| ----------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cd c:/`                                              | Changes from any location to the root of the C drive.                                                                                               |
| `mkdir git-repos`                                     | Creates a new directory, **git-repos**, on the C drive.                                                                                             |
| `cd git-repos`                                        | Changes to the newly created git-repos directory.                                                                                                   |
| `git config --global user.name "Victoria Burke"`      | Sets your user name for all git repos to help identify commits.\*replace Victoria-Burke with your GitHub username.                                  |
| `git config --global user.email "vburke@contoso.com"` | Sets your email address for all git repos to help identify commits.\*replace vburke@contoso.com with the email associated with your GitHub account. |

:::image type="content" source="../media/vscode-git-configuration-commands-1dafe3b1.png" alt-text="Screenshot of VS Code with the configuration commands run.":::


Congratulations! You've sucesfully installed Git and Visual Studio Code. You've also configured Visual Studio Code to start working with your Git repository.
