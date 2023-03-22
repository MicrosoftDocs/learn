Thanks to your efforts, your toy company has a large set of Bicep files to deploy all aspects of its Azure infrastructure. Managing these files has been a challenge, though, and you needed a way to keep track of your changes.

In this module, you learned how the Git version control system can be used with Bicep code to provide a repository for your deployment templates. You learned about the benefits of using Git with Bicep code, and how Git can scale from an individual to an entire organization.

You used Visual Studio Code to initialize a Git repository, added and updated some files, viewed their history, and created a branch. You then merged that branch. Finally, you published your Git repository so that your colleagues can access it. Publishing the repository will also enable you to use a deployment pipeline in the future.

Now, whenever you make changes to your Bicep templates, you can be sure that your updates are tracked and that you can see older versions of your files. You can even use branches to work on experimental changes without breaking the current known-good files.

## Learn more

There's a lot more to know about Git's capabilities for working with deployment templates and scripts. As you continue to learn about Bicep and infrastructure as code, it's important to also learn about version control:

- The learning path [Introduction to version control with Git](/training/paths/intro-to-vc-git/) is a good next step to provide a deeper overview.
- The module [Use Git version-control tools in Visual Studio Code](/training/modules/use-git-from-vs-code/) provides more information on Git integration into Visual Studio Code.

The following features of Git are useful when you work with infrastructure as code:

- [Staging your changes](https://code.visualstudio.com/docs/introvideos/versioncontrol), which enables you to commit only some of the things you've changed while leaving others out of the commit.
- [Stashing your changes](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning), which enables you to keep your changes without committing them.
- [Undoing changes](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things), including reverting commits and resetting your repository status.
- [Branches](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging), including [handling merge conflicts](https://docs.github.com/github/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line), [advanced merging](https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging), and [rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing).
- [Branching workflows](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows) to support your team's ways of working. We introduced [trunk-based development](https://trunkbaseddevelopment.com/) in this module, but some teams prefer the [GitHub Flow](https://docs.github.com/get-started/quickstart/github-flow) model. [Consider some best practices when selecting your branching strategy](/azure/devops/repos/git/git-branching-guidance).
- [Rewriting history](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History), including amending commit messages and removing information from your commit history, and squashing changes.
- [Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules).

Much of the power of Git comes from its use in team environments. Specific features you'll likely work with include:

- Cloning repositories ([GitHub](https://docs.github.com/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository), [Azure Repos](/azure/devops/repos/git/clone)).
- Pull requests ([GitHub](https://docs.github.com/github/collaborating-with-pull-requests/), [Azure Repos](/azure/devops/repos/git/pull-requests)).
- Forking repositories ([GitHub](https://docs.github.com/get-started/quickstart/fork-a-repo), [Azure Repos](/azure/devops/repos/git/forks)).
