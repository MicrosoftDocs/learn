While you can continue to work with your existing artifact repositories in their current locations when using **Azure Artifacts**, there are significant advantages to **migrating** them.

## Benefits of migrating to Azure Artifacts

### Eliminate on-premises dependencies

**Azure Artifacts** provides hosted package feeds as a service.

Using this service, you can often eliminate the dependencies on **on-premises resources** such as:

- **File shares:** Network drives requiring VPN access and maintenance.
- **Locally hosted instances:** NuGet.Server, npm registries, or Maven repositories on local servers.
- **Infrastructure overhead:** Physical or virtual servers requiring updates, backups, and monitoring.

### Universal CI/CD integration

The feeds can also be consumed by any **Continuous Integration system** that supports authenticated feeds:

- **Azure Pipelines:** Native integration with seamless authentication.
- **Jenkins:** Configure via credentials and feed URLs.
- **TeamCity:** Add as external package sources.
- **GitHub Actions:** Authenticate with Personal Access Tokens.
- **GitLab CI:** Configure package sources in CI/CD pipelines.

## Migration strategies

### 1. Direct migration

**Approach:** Migrate all packages at once to Azure Artifacts.

**When to use:**

- Small to medium-sized repositories.
- Limited number of consumers.
- Can coordinate downtime with teams.

**Steps:**

1.  **Create Azure Artifacts feed** with appropriate visibility and settings.
2.  **Export packages** from existing repository.
3.  **Publish to Azure Artifacts** using package manager tools or scripts.
4.  **Update consumers** to reference new feed.
5.  **Decommission old repository** after validation period.

**Advantages:**

- **Clean break:** No mixed sources.
- **Simplified management:** Single source of truth immediately.

**Challenges:**

- **Coordination required:** All teams must update at once.
- **Potential disruption:** Risk if issues arise during migration.

### 2. Gradual migration with upstream sources

**Approach:** Use Azure Artifacts as primary feed with existing repository as upstream source.

**When to use:**

- Large repositories with many consumers.
- Need to minimize disruption.
- Want to test Azure Artifacts gradually.

**Steps:**

1.  **Create Azure Artifacts feed** configured with **upstream sources** pointing to existing repository.
2.  **Update consumers** to reference Azure Artifacts feed.
3.  **Migrate new packages** directly to Azure Artifacts.
4.  **Existing packages** are cached from upstream when requested.
5.  **Optionally migrate existing packages** over time.
6.  **Remove upstream source** once migration is complete.

**Advantages:**

- **Zero downtime:** Consumers transparently access packages.
- **Gradual transition:** Move at your own pace.
- **Fallback option:** Keep existing repository as backup.

**Benefits of upstream sources:**

- **Caching:** Azure Artifacts caches packages from upstream, improving performance.
- **Unified access:** Consumers configure only Azure Artifacts.
- **Security:** Control external access through Azure Artifacts.

### 3. Parallel operation

**Approach:** Run Azure Artifacts alongside existing repository.

**When to use:**

- Risk-averse organizations.
- Need extended validation period.
- Complex migration scenarios.

**Steps:**

1.  **Create Azure Artifacts feed** parallel to existing repository.
2.  **Publish to both** feeds initially.
3.  **Gradually migrate consumers** to Azure Artifacts.
4.  **Monitor usage** of old repository.
5.  **Decommission** when usage drops to zero.

**Advantages:**

- **Low risk:** Can revert if issues arise.
- **Extended validation:** Time to ensure Azure Artifacts meets needs.

**Challenges:**

- **Dual maintenance:** Must publish to both locations.
- **Potential inconsistency:** Versions may drift between sources.

## Migration by package type

### NuGet packages

**Azure Artifacts** provides hosted **NuGet feeds** as a service.

**Migration tools:**

- **NuGet CLI:** Use `nuget push` to publish packages.
- **Azure Artifacts CLI:** `az artifacts universal publish` for bulk operations.
- **PowerShell scripts:** Automate migration with scripts.

**Configuration:**

```xml
<packageSources>
  <add key="AzureArtifacts" value="https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/nuget/v3/index.json" />
</packageSources>
```

### npm packages

**Migration tools:**

- **npm CLI:** Use `npm publish` with configured registry.
- **Scripts:** Automate with Node.js scripts.

**Configuration (`.npmrc`):**

```
registry=https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/npm/registry/
```

### Maven packages

**Migration tools:**

- **Maven CLI:** Use `mvn deploy` to publish.
- **Gradle:** Configure publication with Gradle build scripts.

**Configuration (`pom.xml` or `settings.xml`):**

```xml
<distributionManagement>
  <repository>
    <id>azure-artifacts</id>
    <url>https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/maven/v1</url>
  </repository>
</distributionManagement>
```

### Python packages

**Migration tools:**

- **twine:** Use `twine upload` to publish packages.
- **pip:** Configure index URL for consumption.

**Configuration:**

```bash
pip install --index-url https://pkgs.dev.azure.com/{organization}/_packaging/{feed}/pypi/simple/ {package}
```

### Universal Packages

**Use for:**

- **Build artifacts:** Compiled applications.
- **Binary files:** Any files previously in source control or file shares.
- **Mixed content:** Folders with multiple file types.

**Publish:**

```bash
az artifacts universal publish --organization https://dev.azure.com/{organization} --feed {feed} --name {package-name} --version {version} --path {path-to-folder}
```

## Migration best practices

**Planning:**

- **Inventory packages:** Know what you're migrating.
- **Test first:** Migrate test repositories before production.
- **Communicate:** Inform teams of migration plans and timelines.

**Execution:**

- **Verify packages:** Ensure packages work after migration.
- **Monitor consumption:** Track which packages are accessed from new feed.
- **Maintain old repository:** Keep as read-only backup during transition.

**Post-migration:**

- **Document changes:** Update documentation with new feed URLs.
- **Decommission gradually:** Only remove old repositories after validation period.
- **Train teams:** Ensure everyone knows how to use Azure Artifacts.

## Integration walkthroughs

For detailed step-by-step instructions on how to integrate each package type, see the following walkthroughs:

- [Get started with NuGet packages in Azure DevOps Services and TFS](/azure/devops/artifacts/get-started-nuget) - Publish and consume NuGet packages.
- [Use npm to store JavaScript packages in Azure DevOps Services or TFS](/azure/devops/artifacts/get-started-npm) - Work with npm packages.
- [Get started with Maven packages in Azure DevOps Services and TFS](/azure/devops/artifacts/get-started-maven) - Maven package management.
- [Get started with Python packages in Azure Artifacts](/azure/devops/artifacts/quickstarts/python-packages) - Python package workflows.
- [Publish and then download a Universal Package](/azure/devops/artifacts/quickstarts/universal-packages) - Universal Package operations.
