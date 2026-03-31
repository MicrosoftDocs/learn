Being able to recover data using Git commands is very important for developers. It helps you undo accidental changes, restore deleted files, or recover lost commits. This helps minimize unexpected problems and keeps your project running smoothly. However, it's important to be careful. When using the Git commands described in this section, be cautious, especially when changing commit history or reverting changes, as mistakes can cause data loss.

## Git data recovery commands

Git commands for data recovery can be grouped into several categories: recovering commits, files, specific lines of code, and deleted commits or branches.

### Recovering commits

- **git log** - Shows the commit history of a repository. You can look through the log to find the commit you want to recover.
- **git checkout &lt;commit&gt;** - Switches to a specific commit, effectively "recovering" the state of the repository at that commit.
- **git cherry-pick &lt;commit&gt;** - Applies the changes from a specific commit to your current branch.

### Recovering files

- **git checkout &lt;commit&gt; &lt;file&gt;** - Restores a specific file from a previous commit.
- **git restore &lt;file&gt;** - Discards local changes and restores the file to its last committed state (only works if you haven't committed the changes yet).

### Recovering specific lines of code

- **git blame &lt;file&gt;** - Shows the revision and author of each line in a file, helping you find the commit that introduced a particular change.
- **git show &lt;commit&gt;:&lt;file&gt;** - Shows the content of a file at a specific commit. You can specify the commit and file path to see the content as it was at that time.

### Recovering deleted commits or branches

- **git reflog** - Shows a record of all commits. You can use it to find the SHA-1 hash of a previously deleted commit or branch and then checkout or restore it.
- **git fsck --lost-found** - Checks the integrity of the repository and lists any commits that aren't reachable from any branch or tag. You can use this to recover lost commits.

Remember to use these commands carefully, especially when changing commit history or reverting changes. Always create a backup of your repository before you start, or use `git stash` to save your current changes before attempting any recovery operations.

## Sample scenario

Let's walk through a sample scenario that shows how to use Git commands to recover a deleted file. We'll assume that a file named example.txt in your Git repository was accidentally deleted and you need to recover it.

**Viewing Commit History:**

- Start by showing the commit history:`git log`
- In the commit history, find the SHA-1 hash of the commit where the file example.txt was last present.

**Restoring the Deleted File:**

- Once you've found the SHA-1 hash of the commit, use git checkout to restore the file:`git checkout <commit_SHA>^ -- example.txt`
- Replace `<commit_SHA>` with the SHA-1 hash of the commit. The `^` symbol means the parent of that commit, effectively restoring the file to its state before deletion.

**Verifying Changes:**

- After restoring the file, check that it was successfully restored by checking the repository status:`git status`
- Verify that example.txt is listed as a modified or untracked file.

**Staging and Committing Changes:**

- If the file is listed as modified, stage it for commit:`git add example.txt`
- Commit the changes with a clear commit message:`git commit -m "Restored example.txt"`
