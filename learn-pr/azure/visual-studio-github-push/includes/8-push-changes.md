Once you've committed to your repository, you've inherently saved local snapshots of your code. The next step is to push the commits to GitHub to store them as backups or share the code with others. Visual Studio uses the `git push` command to upload your local repository content to the remote repository.

## Git syncing

Visual Studio helps you keep your local branch synchronized with your remote branch through download (fetch and pull) and upload (push) operations, visible in the Git Repository window. The main panel in the Git Repository shows the Local History of the selected branch. Above the Local History, you'll see two optional sections. The Outgoing section displays the commits that you haven't yet pushed to your remote. The Incoming section displays the commits that you've fetched but not yet pulled from your remote.

:::image type="content" source="../media/8-incoming-outgoing.png" alt-text="Screenshot of Git Changes window with one outgoing commit.":::

Before you push, it's important fetch and pull. Fetching checks if there are any remote commits you should incorporate into your local changes. If you see any, then pull first to prevent any upstream merge conflicts. You may forget to do this first step. So Visual Studio doesn't allow you to push commits if your local branch is behind the remote branch. Instead if you try to push, you'll see a dialog prompting you to pull first, then push. 

:::image type="content" source="../media/8-pull-push.png" alt-text="Screenshot of streamlined push window with a callout around the pull and push button.":::

## Force push

Sometimes, you may want to overwrite the commits on the remote branch with your own local commits. This may occur if you realize the commits you uploaded aren't correct, and you amended them. Git gives you the ability to use the `--force` flag, which is a dangerous command because it deletes any remote commits that may have been added since you last pulled. So instead, Visual Studio provides the modified flag `--force-with-lease`. This is a safer option because it will ensure that you don't overwrite someone else's work by force pushing. To enable the command, you need to go to **Git > Settings** and toggle the checkbox to **Enable push --force-with-lease**. 

:::image type="content" source="../media/8-settings-push.png" alt-text="Screenshot of Options window with Git Settings to enable push --force-with-lease.":::

Then the next time you try pushing with unpulled commits, you'll see the dialog lets you **Force Push**.

:::image type="content" source="../media/8-force-push.png" alt-text="Screenshot of streamlined push window with a callout around the force push button.":::
