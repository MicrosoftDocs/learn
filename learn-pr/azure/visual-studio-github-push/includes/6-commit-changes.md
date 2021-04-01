The core part of any Git workflow is modifying files and committing the changes in those files. While working on your project, you should be able to easily access these Git commands to commit early and often. In this unit, you'll learn how the Git Changes window helps you with managing your changed files. 

## Git Changes window

The Git Changes window is Visual Studio's side panel that gives you the most common Git commands at your fingertips while coding. Keeping this tool window docked next to your code along with Solution Explorer makes it just a click away. 

:::image type="content" source="../media/6-git-changes.png" alt-text="Screenshot of Git Changes window.":::

### Status Section

The top part of the Git Changes window is the status section. You can see what branch you are on. Selecting the branch picker lets you switch branches or create a new branch. Next to the branch picker, you'll see buttons for Fetch, Pull, Push in that order. These buttons help keep your local branch in sync with your remote branch. Underneath the branch picker, is the number of outgoing and incoming commits. Whenever you make commits, you'll notice the first number increment higher to indicate commits you might want to push to your remote branch. And whenever you fetch, you can see if there are any unpulled commits from the remote tracking branch. Clicking on the link takes you to the Git Repository window where you can see the details of the outgoing and incoming commits, and the branches local history. 

:::image type="content" source="../media/6-status-section.png" alt-text="Screenshot of Git Changes window with a callout around status section.":::

### Changes section

The next section we'll talk about is the Changes section. Any file you add, delete, or modify will appear here as a file with pending changes in your working directory. While you're coding, you'll likely spend most of your time looking at the changed set of files here. Each file will have an indicator to the right for the type of change - A for added file, D for deleted file, and M for modified file. There's also a quick action button to Undo the change. 

Single selecting on a modified file will open the Visual Studio Diff viewer. This view shows the difference in the previous version and current modified version of the file. Git compares the changes you made to the file to the last commit of the file. Single select an added or deleted file to open the file in the document well. You can also change the default selection behavior through the Actions (...) menu in the Changes section. Throughout the Git tooling in Visual Studio, you'll notice the Actions menu in multiple places to provide you with more contextual functionality. 

:::image type="content" source="../media/6-changes-section.png" alt-text="Screenshot of Git Changes window with a callout around changes section.":::

### Staged Changes section

The Staged Changes section shows up only after you've staged one or more files from the Changes section. You can stage files by selecting the plus button to the right of the file, folder, or the entire section. Staging a file is the equivalent of the `git add` command. The feature allows you to focus only on the parts of your pending changes that you want to commit now and which changes you want to save until a later commit. A commit is a snapshot of the changes that you made to your code. You might make a bunch of changes, but want to organize them in logical and easily readable snapshots. Staging changes allows you to do that. To remove a file or folder from the staging area, simply select on the minus button to the right. 

:::image type="content" source="../media/6-staged-changes-section.png" alt-text="Screenshot of Git Changes window with a callout around staged changes section.":::

### Committing and updating commits

After staging files, the next logical step is to commit the staged files. You can type a commit message in the Commit text box, and select Commit Staged or the keyboard shortcut `Ctrl+Enter` to create a commit. The Commit button has a dropdown that allows you to **Commit and Push** or **Commit and Sync** in a single command as well. 

:::image type="content" source="../media/6-committing.png" alt-text="Screenshot of Git Changes window with a callout around commit text box and commit button.":::

When you commit a change, you sometimes may want to update the commit if you forgot to add a change or part of the message. That's what the Amend checkbox is for. Clicking on it will let you modify the latest commit in the current branch. You'll see the message for the commit appear in the commit text box and the indication that your next **Commit** action will modify the specific commit.

:::image type="content" source="../media/6-amending.png" alt-text="Screenshot of Git Changes window with a callout around the Amend checkbox.":::

### Undoing a commit

Visual Studio helps you with the ability to undo any commit you make. You may want to erase the local work you just did and start from scratch if you've made a mistake. In that case, you can 'git reset' a commit, which removes it from the commit graph and orphans it. The IDE provides you with two options when resetting commits. The default way is to reset and keep the changes from that commit (--mixed). Here, the commit is removed, and the files that were changed appear in the Changes section of the Git Changes window. The more dangerous operation is to reset and delete the changes from the commit (--hard).

:::image type="content" source="../media/6-resetting.png" alt-text="Screenshot of Commit Details window with a callout around the Reset button.":::

You should never reset a commit that has been pushed up to a public repository. Removing a commit this way will make it look like a chunk of history is missing when other developers try to push their commits and will cause all sorts of problems. Instead, the safe way to undo a public commit is using `git revert`. With Visual Studio, you can revert a commit, which creates a new second commit that undoes the changes applied in the first commit.

:::image type="content" source="../media/6-reverting.png" alt-text="Screenshot of Commit Details window with a callout around Revert button.":::

### Stashes section

Visual Studio provides you with the functionality to stash changes. You can stash all changes or just the unstaged changes using the Commit button dropdown. Stash messages are optional. Visual Studio uses a default stash message indicating Work in Progress (WIP) changes on the previous commit in the repository. Right-clicking on a stash gives you more actions. **Drop** will delete the stash. **Apply** will recover the changes and keep the stash as is. Whereas, **Pop** will recover the changes and delete the stash.

:::image type="content" source="../media/6-stashes-section.png" alt-text="Screenshot of Git Changes window with a callout around stashes section.":::