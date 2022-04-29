People fork repositories when they want to change the code in a repository that they don't have write access to.

If you don't have write access, you aren't part of the team contributing to that repository, so why would you modify the code repository?

In our line of work, we tend to look for technical reasons to improve something.

You may find a better way of implementing the solution or enhancing the functionality by contributing to or improving an existing feature.

You can fork repositories in the following situations:

 -  I want to make a change.
 -  I think the project is exciting and may want to use it in the future.
 -  I want to use some code in that repository as a starting point for my project.

Software teams are encouraged to contribute to all projects internally, not just their software projects.

Forks are a great way to foster a culture of inner open source.

Forks are a recent addition to the Azure DevOps Git repositories.

This recipe will teach you to fork an existing repository and contribute changes upstream via a pull request.

## Getting ready

A fork starts with all the contents of its upstream (original) repository.

When you create a fork in the Azure DevOps, you can include all branches or limit them to only the default branch.

A fork doesn't copy the permissions, policies, or build definitions of the repository being forked.

After a fork has been created, the newly created files, folders, and branches aren't shared between the repositories unless you start a pull request.

Pull requests are supported in either direction: from fork to upstream or upstream to fork.

The most common approach for a pull request will be from fork to upstream.

## How to do it

1.  Choose the Fork button (1), and then select the project where you want the fork to be created (2). Give your fork a name and choose the Fork button (3).

    :::image type="content" source="../media/create-fork-azure-devops-c6f90521.png" alt-text="Create a fork in Azure DevOps.":::


2.  Once your fork is ready, clone it using the command line or an IDE, such as Visual Studio. The fork will be your origin remote. For convenience, you'll want to add the upstream repository (where you forked from) as a remote named upstream. On the command line, type:

```Cmd
git remote add upstream {upstream_url}

```

3.  It's possible to work directly in the main – after all, this fork is your copy of the repo. We recommend you still work in a topic branch, though. It allows you to maintain multiple independent workstreams simultaneously. Also, it reduces confusion later when you want to sync changes into your fork. Make and commit your changes as you normally would. When you're done with the changes, push them to origin (your fork).<br><br>
4.  Open a pull request from your fork to the upstream. All the policies, required reviewers, and builds will be applied in the upstream repo. Once all the policies are satisfied, the PR can be completed, and the changes become a permanent part of the upstream repo:

    :::image type="content" source="../media/create-pull-request-af53d7fb.png" alt-text="Create a pull request.":::


5.  When your PR is accepted into upstream, you'll want to make sure your fork reflects the latest state of the repo. We recommend rebasing on the upstream's main branch (assuming the main is the main development branch). On the command line, run:

```Cmd
git fetch upstream main
git rebase upstream/main
git push origin

```

## How it works

The forking workflow lets you isolate changes from the main repository until you're ready to integrate them.

When you're ready, integrating code is as easy as completing a pull request.

For more information, see:

 -  [Clone an Existing Git repo](/azure/devops/repos/git/clone).
 -  [Azure Repos Git Tutorial](/azure/devops/repos/git/gitworkflow).
