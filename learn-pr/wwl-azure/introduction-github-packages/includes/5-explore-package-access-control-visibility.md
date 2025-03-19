You can only use granular permissions with the Container registry (scoped to a personal user or organization account). GitHub.com doesn't support granular permissions in other package registries, like the npm registry.

You can change the package access control and visibility separately from the repository.

For more information about permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages)".

## Container images visibility and access permissions

If you have admin permissions to a container image, you can set the access permissions for the container image to private or public.

As an admin, you can also grant access permissions for a container image separate from your set permissions at the organization and repository levels.

You can give any person an access role for container images published and owned by a personal account.

For container images published and owned by an organization, you can provide any person or team in the organization an access role.

| **Permission** | **Access description**                                                                                                     |
| -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| read           | Can download the package. Can read package metadata.                                                                       |
| write          | Can upload and download this package. Can read and write package metadata.                                                 |
| admin          | Can upload, download, delete, and manage this package. Can read and write package metadata. Can grant package permissions. |

For more information about the package's access control and visibility configuration, see [Configuring a package's access control and visibility - GitHub Docs](https://docs.github.com/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility).
