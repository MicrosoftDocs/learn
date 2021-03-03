<!-- Guidance on writing the opening to a content/conceptual unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-learning-unit-introduction-format -->

The core part of any Git workflow is modifying files and committing the changes in those files. While working on your project, you should be able to easily access these Git commands to commit early and often. In this unit, you'll learn how the Git Changes window helps you with managing your changed files. 


<!-- 

See here for general guidance on content units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-learning-content?branch=master

-->

## Git Changes window

The Git Changes window is Visual Studio's side panel that gives you the most common Git commands at your fingertips while coding. Keeping this tool window docked next to your code along with Solution Explorer makes it just a click away. 

### Status Section

The top part of the Git Changes window is the status section. You can see what branch you are on. Selecting the branch picker lets you switch branches or create a new branch. Next to the branch picker, you'll see buttons for Fetch, Pull, Push in that order. These buttons help keep your local branch in sync with your remote branch. Underneath the branch picker, is the number of outgoing and incoming commits. Whenever you make commits, you'll notice the first number increment higher to indicate commits you might want to push to your remote branch. And whenever you fetch, you can see if there are any unpulled commits from the remote tracking branch. Clicking on the link takes you to the Git Repository window where you can see the details of the outgoing and incoming commits, and the branches local history. 

### Changes section

The next section we'll talk about is the Changes section. Any file you add, delete, or modify will appear here as a file with pending changes in your working directory. While you're coding, you'll likely spend most of your time looking at the changed set of files here. Each file will have an indicator to the right for the type of change - A for added file, D for deleted file, and M for modified file. There's also a quick action button to Undo the change. 

Single selecting on a modified file will open the Visual Studio Diff viewer. This view shows the difference in the previous version and current modified version of the file. Git compares the changes you made to the file to the last commit of the file. Single select an added or deleted file to open the file in the document well. You can also change the default selection behavior through the Actions (...) menu in the Changes section. Throughout the Git tooling in Visual Studio, you'll notice the Actions menu in multiple places to provide you with more contextual functionality. 

### Staged Changes section

The Staged Changes section shows up only after you've staged one or more files from the Changes section. You can stage files by selecting the plus button to the right of the file, folder, or the entire section. Staging a file is the equivalent of the `git add` command. The feature allows you to focus only on the parts of your pending changes that you want to commit. To remove a file or folder from the staging area, simply select on the minus button to the right. 

### Committing and updating commits

After staging files, the next logical step is to commit the staged files. You can type a commit message in the Commit text box, and select Commit Staged or the keyboard shortcut `Ctrl+Enter` to create a commit. The Commit button has a dropdown that allows you to **Commit and Push** or **Commit and Sync** in a single command as well. 

When you commit a change, you sometimes may want to update the commit if you forgot to add a change or part of the message. That's what the Amend checkbox is for. Clicking on it will let you modify the latest commit in the current branch. You'll see the message for the commit appear in the commit text box and the indication that your next **Commit** action will modify the specific commit.

### Stashes section

Visual Studio provides you with the functionality to stash changes. You can stash all changes or just the unstaged changes using the Commit button dropdown. Stash messages are optional. Visual Studio uses a default stash message indicating Work in Progress (WIP) changes on the previous commit in the repository. Right-clicking on a stash gives you more actions. **Drop** will delete the stash. **Apply** will recover the changes and keep the stash as is. Whereas, **Pop** will recover the changes and delete the stash.



<!-- NOTE: commit changes on to main branch. This is a centralized workflow, where you work on a single main branch and push all commits there. It's great for small teams or solo developers. https://www.atlassian.com/git/tutorials/comparing-workflows#centralized-workflow -->