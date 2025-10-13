**Azure Artifacts** provides **granular permissions** that control what users can do with package feeds and their contents. Understanding these permissions is critical for implementing proper access control and security.

## Feed-level permissions

The feeds in Azure Artifacts require **permission** to the various features it offers. The list of **permissions** consists of increasing **privileged operations**.

### Permissions roles matrix

The list of privileges is as follows:

:::image type="content" source="../media/2-2-permissions-roles-matrix-a7c8db4f.png" alt-text="Screenshot of Permissions Roles matrix.":::

**Permission categories:**

- **Read permissions:** List and restore packages.
- **Write permissions:** Push, unlist, and promote packages.
- **Administrative permissions:** Manage feed settings and permissions.
- **Upstream permissions:** Save packages from upstream sources.

### Assigning permissions

You can assign **users**, **teams**, and **groups** to a specific **role** for each permission, giving the permissions corresponding to that role.

**Requirements:**

You need to have the **Owner role** to do so.

**Best practices:**

- **Use teams:** Assign permissions to teams rather than individual users for easier management.
- **Azure AD groups:** Leverage Azure Active Directory groups for organization-wide permission management.
- **Service principals:** Use service principals for automated systems and CI/CD pipelines.

### Feed users

Once an account has access to the feed from the permission to list and restore packages, it's considered a **Feed user**.

**Feed user definition:**

- **Minimum permission:** Any user with at least Reader role.
- **Access scope:** Can view and consume packages from the feed.
- **Visibility:** Shown in the feed permissions list.

:::image type="content" source="../media/2-2-feed-permissions-d556816e.png" alt-text="Screenshot of Feed Permissions.":::

## View-level permissions

Like permissions and roles for the feed itself, there are extra **permissions** for access to the individual **views**.

### Default views

Any **feed user** has access to all the views, whether the default views of **@Local**, **@Release**, **@Prerelease** or newly created ones.

**View types:**

- **@Local:** Contains all packages published directly to the feed and packages saved from upstream sources.
- **@Release:** Contains packages that have been promoted to the Release view, indicating they're production-ready.
- **@Prerelease:** Contains pre-release versions for testing and validation before promoting to Release.

**View access:**

- **Automatic access:** Feed users automatically have access to all views.
- **No view-specific permissions:** Views don't have separate permission settings.
- **Promotion control:** Use roles to control who can promote packages between views.

### Custom views

**Creating custom views:**

- **Purpose-specific:** Create views for different stages (development, staging, production).
- **Naming conventions:** Use descriptive names like @Development, @QA, @Production.
- **Promotion workflow:** Define promotion paths between views.

## Feed visibility

When creating a feed, you can choose whether the feed is **visible** to people in your Azure DevOps organization or only specific people.

:::image type="content" source="../media/2-2-feed-visibility-653a1c98.png" alt-text="Screenshot of Feed visibility.":::

### Visibility options

**Organization visibility:**

- **Description:** Feed is visible to everyone in your Azure DevOps organization.
- **Discovery:** Users can see the feed exists, even if they don't have access to packages.
- **Use case:** Internal shared libraries used across multiple projects.

**Project visibility:**

- **Description:** Feed is visible only to members of a specific project.
- **Scope:** Limited to project team members.
- **Use case:** Project-specific packages not relevant to other teams.

**Private visibility:**

- **Description:** Feed is visible only to users, teams, and groups explicitly granted permissions.
- **Restricted discovery:** Users outside the permission list can't see the feed exists.
- **Use case:** Sensitive or proprietary packages requiring strict access control.

## Granular permission operations

### List and restore packages

**Permission:** Reader role and above.

**Operations:**

- **List packages:** View available packages and their metadata.
- **Restore/install packages:** Download packages for use in projects.
- **View versions:** See all available versions of packages.
- **Read metadata:** Access package descriptions, dependencies, and release notes.

### Save packages from upstream

**Permission:** Collaborator role and above.

**Operations:**

- **Cache upstream packages:** Save packages from public registries to your feed.
- **Ensure availability:** Make packages available even if upstream source is unavailable.
- **Version pinning:** Lock specific versions from upstream sources.

