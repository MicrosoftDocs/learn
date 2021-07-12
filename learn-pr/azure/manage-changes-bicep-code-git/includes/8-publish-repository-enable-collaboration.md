You've learned about how Git enables you to track the changes to your Bicep code. In this unit, you'll learn how Git also enables collaboration with your team members.

> [!NOTE]
> The commands you see on this page are shown to illustrate the concepts. Don't run them just yet. You'll practice what you learn here in the next part.

## What are GitHub and Azure Repos?

Git is a piece of software that you install and run on your own computer. As you've learned, Git keeps track of the changes you make to your files, and enables powerful features like branching.

GitHub and Azure Repos are both online services that keep copies of your Git repository, and enable collaborative development through a variety of features. Even once you sign up for GitHub or Azure Repos, you continue to work with Git using the same commands you've already been using, and you continue working against your local Git repository. The difference is that you can also synchronize your local Git repository with an online repository. You can also grant access to the online repository to other people, and you can control whether they can read or modify your code.

> [!NOTE]
> Azure Repos is a feature of Azure DevOps. When you work with Azure Repos, you use the Azure DevOps website.

In a team environment, everyone on the team maintains their own local Git repository and synchronizes it with the online copy. In most situations, the online copy becomes the _source of truth_ for your team. In a future module, you'll learn about deploying your Bicep code through an automated deployment pipeline. Pipelines require that your code is stored in an online repository - the pipeline accesses the code from there too.

> [!NOTE]
> GitHub and Azure DevOps are both great options for you to use for hosting your Git repository, and they both have many powerful features. Your organization may already use one or the other tool. If you don't already have a preference, GitHub is a good choice since it's typically easier to get started.

## Local and remote repositories

When you work with repositories hosted in GitHub or Azure DevOps, you configure your local Git repository to know about the remote repository. An online repository has a URL that Git can use to access it from your computer. Conventionally, the term _origin_ refers to the remote repository that your local repository synchronizes with.

You also need to set up _tracking branches_. This tells Git that a branch from your local repository represents the same branch as in your online repository. This is especially important for your **main** branch, since you want to keep that synchronized across all of your repositories. You can also enable tracking on other branches too.

> [!NOTE]
> Your team might already have created a repository that you want to view or modify. You can quickly get a copy of the repository by _cloning_ the online repository using the `git clone` command.

Once you've configured your local repository and tracking branch, you can _push_ the contents of your local repository to the remote, and you can _pull_ the remote repository's changes into your local repository.

> [!NOTE]
> Behind the scenes, the `git pull` operation downloads the changes from your remote, then merges the changes - just like when you merge branches. Occasionally you want to only download changes from the remote repository, such as when you want to update your local repository's list of remote branches. Use the `git fetch` command to do this.

## Authentication

Once you start working with online repositories, security becomes very important. Source code for your infrastructure and applications is valuable, and it's important that it's protected appropriately. Both GitHub and Azure DevOps have comprehensive security processes, and they both require that you authenticate before you start working with remote repositories hosted on their platforms.

The first time you try to work with a remote repository, you're prompted to sign in to GitHub or Azure DevOps. Some organizations protect their Git repositories with additional security checks like multifactor authentication. Once you've signed in, Git uses a component called Git Credential Manager to maintain your access so you don't need to sign in every time.

## Collaborate with others

Once you've set up your Git repository on GitHub or Azure Repos, you're ready to collaborate with others. There are many powerful features you can use to work with your team. One particular feature that you should know about is called _pull requests_, often shortened to _PRs_.

A pull request is effectively a controlled merge of two branches, and GitHub or Azure Repos can enforce policies about who can merge and what kinds of changes can be merged. A typical team workflow would involve a team member making changes to their code on a branch, then creating a pull request to ask someone else to merge their changes into the **main** branch. Other team members can see the list of changes in the PR, and they can even provide feedback on the changes or ask for revisions before they accept them. PRs provide a way to provide quality control around your team's code.

PRs and other collaboration features are outside of the scope of this module, but we provide links to information about these features in the summary.