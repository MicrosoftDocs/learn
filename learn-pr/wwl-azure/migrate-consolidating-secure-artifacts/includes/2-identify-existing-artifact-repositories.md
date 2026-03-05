An **artifact** is a deployable component of your application. **Azure Pipelines** can work with a wide variety of artifact sources and repositories.

## Understanding artifacts in release pipelines

When you're creating a **release pipeline**, you need to link the required artifact sources. Often, it will represent the output of a build pipeline from a continuous integration system like:

- **Azure Pipelines:** Native CI/CD system in Azure DevOps.
- **Jenkins:** Open-source automation server.
- **TeamCity:** JetBrains CI/CD solution.
- **CircleCI, Travis CI, GitLab CI:** Other popular CI systems.

### Current artifact storage locations

The artifacts that you produce might be stored in various locations:

- **Source control:** Git, Team Foundation Version Control (TFVC), Subversion.
- **File shares:** Network drives or shared folders.
- **Package management tools:** NuGet Server, npm registries, Maven repositories.
- **Container registries:** Docker Hub, Azure Container Registry.
- **Cloud storage:** Azure Blob Storage, Amazon S3.

### Version specification

When you need to create a release, you must specify **which version of the artifacts** is required. By default, the release pipeline will choose the latest version of the artifacts. But you might not want that.

**Version selection options:**

- **Specific branch:** Choose artifacts from a particular branch (e.g., main, develop, release/1.0).
- **Specific build version:** Select a specific build number or ID.
- **Tags:** Use Git tags or build tags to identify versions.
- **Latest successful:** Most recent successful build.
- **Latest with specific label:** Artifacts with particular labels or metadata.

## Why consolidate to Azure Artifacts?

**Azure Artifacts** are one of the services that's part of Azure DevOps. Using it can eliminate the need to manage file shares or host private package services.

### Benefits of Azure Artifacts

**Centralized management:**

- Store **Maven, npm, NuGet, Python, and Universal Packages** together in one place.
- **Cloud-hosted:** No infrastructure to maintain.
- **Indexed and searchable:** Easily find packages.
- **Integrated with Azure DevOps:** Seamless access from pipelines and projects.

**Eliminate binary storage in source control:**

Now, while we can do so, there's also **no need to store your binaries in Git**. You can keep them directly using **Universal Packages**. It's also a great way to protect your packages.

**Why avoid binaries in source control:**

- **Repository bloat:** Large files make repositories slow to clone and pull.
- **Version control overhead:** Git isn't optimized for binary files.
- **Merge conflicts:** Binary files can't be easily merged.
- **Security:** Binaries in source control are harder to secure and scan.

**Universal Packages as alternative:**

- **Versioned storage:** Store any file type with version tracking.
- **Secure:** Control access with permissions.
- **Efficient:** Optimized for binary storage.
- **Integrated:** Works seamlessly with Azure Pipelines.

### Comprehensive package management

**Azure Artifacts** provide universal artifact management from Maven, npm, and NuGet, along with **Python and Universal Packages**.

**Package types supported:**

- **NuGet:** .NET packages
- **npm:** JavaScript/Node.js packages
- **Maven:** Java packages
- **Python:** PyPI packages
- **Universal Packages:** Any file type

**Integration benefits:**

And sharing packages, you can easily access all of your artifacts in **builds and releases** because it integrates naturally with **Azure Pipelines** and its CI/CD tooling, along with **versioning and testing**.

- **Build integration:** Reference packages during builds.
- **Release integration:** Deploy packages as part of releases.
- **Versioning:** Track package versions across environments.
- **Testing:** Test with specific package versions.

## Assessing your current artifact landscape

Before migrating to Azure Artifacts, you need to **identify existing artifact repositories** across your organization.

### Inventory checklist

**Package repositories:**

- **Self-hosted:** NuGet Server, npm registries, Nexus, Artifactory, Archiva.
- **Third-party SaaS:** MyGet, JFrog Cloud, GitHub Packages.
- **File shares:** Network drives containing packages or binaries.

**Container registries:**

- **Self-hosted:** Docker Registry, Harbor.
- **Cloud-based:** Docker Hub, Azure Container Registry, Amazon ECR.

**Source control:**

- **Binary files:** Large files stored in Git or TFVC.
- **Build outputs:** Compiled binaries committed to repositories.

### Assessment questions

**For each repository, consider:**

- **Usage:** Who uses this repository? Which projects depend on it?
- **Size:** How many packages? What's the total storage size?
- **Criticality:** Is this repository critical to operations?
- **Access control:** Who has permissions? How is access managed?
- **Integration:** What tools and pipelines reference this repository?
- **Maintenance:** Who maintains the infrastructure?

### Migration priorities

**Prioritize migration based on:**

- **High maintenance burden:** Repositories requiring significant operational overhead.
- **Security concerns:** Repositories with weak access controls or vulnerabilities.
- **Integration opportunities:** Repositories that would benefit from Azure DevOps integration.
- **Cost savings:** Self-hosted solutions with high infrastructure costs.
