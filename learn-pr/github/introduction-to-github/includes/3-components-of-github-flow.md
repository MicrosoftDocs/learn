In this unit, we're reviewing the following components of the GitHub flow:

- Branches
- Commits
- Pull Requests
- The GitHub Flow
- Git flow

## Components of GitHub Flow

Before we get into GitHub-specific workflows, it's helpful to understand that GitHub Flow builds directly on Git’s foundational concepts.

Git provides tools to track and manage changes in your code over time. GitHub builds on this by making it easier to use those tools with features like branches, commits, pull requests, and visual interfaces for collaboration. Let’s start by looking at how these concepts work in GitHub.

## What are branches

In the last section, we created a new file and a new branch in your repository.

Branches are an essential part of the GitHub experience. They let you make changes without affecting the default branch.

Your branch is a safe place to experiment with new features or fixes. If you make a mistake, you can revert your changes or push more changes to fix the mistake. Your changes won't update on the default branch until you merge your branch.

> [!NOTE]
> Alternatively, you can create a new branch and check it out by using git in a terminal. The command would be
> `git checkout -b newBranchName`

## What are commits

In the previous unit, you added a new file into the repository by pushing a commit. Let’s briefly review what commits are.

A **commit** is a change to one or more files on a branch. Each commit is tracked by a unique ID, timestamp, and contributor, regardless of whether it's made via the command line or directly in GitHub's web interface. Commits provide a clear audit trail for anyone reviewing the history of a file or linked item, such as an issue or pull request.

> You can create a commit using Git in your terminal with:
> ```
> git commit -m "Add a helpful commit message"
> ```

:::image type="content" source="../media/2-commits.png" alt-text="A screenshot of a list of GitHub commits to a main branch." border="false":::

Within a git repository, a file can exist in several valid states as it goes through the version control process. The primary states for a file in a Git repository are **Untracked** and **Tracked**.

**Untracked:** An initial state of a file when it isn't yet part of the Git repository. Git is unaware of its existence.

**Tracked:** A tracked file is one that Git is actively monitoring. It can be in one of the following substates:

- **Unmodified:** The file is tracked, but it hasn't been modified since the last commit.
- **Modified:** The file has been changed since the last commit, but these changes aren't yet staged for the next commit.
- **Staged:** The file has been modified, and the changes have been added to the staging area (also known as the index). These changes are ready to be committed.
- **Committed:** The file is in the repository's database. It represents the latest committed version of the file.

These states help your team understand the status of each file and where it is in the version control process.

## What are pull requests?

A **pull request** is the mechanism used to signal that the commits from one branch are ready to be merged into another branch.

The team member submitting the **pull request** asks one or more reviewers to verify the code and approve the merge. These reviewers have the opportunity to comment on changes, add their own, or use the pull request itself for further discussion.

GitHub also supports _Draft Pull Requests_, which let you open a pull request that's not yet ready for review.

Once the changes have been approved (if required), the pull request's source branch (the compare branch) is merged into the base branch.

:::image type="content" source="../media/2-pull-request.png" alt-text="A screenshot of a pull request and a comment within the pull request." border="false":::

Now that you’ve seen how branches, commits, and pull requests work, let’s walk through how they come together in GitHub Flow.

## The GitHub flow

:::image type="content" source="../media/2-branching.png" alt-text="Screenshot showing a visual representation of the GitHub Flow in a linear format that includes a new branch, commits, pull request, and merging the changes back to main in that order." border="false":::

The GitHub flow is a simple workflow that helps you safely make and share changes. It’s great for trying out ideas and collaborating with your team using branches, pull requests, and merges.

> [!NOTE]
> GitHub flow is one of several popular workflows. Others include Git flow and trunk-based development.

Now that we know the basics of GitHub we can walk through the GitHub flow and its components.

1. Start by creating a branch so your changes, features, or fixes don’t affect the main branch.
2. Next, make your updates in the branch. If your workflow supports it, you can deploy changes from this branch to test them before merging.
3. Now, open a pull request to invite feedback and begin a review.
4. Then, review the comments and make any necessary updates based on your team’s feedback.
5. Finally, once you’re confident in your changes, get approval and merge the pull request into the main branch.
6. After that, delete the branch to keep your repository clean and avoid using outdated branches.

## Git flow

:::image type="content" source="../media/2-git-flow-image.png" alt-text="Diagram illustrating the Git flow workflow with parallel lanes for feature branches, develop, release branches, hotfixes, and master. It shows how features are merged into develop, release branches are created from develop, hotfixes are branched from master, and all changes are eventually merged back into master and develop with tagged versions.
" border="false":::

While GitHub Flow is a lightweight workflow designed for continuous delivery, **Git flow** is a more structured branching model often used in release-driven environments. Git flow has been around longer than GitHub Flow, and you may still see the term **`master`** used instead of **`main`** as the default branch.

### Git flow Branch Types

Git flow uses several long-lived and temporary branches:

- **master**: Always reflects production-ready code.
- **develop**: Contains the latest development work for the next release.
- **feature/***: Used to create new features; branched from `develop` and merged back when complete.
- **release/***: Prepares a new production release from `develop`; allows final testing and minor bug fixes.
- **hotfix/***: Used to quickly patch production issues; branched from `master`.

### How the Git flow Process Works

1. Developers create **feature branches** from `develop` to build new functionality.
2. When it's time for a release, a **release branch** is created from `develop`. This isolates release preparation work so development can continue uninterrupted.
3. Bug fixes can be added to the release branch, but major features should wait for a future release.
4. Once ready, the release branch is merged into `master` and tagged with a version number. GitHub can use these tags to help you generate release notes.
5. The same release branch should be merged back into `develop` to keep it in sync.
6. If a critical production bug arises, a **hotfix branch** is created from `master`. Once fixed, it’s merged into both `master` and `develop`.

### When to Use Git flow

- Best suited for projects with **scheduled or versioned releases**
- Helpful if you maintain **multiple production versions** (e.g., long-term support branches)
- Ideal for **slower, more structured development cycles** (e.g., enterprise or regulated environments)
- Considered more "heavyweight" than GitHub Flow due to **additional branch management**

Note: Git flow assumes merge commits for integrating branches. Using rebase or squash merges can interfere with its branch structure and history tracking.

> For many teams using GitHub, GitHub Flow is simpler and faster. But if your team values predictability and needs more release planning, Git flow may be a better fit.

Congratulations! You’ve just walked through the full GitHub Flow—and explored how Git flow offers a structured alternative for release-driven projects.

Let’s move onto the next section where we’ll cover the differences between issues and discussions.
