**Azure Artifacts** provides a **role-based access control** (RBAC) model that defines who can perform specific actions on package feeds and packages. Understanding these roles is essential for implementing proper security and access control.

## The four Azure Artifacts roles

Azure Artifacts has four different **roles** for package feeds. These are **incremental** in the **permissions** they give.

### Role hierarchy

The roles are in incremental order:

- **Reader:** Can list and restore (or install) packages from the feed.
- **Collaborator:** Can save packages from upstream sources.
- **Contributor:** Can push and unlist packages in the feed.
- **Owner:** Has all available permissions for a package feed.

**Permission inheritance:**

- **Reader → Collaborator → Contributor → Owner**
- Each level adds more permissions while retaining all permissions from lower levels.
- This **incremental model** simplifies role management.

## Role definitions

### Reader

**Can list and restore (or install) packages from the feed.**

**Specific permissions:**

- **List packages:** View all packages in the feed.
- **Restore packages:** Download and install packages.
- **View package metadata:** Read package descriptions, versions, and dependencies.
- **View feed details:** See feed settings and configuration.

**Common use cases:**

- **Developers:** Who only need to consume packages from the feed.
- **Build agents:** That download packages during builds.
- **Teams:** That use packages but don't need to publish.
- **External partners:** With limited access to specific packages.

**When to assign:**

Assign the **Reader** role when users only need to consume packages, not modify them. This is the default role for most organization members.

### Collaborator

**Can save packages from upstream sources.**

**Specific permissions:**

- **All Reader permissions:** Can list and restore packages.
- **Save packages from upstream:** Can save packages from public registries (npmjs.com, NuGet.org, etc.) to your feed.
- **Cache packages:** Store copies of upstream packages in your feed for offline access.

**Common use cases:**

- **Build services:** The Project Collection Build Service that needs to cache upstream packages.
- **Developers:** Who work with upstream sources and want to ensure package availability.
- **Automated systems:** That populate feeds with external packages.

**When to assign:**

Assign the **Collaborator** role when you use **upstream sources** and need users or services to cache packages from external registries. This role was added specifically to support the upstream sources functionality.

### Contributor

**Can push and unlist packages in the feed.**

**Specific permissions:**

- **All Collaborator permissions:** Can list, restore, and save packages.
- **Push packages:** Publish new packages to the feed.
- **Unlist packages:** Hide specific package versions from search results.
- **Promote packages:** Move packages between views (e.g., from Prerelease to Release).
- **Delete packages:** Remove packages from the feed (may be restricted by feed settings).

**Common use cases:**

- **Package maintainers:** Who create and publish packages.
- **Build pipelines:** Automated builds that publish packages.
- **Development teams:** With authority to publish packages for their projects.

**When to assign:**

Assign the **Contributor** role to users and service principals that need to publish packages to your feed. This is appropriate for developers on teams that own specific packages.

**Security considerations:**

- **Package integrity:** Contributors can publish packages, so ensure they're trusted.
- **Version management:** Contributors can unlist but typically not delete packages.
- **Review workflows:** Consider implementing manual reviews before publishing to production feeds.

### Owner

**Has all available permissions for a package feed.**

**Specific permissions:**

- **All Contributor permissions:** Can list, restore, save, push, and unlist packages.
- **Manage feed settings:** Configure feed settings, upstream sources, views, and retention policies.
- **Manage permissions:** Add or remove users, assign roles, and modify access control.
- **Delete feed:** Remove the entire feed.
- **Edit feed details:** Change feed name, description, and visibility.

**Common use cases:**

- **Feed administrators:** Responsible for feed configuration and management.
- **Project administrators:** Who oversee all aspects of package management.
- **DevOps engineers:** Managing feed infrastructure.

**When to assign:**

Assign the **Owner** role sparingly to users who need full administrative control over the feed. Typically, this should be limited to a small number of trusted administrators.

**Security considerations:**