### Push and unlist packages

**Permission:** Contributor role and above.

**Operations:**

- **Push packages:** Publish new packages or versions to the feed.
- **Unlist packages:** Hide specific versions from search results without deleting.
- **Promote packages:** Move packages between views (@Prerelease → @Release).
- **Deprecate packages:** Mark packages as deprecated.

### Delete/unpublish packages

**Permission:** Contributor role and above (may be restricted by feed settings).

**Operations:**

- **Delete packages:** Permanently remove package versions.
- **Unpublish:** Remove packages from the feed entirely.
- **Recycle bin:** Deleted packages may be recoverable for a period.

**Best practice:**

**Unlisting** is preferred over deletion to maintain version history and prevent breaking builds that reference specific versions.

### Edit feed

**Permission:** Owner role only.

**Operations:**

- **Change feed settings:** Modify retention policies, upstream sources, and views.
- **Rename feed:** Change the feed name (affects package URLs).
- **Delete feed:** Permanently remove the feed and all packages.
- **Configure retention:** Set how long to keep old package versions.

### Administer permissions

**Permission:** Owner role only.

**Operations:**

- **Add users/teams/groups:** Grant access to the feed.
- **Assign roles:** Set Reader, Collaborator, Contributor, or Owner roles.
- **Remove access:** Revoke permissions from users or groups.
- **View audit logs:** Review permission changes and access history.

## Permission best practices

### Principle of least privilege

**Start restrictive:**

- **Default to Reader:** Grant read-only access by default.
- **Elevate as needed:** Promote to higher roles only when justified.
- **Regular reviews:** Periodically audit and reduce unnecessary permissions.

### Separation of concerns

**Different feeds for different purposes:**

- **Development feed:** Contributors can push frequently.
- **Production feed:** Only automated pipelines can push after approvals.
- **Shared libraries feed:** Tightly controlled with limited contributors.

### Automated systems

**Service principals for CI/CD:**

- **Build pipelines:** Use service principal with Contributor role to publish packages.
- **Deployment pipelines:** Use service principal with Reader role to consume packages.
- **Token management:** Rotate Personal Access Tokens regularly.

### Permission inheritance

**Leverage Azure DevOps groups:**

- **Project contributors:** Automatically inherit Contributor role on project feeds.
- **Administrators:** Automatically get Owner role.
- **Override when needed:** Remove default assignments for more restrictive access.

## Managing permissions

### In Azure DevOps portal

1.  **Navigate to feed:** Go to Artifacts and select your feed.
2.  **Feed settings:** Click the gear icon to access settings.
3.  **Permissions tab:** Select the Permissions section.
4.  **Add permissions:** Click "Add users/groups" and search for users, teams, or groups.
5.  **Select role:** Choose the appropriate role from the dropdown.
6.  **Save changes:** Confirm the permission assignment.

### Using Azure CLI

```bash
# Grant user Contributor permission
az artifacts feed permission add --feed <feed-name> --role contributor --user <user-email>

# Remove user permission
az artifacts feed permission remove --feed <feed-name> --user <user-email>

# List all permissions
az artifacts feed permission list --feed <feed-name>
```

### Using REST API

**Programmatic management:**

Use the Azure DevOps REST API for automated permission management in large organizations.

```http
POST https://feeds.dev.azure.com/{organization}/_apis/packaging/Feeds/{feedId}/permissions?api-version=7.0
```

## Monitoring and auditing

### Permission changes

**Track modifications:**

- **Audit logs:** Azure DevOps logs all permission changes.
- **Change notifications:** Configure alerts for permission modifications.
- **Compliance reports:** Generate reports for security audits.

### Access patterns

**Monitor usage:**

- **Package downloads:** Track which users download which packages.
- **Publish operations:** Monitor who publishes packages and when.
- **Failed access attempts:** Alert on unauthorized access attempts.

See also: [Secure and share packages using feed permissions](/azure/devops/artifacts/feeds/feed-permissions).
