Visual Studio Code provides tight source-control integration with Git, by default, and with other source code management (SCM) providers through Visual Studio Code extensions.  Here, you'll learn about some of the most important git operations and perform them using built-in Visual Studio Code features.

## Git operations using Visual Studio Code

If you're an avid user of Visual Studio Code, it's possible that you've either kept Git Bash open in a separate window or used the Visual Studio Code integrated terminal window to enter Git commands. Although this technique works, you might want to improve your workflow efficiency by learning more about other tools that Visual Studio Code has to offer. Visual Studio Code provides many visual cues, helpful prompts, and shortcuts to common Git features that are tucked away and available when you use common tools such as the Command Palette, the Status Bar, and the Source Control view.

## Forks, clones, and branches

If you clone someone else's GitHub repository and make some changes, you'll find that you don't have permission to push those changes back to GitHub. The workflow for making contributions to other people's projects on GitHub is a little more complex than working directly in the project repository. It requires that you create a fork.

### What is a Fork?

A fork is point-in-time copy of an entire GitHub repository from the source. You can fork any repository available to you to your own GitHub account. This repository won't automatically keep up to date with the original repository but will allow you full access to the forked repository. This is a required step to creating pull requests to a repository you don't have access to.

:::image type="content" source="../media/2-clone-branch-01.png" alt-text="Forking a repository from one user to another":::

> [!NOTE]
> A fork doesn't exist in git. It is a concept that only exist in GitHub.

### What is a clone?

A cloned repository is an entire copy of a remote repository (including forked repositories). You can clone a repository to your machine and have access to all the commit history since the repository's creation. This repository can belong to anyone as long as they are public. From this local copy, you will be able to create commits, branches, and synchronize those changes back to the remote repository (if you have access).

:::image type="content" source="../media/2-clone-branch-02.png" alt-text="Cloning a forked repository to a local computer":::

### What is a branch?

A branch, like the default branch is simply a pointer to a specific commit. A commit can have a parent, and be the parent of multiple commits. A commit is often time represented by the first 5 characters of a hash.

Creating a new branch and committing some new code creates a new commit at the end of the chain and moving the branch pointer along.

:::image type="content" source="../media/2-clone-branch-03.png" alt-text="New commit on a new branch":::

## Next steps

While those steps can be done from the command line or many editors, we're going to reproduce that structure in the next exercise with the help of Visual Studio Code's tight integration with Git.