- **Principle of least privilege:** Only assign Owner role when necessary.
- **Multiple owners:** Ensure multiple owners to prevent single points of failure.
- **Audit trails:** Monitor owner actions for compliance.

## Default role assignments

When creating an **Azure Artifacts feed**, default roles are automatically assigned to several identities.

### Project Collection Build Service

When creating an Azure Artifacts feed, the **Project Collection Build Service** is given **Contributor rights** by default.

**Build identity:**

This **organization-wide build identity** in Azure Pipelines can access the feeds it needs when running tasks.

**Project-level build identity:**

If you changed the **build identity** to be at the **project level**, you need to give that identity permissions to access the feed.

**Best practice:**

For publishing packages from builds, consider using a **service principal** or **Personal Access Token** with appropriate permissions rather than relying solely on the build service identity.

### Team project contributors

Any **contributors** to the team project are also **contributors** to the feed.

**Automatic inheritance:**

- **Project role mapping:** Project contributors automatically get Contributor role on feeds.
- **Convenience:** Simplifies permission management for development teams.
- **Override capability:** Can be changed if more restrictive access is needed.

### Project Collection Administrators

**Project Collection Administrators** and **administrators** of the team project, plus the **feed's creator**, are automatically made **owners** of the feed.

**Administrative access:**

- **Full control:** Administrators have complete control over feed settings.
- **Multiple owners:** Ensures administrative continuity.
- **Feed creator:** The user who created the feed gets Owner role.

### Modifying default assignments

The roles for these users and groups can be **changed or removed**.

**Customization options:**

- **Remove default assignments:** If the automatic assignments don't match your security requirements.
- **Change roles:** Downgrade or upgrade roles as needed.
- **Add custom permissions:** Grant access to additional users, teams, or groups.

## Role assignment best practices

### Principle of least privilege

**Grant minimum necessary permissions:**

- Start with **Reader** for everyone.
- Elevate to **Collaborator** only if using upstream sources.
- Assign **Contributor** to package publishers.
- Limit **Owner** to feed administrators.

### Team-based assignments

**Use teams instead of individual users:**

- **Scalability:** Manage permissions for groups, not individuals.
- **Maintainability:** Add/remove users from teams, not feeds.
- **Clarity:** Team names indicate the purpose of access.

### Service principal access

**For automated systems:**

- **Build pipelines:** Use service principals with **Contributor** role.
- **Deployment pipelines:** Use service principals with **Reader** role.
- **Upstream caching:** Use service principals with **Collaborator** role.

### Regular access reviews

**Periodically review role assignments:**

- **Remove stale access:** When users change roles or leave.
- **Verify necessity:** Ensure users still need their assigned roles.
- **Audit compliance:** Document access reviews for compliance.

## Role comparison table

| Role             | List & Restore | Save from Upstream | Push & Unlist | Manage Feed |
| ---------------- | -------------- | ------------------ | ------------- | ----------- |
| **Reader**       | ✓              | ✗                  | ✗             | ✗           |
| **Collaborator** | ✓              | ✓                  | ✗             | ✗           |
| **Contributor**  | ✓              | ✓                  | ✓             | ✗           |
| **Owner**        | ✓              | ✓                  | ✓             | ✓           |

## Changing role assignments

### In the Azure DevOps web portal

1.  **Navigate to Artifacts:** Select your feed.
2.  **Feed settings:** Click the gear icon for settings.
3.  **Permissions:** Select the Permissions tab.
4.  **Add users:** Click "Add users/groups" and select users, teams, or groups.
5.  **Assign role:** Choose the appropriate role from the dropdown.
6.  **Save:** Confirm the changes.

### Using Azure CLI

```bash
# Add user to feed with Contributor role
az artifacts feed permission add --feed <feed-name> --role contributor --user <user-email>
```

### Using REST API

Use the **Azure DevOps REST API** to programmatically manage role assignments for automation scenarios.
