Source control is invaluable to development in an enterprise, as it can be tricky maintaining multiple copies and versions of the same base code across multiple developers. By definition, source control is a system to store files and track changes. Some systems also offer version control as well. For Power BI, the same problems exist with datasets and reports, and therefore finding a source control solution for Power BI will help your organization reduce management overhead.

## Consider the options

TO source control Power BI asses, you can use OneDrive for Business, SharePoint, or Git. If your organization is already using one of these tools, consider who your primary Power BI users are, and which tool would be the easiest to adopt. Power BI is meant to be low- to no-code, meaning your users are probably familiar with the traditional folder structure of OneDrive or SharePoint, but may not be comfortable navigating a Git repository.

If your organization develops datasets and reports through Power BI Desktop using only the .pbix files, then using OneDrive or SharePoint is the easiest implementation. If you also use Tabular Editor or Visual Studio to create .bim files, then you can use a Git solution for the .bim files. You can also use Git for .bim files, and OneDrive or SharePoint for .pbix file tracking, although that may be more complex.

Keep in mind, there's not one solution for every project. Maybe your HR department reports are designed by HR employees, and they only work with .pbix files and OneDrive is the easiest solution. Whereas Engineering has dedicated dataset developers creating .bim files in Git repositories and .pbix files in SharePoint.

## Implement file version tracking with OneDrive

Version tracking simply allows you to restore a previous version if the most recent copy overwrites or removes elements you wish to keep. Using OneDrive allows team collaboration and file version tracking, however what happens if multiple people update the same file and there's a conflict? You'll have to manually merge changes into the current or previous copy. You could use SharePoint to check files out and in to prevent such conflict among team members, but it's still manual and requires process and training.

## Use Git for source control

Git is a traditional distributed repository system with push, pull, merge, and branching options. Developers pull down a copy to make their edits, then push changes, and finally changes are merged. When you have multiple developers working on a dataset, Git allows a simple way to incorporate changes when you're using .bim files for datasets. There are several different products that use Git, such as GitHub and Azure DevOps.

However, since Power BI reports are binary files, you can't track changes within the file and Git for .pbix files isn't ideal. If you have large files, using Git can significantly increase your repository size, even if you apply the large-file storage (LFS) option.

## Best practices

Don't use the Power BI service workspace for .pbix file source control. You can't track versions, and if someone overwrites the workspace copy, you'll need to determine most accurate copy and upload again.

Choose the best solution for each project:

* If only developing .pbix files, use OneDrive or SharePoint to maintain a single source for files and version tracking.
* If developing .pbix and .bim files, still use OneDrive or SharePoint for .pbix files, and use Git for .bim files.
* If using dataflows or datamarts, you can only manage in Power BI service with deployment pipelines, which will discuss next.

If using Git, determine if changes can be merged to the main branch automatically, or if changes need review and approval beforehand.

> [!TIP]
> Review [Git branching guidance](/azure/devops/repos/git/git-branching-guidance) for more detailed explanation of Git repository design strategies.

Regardless of your choices, deciding on an organizational process for development is invaluable. In the next module we'll discuss deployment pipelines, which help when deploying through development, test, and production workspaces, per application lifecycle management (ALM).
