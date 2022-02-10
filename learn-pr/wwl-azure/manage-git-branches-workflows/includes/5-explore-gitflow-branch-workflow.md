Gitflow Workflow is a Git workflow design first published and made famous by Vincent Driessen at nvie.

The Gitflow Workflow defines a strict branching model designed around the project release. It provides a robust framework for managing more significant projects.

Gitflow is ideally suited for projects that have a scheduled release cycle.

This workflow doesn't add any new concepts or commands beyond what's required for the Feature Branch Workflow.

Instead, it assigns particular roles to different branches and defines how and when they should interact.

Also, to feature branches, it uses individual branches for preparing, maintaining, and recording releases.

You also get to use all the benefits of the Feature Branch Workflow: pull requests, isolated experiments, and more efficient collaboration.

Also, to the abstract Gitflow Workflow idea, a more tangible git-flow toolset is available, which integrates with Git to provide specialized Gitflow Git command-line tool extensions.

## Getting started

Gitflow is just an abstract idea of a Git workflow. It means it dictates what kind of branches to set up and how to merge them. We'll touch on the purposes of the branches below.

The git-flow toolset is an essential command-line tool that has an installation process. The installation process for git-flow is straightforward. Packages for git-flow are available on multiple operating systems.

On OSX systems, you can execute brew install git-flow.

On windows, you'll need to download and install git-flow.

After installing git-flow, you can use it in your project by running git flow init. Git-flow is a wrapper around Git.

The git flow init command is an extension of the default git init command. It doesn't change anything in your repository other than creating branches for you.

How it works:

:::image type="content" source="../media/git-branch-main-develop-5a0f697f.png" alt-text="Git branch representation. Main, and develop.":::


## Develop and main branches

Instead of a single main branch, this workflow uses two branches to record the project's history.

The main branch stores the official release history, and the develop branch serves as an integration branch for features. It's also convenient to tag all commits in the main branch with a version number.

The first step is to complement the default main with a develop branch. A simple way to do it is for one developer to create an empty develop branch locally and push it to the server:

```Cmd
git branch develop
git push -u origin develop

```

This branch will contain the project's complete history, but the main will have an abridged version. Other developers should now clone the central repository and create a tracking branch for develop.

When using the git-flow extension library, executing git flow init on an existing repo will create the develop branch:

```Cmd
Initialized empty Git repository in ~/project/.git/
No branches exist yet. Base branches must be created now.
Branch name for production releases: [main]
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []

$ git branch

* develop
main

```

## Feature branches

Each new feature should be in its branch, which can be pushed to the central repository for backup/collaboration.

But, instead of branching off main, feature branches use develop as their parent branch.

When a feature is complete, it gets merged back into develop. Features should never interact directly with the main.

:::image type="content" source="../media/feature-branches-main-develop-features-8d909507.png" alt-text="Feature branches presentation. Main, develop, and features.":::


Feature branches combined with the develop branch are the Feature Branch Workflow. But the Gitflow Workflow doesn't stop there.

Feature branches are created off to the latest develop branch.

Creating a feature branch Without the git-flow extensions:

```Cmd
git checkout develop
git checkout -b feature_branch

```

When using the git-flow extension:

```Cmd
git flow feature start feature_branch

```

Continue your work and use Git like you usually would.

Finishing a feature branch When you're done with the development work on the feature, the next step is to merge the feature\_branch into develop.

Without the git-flow extensions:

```Cmd
git checkout develop
git merge feature_branch

```

Using the git-flow extensions:

```
git flow feature finish feature_branch

```

## Release branches

:::image type="content" source="../media/release-branches-main-develop-features-ca1fee60.png" alt-text="Release branches presentation. Main, develop, and features.":::


Once develop has acquired enough features for a release (or a predetermined release date is approaching), you fork a release branch off develop.

Creating this branch starts the next release cycle, so no new features can be added after this point—only bug fixes, documentation generation, and other release-oriented tasks should go in this branch.

Once it's ready to ship, the release branch gets merged into main and tagged with a version number.

Also, it should be merged back into develop, which may have progressed since the release was started.

Using a dedicated branch to prepare releases allows one team to polish the current release while another team continues working on features for the next release.

It also creates well-defined phases of development. For example, it's easy to say, "This week we're preparing for version 4.0," and to see it in the repository structure.

Making release branches is another straightforward branching operation. Like feature branches, release branches are based on the develop branch.

A new release branch can be created using the following methods.

Without the git-flow extensions:

```Cmd
git checkout develop
git checkout -b release/0.1.0
``` cmd

When using the git-flow extensions:

``` cmd
$ git flow release start 0.1.0
Switched to a new branch 'release/0.1.0'

```

Once the release is ready to ship, it will get merged into main and develop. Then the release branch will be deleted.

It's essential to merge back into develop because critical updates may have been added to the release branch. Also, they need to be accessible to new features.

If your organization stresses code review, it would be an ideal place for a pull request.

To finish a release branch, use the following methods:

Without the git-flow extensions:

```Cmd
git checkout develop
git merge release/0.1.0

```

Or with the git-flow extension:

```Cmd
git checkout main
git checkout merge release/0.1.0
git flow release finish '0.1.0'

```

:::image type="content" source="../media/branches-main-hotfix-release-develop-features-75d33a59.png" alt-text="Release branches presentation. Main, hotfix, release, develop, and features.":::


Maintenance or "hotfix" branches are used to patch production releases quickly. Hotfix branches are like release branches and feature branches, except they're based on main instead of develop.

It's the only branch that should fork directly off main.

Once the fix is complete, it should be merged into both main and develop. Or the current release branch.

Also, the main should be tagged with an updated version number.

Having a dedicated line of development for bug fixes lets your team address issues without interrupting the rest of the workflow. Or waiting for the next release cycle.

You can think of maintenance branches as improvised release branches that work directly with the main. A hotfix branch can be created using the following methods:

Without the git-flow extensions:

```Cmd
git checkout main
git checkout -b hotfix_branch

```

When using the git-flow extensions:

```Cmd
$ git flow hotfix start hotfix_branch

```

Like finishing a release branch, a hotfix branch gets merged into both main and develop.

```Cmd
git checkout main
git merge hotfix_branch
git checkout develop
git merge hotfix_branch
git branch -D hotfix_branch
$ git flow hotfix finish hotfix_branch

```

Some key takeaways to know about Gitflow are:

 -  The workflow is great for a release-based software workflow.
 -  Gitflow offers a dedicated channel for hotfixes to production.

The overall flow of Gitflow is:

 -  A develop branch is created from the main.
 -  A release branch is created from develop.
 -  Feature branches are created from develop.
 -  When a feature is complete, it's merged into the develop branch.
 -  When the release branch is done, it's merged into develop and main.
 -  If an issue in the main is detected, a hotfix branch is created from the main.
 -  Once the hotfix is complete, it's merged to both develop and main.
