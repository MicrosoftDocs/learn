To support continuous integration, you frequently merge your code changes into a shared repository. The shared repository is part of a version control system like GitHub or Azure DevOps. Version control is a way of managing changes to code over time. It lets you track code revisions, contribute collaboratively to code development, and revert to prior versions of code if needed.

GitHub and Azure DevOps are the version control systems that are supported in Fabric. These version control systems allow you to create a copy of a code repository that's called a branch. You can use the branch to work on your own code independently from the main version of your team's code. When you have changes to submit, you can **commit** them to the repository and merge your changes with a main code branch.

Integration with version control is at the workspace level in Fabric. You can version items you develop within a workspace.

## Connect to a Git Repository
A Fabric workspace is shared environment that accesses live items. Any changes made directly in the workspace overrides and affect all other workspace users. A best practice is for you to develop in an isolated workspace, outside of a shared, live workspace. In your own protected workspace, you can connect to your own branch and sync content from the live workspace into your protected workspace, and then commit your changes back to your branch or the main branch.

1. **Set up a git repository:**
The first step in implementing Git integration is to set up a Git repository in either GitHub or Azure DevOps. The repository is the central location for storing and managing items.

2. **Connect a Fabric workspace to a Git repository:**
Next, within the workspace that you want to connect to your repository, establish a connection to the repository from the **Git integration** option in workspace settings.

    :::image type="content" source="../media/connect-git.png" alt-text="Screenshot of workspace to Git provider connection interface." :::

    When you connect a workspace to Git, you **create or select an existing a Git repository branch** to sync with. Fabric syncs the content between the workspace and Git so they have the same content.
    
    :::image type="content" source="../media/branch-selection.png" alt-text="Screenshot of branch selection in Git provider interface." :::

## Commit and update the Fabric workspace and Git repository
After you connect to the repository, the workspace shows a Git status column indicating the sync state of items in the workspace, compared to the items in the remote branch.

The source control icon shows the number of items that are different between the workspace and the repository. 

To synchronize the workspace and repository:
- When you make workspace changes, synchronize them with the Git branch using the **Changes** selection in the **Source control** window.
- When new commits are made in the Git branch, synchronize them with your workspace using the **Updates** selection in the **Source control** window.

    :::image type="content" source="../media/git-status.png" alt-text="Screenshot of uncommitted changes in workspace." :::

## Branching scenarios
Changes that you make to a workspace when you're doing development work affect all other workspace users so it's a best practice to work in isolation outside of shared workspaces. To keep your development work isolated from shared workspaces, you can develop using:
- A separate, isolated workspace 
- Client tools like Power BI Desktop for reports and semantic models or VS Code for Notebooks.

 In both scenarios, your feature development work should take place in a dedicated branch instead of the main code branch.  This makes it easy for multiple developers to work on a feature without affecting the main branch. 

### Create a dedicated branch, issue pull requests and sync a workspace with Git

Create a dedicated branch and issue pull requests to pull changes from your branch into the main branch by following these steps: 

For development using a separate, isolated workspace:

1. Connect a development workspace to the main branch, following the instructions in the section on this page entitled "Connect to a Git Repository". 
2. If you're a developer who works in the Fabric web interface, create an isolated branch for your work from the development workspace that's connected to the main branch by selecting **Source control** and **Branch out to new workspace**. Name the branch and associate it with another workspace.  The new workspace syncs with the main branch and become an isolated work environment for your work.

    :::image type="content" source="../media/branch-out-to-new-workspace.png" alt-text="Screenshot of creating new workspace and branch." :::

3. Makes changes in your branch, then commit them to your isolated branch via the **Source control** interface in Fabric. 
4. Then, *in Git*, create a **Pull Request (PR)** to pull the changes from your isolated branch into the main branch.  
5. The main branch in Git will be updated once the PR is merged to the main branch. When you open the *shared* development workspace, you'll be prompted to synchronize the new content from Git with the shared development workspace. 

When using client tools for development, the process is similar to that when developing in the Fabric web interface. 
 
1. Connect a development workspace to the main branch, following the instructions in the section on this page entitled "Connect a Fabric workspace to a Git repository".
2. Clone the repository on your local machine. 
3. Push the changes to the remote repository when you're ready to test in Fabric. Test the changes by connecting your isolated branch to a separate workspace.
4. Issue a PR *in Git* to merge your changes into the main branch.
5. When you open the shared workspace associated with the main branch, you'll be prompted to sync the changes from the repository into the workspace.