## Migrating the tip

Most teams wish they could reorganize their source control structure.

Typically, the structure the team is using today was set up by a well-meaning developer a decade ago, but it is not optimal.

Migrating to Git could be an excellent opportunity to restructure your repo.

In this case, it probably does not make sense to migrate history anyway since you are going to restructure the code (or break the code into multiple repos).

The process is simple:

 -  Create an empty Git repo (or multiple empty repos).
 -  Get-latest from TFS.
 -  Copy/reorganize the code into the empty Git repos.
 -  Commit and push, and you are there!

If you have shared code, you need to create builds of the shared code to publish to a package feed. And then consume those packages in downstream applications, but the Git part is straightforward.

## Single branch import

If you are on TFVC and in Azure DevOps, you have the option of a simple single-branch import. Click on the Import repository from the Azure Repos top-level drop-down menu to open the dialog. Then enter the path to the branch you are migrating to (yes, you can only choose one branch). Select if you want history or not (up to 180 days). Add in a name for the repo, and the import will be triggered.

## Import repository

Import repository also allows you to import a git repository. It is beneficial to move your git repositories from GitHub or any other public or private hosting spaces into Azure Repos.

:::image type="content" source="../media/image-8e79d252-e94e-4ef8-97ca-94d105a3b260-dae00d71-6a59c9ac-c9918a69.png" alt-text="Screenshot of the PartsUnlimited Import Repository menu selection.":::


There are some limitations here (that apply only when migrating source type TFVC): a single branch and only 180 days of history.

However, if you only care about one branch and are already in Azure DevOps, it is an effortless but effective way to migrate.
