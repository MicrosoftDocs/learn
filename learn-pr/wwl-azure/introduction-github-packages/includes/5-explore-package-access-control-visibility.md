**Access control and visibility** settings determine who can view, download, and manage your packages in GitHub Packages. Understanding these settings is crucial for **security**, **compliance**, and **collaboration**.

## Understanding permission models

**GitHub Packages** supports **two permission models** depending on the package type:

### Repository-inherited permissions

**Most package registries** (npm, NuGet, Maven, RubyGems, Gradle) inherit permissions from their repository:

- **Same access control:** Package permissions match repository permissions
- **Simplified management:** One set of permissions for both code and packages
- **Automatic updates:** Permission changes to repository automatically apply to packages
- **Team-based access:** Repository teams and collaborators have package access

**Pros and cons:**

- **Pro:** Simple and consistent with repository access
- **Pro:** No additional permission configuration needed
- **Con:** Cannot separate code access from package access
- **Con:** All repository collaborators can publish packages

### Granular permissions (Container registry only)

**Container registry packages** support **independent access control**:

- **Separate from repository:** Package permissions can differ from repository
- **User-scoped:** Grant access to individual users
- **Organization-scoped:** Grant access to teams within organizations
- **Role-based:** Assign read, write, or admin roles independently

**Pros and cons:**

- **Pro:** Fine-grained control over package access
- **Pro:** Can share packages without sharing code
- **Con:** More complex permission management
- **Con:** Only available for container images

> [!IMPORTANT]
> You can **change package access control and visibility separately** from the repository for container registry packages. For other package types, visibility and access are tied to the repository.

For more information about permissions, see [About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages).

## Package visibility options

**Visibility** determines who can discover and access your packages:

### Public packages

- **Anyone can discover:** Package appears in search results for all users
- **Anyone can download:** No authentication required to install (but authentication required for uploads)
- **Open source friendly:** Ideal for community libraries and tools
- **Free storage:** No storage or bandwidth limits for public packages
- **Usage tracking:** Download statistics visible to everyone

**Use cases for public packages:**

- Open-source libraries and frameworks
- Community tools and utilities
- Public API clients and SDKs
- Educational examples and templates

### Private packages

- **Organization/user only:** Only authenticated users with permission can discover
- **Access controlled:** Must have read permission to download
- **Secure by default:** Ideal for internal libraries and proprietary code
- **Usage limits:** Subject to GitHub plan storage and bandwidth limits
- **Usage tracking:** Statistics visible only to authorized users

**Use cases for private packages:**

- Internal company libraries
- Proprietary dependencies
- Pre-release versions
- Client-specific customizations

### Internal packages (GitHub Enterprise only)

- **Organization-wide access:** All organization members can discover and download
- **Simplified sharing:** No individual permission grants needed
- **Enterprise feature:** Available only with GitHub Enterprise Cloud or Server
- **Balanced security:** More accessible than private, more secure than public

**Use cases for internal packages:**

- Shared organizational libraries
- Cross-team dependencies
- Internal standards and frameworks
- Common utilities and helpers

## Container image permissions

If you have **admin permissions** to a container image, you can configure **granular access control**:

### Setting visibility

- **Public visibility:** Anyone can pull the container image without authentication
- **Private visibility:** Only users with explicit permissions can pull the image

### Granting access permissions

**Personal account containers:**

- Grant **any GitHub user** an access role
- Specify **individual permissions** for each user
- Manage access **independently** from repository

**Organization containers:**

- Grant access to **any person** in the organization
- Grant access to **any team** in the organization
- Combine **individual and team** permissions
- Inherit permissions from **organization membership**

### Permission roles

| **Permission** | **Access description**                                                                                                     |
| -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **read**       | Can download the package. Can read package metadata.                                                                       |
| **write**      | Can upload and download this package. Can read and write package metadata.                                                 |
| **admin**      | Can upload, download, delete, and manage this package. Can read and write package metadata. Can grant package permissions. |

**Permission inheritance:**

- **Admin role:** Includes all write and read permissions
- **Write role:** Includes all read permissions
- **Read role:** Minimum permissions for consuming packages

### Configuring access

To configure **access control and visibility** for container images:

1. Navigate to the **package page**
2. Click **Package settings**
3. Under **Danger Zone**, change **visibility** (public/private)
4. Under **Manage access**, add **users or teams**
5. Select **role** for each user or team (read, write, admin)
6. Click **Add** to grant permissions

For more information, see [Configuring a package's access control and visibility](https://docs.github.com/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility).

## Best practices for access control

**Security recommendations:**

- **Principle of least privilege:** Grant minimum necessary permissions
- **Regular audits:** Review and remove unnecessary access periodically
- **Team-based access:** Use teams instead of individual users when possible
- **Public carefully:** Ensure public packages don't expose sensitive information
- **Document access:** Maintain records of who has access and why
- **Automate reviews:** Use tools to detect permission changes

**Organizational strategies:**

- **Standardize visibility:** Establish defaults for different package types
- **Access request process:** Define how users request package access
- **Ownership clarity:** Assign clear ownership for package management
- **Integration with SSO:** Use SAML/SCIM for centralized access management
- **Compliance alignment:** Ensure access controls meet regulatory requirements
