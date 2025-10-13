**Deleting and restoring packages** in GitHub Packages allows you to manage package lifecycle, remove outdated versions, and recover accidentally deleted packages. Understanding deletion rules and restoration procedures is essential for **package governance**.

## Understanding deletion permissions

You can **delete packages** from GitHub if you have the **required access permissions**:

### What you can delete

**Private packages:**

- **Entire private package:** Delete all versions at once
- **Specific version:** Remove individual versions selectively

**Public packages (with restrictions):**

- **Entire public package:** Only if there aren't more than **5,000 downloads** of any version
- **Specific version:** Only if that version doesn't have more than **5,000 downloads**

### Required permissions

**Repository-scoped packages:**

- **Admin permissions:** You must have admin access to the repository that owns the package
- **Inherited permissions:** Package permissions follow repository access control

**User or organization-scoped packages (Container registry):**

- **Package admin role:** Direct admin access to the package
- **Organization owner:** Full access to all organization packages

> [!IMPORTANT]
> The **5,000 download limit** for public packages is a safety measure to prevent breaking widely-used packages. Once a package exceeds this threshold, deletion is disabled to protect consumers.

## Restoration requirements

You can **restore deleted packages** under specific conditions:

### Restoration conditions

- **30-day window:** You must restore the package **within 30 days** of its deletion
- **Namespace availability:** The same package namespace must still be **available** and not used for a new package
- **Permissions retained:** You still have the necessary permissions to access the package

**When restoration isn't possible:**

- More than 30 days have passed since deletion
- A new package with the same name has been published
- You no longer have access permissions to the original package
- The repository or organization has been deleted

## Using the REST API

You can use the **GitHub REST API** to **programmatically** manage packages:

**API capabilities:**

- **List packages:** Get all packages for a user or organization
- **Get package details:** Retrieve metadata for a specific package
- **Delete package version:** Remove a specific version
- **Delete entire package:** Remove all versions
- **Restore package version:** Recover a deleted version
- **List package versions:** View all available versions

