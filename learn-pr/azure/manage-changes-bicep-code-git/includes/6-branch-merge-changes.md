When you work on Bicep code, it's common to need to do more than one thing at a time. For example, here are two scenarios for working with your toy company's website:

- Your website's development team wants your help in updating Bicep files with significant changes. However, the team doesn't want those changes to go live yet. You need to be able to make minor tweaks to the current live version of the website in parallel with the work on the new version.
- You're working on experimental changes that you think will help to improve the performance of the website. However, these changes are preliminary. You don't want to apply them to the live version of the website until you're ready.

In this unit, you learn about Git branches.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## What are branches?

A _branch_ provides a way to have multiple active copies of your files. You can create and switch between branches whenever you want. When you're done working with a branch, you can _merge_ it into another branch. Or you can delete it, which removes all of the changes.

It's common to use branches for all of your work. Often, you designate one branch as the primary branch that represents the _known good_ or live version of your files. By convention, this branch is usually called _main_. You can create any number of other branches. When your changes on a branch are ready, you merge the branch into the _main_ branch.

## Create and check out a branch

Creating a branch is quick and easy in Git. There are a few ways to do it, but the easiest way is typically to use the `git checkout` command. Here's an example of how we create a new branch named _my-experimental-changes_:

```bash
git checkout -b my-experimental-changes
```

This command actually does two things: it creates the _my-experimental-changes_ branch, and it checks out the newly created branch. A _checkout_ means that the copy of the files you see in your folder will reflect what's in the branch. If you have two branches with different sets of changes, checking out one branch and then the other allows you to flip between the two sets of changes.

You can switch to an existing branch by using the `git checkout` command too. In this example, you check out the _main_ branch:

```bash
git checkout main
```

> [!NOTE]
> You normally need to commit your changes before you can check out a different branch. Git will warn you if you can't check out.

## Work on a branch

After you switch to a branch, you commit files just like normal. In fact, everything you've done up to now has been on a branch. You were working on the _main_ branch, which is the default branch when you create a new repository.

When you commit some changes while you've checked out a branch, the commit is associated with the branch. When you switch to a different branch, you probably won't see the commit in the `git log` history until you merge the branch.

## Merge branches

Branches are a great way to separate your in-progress work from the current live version of your Bicep code. But after you finish making changes to your files on a branch, you often want to merge the changes back to your _main_ branch.

When you're working on one branch, you can merge another branch's changes into your current branch by using the `git merge` command.

> [!NOTE]
> Be sure to check out the merge destination branch (often called the _target_ branch) before you merge. Remember that you're merging _from_ another branch _into_ your current working branch.

Here's an example that shows how you can check out the _main_ branch, and then merge the changes from the _my-experimental-changes_ branch into the _main_ branch. Finally, you delete the _my-experimental-changes_ branch because you no longer need it.

```bash
git checkout main
git merge my-experimental-changes
git branch -d my-experimental-changes
```

> [!TIP]
> When you work with other people, it's common to use _pull requests_ to merge your changes instead of directly merging branches. You'll learn more about collaboration and pull requests shortly.

## Merge conflicts

When Git merges changes from one branch into another, it looks at the files that have been modified and it tries to merge the changes together. Sometimes, you might have made changes to the same lines of code on two different branches. In these situations, Git can't choose which is the correct version of the code, so it will instead create a _merge conflict_.

We don't discuss merge conflicts in depth in this module, but it's important to know that merge conflicts can happen. And it's more common when you collaborate with other people. In the summary for this module, we provide a link to more information about how Git and Visual Studio Code help you to resolve merge conflicts.

## Git workflows

In this module, you learn about only the basics of branches. However, branches are powerful and give you flexibility in how you work. For example, you can create branches off other branches, and merge a branch with any other branch. You can use branches to create all sorts of different _workflows_ that support the way you and your team like to work.

In this module, we're using a simple workflow called _trunk-based development_. In this workflow, you have a single _trunk_ branch. For example, we use _main_ in this article's examples. That branch represents the known-good version of your code. You create branches off this trunk when you make changes or do any work.

Trunk-based development discourages making changes directly on the trunk branch. You try to keep other branches around for only a short amount of time, which helps to minimize merge conflicts. Then you merge and delete those branches as you complete pieces of work.

There are other workflows that are common in team environments where you might want to control how often you release your changes. In the summary for this module, we provide links to more information about Git workflows.
