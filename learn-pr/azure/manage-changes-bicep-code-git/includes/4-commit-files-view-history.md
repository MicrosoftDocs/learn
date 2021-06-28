Now that you've initialized your Git repository, you're ready to start adding files. In this unit, you'll learn how to tell Git to track the changes to files in your repository.

## Folder structure for your repository

When you work with a version control system like Git, it's important to plan how you store your files. It's a good idea to have a clear folder structure. If you're building Bicep code to deploy an application or another solution, it's also a good idea to store your Bicep files in the same repository as the application code and other files. That way, anytime anyone needs to add a new feature that changes both Bicep and application code, they'll be tracked together. It also makes it easier to deploy your solution from a pipeline, which you'll learn about in a future module.

Different teams have different conventions for how they set up their repository folders and files. If your team doesn't already have a preference, here's a suggestion for how you might do it:

- At the root of your repository, create a _README.md_ file, which is a Markdown (text) file that describes what's in the repository, and any instructions to help team members set things up.
- At the root of your repository, create a _deploy_ folder. Inside the folder:
  - Store your main Bicep template, named _main.bicep_.
  - Create a _modules_ subfolder, to store your Bicep modules.
  - If you have other scripts or files that are used during deployments, store them in the _deploy_ folder.
- At the root of your repository, create a _src_ folder. Use this to store application code.
- At the root of your repository, create a _docs_ folder. Use this to store documentation about your solution.

Here's an illustration of how this structure might look for our toy company's website:

:::image type="content" source="../media/4-folder-structure.png" alt-text="Diagram that illustrates the folder hierarchy described in the list above." border="false":::

## What's a commit?

A _commit_ represents a set of changes to one or more files in your repository. When you commit, you provide a _commit message_, which is a human-readable description of the change you've made in that commit.

> [!TIP]
> It's good practice to commit your work early and often. There's no cost to commits, and each commit gives you a checkpoint you can go back to later if you need to view the history of your file or undo your changes.

## Stage your changes

Before you commit your changes, you first need to _stage_ them. Staging tells Git that you consider the changes important enough to change. It might seem like an unnecessary extra step, but staging gives you a lot of flexibility as you work. For example, you might make changes to several files, but only want to commit one of them.

To stage a file, you use the `git add` command and specify the filename or folder name that you want to stage. Once you do this, Git knows that you might want to commit the change. When you query the repository status by using `git status`, you see the staged changed.

> [!IMPORTANT]
> Once you've staged a file, if you make any further changes to it before you commit, those changes won't be recorded by Git. You need to stage the file again for Git to catch the most recent changes.

For example, imagine you've just created a Bicep module to define an Azure Cosmos DB account. It's named _cosmos-db.bicep_ and you saved it in the *deploy/modules* folder. Here's how you could stage the file:

```bash
git add deploy/modules/cosmos-db.bicep
```

You can also stage all of the changes in your repo by running this command from the root folder of your repository:

```bash
git add .
```

## Commit the staged changes

When you're ready to commit the changes you've staged, you use the `git commit` command. Commits need to have a commit message.

Here's an example showing how you commit the changes you staged above:

```bash
git commit --message "Add Cosmos DB account definition."
```

> [!TIP]
> Make your commit messages descriptive, but fairly short. There aren't any rules about what commit messages need to contain or how they're formatted, but conventionally they are written in the present tense and in a full sentence, as if you're giving orders to your codebase.
> 
> Here are some examples of good commit messages:
> - _Update App Service configuration to add network configuration._
> - _Remove storage account since it's been replaced by a Cosmos DB database._
> - _Add Application Insights resource definition and integrate with function app._

Visual Studio Code can commit to your Git repository too. When you use Visual Studio Code's Git integration, you can commit without explicitly staging the files. Visual Studio Code automatically stages all of the changed files. If you want, you can also stage and unstage files using the **Source Control** panel.

## View a file's history

Once you've committed files to your Git repository, you can use the `git log` CLI command to view the history of a file, or even all the commits to the repository.

To view a list of commits, run the following command:

```bash
git log --pretty=oneline
```

The output of this command shows a list of the commits, with the most recent commits first. Each line includes the _commit hash_, which is an identifier that Git internally uses to track each commit. It also includes the commit message, which is one of the reasons why it's so important to write good commit messages.

It's also common to view the commits to a specific file. You can specify the filename when you run the `git log` command, like this:

```bash
git log deploy/main.bicep
```

The Git CLI and the `git log` command provide many arguments you can use to view information about your commits and files. However, it's often easier to use Visual Studio Code to view the commit history for a file. In the **Explorer** pane in Visual Studio Code, you can right-click a file in your repository and select **View Timeline**. The **Timeline** pane opens, and shows a list of each commit that affected that file. When you click a commit, you see the exact changes to the file. You'll see how to use this in the next exercise.
