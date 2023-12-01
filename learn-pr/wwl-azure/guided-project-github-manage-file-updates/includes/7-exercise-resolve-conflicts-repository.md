Since you’re the only person working in this repository, either locally or on GitHub, you won't run into conflicts if you’re consistent with pushing your branches to your remote repo. However, for this unit, you’re going to force a conflict between the remote repository and your local repository. Suppose that the teacher you're helping out had a new student join the class for project 2, 3, and 4. The teacher goes into the GitHub repository and updates the grade files to add the student's name. To simulate this, follow the steps.

Start by logging into GitHub at [https://github.com](https://github.com?azure-portal=true).

1.  Select your **learn-git** repository from the left side, under Top Repositories.
    
    :::image type="content" source="../media/github-top-repositories-7633ebff.png" alt-text="Screenshot of the top repositories section of GitHub.":::
    
2.  Change your branch to **project2**.
    
    :::image type="content" source="../media/branch-selector-ca9bf5ab.png" alt-text="Screenshot of the branch selector in GitHub.":::
    
3.  Edit the **project2.md** file.
4.  Add another grade line for Monty below Mingkwan.
    
    `| Monty | pts |`
5.  Select **Commit changes**.
6.  Select **Commit changes**.
7.  Change your repository branch to **project34**.
8.  Edit **project3.md** to add a grade line for Monty.
    
    `| Monty | pts |`
9.  Select **Commit changes**.
10. Select **Commit changes**.
11. Edit **project4.md** to add a grade line for Monty.
    
    `| Monty | pts |`
12. Select **Commit changes**.
13. Select **Commit changes**.

> [!IMPORTANT]
> Did you notice that when you looked at project2.md, all of the grades for the other students were already there? Remember when you pushed the project2 branch to the remote? That's why it reflects what's in your local repository. However, project34 didn't have the grades. It seemed to still have the placeholder files. That's because you didn't push the updates after you added the grades to the project34 branch. That was on purpose, but now you'll have to fix that.

If you still have Visual Studio Code open to the learn-git project, continue to:

<!--- raw content start --->
[Update the project2 branch](#update-the-project2-branch)
<!--- raw content end --->

## Open Visual Studio Code

1.  Launch **Visual Studio Code**.
2.  On the menu bar, select **Terminal &gt; New Terminal** or use the hotkey combination **CTRL \`** (control backtick) to open the terminal in Visual Studio Code.
3.  Change the terminal type to **Git Bash**.
4.  In the terminal window, enter `cd c:/git-repos`

### Open your local repository in VS Code File Explorer

1.  In the Visual Studio Code menu, go to **File, Open Folder** or use the hotkey sequence **CTRL O** followed by **CTRL K**.
2.  Navigate to **c:\\git-repos** and select **learn-git**.
3.  Click **Select folder**.

The explorer view should update to show your README.md file and your grade-tempalte.md file. Your terminal window may close. Re-open the terminal window with the **CTRL \`** (control backtick) hotkey and change back to **Git Bash** if that's not your default.

:::image type="content" source="../media/vscode-explorer-view-7358913c.png" alt-text="Screenshot of VS Code explorer view with two files from the learn-git repository.":::


## Update the project2 branch

Because you pushed the project2 branch to GitHub when you were done making changes, the remote had the most up-to-date files. Updating project2 should be straightforward. All you'll need to do is get the latest files from the remote, update Monty's grade, and then re-commit and re-push the updates you make.

1.  From the Git command line in Visual Studio Code, issue the following commands:
    
    | **Command**             | **Action**                                                                    |
    | ----------------------- | ----------------------------------------------------------------------------- |
    | `git checkout project2` | Changes the working branch to the project2 branch.                            |
    | `git pull`              | Updates your local repository with the content in the GitHub project2 branch. |
2.  Update Monty's grade to give them 16 points for project 2 in the project2.md file.
3.  Save the file, then update your local repository and your remote repository with the following commands:
    
    | **Command**                              | **Action**                                                   |
    | ---------------------------------------- | ------------------------------------------------------------ |
    | `git add project2.md`                    | Stages the project2.md file.                                 |
    | `git commit -m "adding grade for Monty"` | Commits the update to your local repository.                 |
    | `git push`                               | Pushes your local repository update to your remote (GitHub). |

## Update the project34 branch

Because you didn't push the project34 branch to the remote after you changed the grades, there will be a conflict. Thankfully, Visual Studio Code makes it easy to resolve conflicts.

1.  From the Git command line in Visual Studio Code, issue the following commands:
    
    | **Command**                  | **Action**                                                                     |
    | ---------------------------- | ------------------------------------------------------------------------------ |
    | **`git checkout project34`** | Changes the working branch to the project34 branch.                            |
    | **`git pull`**               | Updates your local repository with the content in the GitHub project34 branch. |

You should receive a message about a conflict, and the file names in Visual Studio Code explorer should change color and gain an **!** indicating there's a conflict because both the local and remote files were updated.

### Update project3.md

1.  Select project3.md and Visual Studio Code will give you several options for managing the changes.
    
    | **Option**              | **Impact**                                                                                                                                                     |
    | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Accept Current Change   | Keeps the information in your local repository and discards the changes made to the remote.                                                                    |
    | Accept Incoming Change  | Keeps the information from the remote and discards the changes made locally.                                                                                   |
    | Accept Both Changes     | Incorporates all of the changes in the same file.                                                                                                              |
    | Compare Changes         | Provides a few that visually highlights the differences between the two files.                                                                                 |
    | Resolve in Merge Editor | Provides a new view that lets you use similar options, but also grants the chance to make updates or manually incorporate changes in the way that makes sense. |
    
    If you select Accept Incoming, you'll have to re-enter the grades. If you select Accept Current, you'll have to add Monty back in, and if you select Accept Combination you'll have to manually merge the two together. For this exercise, you'll stick with what you currently have locally and add Monty in.
2.  Select Resolve in Merge Editor
3.  Select Accept Current
4.  In the Result panel, manually add a new line that gives Monty 12 pts
    
    `| Monty | 12 pts |`
5.  Select Complete Merge

### Update project4.md

You'll need to follow the same process for project4.md to give Monty credit for their work on project 4.

1.  Select project4.md
2.  Select Resolve in Merge Editor
3.  Select Accept Current
4.  In the Result panel, manually add a new line that gives Monty 14 pts.
    
    `| Monty | 14 pts |`
5.  Select Complete Merge

> [!IMPORTANT]
> When you use the merge editor, the files are automatically staged once you make the updates. All that's left is to commit the updates to the local branch and then push them to the remote.

### Update the GitHub remote repository

1.  From the Git command line in Visual Studio Code:
    
    | **Command**                                    | **Action**                                                           |
    | ---------------------------------------------- | -------------------------------------------------------------------- |
    | **`git commit -m "resolving merge conflict"`** | Creates a commit for your local repository.                          |
    | **`git push`**                                 | Updates your remote (GitHub) with changes from the local repository. |

Congratulations! Whether it's a merge conflict between local branches or between your remote and local repositories, solving for merge conflicts follows the same steps. Remember, it's important to commit your work locally and push your work to remotes. This keeps your work backed up and ensures everyone has access to it!
