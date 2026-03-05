This module introduced you to **GitHub Packages**, a fully integrated package hosting service within GitHub. You learned how to publish, install, delete, and restore packages while controlling permissions and visibility for secure package management.

## What you learned

You learned how to describe the benefits and usage of:

### Publishing packages

- **Supported registries:** npm, NuGet, Maven, Gradle, RubyGems, Docker, and Container registry.
- **Authentication:** Creating and using personal access tokens (PATs) with appropriate scopes.
- **Publishing workflow:** Authenticate, configure package metadata, and publish using native tools.
- **NuGet publishing:** Using dotnet CLI and nuget.config files for authentication.
- **npm publishing:** Configuring .npmrc files and using npm login for authentication.
- **Automation:** Publishing packages automatically with GitHub Actions workflows.
- **Best practices:** Versioning, documentation, security advisories, and metadata completeness.

### Installing packages

- **Package discovery:** Searching globally, within organizations, or in repositories.
- **Installation workflow:** Authenticate to GitHub Packages and install with native package managers.
- **NuGet installation:** Using Visual Studio, dotnet CLI, or direct .csproj edits.
- **npm installation:** Configuring .npmrc files, package.json dependencies, and multi-organization support.
- **CI/CD integration:** Installing packages in GitHub Actions using GITHUB_TOKEN.
- **Troubleshooting:** Resolving authentication, permission, and version issues.

### Deleting and restoring packages

- **Deletion rules:** Understanding restrictions for public packages (5,000 download limit).
- **Permission requirements:** Admin access for repository-scoped packages.
- **Deleting versions:** Removing specific versions while keeping others available.
- **Deleting entire packages:** Removing all versions from GitHub Packages.
- **Restoration conditions:** 30-day window, namespace availability, and permission retention.
- **API management:** Using REST API for programmatic package operations.
- **Best practices:** Communication, deprecation, grace periods, and audit trails.

### Configuring access control and visibility

- **Permission models:** Repository-inherited permissions vs. granular permissions (container registry).
- **Visibility options:** Public, private, and internal (Enterprise only) packages.
- **Container image permissions:** Read, write, and admin roles with independent access control.
- **User and team access:** Granting permissions to individuals and teams.
- **Security best practices:** Least privilege, regular audits, team-based access, and documentation.
- **Organizational strategies:** Standardized visibility, access request processes, and compliance alignment.

## Key concepts summary

### GitHub Packages integration

- **Unified platform:** Packages live alongside source code in GitHub.
- **Same authentication:** Use GitHub credentials instead of separate registry accounts.
- **Workflow automation:** Publish packages automatically with GitHub Actions.
- **Multiple registries:** Support for npm, NuGet, Maven, Docker, and more in one platform.

### Security and access control

- **Granular permissions:** Container registry supports independent access control.
- **Repository-inherited permissions:** Most package types follow repository access.
- **PAT authentication:** Secure authentication using personal access tokens.
- **Public vs. private:** Choose visibility based on security and collaboration needs.

### Package lifecycle management

- **Publishing:** Automated or manual publishing with native package tools.
- **Versioning:** Semantic versioning for clear change communication.
- **Deletion:** Remove outdated or vulnerable versions with safety restrictions.
- **Restoration:** Recover deleted packages within 30-day window.

### Automation benefits

- **CI/CD integration:** Seamless integration with GitHub Actions.
- **GITHUB_TOKEN:** Automatic authentication in workflows without PATs.
- **Consistent publishing:** Every release creates a package automatically.
- **Quality gates:** Run tests before publishing packages.

## Next steps

### Continue learning

**Enhance your GitHub Packages skills:**

- **Advanced authentication:** Implement organization-wide authentication strategies.
- **Package promotion:** Develop workflows for promoting packages through quality stages.
- **Monorepo publishing:** Publish multiple packages from a single repository.
- **Security scanning:** Integrate vulnerability scanning for published packages.

**Explore advanced scenarios:**

- **Multi-registry support:** Configure projects to use multiple package registries.
- **Package mirroring:** Cache external packages in GitHub Packages.
- **Custom automation:** Build advanced publishing workflows with GitHub Actions.
- **Package analytics:** Track usage and adoption of your packages.

### Practical application

**Start implementing:**

1. **Set up authentication:** Create PATs with appropriate scopes for your team.
2. **Publish first package:** Choose a registry and publish a test package.
3. **Configure consumers:** Set up projects to install packages from GitHub Packages.
4. **Automate publishing:** Create GitHub Actions workflows for automated publishing.
5. **Configure access control:** Set visibility and permissions based on security needs.
6. **Document procedures:** Create team guidelines for package management.

### Integration with DevOps practices

**GitHub Packages in DevOps workflows:**

- **Continuous Integration:** Automatically build and publish packages on commits.
- **Continuous Delivery:** Use packages as artifacts in deployment pipelines.
- **Dependency management:** Centralize internal dependencies in GitHub Packages.
- **Version control:** Track package versions alongside code versions.
- **Security compliance:** Implement access controls aligned with organizational policies.

## Learn more

### Official documentation

- [Quickstart for GitHub Packages](https://docs.github.com/packages/quickstart) - Get started quickly with GitHub Packages.
- [Learn GitHub Packages](https://docs.github.com/packages/learn-github-packages) - Comprehensive guide to GitHub Packages concepts.
- [Working with a GitHub Packages registry](https://docs.github.com/packages/working-with-a-github-packages-registry) - Registry-specific guides for all supported package types.
- [About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages) - Understanding permission models and access control.

### Registry-specific guides

- [Working with the npm registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-npm-registry) - Complete npm package management guide.
- [Working with the NuGet registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry) - Complete NuGet package management guide.
- [Working with the Container registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-container-registry) - Docker and OCI image management.
- [Working with the Apache Maven registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-apache-maven-registry) - Maven package management.
- [Working with the Gradle registry](https://docs.github.com/packages/working-with-a-github-packages-registry/working-with-the-gradle-registry) - Gradle package management.

### Security and best practices

- [Configuring a package's access control and visibility](https://docs.github.com/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility) - Managing package security.
- [Deleting and restoring a package](https://docs.github.com/packages/learn-github-packages/deleting-and-restoring-a-package) - Package lifecycle management.
- [Publishing a package](https://docs.github.com/packages/learn-github-packages/publishing-a-package) - Best practices for package publishing.
- [Installing a package](https://docs.github.com/packages/learn-github-packages/installing-a-package) - Best practices for package consumption.

### API and automation

- [GitHub Packages API](https://docs.github.com/rest/reference/packages) - REST API for programmatic package management.
- [Publishing packages with GitHub Actions](https://docs.github.com/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions) - CI/CD integration examples.
- [Using GitHub Packages with GitHub Actions](https://docs.github.com/packages/managing-github-packages-using-github-actions-workflows) - Advanced workflow patterns.

### Community and support

- **GitHub Documentation:** Explore comprehensive guides and tutorials.
- **GitHub Community:** Ask questions and get answers from the community.
- **GitHub Blog:** Stay updated with latest features and announcements.
- **GitHub Skills:** Interactive learning paths for GitHub features.
