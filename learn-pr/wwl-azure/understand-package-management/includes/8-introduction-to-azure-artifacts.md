Previously you learned about packaging dependencies and the various packaging formats, feeds, sources, and package managers. Now, you'll know more about **package management**, creating a feed, and publishing packages using **Azure Artifacts**.

During this module, NuGet and Azure Artifacts are used as an example of a package format and a particular package feed and source type.

## Azure DevOps

**Azure DevOps** provides various features for application lifecycle management, including:

- **Work item tracking:** Plan and track work with Agile tools.
- **Source code repositories:** Git and TFVC version control.
- **Build and release pipelines:** CI/CD automation with Azure Pipelines.
- **Artifact management:** Package management with Azure Artifacts.
- **Test plans:** Manual and exploratory testing tools.

The artifact management is called **Azure Artifacts** and was previously known as **Package management**. It offers public and private feeds for software packages of various types.

## What is Azure Artifacts?

**Azure Artifacts** is a fully integrated package management solution within Azure DevOps that enables teams to:

- **Create and share packages:** Publish packages to feeds for consumption across projects.
- **Manage dependencies:** Control package versions and dependencies centrally.
- **Secure packages:** Use permissions and scopes to control access.
- **Integrate with CI/CD:** Seamlessly use packages in build and release pipelines.
- **Support multiple formats:** Work with various package types in a unified platform.

## Types of packages supported

Azure Artifacts currently supports feeds that can store **five different package types**:

- **NuGet packages:** For .NET libraries and tools.
- **npm packages:** For JavaScript and Node.js libraries.
- **Maven packages:** For Java libraries and applications.
- **Python packages:** For Python modules and packages.
- **Universal Packages:** Azure Artifacts-specific format for any file type.

### Universal Packages

**Universal Packages** are an Azure Artifacts-specific package type. In essence, it's a versioned package containing multiple files and folders.

**Use cases:**

- **Build artifacts:** Store compiled applications or libraries.
- **Configuration files:** Version control for configuration sets.
- **Documentation:** Package documentation for distribution.
- **Any file type:** Use for any content that doesn't fit standard package formats.

**Benefits:**

- **Simple format:** Easy to create and consume.
- **Versioning:** Track versions like other package types.
- **Integration:** Works with Azure Pipelines and other tools.

### Mixed package types

A single Azure Artifacts feed can contain **any combination** of such packages. You can connect to the feed using the package managers and the corresponding tooling for the package types.

**Examples:**

- A feed containing both NuGet and npm packages for a full-stack project.
- A feed with Maven, npm, and Universal Packages for a Java web application.

**Tooling support:**

- For Maven packages, this can also be the **Gradle** build tool.
- Each package type has its own endpoint within the feed.

## Selecting package sources

When creating your solution, you'll decide which packages you want to consume to offer the dependent components.

The next step is to determine the **sources** for these packages. The main choice is selecting public and private feeds or a combination of them.

### Public sources

**Publicly available packages** can usually be found in the public package sources:

- **NuGet.org:** For .NET packages.
- **npmjs.com:** For JavaScript/Node.js packages.
- **Maven Central:** For Java packages.
- **PyPI.org:** For Python packages.

Your solution can select these sources if it **only consumes packages available there**.

### Private sources

Whenever your solution also has **private packages** that can't be available on public sources, you'll need to use a **private feed**.

**Reasons for private feeds:**

- **Proprietary code:** Internal libraries and business logic.
- **Security:** Sensitive code that shouldn't be public.
- **Pre-release packages:** Beta versions not ready for public consumption.

## Upstream sources in Azure Artifacts

In the previous sections, you learned that public package sources could be **upstream sources** to private feeds.

**Azure Artifacts** allows its feeds to specify one or more upstream sources, public, or other private feeds.

### Configuring upstream sources

**Benefits:**

- **Unified configuration:** Developers configure only your private feed.
- **Automatic fallback:** Packages not in your feed are fetched from upstream sources.
- **Caching:** Downloaded upstream packages are cached in your feed.
- **Governance:** Control which external packages teams can use.

**Supported upstream sources:**

- **Public sources:** NuGet.org, npmjs.com, Maven Central, PyPI.org.
- **Other Azure Artifacts feeds:** Within your organization or other organizations.

**Example scenario:**

- Configure your Azure Artifacts feed with NuGet.org as upstream source.
- Developers reference only your feed.
- When a package is requested, Azure Artifacts checks your feed first.
- If not found, it fetches from NuGet.org and caches it.
- Subsequent requests use the cached version.

## Feed views

**Azure Artifacts** supports **feed views** to manage package promotion and lifecycle.

**What are feed views:**

- **Filtered subsets:** Views show specific subsets of packages in a feed.
- **Promotion:** Move packages between views as they mature (e.g., Development → Release).
- **Access control:** Different views can have different permissions.

**Common views:**

- **@Local:** Packages published directly to your feed.
- **@Prerelease:** Packages tagged as prerelease versions.
- **@Release:** Stable packages promoted for production use.

**Use cases:**

- **Quality gates:** Promote packages through views as they pass testing.
- **Environment separation:** Different environments consume different views.
- **Version control:** Control which versions are available in each view.

## Integration with Azure Pipelines

**Azure Artifacts** integrates seamlessly with **Azure Pipelines**:

- **Restore packages:** Automatically restore packages during builds.
- **Publish packages:** Publish build outputs as packages to feeds.
- **Version management:** Automatically version packages based on build numbers.
- **Authentication:** Built-in authentication for pipeline tasks.

See also [Get started with Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts).
