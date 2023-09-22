Reviewing all of the possible Git commands is overwhelming. There are over 100 commands, and even trying to keep track of them, much less know how to use them correctly, is daunting.

While all of the commands have a use, you can effectively use Git for collaboration and development with a handful of basic commands. Having an understanding of how and when to use these basic commands will get you headed in the right direction.

All Git commands start with the word `git`, and then the operator. In most cases, the operator is self-explanatory, but we’ll go through some just in case.

## git init

If you’re starting from scratch and want to create a new repository, use `git init`. With the `git init` command, you can create a new repository with default values, or you can specify values for the new repository. If you haven’t run `git config` yet, you may want to specify the name for the default branch.

`git init --initial-branch main`

:::image type="content" source="../media/git-init-command-76c9e6ac.png" alt-text="Screenshot of the git init command for the initial branch.":::


You can also set permissions when you initially create the repository with the --shared flag. By default, it will be a private repository, but you can change that on the initial setup.

`git init --initial-branch main --shared all` would create a new repository with the default branch being **main**. Anyone that wants to connect with the new repository can connect to it.

## git config

The first command you’ll likely need is `git config`. `git config` sets several configuration attributes. If you want to see what your settings are without changing anything, list them.

`git config --list`

> [!NOTE]
> When setting up your configuration, you can set things globally (for all projects on which you collaborate), or for the current repository. Use the --global flag for global settings.

### Identity

When you’re collaborating on a project with others, it’s important to know the identity of people making changes. With `git config`, you can set the name and email address associated with all of your changes.

`git config user.name “<your name>”`

`git config --global user.name “<your name>”`

### Default branch

The default branch name is the name that Git will use if you create a new repository with the `git init` command. The system may use **master** as the default branch, but industry trends are shifting to **main**. It’s recommended to use **main** as your default branch.

`git config --global init.defaultBranch <branch name>`

:::image type="content" source="../media/git-config-command-4501d576.png" alt-text="Screenshot of the git config command setting the default branch to main.":::


## git clone

`git clone` is the command that you’ll likely start most projects with, unless you’ve been tasked with setting up a repo using git init.

`git clone` is the command that copies (or clones) a repository to your local computer. By running the `git clone` command, you create a full and complete copy of the remote or origin repo, including branches, history, and other metadata.

When you clone a repository, you can specify the location. If you don’t specify where to place the repo, it will be placed in the current working folder (where you’re issuing the command from).

`git clone <source repo URL> <path or location to place the clone>`

:::image type="content" source="../media/git-clone-command-0a512bf1.png" alt-text="Screenshot of the clone command cloning the GitHub training repo.":::


## git branch

`git branch` lets you create a new branch or see what branches currently exist for the repo. To see a list of branches that currently exist, you can use the `git branch` command, or you can add the toggle --list.

`git branch`

`git branch --list`

:::image type="content" source="../media/git-branch-command-67457c1e.png" alt-text="Screenshot of the git branch --list command.":::


To create a new branch based on the current branch you’re working within, you use the `git branch` command along with the name of the new branch, `git branch <new branch name>`

`git branch training` would create a new branch in your repo named training.

> [!IMPORTANT]
> Using branches effectively is critical to your success using Git. You seldom want to be working on the main or primary branch. Instead, you work on a targeted or focused branch (such as bug fixes or feature development) and then move the changes back to the main branch after the updated code is tested.<br>

## git checkout

`git checkout` lets you quickly change between different branches in your Git repository. When you’re working “within” a branch, all of the files you access will be as they are in that branch. When you change branches, the content of the files on your computer changes to match the branch to which you changed.

If you’re working on a new feature, and then need to go work on bugs for a while, you might have to:

 -  Change branches to the bug branch.
 -  Update files in the bug branch.
 -  Update the bug branch.
 -  Change back to your feature branch.

`git checkout <branch name>`

:::image type="content" source="../media/git-checkout-command-18adfcc0.png" alt-text="Screenshot of the git checkout command for the training branch.":::


## git add

Working on and saving your local files doesn’t automatically update the Git repository. In fact, if all you do is save the files locally, nobody else will ever see the changes, not even your local clone of the repository. Getting your code to the remote or origin repository is a multi-step process that starts with `git add`.

`git add` takes the changes you’ve made locally and adds those files to Git’s “staging area”. The staging is just a way that Git keeps track of changed files before they’re added into your local repository.

> [!NOTE]
> If you make more changes after you run the `git add` command, you’ll need to run the command again before progressing.

`git add`

:::image type="content" source="../media/git-add-command-6aadd79a.png" alt-text="Screenshot of the git add command.":::


> [!IMPORTANT]
> `git add` is the command you use to add OR delete files. The command is simply indicating that there's an update to the repository. Additionally, you can update the status of multiple files with one git add command by using . instead of the file name ex: `git add .`

## git commit

Once the files are in the staging area, you need to commit the files to your local branch and repository. The `git commit -m "<comment>"` command adds the files into the current branch and makes them a permanent part of your local repository.

The commit is what everyone may see at some point in the future. It’s important when committing a set of changes to a repo that you include a note about what you did. That way, if someone else wonders what the purpose of your commit was, there’s a note telling them. While you may be able to commit without a message, it’s not recommended. Use the -m toggle along with your comment included in quotes.

`git commit -m “<your message>”`

:::image type="content" source="../media/git-commit-command-792a6dfc.png" alt-text="Screenshot of the git commit command.":::


## git push

Once your updates are present on your local repository, you need to decide if they should be shared with the origin or remote repository as well. `git push` “pushes” the changes you’ve made, along with the note you added (right?) for your commit, to the remote repository.

When you use the `git push` command, it pushes your current branch, along with all history, comments, and file changes. It’s important to make sure you’re in the right branch before issuing the git push command.

`git push`

:::image type="content" source="../media/git-push-command-1ffa886f.png" alt-text="Screenshot of the git push command.":::


## git status

To make sure you’re in the right branch before pushing, you can use `git status`. `git status` tells you a lot of information, not only about where you are, but what the status of your files are as well. You can use `git status` to see:

 -  Your current branch (`git checkout`)
 -  Un-staged files (`git add`)
 -  Uncommitted files (`git commit`)

`git status`

:::image type="content" source="../media/git-status-branch-indicator-92b4a2d0.png" alt-text="Screenshot of the git status command.":::
