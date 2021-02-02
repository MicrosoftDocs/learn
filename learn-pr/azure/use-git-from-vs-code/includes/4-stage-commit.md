Modifying files locally to a repository doesn't bring you anything until they can be synchronized to your main GitHub repository. In this unit, you'll walk through the different stages a file will go through from modification to being uploaded to GitHub.

## Local vs Remotes

One important concept with GitHub is the difference between local repository and remote repositories. Any cloned repository to your local disk is an identical copy of the GitHub repository.

It is important to highlight that commits made locally will not be found on GitHub automatically.

To upload commits to GitHub, we need to run a `push` operation that will transfer unsynchronized commits on our local repository to the remote GitHub repository.

## What is an unstaged change?

An unstaged change is a file that has been modified but hasn't been added to your Git staging area. The staging area is filled with files that are going to find themselves in the next commit. If you create a commit with unstaged files, they are not part of this commit in your local repository.

:::image type="content" source="../media/4-exercise-stage-commit-01.png" alt-text="Modifying files updates your working directory":::

### What is a staged change?

A staged change is a file has been added to the staging area. They are part of the list of files to be added to the next created commit. Staged changes includes new files, deleted files, as well as modified files.

:::image type="content" source="../media/4-exercise-stage-commit-02.png" alt-text="Staging files from your working directory":::

## What is a commit?

A commit is a combination of a log message and the content of the files that were previously staged. This new commit has a hash assigned and will represent the new modifications to your files. The staging area is then cleared as the changes are now persisted into the local repository.

:::image type="content" source="../media/4-exercise-stage-commit-03.png" alt-text="Committing files to your local repository":::

## What is a `push` command?

The push command updates your remote repository with your local changes. This command is the final step to ensure your local changes become permanent on GitHub. Once the `push` command has been done, any contributors to your GitHub project will have access to new updated repository.

:::image type="content" source="../media/4-exercise-stage-commit-04.png" alt-text="Pushing files from the local repository to the remote repository":::

## Next Steps

Next, you'll continue what we started in the previous unit. Visual Studio Code will help us stage our changes, commit those changes to our local repository, and finally synchronize our repository to GitHub.