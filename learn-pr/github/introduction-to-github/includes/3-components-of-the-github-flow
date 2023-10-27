In this unit we will be reviewing the following:
-	Branches
-	Commits 
-	Pull Requests
-	The GitHub Flow

## What are branches

If you were following along with creating a new file in the last section, you might have just created a new branch in your repositories. 

Branches are an essential part to the GitHub experience because they are where we can make changes without affecting the entire project we are working on. 

Your branch is a safe place to experiment with new features or fixes. If you make a mistake, you can revert your changes or push additional changes to fix the mistake. Your changes will not end up on the default branch until you merge your branch.

Note: If you wanted to do this by simply using git in a terminal the command would be 
`git checkout -b newBranchName`


## What are commits

As you might have noticed in the previous unit, adding in a new file into the repository, you needed to push a commit.

Let’s briefly review what commits are. 

A **commit** is a change to one or more files on a branch. Every time a commit is created, it's assigned a unique ID and tracked, along with the time and contributor. This provides a clear audit trail for anyone reviewing the history of a file or linked item, such as an issue or pull request.
 
:::image type="content" source="../media/2-commits.png" alt-text="A list of GitHub commits to a main branch." border="false":::

Within a git repository, a file can exist in several vaid states as it goes through the version control process:

The primary states for a file in a Git repository are:

Untracked: This is the initial state of a file when it is not yet part of the Git repository. Git is unaware of its existence.

Tracked: A tracked file is one that Git is actively monitoring. It can be in one of the following sub-states:

- Unmodified: The file is tracked, but it has not been modified since the last commit.
- Modified: The file has been changed since the last commit, but these changes are not yet staged for the next commit.
- Staged: The file has been modified, and the changes have been added to the staging area (also known as the index). These changes are ready to be committed.
- Committed: The file is in the repository's database. It represents the latest committed version of the file.

These states and substates are important to collaborating with your team to know where each and every commit is in the process of your project. 

Now let’s move on to pull requests. 

## What are pull requests?

Now that we know what a commit is, let’s review a pull request. 

A **pull request** is the mechanism used to signal that the commits from one branch are ready to be merged into another branch. 

The team member submitting the **pull request** will often request one or more reviewers to verify the code and approve the merge. These reviewers have the opportunity to comment on changes, add their own, or use the pull request itself for further discussion. 

Once the changes have been approved (if approval is required), the pull request's source branch (the compare branch) may be merged into the base branch.

:::image type="content" source="../media/2-pull-request.png" alt-text="GitHub pull requests provide a way to get commits from one branch into another branch." border="false":::

Now that we are aware of all the ingredients, let’s review the GitHub flow. 

## The GitHub flow

:::image type="content" source="../media/2-branching.png" alt-text=" A visual representation of the GitHub Flow that includes a new branch, commits, pull request, and merging the changes back to main." border="false":::

Like the GitHub platform itself, the GitHub flow can be defined as a lightweight workflow that allows for safe experimentation with new ideas and collaboration on projects through branching, pull requests, and merging. 

Now that we know the basics of GitHub we can walk through the GitHub flow and its components.

1.	The first step of the GitHub flow is creating a branch so that the changes, features, and fixes you create will not affect the main branch. 
2.	The second step is to make your changes. It is recommended to deploy these changes to your feature branch before merging into the main branch to ensure the changes are verified and validated in a production environment. 
3.	The third step is to create a pull request to ask collaborators for feedback. Pull request review is so valuable that some repositories require an approving review before pull requests can be merged.
4.	Next is the fourth step of reviewing and implementing your feedback from your collaborators.
5.	Step five, once you’re feeling great about your changes now it is time to get your pull request approved and merge it into the main branch.
6.	The sixth and final step is to delete your branch. This in GitHub will signal that the work on the branch is completed and prevents you or others from accidentally using old branches. 

And that’s it, you’ve just been through a GitHub flow cycle!  

Let’s move onto the next section where we’ll cover the differences between issues and discussions.