For more information, see the [GitHub Packages API](https://docs.github.com/rest/reference/packages).

### Example API usage

**Delete a package version:**

```bash
curl -X DELETE \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  https://api.github.com/user/packages/npm/PACKAGE_NAME/versions/VERSION_ID
```

**Restore a package version:**

```bash
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  https://api.github.com/user/packages/npm/PACKAGE_NAME/versions/VERSION_ID/restore
```

## Deleting a package version

You can delete **individual versions** of a package while keeping other versions available. This is useful for removing broken, vulnerable, or outdated versions.

### Deletion scope options

**Package versions can be deleted in different scopes:**

- **Repository-scoped package on GitHub:** Use web interface for packages linked to repositories
- **Repository-scoped package with GraphQL:** Use API for programmatic deletion
- **User-scoped package on GitHub:** Delete from your personal account
- **Organization-scoped package on GitHub:** Delete from organization packages

### Deleting via web interface

To delete a version of a **repository-scoped package**:

**Step 1: Navigate to package**

1. On **GitHub.com**, navigate to the **main page** of the repository
2. To the right of the list of files, click **Packages**
3. Search for and **select your package**

**Step 2: Access version management**

4. In the top right of your package's landing page, click **Package settings**
5. On the left sidebar, click **Manage versions**

**Step 3: Delete version**

6. To the right of the version you want to delete, click the **⋯** menu and select **Delete version**
7. To confirm the deletion, type the **package name** and click **I understand the consequences, delete this version**

> [!WARNING]
> Deletion is **permanent** after the 30-day restoration window. Make sure you have the correct version before confirming.

### Best practices for version deletion

**Before deleting a version:**

- **Check dependencies:** Verify no active projects depend on this version
- **Notify consumers:** Announce deprecation before deletion
- **Document reason:** Add comments explaining why the version was removed
- **Keep alternatives:** Ensure a replacement version is available
- **Archive information:** Save release notes and documentation externally

## Deleting an entire package

You can delete **all versions** of a package at once. This completely removes the package from GitHub Packages.

### Deletion scope options

**Entire packages can be deleted in different scopes:**

- **Repository-scoped package on GitHub:** Delete from repository packages
- **User-scoped package on GitHub:** Delete from personal account
- **Organization-scoped package on GitHub:** Delete from organization packages

### Deleting via web interface

To delete an **entire repository-scoped package**:

**Step 1: Navigate to package**

1. On **GitHub.com**, navigate to the **main page** of the repository
2. To the right of the list of files, click **Packages**
3. Search for and **select your package**

**Step 2: Access package settings**

4. In the top right of your package's landing page, click **Package settings**

**Step 3: Delete package**

5. Scroll down to the **Danger Zone** section
6. Click **Delete this package**
7. Review the confirmation message carefully
8. Enter your **package name** to confirm
9. Click **I understand, delete this package**

> [!CAUTION]
> Deleting an entire package removes **all versions** and **all metadata**. This action is **irreversible** after 30 days. Consumers depending on this package will experience broken builds.

### When to delete entire packages

**Appropriate scenarios:**

- **Abandoned project:** Package is no longer maintained or needed
- **Replaced by alternative:** New package supersedes the old one
- **Security issue:** Package contains unfixable vulnerabilities
- **Compliance requirement:** Legal or regulatory reasons
- **Wrong repository:** Package was published to incorrect location

**Alternatives to deletion:**

- **Deprecation notice:** Mark package as deprecated without deleting
- **Archive repository:** Preserve package but signal end-of-life
- **Private visibility:** Change to private instead of deleting
- **Documentation update:** Add warnings about not using the package

## Restoring a package version

You can **restore deleted packages** within the **30-day** restoration window. This allows you to recover from accidental deletions.

### Restoration procedure

To restore a **deleted package version**:

**Step 1: Navigate to package**

1. Navigate to your **package's landing page**
2. On the right, click **Package settings**

**Step 2: Find deleted versions**

3. On the left sidebar, click **Manage versions**
4. Use the **Versions** drop-down menu on the top right
5. Select **Deleted** to show only deleted versions

**Step 3: Restore version**

6. Next to the deleted package version you want to restore, click **Restore**
7. To confirm, click **I understand the consequences, restore this version**

> [!TIP]
> Restored packages return to the same visibility settings they had before deletion (public, private, or internal).

### Restoration scenarios

**Common restoration use cases:**

- **Accidental deletion:** Restore version deleted by mistake
- **Dependency recovery:** Consumer needs a previously deleted version
- **Rollback decision:** Decided not to remove version after all
- **Testing purposes:** Need old version for comparison testing
- **Compliance requirement:** Must retain historical versions

### Post-restoration steps

**After restoring a package:**

1. **Verify functionality:** Test that restored package works correctly
2. **Update documentation:** Add notes about deletion and restoration
3. **Notify consumers:** Inform users the package is available again
4. **Review permissions:** Ensure access controls are still appropriate
5. **Consider alternatives:** Evaluate if deletion was the right approach

## Package lifecycle management

**Best practices for package management:**

- **Deprecation first:** Mark versions as deprecated before deleting
- **Communication plan:** Notify consumers well in advance
- **Grace period:** Allow time for consumers to migrate
- **Version retention:** Keep minimum viable versions available
- **Audit trail:** Document all deletion decisions
- **Automated cleanup:** Use policies to remove old versions systematically

## Additional resources

For more information, see:

- [Deleting and restoring a package - GitHub Docs](https://docs.github.com/packages/learn-github-packages/deleting-and-restoring-a-package) - Complete deletion and restoration guide.
- [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry) - Registry-specific operations.
- [Working with the NuGet registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry) - NuGet-specific deletion procedures.
- [Working with the npm registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-npm-registry) - npm-specific deletion procedures.
- [Required permissions](https://docs.github.com/packages/learn-github-packages/deleting-and-restoring-a-package) - Understanding permission requirements for package operations.
