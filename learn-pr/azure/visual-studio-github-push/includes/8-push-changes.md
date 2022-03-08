After you've committed to your repository, you've inherently saved local snapshots of your code. The next step is to push the commits to GitHub in order to store them as backups or share the code with others. Visual Studio uses the `git push` command to upload your local repository content to the remote repository.

## Git syncing

Visual Studio helps you keep your local branch synchronized with your remote branch through download (fetch and pull) and upload (push) operations. These operations are visible in the **Git Repository** window.

The main panel in the **Git Repository** window shows **Local History** for the selected branch. Above **Local History** are two optional sections:

- The **Outgoing** section displays the commits that you haven't yet pushed to your remote.
- The **Incoming** section displays the commits that you've fetched but not yet pulled from your remote.

:::image type="content" source="../media/8-incoming-outgoing.png" alt-text="Screenshot of the Git Changes window with one outgoing commit.":::

Before you push, it's important to fetch and pull. Fetching checks if there are any remote commits that you should incorporate into your local changes. If you see any, pull first to prevent any upstream merge conflicts.

Visual Studio doesn't allow you to push commits if your local branch is behind the remote branch. If you try to push, a dialog prompts you to pull before pushing. The dialog includes a **Pull and Push** button.

:::image type="content" source="../media/8-pull-push.png" alt-text="Screenshot of a dialog with the Pull and Push button highlighted.":::

## Force push

Sometimes, you might want to overwrite the commits on the remote branch with your own local commits. It may be required when the commits you uploaded earlier aren't correct, and you want to amend them now.

You can use the `--force` flag in Git, but it's a dangerous command because it deletes any remote commits that might have been added since you last pulled. Instead, Visual Studio provides the modified flag `--force-with-lease`. It's a safer flag option, because it ensures that you don't overwrite someone else's work by force pushing. To enable the command, go to **Git** > **Settings** and select the **Enable push--force-with-lease** checkbox.

:::image type="content" source="../media/8-settings-push.png" alt-text="Screenshot of the Options window with Git settings to enable the force-with-lease flag.":::

The next time you try pushing the commits that weren't pulled earlier, the dialog that prompts you about pulling before pushing includes a **Force Push** button.

:::image type="content" source="../media/8-force-push.png" alt-text="Screenshot of a dialog with the Force Push button highlighted.":::
