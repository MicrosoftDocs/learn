Once you understand the basic Git commands, you can start using Git as a source and version control platform. If you’re working by yourself, or as part of a small team where everyone has their own files that they’re responsible for, you may not even need to go much past the basic Git commands. However, for more complex repositories, working together with multiple people on the same branch, and managing the history of branches, you’ll need a few more advanced Git commands in your toolbelt.

## git pull

If you’re the only one working in a branch or on a repository, and all of your work is done from the same compute, then you know that you’ve always got the latest version. However, the point of Git is collaboration. What if you made changes to a file on a different computer, or if someone else made changes to a file in the branch you’re working on?

`git pull` reaches out to the remote branch and checks if there are updates needed, and then updates your local repo It’s a good idea to run a git pull before you start working on your files. Updating your repo before you start work helps avoid conflicts later if you didn’t start from the latest update.

`git pull`

:::image type="content" source="../media/git-pull-command-67dbb368.png" alt-text="Screenshot of the git pull intermediate command.":::


> [!NOTE]
> `git pull` updates the branch you’re currently working within. Make sure you run `git checkout <branch>` to the branch you want to update first.

## git merge

Recall that branching lets you manage multiple versions of code at the same time. You can manage the production code, the development code, and the bug-fix version of the code from within one repository. But, what about when it’s time to merge the updates from on branch to another? Merging your code back into one of the main branches of a repository helps keep the code in the right place.

`git merge` lets you tell Git that you want to take your file from the training branch, for example, and incorporate it into the production or main branch of the code. When merging, you merge a different branch into the branch you're currently in. That means, if you just finished working on code in your training branch, and want to merge into the main branch, you’ll need to switch to the main branch first using the `git checkout main` command.

Then, once you’re in the main branch, you can merge your updates into the main branch from the training branch with `git merge <branch to merge>`, in this case training.

`git merge training`

:::image type="content" source="../media/git-merge-command-4f36f0e3.png" alt-text="Screenshot of the git merge command.":::


If you’re the only person that’s made updates to the file you’re attempting to merge, the process should go seamlessly (it’s a good idea to run a `git pull` before starting work).

If other changes have been made, you’ll need to manage the conflict. Any files with a conflict will be updated to include both versions of content in a single file. If you open the file, you'll see your changes and current version of content (as it exists in the repo). You can manually update and re-commit the file, which will effectively complete the merge.<br>

:::image type="content" source="../media/git-merge-conflict-648b07bf.png" alt-text="Screenshot of the git merge command with conflict.":::


```
<<<<<<< HEAD
This is a training document.
=======
This is a note from a different branch in the same document.
<p>:::blockquote-begin:::>>>>>> training:::blockquote-end:::</p>












```

Once you've made edits to the file, you'll need to run the `git add` command to stage the file, and then a `git commit -m "<your comment>"` to commit the file to the current branch of the repo.

> [!NOTE]
> You don’t need to re-merge because when you finish the `git commit`, you’ve updated the file on the branch.
