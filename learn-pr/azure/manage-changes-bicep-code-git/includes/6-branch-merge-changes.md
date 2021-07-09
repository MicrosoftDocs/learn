When you work on Bicep code, it's common to need to do more than one thing at a time. For example, when you work with your toy company's website, here are some example scenarios:

- Your website's development team is working on a major new update to the website, and they want your help to update the Bicep files with some significant changes. However, they don't want those changes to go live just yet, and you need to be able to make minor tweaks to the current live version of the website in parallel with the work on the new version.
- You are working on some experimental changes that you think will help to improve the performance of the website. However, these are still preliminary, and you don't want to apply them to the live version of the website until you're ready.

In this unit, you learn about Git branches.

> [!NOTE]
> The content in this unit isn't part of the exercise. You'll practice what you learn here on the next page.

## What are branches?

A _branch_ provides a way to have multiple active copies of your files. You can create and switch between branches whenever you want. When you're done working with a branch, you can either _merge_ it into another branch, or you can delete it - which removes all of the changes.

It's very common to use branches for all of your work. Often, you designate one branch as the primary branch that represents the _known good_ or live version of your files. By convention, this is usually called **main**. You can create any number of other branches, and when your changes on a branch are ready, you merge the branch into the **main** branch.

## Create and checkout a branch

Creating a branch is very quick and easy in Git. There are a few ways to do it, but the easiest way is typically to use the `git checkout` command. Here's an example of how we create a new branch named **my-experimental-changes**:

```bash
git checkout -b my-experimental-changes
```

This command actually does two things: it creates the **my-experimental-changes** branch, and it also does checks out the newly created branch. A _checkout_ means that the copy of the files you see in your folder will reflect what's in the branch. If you have two branches with completely different sets of changes, then checking out one branch and then the other allows you to flip between the two sets of changes.

You can switch to an existing branch by using the `git checkout` command too, as in this example, where you check out the **main** branch:

```bash
git checkout main
```

> [!NOTE]
> You normally need to commit your changes before you can check out a different branch. Git will warn you if you can't check out.

## Work on a branch

Once you've switched to a branch, you commit files just like normal. In fact, everything you've done up to now has been on a branch - you were working on the **main** branch, which is the default branch when you create a new repository.

When you commit some changes while you've checked out a branch, the commit is associated with the branch. When you switch to a different branch, you probably won't see the commit in the `git log` history until you merge the branch.

## Merge branches

Branches are a great way to separate your in-progress work from the current live version of your Bicep code. However, once you've finished making changes to your files on a branch, you often want to merge the changes back to your **main** branch.

When you're working on one branch, you can merge another branch's changes into your current branch by using the `git merge` command.

> [!NOTE]
> Make sure you check out the merge destination branch (often called the _target_ branch) before you merge. Remember that you are merging _from_ another branch _into_ your current working branch.

Here's an example showing how you can check out the **main** branch, then merge the changes from the **my-experimental-changes** branch into the **main** branch. Finally, you delete the **my-experimental-changes** branch since you no longer need it:

```bash
git checkout main
git merge my-experimental-changes
git branch -d my-experimental-changes
```

> [!TIP]
> When you work with other people, it's common to use _pull requests_ to merge your changes instead of directly merging branches. You'll learn more about collaboration and pull requests shortly.

## Merge conflicts

When Git merges changes from one branch into another, it looks at the files that have been modified and it tries its best to merge the changes together. Sometimes, you might have made changes to the same lines of code on two different branches. In these situations, Git cannot choose which is the correct version of the code, and so it will instead create a _merge conflict_. We don't discuss merge conflicts in this module, but it's important to know that this can happen - and it's even more common when you collaborate with other people. In the summary for this module, we provide some links to more information about how Git and Visual Studio Code help you to resolve merge conflicts.

## Git workflows

In this module, you only learn about the very basics of branches. However, branches are very powerful and give you a lot of flexibility in how you work. For example, you can create branches off other branches, and merge a branch with any other branch. You can use branches to create all sorts of different _workflows_ that support the way you and your team like to work.

In this module, we're using a very simple workflow called _trunk-based development_. In this workflow, you have a single _trunk_ branch - we've been using **main** - and that represents the known-good version of your code. You create branches off this trunk when you make changes or do any work - in fact, trunk-based development discourages making changes directly on the trunk branch. You try to only keep other branches around for a short period of time, which helps to minimize merge conflicts. Then you merge and delete those branches as you complete pieces of work.

There are other workflows too. These are common in team environments where you might want to control how frequently you release your changes. In the summary for this module, we provide some links to more information about Git workflows you can consider.

