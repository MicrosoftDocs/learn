Now let's get some hands-on practice fixing our mistakes!

## Practice recovering a deleted file

1. First, try deleting **index.html**.:

    ```bash
    rm index.html
    ```

    This may seem like a bad idea, but remember: Git has your back!

1. Use an `ls` command to verify that **index.html** was deleted:

    ```bash
    ls
    ```

1. This is the output you should see. Note, there is no **index.html** file!

    ```output
    CSS
    ```

1. Now, let's recover **index.html**. Use ``git checkout`` to bring **index.html** back:

    ```bash
    git checkout -- index.html
    ```

1. Use `ls` again to check the contents of the current directory. Has **index.html** been restored?

1. Yes! Now the output should have an **index.html** file alongside the **CSS** directory:

    ```output
    CSS  index.html
    ```

## Practice recovering a file deleted with `git rm`

When it comes to recovering deleted files, things get a little more complicated if you delete them with `git rm` rather than `rm`.

1. To see for yourself, try this command:

    ```bash
    git rm index.html
    ```

1. Again, verify **index.html** with `ls`.

1. Once more, **index.html** is gone. Try to recover it the same way you did last time:

    ```bash
    git checkout -- index.html
    ```

1. This time, Git complains that it knows nothing about **index.html**. That's because Git not only deleted the file, it recorded the deletion in the index.

    ```output
    error: pathspec 'index.html' did not match any file(s) known to git.
    ```

1. Unstage the deletion of **index.html** with the `git reset` command:

    ```bash
    git reset HEAD index.html
    ```

1. You should see this output confirming:

    ```output
    Unstaged changes after reset:
    D       index.html
    ```

1. Now you can recover your file from the index with the command we used before:

    ```bash
    git checkout -- index.html
    ```

    `git reset` unstaged the change, but the file was still deleted, so you had to use `checkout` to get it back.

1. Double checked it work with `ls`.

## Revert a commit

Now let's make things more complicated. Suppose you accidentally overwrite one file with another, or make a change to a file that turns out to be a big mistake. You want to revert to the previous version of the file, but you had already committed the changes. This means that a simple `git checkout` won't do the trick.

One solution to this problem is to revert the previous commit.

1. Open up **index.html** with code:

    ```bash
    code index.html
    ```

1. Replace the contents of **index.html** with this:

    ```html
    <h1>That was a mistake!</h1>
    ```

1. Save and close the file.

1. Use these commands to commit the changes, and show the latest commit:

    ```bash
    git commit -m "Purposely overwrite the contents of index.html" index.html
    git log -n1
    ```

    > The `-n1` flag here tells Git that we just want the most recent commit entry.

1. Use the following commands to attempt to restore **index.html**:

    ```bash
    git checkout -- index.html
    ```

1. Open up **index.html** with the editor.

    ```bash
    code index.html
    ```

    Which version of **index.html** do you see? The old or the new?

    In this situation, the best course of action is to _revert_ the change by making another commit that cancels out the first one. That's a job for `git revert`.

1. Close the file and use `git revert` to undo your committed changes:

    ```bash
    git revert --no-edit HEAD
    ```

    > The `--no-edit` flag here tells Git that we don't want to add a commit message for this action.

1. You should see output similar to this:

    ```output
    [main 6a27310] Revert "Purposely overwrite the contents of index.html"
    1 file changed, 13 insertions(+), 1 deletion(-)
    ```

1. Follow up with a `git log` command to show the latest commit:

    ```bash
    git log -n1
    ```

1. Now, this is the output you should see:

    ```output
    Author: User Name <user-name@contoso.com>
    Date:   Tue Nov 19 23:42:26 2019 +0000

    Revert "Purposely overwrite the contents of index.html"

    This reverts commit 15d3bded388470c98881a632025bc15190fe9d17.
    ```

1. Finally, open the **index.html** file to make sure the content is the correct version.

Reverting isn't the only way to remedy this situation; you could simply edit **index.html** and commit the corrected file. That's harder if the changes you committed were extensive, and in any case, `git revert` is a good way to signal your intent.
