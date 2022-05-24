You can delete it on GitHub if you have the required access:

 -  An entire private package.
 -  If there aren't more than 5000 downloads of any version of the package, an entire public package.
 -  A specific version of a private package.
 -  A specific version of a public package if the package version doesn't have more than 5000 downloads.

For packages that inherit their access permissions from repositories, you can delete a package if you have admin permissions to the repository.

You can also restore an entire package or package version, if:

 -  You restore the package within 30 days of its deletion.
 -  The same package namespace is still available and not used for a new package.

You can use the REST API to manage your packages. For more information, see the "[GitHub Packages API](https://docs.github.com/rest/reference/packages)".

## Deleting a package version

You can delete a package version:

 -  Deleting a version of a repository-scoped package on GitHub.
 -  Deleting a version of a repository-scoped package with GraphQL.
 -  Deleting a version of a user-scoped package on GitHub.
 -  Deleting a version of an organization-scoped package on GitHub.

To delete a version of a repository-scoped package, you must have admin permissions to the repository that owns the package.

1.  On GitHub.com, navigate to the main page of the repository.
2.  To the right of the list of files, click Packages.
3.  Search for and select your package.
4.  In the top right of your package's landing page, click Package settings.
5.  On the left, click Manage versions.
6.  To the right of the version you want to delete, click and select Delete version.
7.  To confirm the deletion, type the package name and click I understand the consequences, delete this version.

## Deleting an entire package

You can delete a package version:

 -  Deleting an entire repository-scoped package on GitHub.
 -  Deleting an entire user-scoped package on GitHub.
 -  Deleting an entire organization-scoped package on GitHub.

To delete an entire repository-scoped package, you must have admin permissions to the repository that owns the package.

1.  On GitHub.com, navigate to the main page of the repository.
2.  To the right of the list of files, click Packages.
3.  Search for and select your package.
4.  In the top right of your package's landing page, click Package settings.
5.  Under "Danger Zone," click Delete this package.
6.  Review the confirmation message, enter your package name, click I understand, and delete this package.

## Restoring a package version

You can restore a package version from your package's landing page.

1.  Navigate to your package's landing page.
2.  On the right, click Package settings.
3.  On the left, click Manage versions.
4.  Use the "Versions" drop-down menu and select Deleted on the top right.
5.  Next to the deleted package version you want to restore, click Restore.
6.  To confirm, click I understand the consequences, restore this version.

For more information, see:

 -  [Deleting and restoring a package - GitHub Docs](https://docs.github.com/packages/learn-github-packages/deleting-and-restoring-a-package).
 -  [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry).
 -  [Working with the NuGet registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry).
 -  [Working with the npm registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-npm-registry).
 -  [Required permissions](https://docs.github.com/packages/learn-github-packages/deleting-and-restoring-a-package).
