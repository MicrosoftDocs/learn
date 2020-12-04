## Visual Studio Code Git Integration

Visual Studio Code provides tight source-control integration with Git, by default, and with other source code management (SCM) providers through Visual Studio Code extensions.

If you're an avid user of Visual Studio Code, it's possible that you've either kept Git Bash open in a separate window or used the Visual Studio Code integrated terminal window to enter Git commands. Although this technique works, you might want to improve your workflow efficiency by learning more about other tools that Visual Studio Code has to offer.  Visual Studio Code provides many visual cues, helpful prompts, and shortcuts to common Git features that are tucked away and available when you use common tools such as the Command Palette, the Status Bar, and the Source Control view.

## Forks and clones

If you clone someone else's GitHub repository and make some changes, you'll find that you don't have permission to push those changes back to GitHub. The workflow for making contributions to other people's projects on GitHub is a little more complex than working directly in the project repository. It requires that you create a fork.

### What is a Fork?

A fork is point in time copy of the entire repository from the source. You can fork any repository available to you to your own GitHub account. This repository won't automatically keep up to date with the original repository but will allow you full access to the forked repository. This is a required step to creating pull requests to a repository you don't have access to.
### What is a clone?

A cloned repository is an entire copy of a remote repository (including forked repositories). You can clone a repository to your machine and have access to all the commit history since the repository's creation. This repository can belong to anyone as long as they are public. From this local copy, you will be able to create commits, branches, and synchronize those changes back to the remote repository (if you have access).

### GitHub workflow

It all starts with creating a *fork*. A fork is a copy of a GitHub repository that's associated with your GitHub account. When you create a fork, you're granted full permissions to push changes to it, even if you don't have those permissions in the original repository.

:::image type="content" source="../media/2-clone-branch-01.png" alt-text="Forking a repository from one user to another":::

After you've created a fork of the repository that you want to contribute to, you can clone that fork to your computer, make the changes you want, and then push them back to your fork.

:::image type="content" source="../media/2-clone-branch-02.png" alt-text="Cloning a forked repository to a local computer":::

You can then ask the project maintainers to merge your changes from your fork into their repository by creating a GitHub pull requests.

:::image type="content" source="../media/2-clone-branch-03.png" alt-text="Creating a pull request to the original repository":::

Creating a fork of the repository that you want to contribute to is an important first step. Forking takes place entirely within GitHub, so you use the GitHub web interface to do it, not a tool on your development computer.

We're going to fork a repository and clone its branch in the next exercise.
