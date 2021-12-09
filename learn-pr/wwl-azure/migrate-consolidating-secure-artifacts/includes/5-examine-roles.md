Azure Artifacts has four different roles for package feeds. These are incremental in the permissions they give.

The roles are in incremental order:

 -  Reader: Can list and restore (or install) packages from the feed.
 -  Collaborator: Can save packages from upstream sources.
 -  Contributor: Can push and unlist packages in the feed.
 -  Owner: has all available permissions for a package feed.

When creating an Azure Artifacts feed, the `Project Collection Build Service` is given contributor rights by default.

This organization-wide build identity in Azure Pipelines can access the feeds it needs when running tasks.

If you changed the build identity to be at the project level, you need to give that identity permissions to access the feed.

Any contributors to the team project are also contributors to the feed.

Project Collection Administrators and administrators of the team project, plus the feed's creator, are automatically made owners of the feed.

The roles for these users and groups can be changed or removed.
