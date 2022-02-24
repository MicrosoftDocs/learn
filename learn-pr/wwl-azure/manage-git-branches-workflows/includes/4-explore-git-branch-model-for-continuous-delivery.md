The purpose of writing code is to ship enhancements to your software.

A branching model that introduces too much process overhead doesn't help increase the speed of getting changes to customers.

That's essential to develop a branching model that gives you enough padding not to ship poor-quality changes. But, at the same time doesn't introduce too many processes to slow you down.

The internet is full of branching strategies for Git; while there's no right or wrong, a perfect branching strategy works for your team!

You'll learn always to use the combination of feature branches and pull requests to have a ready-to-ship main branch. Also, sync bug fixed in a fix of fail branches back into main to avoid regression.

## Getting ready

Let's cover the principles of what we suggest:

 -  The main branch:
    
     -  The main branch is the only way to release anything to production.
     -  The main branch should always be in a ready-to-release state.
     -  Protect the main branch with branch policies.
     -  Any changes to the main branch flow through pull requests only.
     -  Tag all releases in the main branch with Git tags.
 -  The feature branch:
    
     -  Use feature branches for all new features and bug fixes.
     -  Use feature flags to manage long-running feature branches.
     -  Changes from feature branches to the main only flow through pull requests.
     -  Name your feature to reflect their purpose.
    
    List of branches:
    
    ```Cmd
    features/feature-area/feature-name
    users/username/description
    users/username/workitem
    bugfix/description
    features/feature-name
    features/feature-area/feature-name
    hotfix/description
    
    ```
 -  Pull requests:
    
     -  Review and merge code with pull requests.
     -  Automate what you inspect and validate as part of pull requests.
     -  Tracks pull request completion duration and set goals to reduce the time it takes.

We'll be using the myWebApp created in the previous exercises. In this recipe, we'll be using three trendy extensions from the marketplace:

 -  [Azure CLI](/cli/azure/install-azure-cli): is a command-line interface for Azure.
 -  Azure DevOps CLI: It's an extension for the Azure CLI for working with Azure DevOps and Azure DevOps Server. It's designed to seamlessly integrate with Git, CI pipelines, and Agile tools. With the Azure DevOps CLI, you can contribute to your projects without ever leaving the command line. CLI runs on Windows, Linux, and Mac.
 -  Git Pull Request Merge Conflict: This open-source extension created by Microsoft DevLabs allows you to review and resolve pull request merge conflicts on the web. Before a Git pull request can complete, any conflicts with the target branch must be resolved. With this extension, you can resolve these conflicts on the web as part of the pull request merge instead of doing the merge and resolving conflicts in a local clone.

The Azure DevOps CLI supports returning the query results in JSON, JSONC, table, and TSV. You can configure your preference by using the configure command.

## How to do it

1.  After you've cloned the main branch into a local repository, create a new feature branch, myFeature-1:
    
    ```Cmd
    myWebApp> git checkout -b feature/myFeature-1
    Switched to a new branch 'feature/myFeature-1'
    
    ```
2.  Run the Git branch command to see all the branches, the branch showing up with asterisk is the "currently-checked-out" branch:
    
    ```Cmd
    myWebApp> git branch * feature/myFeature-1  main
    
    ```
3.  Make a change to the Program.cs file in the feature/myFeature-1 branch:
    
    ```Cmd
    myWebApp> notepad Program.cs
    
    ```
4.  Stage your changes and commit locally, then publish your branch to remote:
    
    ```Cmd
    myWebApp> git status
    
    On branch feature/myFeature-1 Changes not staged for commit: (use "git add <file>..." to update what will be committed) (use "git checkout -- <file>..." to discard changes in working directory) modified: Program.cs
    
    ```
    
    ```Cmd
    myWebApp> git add .
    myWebApp> git commit -m "Feature 1 added to Program.cs"
    
    [feature/myFeature-1 70f67b2] feature 1 added to program.cs 1 file changed, 1 insertion(+)
    
    ```
    
    ```Cmd
    myWebApp> git push -u origin feature/myFeature-1
    
    Delta compression using up to 8 threads. Compressing objects: 100% (3/3), done. Writing objects: 100% (3/3), 348 bytes | 348.00 KiB/s, done. Total 3 (delta 2), reused 0 (delta 0) remote: Analyzing objects... (3/3) (10 ms) remote: Storing packfile... done (44 ms) remote: Storing index... done (62 ms) To http://dev.azure.com/Geeks/PartsUnlimited/_git/MyWebApp * [new branch] feature/myFeature-1 -> feature/myFeature-1 Branch feature/myFeature-1 set up to track remote branch feature/myFeature-1 from origin.
    
    ```
    
    The remote shows the history of the changes:
    
    :::image type="content" source="../media/remote-history-changes-133245b4.png" alt-text="Screenshot showing the remote history of the changes.":::
    
