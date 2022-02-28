The core part of any Git workflow is modifying files and committing the changes in those files. While you're working on your project, you should commit early and often. In this unit, you'll learn how the **Git Changes** window helps you with managing your changed files. 

The **Git Changes** window is a side panel in Visual Studio. It shows the most common Git commands for easy access while you're coding. Keeping this tool window docked next to your code along with Solution Explorer makes it just a click away.

:::image type="content" source="../media/6-git-changes.png" alt-text="Screenshot of the Git Changes window.":::

## Status section

The top part of the **Git Changes** window is the status section. It shows what branch you're on.

Selecting the branch picker lets you switch branches or create a new branch. Next to the branch picker are **Fetch**, **Pull**, and **Push** buttons. These buttons help keep your local branch in sync with your remote branch.

Under the branch picker is the number of outgoing and incoming commits. Whenever you make commits, you'll notice the first number increment higher to indicate commits that you might want to push to your remote branch. And whenever you fetch, you can see if there are any commits not pulled in from the remote tracking branch. Selecting the link takes you to the **Git Repository** window, where you can see the details of the outgoing and incoming commits, along with the branch's local history.

:::image type="content" source="../media/6-status-section.png" alt-text="Screenshot of the Git Changes window, with the status section highlighted.":::

## Changes section

Any file that you add, delete, or modify will appear in the **Changes** section as a file with pending changes in your working directory. While you're coding, you'll likely spend most of your time looking at the changed set of files here. Each file has an indicator to the right for the type of change:

- **A** for added file
- **D** for deleted file
- **M** for modified file

There's also a quick action button to undo the change made.

Selecting a modified file opens the Visual Studio *diff* view. This view shows the difference in the previous version and the current modified version of the file. Git compares the changes that you made in the file to the last commit of the file. Select an added or deleted file to open the file in the document well.

You can also change the default selection behavior through the **Actions** (**...**) menu in the **Changes** section. Throughout the Git tooling in Visual Studio, you'll notice the **Actions** menu in multiple places to give you more contextual functionality.

:::image type="content" source="../media/6-changes-section.png" alt-text="Screenshot of the Git Changes window, with the Changes section highlighted.":::

## Staged Changes section

The **Staged Changes** section shows up only after you've staged one or more files from the **Changes** section. You can stage files by selecting the plus button to the right of the file, the folder, or the entire section.

Staging a file is the equivalent of the `git add` command. You can use the feature to focus only on the changes pending commit now and decide which changes you want to commit later.

A commit is a snapshot of the changes that you made to your code. You might make a bunch of changes but want to organize them in logical and easily readable snapshots. Staging changes allows you to do that. To remove a file or folder from the staging area, select the minus button to the right.

:::image type="content" source="../media/6-staged-changes-section.png" alt-text="Screenshot of Git Changes window, with the Changes section highlighted.":::

### Commit and update commits

After you stage files, the next logical step is to commit the staged files. You can enter a commit message in the text box, and then select **Commit Staged** or the keyboard shortcut Ctrl+Enter to create a commit. The **Commit Staged** button also has a dropdown menu where you can select **Commit and Push** or **Commit and Sync** to perform those actions in a single command.

:::image type="content" source="../media/6-committing.png" alt-text="Screenshot of the Git Changes window, with the Commit text box and Commit button highlighted.":::

When you commit a change, you sometimes might want to update the commit if you forgot to add a change or part of the message. That's what the **Amend** checkbox is for. If you select it, you can modify the latest commit in the current branch. The message for the commit appears in the text box, along with an indication that your next **Commit Staged** action will modify the specific commit.

:::image type="content" source="../media/6-amending.png" alt-text="Screenshot of the Git Changes window, with the Amend checkbox highlighted.":::

### Undo a commit

Visual Studio can help you undo any commit that you make. You might want to erase the local work that you just did and start from scratch if you've made a mistake. In that case, you can use select **Reset** (the `git reset` command), which removes the commit from the commit graph and orphans it.

The IDE has two options for resetting commits. The default way is to reset and keep the changes from that commit (`--mixed`). Here, the commit is removed, and the files that were changed appear in the **Changes** section of the **Git Changes** window. The more dangerous operation is to reset and delete the changes from the commit (`--hard`).

:::image type="content" source="../media/6-resetting.png" alt-text="Screenshot of the Commit Details window, with the Reset button highlighted.":::

You should never reset a commit that has been pushed up to a public repository. Removing a commit this way will make it look like a chunk of history is missing when other developers try to push their commits leading to all sorts of problems. The safe way to undo a public commit is to select **Revert** (the `git revert` command). With Visual Studio, reverting a commit creates a new second commit that undoes the changes applied in the first commit.

:::image type="content" source="../media/6-reverting.png" alt-text="Screenshot of the Commit Details window, with the Revert button highlighted.":::

## Stashes section

Visual Studio has the functionality to stash changes. You can stash all changes or just the untracked changes by using the **Commit Staged** button's dropdown menu.

Stash messages are optional. Visual Studio uses a default stash message that indicates Work in Progress (WIP) changes on the previous commit in the repository.

Right-clicking a stash gives you more actions:

- **Drop** will delete the stash.
- **Apply** will recover the changes and keep the stash as is.
- **Pop** will recover the changes and delete the stash.

:::image type="content" source="../media/6-stashes-section.png" alt-text="Screenshot of the Git Changes window, with the Stashes section highlighted.":::
