Good job! So far you’ve created a new GitHub repository using the GitHub web interface, set up software to help you work with that repository locally, and then made changes and handled conflicts. Now, you’re going to get all of your changes into one place, the **main** branch.

Visual Studio Code should already be open, with your repository in the explorer pane. Recall that when merging branches in Git, you always merge the branch with updates into the branch you want to update. For this to work, you have to be working in the branch you want to update.

Use the Git command line in Visual Studio Code to issue the following commands:

| **Command**           | **Action**                                                                                                                  |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `git checkout main`   | Sets the working branch to **main**, the branch you want to update.                                                         |
| `git merge project1`  | Merges the project1 branch into the current (in this case **main**) branch, bringing the files and history from project1.   |
| `git merge project2`  | Merges the project2 branch into the current (in this case **main**) branch, bringing the files and history from project2.   |
| `git merge project34` | Merges the project34 branch into the current (in this case **main**) branch, bringing the files and history from project34. |
| `git push`            | Pushes the current (in this case **main**) branch to the remote, updating GitHub with recently merged changes.              |

Congratulations, you've finished the exercise! You've successfully created a new Git repository on GitHub, modified the files both on the web and locally, used branches to keep changes organized, and brought everything back together in a synchronized Git repository that's backed up to the remote (GitHub).
