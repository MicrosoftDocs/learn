In this unit, we're reviewing the following components of the GitHub flow:

-	Branches
-	Commits 
-	Pull Requests
-	The GitHub Flow

## What are branches

In the last section, we created a new file and a new branch in your repositories.

Branches are an essential part to the GitHub experience because they're where we can make changes without affecting the entire project we're working on. 

Your branch is a safe place to experiment with new features or fixes. If you make a mistake, you can revert your changes or push more changes to fix the mistake. Your changes won't update on the default branch until you merge your branch.

> [!NOTE]
> Alternatively, you can create a new branch and check it out by simply using git in a terminal the command would be 
> `git checkout -b newBranchName`


## What are commits

As you might have noticed in the previous unit, adding in a new file into the repository, you needed to push a commit.

Let’s briefly review what commits are. 

A **commit** is a change to one or more files on a branch. Every time a commit is created, it's assigned a unique ID and tracked, along with the time and contributor. Commits provide a clear audit trail for anyone reviewing the history of a file or linked item, such as an issue or pull request.
 
:::image type="content" source="../media/2-commits.png" alt-text="A screenshot of a list of GitHub commits to a main branch." border="false":::

Within a git repository, a file can exist in several valid states as it goes through the version control process:

The primary states for a file in a Git repository are:

Untracked: An initial state of a file when it isn't yet part of the Git repository. Git is unaware of its existence.

Tracked: A tracked file is one that Git is actively monitoring. It can be in one of the following substates:

- Unmodified: The file is tracked, but it hasn't been modified since the last commit.
- Modified: The file has been changed since the last commit, but these changes aren't yet staged for the next commit.
- Staged: The file has been modified, and the changes have been added to the staging area (also known as the index). These changes are ready to be committed.
- Committed: The file is in the repository's database. It represents the latest committed version of the file.

These states and substates are important to collaborating with your team to know where each and every commit is in the process of your project. 

Now let’s move on to pull requests. 

## What are pull requests?

Now that we know what a commit is, let’s review a pull request. 

A **pull request** is the mechanism used to signal that the commits from one branch are ready to be merged into another branch. 

The team member submitting the **pull request** requests one or more reviewers to verify the code and approve the merge. These reviewers have the opportunity to comment on changes, add their own, or use the pull request itself for further discussion. 

Once the changes have been approved (if approval is required), the pull request's source branch (the compare branch) is merged into the base branch.

:::image type="content" source="../media/2-pull-request.png" alt-text="A screenshot of a pull request and a comment within the pull request." border="false":::

Now that we know of all the ingredients, let’s review the GitHub flow. 

## The GitHub flow

:::image type="content" source="../media/2-branching.png" alt-text="Screenshot showing a visual representation of the GitHub Flow in a linear format that includes a new branch, commits, pull request, and merging the changes back to main in that order." border="false":::

The GitHub flow can be defined as a lightweight workflow that allows for safe experimentation. You can test new ideas and collaboration with your team by using branching, pull requests, and merging. 

Now that we know the basics of GitHub we can walk through the GitHub flow and its components.

1.	The first step of the GitHub flow is creating a branch so that the changes, features, and fixes you create don't affect the main branch. 
2.	The second step is to make your changes. We recommend deploying changes to your feature branch before merging into the main branch. Doing so ensures the changes are valid in a production environment. 
3.	The third step is to create a pull request to ask collaborators for feedback. Pull request review is so valuable that some repositories require an approving review before pull requests can be merged.
4.	Next is the fourth step of reviewing and implementing your feedback from your collaborators.
5.	The fifth step, once you’re feeling great about your changes now it's time to get your pull request approved and merge it into the main branch.
6.	The sixth and final step is to delete your branch. Deleting your branch signals your work on the branch is completed and prevents you or others from accidentally using old branches. 

And that’s it, you’ve been through a GitHub flow cycle!  

Let’s move onto the next section where we’ll cover the differences between issues and discussions.
