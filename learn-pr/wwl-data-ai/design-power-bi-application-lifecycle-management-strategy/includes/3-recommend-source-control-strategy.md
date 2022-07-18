Source control is invaluable to development in an enterprise, as it can be tricky maintaining multiple copies and versions of the same base code across multiple developers. By definition, source control is a system to store files and track changes. Some systems also offer version control as well. For Power BI, the same problems exist with datasets and reports, and therefore finding a source control solution for Power BI will help your organization reduce management overhead.

## Consider the options

You can use OneDrive for Business, SharePoint, or Git for Power BI source control. If your organization is already using one of these tools, consider who your primary Power BI users are, and which tool would be the easiest to adopt. Power BI is meant to be low- to no-code, meaning your users they probably are familiar with OneDrive or SharePoint and the traditional folder structure, but may not be comfortable navigating a Git repository - a distributed system focused on branching.

If your organization develops datasets and reports through Power BI Desktop using only the .PBIX files, then using OneDrive or SharePoint is the easiest implementation. If are you also leveraging Tabular Editor or Visual Studio to create .BIM files, then you can use a Git solution for the .BIM files. You can also use Git for .BIM files, and OneDrive or SharePoint for .PBIX file tracking, although that may be more complex.

Keep in mind, there's not one solution for every project. Maybe your HR department reports are designed by HR employees, and they only work with .PBIX files and OneDrive is the easiest solution, whereas Engineering has dedicated dataset developers creating .BIM files in Git repositories and .PBIX files in SharePoint.

## Implement file version tracking with OneDrive

Version tracking simply allows you to restore a previous version if the most recent copy overwrites or removes elements you wish to keep. Using OneDrive allows team collaboration and file version tracking, however what happens if multiple people update the same file and there is a conflict? You will have to manually merge changes into the current or previous copy. You could leverage SharePoint to check files out and in to prevent such conflict among team members, but this is still manual and requires process and training.

## Use Git for source control

Git is a traditional distributed repository system with push, pull, merge, and branching options. Developers pull down a copy to make their edits, then push changes, and finally changes are merged. When you have multiple developers working on a dataset, Git allows a simple way to incorporate changes when you are using .BIM files for datasets. There are several different products that leverage Git, such as Git and Azure DevOps.

However, since Power BI reports are binary files, you can't track changes within the file and Git for .PBIX files is not ideal. If you have large files, using Git can significantly increase your repository size, even if you leverage the large-file storage (LFS) option.

## Best practices

Do not leverage the Power BI service workspace for .PBIX file source control. You cannot track versions, and if someone overwrites the workspace copy, you will need to determine who has the most accurate copy and upload again.

Choose the best solution for each project:

* If only developing .PBIX files, use OneDrive or SharePoint to maintain a single source for files and version tracking.
* If developing .PBIX and .BIM files, still use OneDrive or SharePoint for .PBIX files, and use Git for .BIM files.
* If using dataflows or datamarts, these can only be managed in Power BI service with deployment pipelines, which will discuss next.

If using Git, determine if changes can be merged to the main branch automatically, or if changes need review and approval beforehand.

> [!TIP]
> Review [Git branching guidance](/azure/devops/repos/git/git-branching-guidance?view=azure-devops) for more detailed explanation of Git repository design strategies.

Regardless of your choices, deciding on an organizational process for development is invaluable. In the next unit we will discuss Deployment Pipelines, which help when deploying through Dev, Test, and Prod workspaces, per application lifecycle management (ALM).
