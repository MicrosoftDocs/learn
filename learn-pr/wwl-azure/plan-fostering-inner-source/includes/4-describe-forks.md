People fork repositories when they want to change the code in a repository they don't have write access to.

If you don't have write access, you aren't part of the team contributing to that repository, so why would you want to modify the code repository?

## Common reasons to fork

We often look for technical reasons to improve something in our work. You may find a better way to implement a solution or enhance functionality by contributing to or improving an existing feature.

You can fork repositories in the following situations:

- **I want to make a change**: You've found a bug or want to add a feature to someone else's project.
- **I think the project is interesting and may want to use it**: You want to experiment with the code without affecting the original.
- **I want to use some code as a starting point**: You want to build on existing work for your own project.

Software teams are encouraged to contribute to all projects internally, not just their own software projects. Forks are a great way to foster a culture of inner open source.

## Azure DevOps forks

Forks are available in Azure DevOps Git repositories. This section will teach you to fork an existing repository and contribute changes upstream via a pull request.

## Understanding fork structure

A fork starts with all the contents of its upstream (original) repository. When you create a fork in Azure DevOps, you can include all branches or limit them to only the default branch.

**Important Points:**

- A fork doesn't copy the permissions, policies, or build definitions of the repository being forked.
- After a fork has been created, newly created files, folders, and branches aren't shared between the repositories unless you start a pull request.
- Pull requests are supported in either direction: from fork to upstream or upstream to fork.
- The most common approach for a pull request is from fork to upstream.

## Step-by-step fork workflow

### Step 1: Create the fork

1. Choose the Fork button (1).
1. Select the project where you want the fork to be created (2).
1. Give your fork a name and choose the Fork button (3).

### Step 2: Clone your fork

Once your fork is ready, clone it using the command line or an IDE, such as Visual Studio. The fork will be your origin remote.

````bash
git clone {your_fork_url}
For convenience, you'll want to add the upstream repository (where you forked from) as a remote named upstream:

```bash
git remote add upstream {upstream_url}
````

### Step 3: Make your changes

It's possible to work directly in the main branch – this fork is your copy of the repo. However, we recommend you still work in a topic branch because:

- It allows you to maintain multiple independent workstreams at the same time.
- It reduces confusion later when you want to sync changes into your fork.

Make and commit your changes as you normally would. When you finish the changes, push them to the origin (your fork).

### Step 4: Create a pull request

Open a pull request from your fork to the upstream repository. The upstream repo will apply all the policies required for reviewers and builds. Once all the policies are satisfied, the pull request can be completed, and the changes become a permanent part of the upstream repo:

:::image type="content" source="../media/create-pull-request-af53d7fb.png" alt-text="Diagram showing Create a pull request.":::

### Step 5: Sync your fork

When your pull request is accepted upstream, you must ensure your fork reflects the latest repo state. We recommend rebasing on the upstream's main branch (assuming main is the main development branch):

```bash
git fetch upstream main
git rebase upstream/main
git push origin
```

## Benefits of fork workflow

The fork workflow provides several advantages:

- **Independence**: You can work on changes without affecting the original repository.
- **Collaboration**: Multiple people can contribute to projects they don't normally work on.
- **Quality Control**: All changes go through the same review process before being merged.
- **Learning**: Developers can explore and learn from code in other teams' projects.

For more information about Git, see:

- [Clone an Existing Git repo](/azure/devops/repos/git/clone).
- [Azure Repos Git Tutorial](/azure/devops/repos/git/gitworkflow).