5.  Create a new pull request (using the Azure DevOps CLI) to review the changes in the feature-1 branch:
    
    ```Cmd
      az repos pr create --title "Review Feature-1 before merging to main" --work-items 38 39 `
              -d "#Merge feature-1 to main" `
              -s feature/myFeature-1 -t main -r myWebApp -p
      $prj -i $i
    
    ```
    
    Use the --open switch when raising the pull request to open the pull request in a web browser after it has been created. The --deletesource-branch switch can be used to delete the branch after the pull request is complete. Also, consider using --auto-complete to complete automatically when all policies have passed, and the source branch can be merged into the target branch.
    
    The team jointly reviews the code changes and approves the pull request:
    
    :::image type="content" source="../media/pr-code-changes-approved-completed-90fe3da6.png" alt-text="Screenshot showing the pull request with code changes approved and completed.":::
    
    
    The main is ready to release. Team tags main branch with the release number:
    
    :::image type="content" source="../media/create-tag-example-9a81a5d0.png" alt-text="Create a tag example.":::
    
6.  Start work on Feature 2. Create a branch on remote from the main branch and do the checkout locally:
    
    ```Cmd
    myWebApp> git push origin origin:refs/heads/feature/myFeature-2
    
    Total 0 (delta 0), reused 0 (delta 0) To https://dev.azure.com/Geeks/PartsUnlimited/_git/MyWebApp * [new branch] origin/HEAD -> refs/heads/feature/myFeature-2
    
    ```
    
    ```Cmd
    myWebApp> git checkout feature/myFeature-2
    
    Switched to a new branch 'feature/myFeature-2' Branch feature/myFeature-2 set up to track remote branch feature/myFeature-2 from origin.
    
    ```
7.  Modify Program.cs by changing the same comment line in the code that was changed in feature-1.
    
    ```
    public class Program
    {
        // Editing the same line (file from feature-2 branch)
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }
    
        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .Build();
    
    
    ```
8.  Commit the changes locally, push to the remote repository, and then raise a pull request to merge the changes from feature/myFeature-2 to the main branch:
    
    ```Cmd
      az repos pr create --title "Review Feature-2 before merging to main" --work-items 40 42 `
                -d "#Merge feature-2 to main" `
                -s feature/myFeature-2 -t main -r myWebApp -p
      $prj -i $1
    
    ```
    
    With the pull request in flight, a critical bug is reported in production against the feature-1 release. To investigate the issue, you need to debug against the version of code currently deployed in production. To investigate the issue, create a new fof branch using the release\_feature1 tag:
    
    ```Cmd
    myWebApp> git checkout -b fof/bug-1 release_feature1
    Switched to a new branch 'fof/bug-1'
    
    ```
9.  Modify Program.cs by changing the same line of code that was changed in the feature-1 release:
    
    ```
    public class Program
    {
        // Editing the same line (file from feature-FOF branch)
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }
    
        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .Build();
    
    
    ```
10. Stage and commit the changes locally, then push changes to the remote repository:
    
    ```Cmd
    myWebApp> git add .
    
    myWebApp> git commit -m "Adding FOF changes"
    
    myWebApp> git push -u origin fof/bug-1
    
    To https://dev.azure.com/Geeks/PartsUnlimited/_git/MyWebApp * [new branch] fof/bug-1 -> fof/bug-1 Branch fof/bug-1 set up to track remote branch fof/bug-1 from origin.
    
    ```
11. Immediately after the changes have been rolled out to production, tag the fof\\bug-1 branch with the release\_bug-1 tag, then raise a pull request to merge the changes from fof/bug-1 back into the main:
    
    ```Cmd
      az repos pr create --title "Review Bug-1 before merging to main" --work-items 100 `
                -d "#Merge Bug-1 to main" `
                -s fof/Bug-1 -t main -r myWebApp -p
      $prj -i $i
    
    ```
    
    As part of the pull request, the branch is deleted. However, you can still reference the entire history to that point using the tag.
    
    With the critical bug fix out of the way, let's go back to the review of the feature-2 pull request.
    
    The branches page makes it clear that the feature/myFeature-2 branch is one change ahead of the main and two changes behind the main:
    
    :::image type="content" source="../media/branches-page-352f877b.png" alt-text="Screenshot showing the branches page. The feature myFeature 2 branch is one change ahead of the main and two changes behind the main.":::
    
    
    If you tried to approve the pull request, you'd see an error message informing you of a merge conflict:
    
    :::image type="content" source="../media/merge-conflicts-pull-request-84cba5e1.png" alt-text="Screenshot showing merge conflicts from pull request.":::
    
12. The Git Pull Request Merge Conflict resolution extension makes it possible to resolve merge conflicts right in the browser. Navigate to the conflicts tab and click on Program.cs to resolve the merge conflicts:
    
    :::image type="content" source="../media/git-pr-merge-conflict-resolution-extension-0e6d8b72.png" alt-text="Screenshot from the Git pull request merge conflict resolution extension.":::
    
    
    The user interface allows you to take the source, target, or add custom changes and review and submit the merge. With the changes merged, the pull request is completed.

## How it works

We learned how the Git branching model gives you the flexibility to work on features in parallel by creating a branch for each feature.

The pull request workflow allows you to review code changes using the branch policies.

Git tags are a great way to record milestones, such as the version of code released; tags give you a way to create branches from tags.

We created a branch from a previous release tag to fix a critical bug in production.

The branches view in the web portal makes it easy to identify branches ahead of the main. Also, it forces a merge conflict if any ongoing pull requests try to merge to the main without resolving the merge conflicts.

A lean branching model, such as this, allows you to create short-lived branches and push quality changes to production faster.
