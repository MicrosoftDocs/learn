Here, we discuss how merge conflict resolution helps developers produce the best result from two overlapping sources.

## The GitHub Flow

In addition to providing a platform for collaborative software development, GitHub also offers a prescribed workflow designed to optimize use of its various features. While this unit specifically covers merge conflicts, it is recommended that you first review [Understanding the GitHub flow](https://guides.github.com/introduction/flow/?azure-portal=true).

## Merging branches

Consider a scenario where a developer creates a branch named `feature-branch` based off `master` and creates two commits. As this is happening, someone else merges a pull request. What happens when our developer tries to merge `feature-branch` back in to `master`?

The answer: *it depends*.

Although `feature-branch` was created from `master`, it wasn't actually based on the branch itself. Rather, it was based on the *HEAD commit* of `master` at the time. It is not aware of all of the commits that have been applied to `master` since then, so the commits it's currently tracking won't necessarily fold into the current state of the branch without overwriting recent changes.

If it turns out that the `feature-branch` commits don't overlap with parallel commits made to `master` since the branch was created, then there will be no problems. New files can be added. Untouched files can be deleted. Lines of code that were changed in `feature-branch` can be changed in `master` as long as the parallel work did not change them since `feature-branch` was created.

![A pull request with no merge conflicts](../media/2-no-merge-conflicts.png)

But what if both sets of commits include changes to the same lines of code? This would cause a **merge conflict**.

![A merge conflict](../media/2-merge-conflict.png)

## What are merge conflicts?

Merge conflicts are raised when a developer attempts to merge changes that risk overwriting changes merged from a parallel path. It doesn't matter how those other changes were merged into the base branch. Git won't automatically overwrite one set of changes in favor of another. Instead, it will point them out to the person trying to merge so that they can resolve them on their compare branch before trying to merge again.

![A pull request with merge conflicts](../media/2-yes-merge-conflicts.png)

### Resolving merge conflicts

To help you resolve merge conflicts, Git generates a hybrid file that includes the differences from each branch. The convention is that the text from compare branch is shown above the base branch, separated by a line of equal signs (`=======`). 

![Resolving a merge conflict](../media/2-resolving-merge-conflict.png)

You can use this view to directly edit the file if the changes are minor. If you decide to keep the final result, it will be committed to the compare branch. If the merge is more involved, you may prefer to perform it using other development tools. Either way, don't forget to remove the branch markers from your code before committing.

> [!NOTE]
> This unit discusses resolving merge conflicts within the context of a browser. There are also many development platforms, like [Visual Studio](https://visualstudio.microsoft.com/?azure-portal=true), that offer integrated merge conflict resolution experiences.

Once all of the merges conflicts have been resolved on your branch, you can retry the merge.

## Avoiding merge conflicts

Certain merge conflicts are unavoidable. Any merge could potentially produce merge conflicts for pull requests waiting to be approved. However, one effective way to reduce the complexity of merge conflicts is to **rebase** your branch often.

### What is git rebase?

The `git rebase` command enables you to update your branch so that it uses the current HEAD commit of the base branch as its base. It's conceptually similar to the **Get Latest** command that many version control systems use to allow you to update your local code to the latest version. When you rebase your code, you are effectively merging down all of the commits that have happened since the branch was created (or last rebased).

Rebasing your branch may result in merge conflicts, but that's okay. You would have gotten them later on anyway, and by getting them earlier, they're usually easier to address. Learn more about [resolving merge conflicts after a Git rebase](https://help.github.com/github/using-git/resolving-merge-conflicts-after-a-git-rebase?azure-portal=true).

In addition to mitigating the impact of merge conflicts, rebasing also allows you to integrate committed changes into your branch as you work on it. For example, there may be class definition changes in other files that will cause your code to no longer compile. You probably wouldn't have gotten a merge conflict when you tried to merge later on, but it would have broken the build if you didn't test first. It's a best practice to rebase often to keep your branch as close to its base as possible.

Learn more [about Git rebase](https://help.github.com/github/using-git/about-git-rebase?azure-portal=true).