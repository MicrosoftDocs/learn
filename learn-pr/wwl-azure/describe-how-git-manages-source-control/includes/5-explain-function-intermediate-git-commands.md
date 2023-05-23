
Once you understand the basic git commands, you can start using git as a source and version control platform. If you’re working by yourself, or as part of a small team where everyone has their own files that they’re responsible for, you may not even need to go much past the basic git commands. However, for more complex repositories, working together with multiple people on the same branch, and managing the history of branches, you’ll need a few more advanced git commands in your toolbelt.

## git pull

If you’re the only one working in a branch or on a repository, and all of your work is done from the same compute, then you know that you’ve always got the latest version. However, the point of git is collaboration. What if you made changes to a file on a different computer, or if someone else made changes to a file in the branch you’re working on?

git pull reaches out to the remote branch and checks if there are updates needed, and then updates your local repo It’s a good idea to run a git pull before you start working on your files. Updating your repo before you start work helps avoid conflicts later if you didn’t start from the latest update.

`git pull`

:::image type="content" source="../media/git-pull-command.png" alt-text="asdf":::


> [!NOTE]
> git pull updates the branch you’re currently working within. Make sure you git checkout &lt;branch&gt; to the branch you want to update first.

## git merge

Recall that branching lets you manage multiple versions of code at the same time. You can manage the production code, the development code, and the bug-fix version of the code from within one repository. But, what about when it’s time to move the break-fix version of code into the development version? Merging your code back into one of the main branches of a repository helps keep the code in the right place.

git merge lets you tell git that you want to take your file from the development branch, for example, and incorporate it into the production or main branch of the code. When merging, you merge a different branch into the branch your currently in. That means, if you just finished working on code in your development branch, and want to merge into the main branch, you’ll need to switch to the main branch first using the git checkout command.

Then, once you’re in the main branch, you can merge your updates into the main branch from the development branch with git merge &lt;branch to merge&gt;, in this case development. You’ll also want to include a status message, which you can do with -m &lt;”your message, including the quotes”&gt;.

`git merge development -m “test update”`

:::image type="content" source="../media/git-merge-command.png" alt-text="fhg":::


If you’re the only person that’s made updates to the file you’re attempting to merge, the process should go seamlessly (it’s a good idea to run a git pull before starting work).

:::image type="content" source="../media/git-merge-no-conflict.png" alt-text="5436":::


If other changes have been made, you’ll need to manage the conflict. The conflict file will be updated with your changes and the changes you missed that are currently on the branch. If you open the documents with conflicts, the two conflict will be separated by a series of equals signs.

:::image type="content" source="../media/git-merge-conflict.png" alt-text="aert":::


```
<<<<<<< HEAD
This is a training document.
=======
This is a note from a different branch in the same document.
<p>:::blockquote-begin:::>>>>>> training:::blockquote-end:::</p>










```

Edit the file, then use the git add and git commit -m "&lt;your comment&gt;" commands to update the repository.

> [!NOTE]
> You don’t need to remerge because when you finish the git commit, you’ve update the file on the branch.
