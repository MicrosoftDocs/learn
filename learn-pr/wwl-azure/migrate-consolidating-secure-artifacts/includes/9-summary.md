This module detailed **package migration**, **consolidation**, and configuration to **secure access** to package feeds and artifact repositories. You learned essential strategies for moving from legacy package storage to Azure Artifacts while implementing robust security controls.

## What you learned

You learned how to describe the benefits and usage of:

### Identifying artifact repositories

- **Assess current landscape:** Identify artifact repositories across your organization, including file shares, build drop locations, and self-hosted package servers.
- **Inventory package types:** Catalog NuGet, npm, Maven, Python, and Universal packages across different storage locations.
- **Evaluate consolidation benefits:** Understand the advantages of centralized package management with Azure Artifacts.

### Migrating and integrating artifact repositories

- **Choose migration strategies:** Select between direct migration, gradual migration with upstream sources, or parallel operation based on your risk tolerance.
- **Package-specific migration:** Implement migration for different package types (NuGet, npm, Maven, Python, Universal Packages) with appropriate configuration.
- **Integration walkthroughs:** Follow detailed guides for each package type to integrate with Azure Artifacts.

### Securing package feeds

- **Feed as trusted source:** Recognize package feeds as critical components of your software supply chain requiring protection.
- **Access control:** Implement restricted access for both consumption and publishing to prevent malicious packages.
- **Visibility options:** Configure feed visibility (Organization, Project, Private) based on security requirements.
- **Security best practices:** Apply vulnerability scanning, package signing, and monitoring to maintain feed integrity.

### Understanding roles

- **Four-role hierarchy:** Master the Reader, Collaborator, Contributor, and Owner roles with their incremental permissions.
- **Role assignments:** Understand default role assignments for build services, project contributors, and administrators.
- **Least privilege:** Apply principle of least privilege by starting with minimal permissions and elevating as needed.
- **Team-based management:** Use teams instead of individual users for scalable permission management.

### Managing permissions

- **Granular control:** Implement feed-level and view-level permissions for fine-grained access control.
- **Feed users:** Manage who can access feeds and what operations they can perform.
- **Views:** Leverage views (@Local, @Release, @Prerelease, custom) for different package lifecycles.
- **Monitoring:** Audit permission changes and track access patterns for compliance.

### Implementing authentication

- **Microsoft Entra ID:** Leverage transparent authentication for Azure DevOps users.
- **Pipeline authentication:** Use build identity for automatic authentication in Azure Pipelines.
- **Personal Access Tokens:** Create and manage PATs for external tools and scripts.
- **Credential providers:** Install and configure credential providers for seamless authentication.
- **Service principals:** Use service principals for automated systems and long-lived services.

## Key concepts summary

### Migration strategies

- **Direct migration:** Complete cutover for simpler scenarios.
- **Gradual migration:** Phased approach with upstream sources for risk mitigation.
- **Parallel operation:** Run old and new systems simultaneously for maximum safety.

### Security model

- **Authentication:** Identity verification through Microsoft Entra ID, PATs, or service principals.
- **Authorization:** Role-based access control with four hierarchical roles.
- **Visibility:** Feed-level visibility control (Organization, Project, Private).
- **Auditing:** Comprehensive logging and monitoring of feed activities.

### Best practices

- **Centralize packages:** Consolidate all packages in Azure Artifacts for unified management.
- **Automate security:** Integrate vulnerability scanning into CI/CD pipelines.
- **Use upstream sources:** Leverage upstream sources for public packages to ensure availability.
- **Regular reviews:** Periodically audit permissions and remove unnecessary access.
- **Rotate credentials:** Regularly rotate PATs and service principal secrets.

## Next steps

### Continue learning

**Enhance your Azure Artifacts skills:**

- **Implement retention policies:** Configure retention policies to manage feed storage.
- **Set up upstream sources:** Connect to public registries for package caching.
- **Configure views and promotions:** Implement package promotion workflows across views.
- **Integrate with pipelines:** Automate package publishing and consumption in CI/CD pipelines.

**Explore advanced scenarios:**

- **Multi-organization feeds:** Share packages across Azure DevOps organizations.
- **Private endpoint integration:** Use Azure Private Link for enhanced security.
- **Package badges:** Display package status badges in documentation.
- **Semantic versioning:** Implement versioning strategies for package releases.

### Practical application

**Start implementing:**

1.  **Audit current state:** Inventory your existing artifact repositories.
2.  **Plan migration:** Choose appropriate migration strategy for each package type.
3.  **Configure security:** Set up roles, permissions, and authentication for your feeds.
4.  **Test thoroughly:** Validate migrations in non-production environments first.
5.  **Monitor and optimize:** Track usage and adjust configurations as needed.

## Learn more

### Official documentation

- [Azure Artifacts overview - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/start-using-azure-artifacts) - Comprehensive introduction to Azure Artifacts features and capabilities.
- [Best practices when working with Azure Artifacts - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/concepts/best-practices) - Detailed recommendations for feeds, versioning, and package management.
- [Set up permissions - Azure Artifacts \| Microsoft Learn](/azure/devops/artifacts/feeds/feed-permissions) - Complete guide to configuring feed permissions and roles.

### Additional resources

- [Secure and share packages using feed permissions](/azure/devops/artifacts/feeds/feed-permissions) - Deep dive into permission management and security.
- [Upstream sources in Azure Artifacts](/azure/devops/artifacts/concepts/upstream-sources) - Guidance on configuring and using upstream sources.
- [Azure Artifacts credential provider](/azure/devops/artifacts/npm/npmrc) - Setup and configuration for credential providers.
- [Package retention and deletion](/azure/devops/artifacts/how-to/delete-and-recover-packages) - Managing package lifecycle and storage.
- [Azure Artifacts REST API](/rest/api/azure/devops/artifacts/) - Programmatic access to Azure Artifacts features.

### Community and support

- **Azure DevOps Documentation:** Explore the full Azure DevOps documentation for comprehensive guides.
- **Microsoft Q&A:** Ask questions and connect with the community.
- **Azure DevOps Blog:** Stay updated with latest features and announcements.
