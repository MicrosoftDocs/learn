As software is developed and components are written, you'll most likely produce **components as dependencies** packaged for reuse.

Discussed previously was guidance to find components that can be isolated into dependencies. These components need to be managed and packaged. After that, they can be **published to a feed**, allowing others to consume the packages and use the components they contain.

## Create a feed

The first step is to **create a feed** where your packages will be stored. Azure Artifacts allows you to create multiple feeds as needed.

### Feed creation options

When creating a feed, you can specify:

- **Name:** Descriptive name for your feed (e.g., `MyCompany-Libraries`).
- **Visibility:** Choose between organization-scoped or project-scoped.
- **Upstream sources:** Choose whether to include packages from common public sources such as NuGet.org and npmjs.com.
- **Permissions:** Set who can contribute, read, or administer the feed.

### Creating a feed in Azure Artifacts

**Steps:**

1.  Navigate to **Azure DevOps** → **Artifacts**.
2.  Click **Create Feed**.
3.  Specify feed name and visibility.
4.  Optionally enable upstream sources for public package sources.
5.  Click **Create**.

## What are feeds in Azure Artifacts?

In **Azure Artifacts**, you can create multiple feeds within your projects. Feeds can be scoped to your project or made available across your entire organization.

### Feed characteristics

**Scope options:**

- **Project-scoped feeds:** Available only within a specific project.
- **Organization-scoped feeds:** Shared across all projects in the organization.

**Package type support:**

Feeds can store packages of different types such as:

- **npm:** JavaScript and Node.js packages.
- **NuGet:** .NET packages.
- **Maven:** Java packages.
- **Python:** Python packages.
- **Universal Packages:** Azure Artifacts-specific format.

### Feed features

**Upstream sources:**

Each feed can include one or more **upstream sources** to automatically include packages from:

- Public sources (NuGet.org, npmjs.com, Maven Central, PyPI).
- Other private Azure Artifacts feeds.

**Security settings:**

Each feed has its own **configurable security settings**:

- **Readers:** Can view and restore packages.
- **Contributors:** Can publish and restore packages.
- **Collaborators:** Can save packages from upstream sources.
- **Owners:** Full administrative control.

**Access control:**

Azure Artifacts enables developers to store, manage, and share their packages while maintaining **access control**. Developers can control how packages are shared:

- Restricting access to specific users, teams, or organizations.
- Making packages publicly available.
- Controlling package promotion through feed views.

## Publish packages to a feed

Azure Artifacts supports a wide range of package types and technologies. Each **package manager** has a different workflow for authenticating with Azure Artifacts and publishing packages to a feed.

### General publishing workflow

1.  **Create the package:** Build and package your component using appropriate tools.
2.  **Authenticate:** Configure authentication to Azure Artifacts (Personal Access Token, Credential Provider).
3.  **Configure feed:** Add your Azure Artifacts feed to package manager configuration.
4.  **Publish:** Use package manager commands to push the package to the feed.

### Finding the right workflow

To find the right workflow for your technology:

1.  Sign in to your **Azure DevOps** organization.
2.  Navigate to **Artifacts**.
3.  Select **Connect to feed**.
4.  From the left panel, choose the **package type** you're working with.
5.  Follow the **Project setup** instructions.

See [Get started with Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts#get-started) for more details.

### Publishing examples

**NuGet:**

```bash
dotnet nuget push MyPackage.1.0.0.nupkg --source "MyFeed" --api-key az
```

**npm:**

```bash
npm publish --registry https://pkgs.dev.azure.com/myorg/_packaging/myfeed/npm/registry/
```

**Maven:**

```bash
mvn deploy
```

**Python:**

```bash
twine upload --repository-url https://pkgs.dev.azure.com/myorg/_packaging/myfeed/pypi/upload mypackage-1.0.0.tar.gz
```

## Updating packages

Packages might need to be updated during their lifetime. Technically, **updating a package** is made by pushing a **new version** of the package to the feed.

The package feed manager manages to properly store the updated package with the existing packages in the feed.

### Versioning requirements

> [!NOTE]
> Updating packages requires a **versioning strategy**.

**Common versioning approaches:**

- **Semantic Versioning (SemVer):** `MAJOR.MINOR.PATCH` format (e.g., 1.2.3).
- **Date-based versioning:** Using dates in version numbers (e.g., 2025.10.09).
- **Build-based versioning:** Incorporating build numbers (e.g., 1.0.0-build.456).

### Immutability

**Important:** Once a package version is published, it's typically **immutable** (cannot be changed).

- To update a package, publish a new version with incremented version number.
- Don't overwrite existing versions, as this breaks reproducibility.
- Use prerelease suffixes for unstable versions (e.g., 1.0.0-alpha, 1.0.0-beta).

### Best practices for package updates

**Versioning:**

- Follow **semantic versioning** principles.
- Increment **MAJOR** for breaking changes.
- Increment **MINOR** for new features (backward compatible).
- Increment **PATCH** for bug fixes.

**Release notes:**

- Document changes in each version.
- Include what's new, what's changed, and what's fixed.
- Note any breaking changes clearly.

**Deprecation:**

- Mark old versions as deprecated when appropriate.
- Provide migration guides for breaking changes.
- Communicate deprecation timeline to consumers.

**Testing:**

- Test packages before publishing.
- Use prerelease versions for beta testing.
- Promote to stable versions only after validation.

## Automation with CI/CD

**Publishing packages** can be automated using **Azure Pipelines**:

**Benefits of automation:**

- **Consistency:** Same process for every package.
- **Version management:** Automatic version incrementing.
- **Quality gates:** Publish only after passing tests.
- **Speed:** Fast and reliable publishing.

**Example pipeline task:**

```yaml
- task: NuGetCommand@2
  inputs:
    command: "push"
    packagesToPush: "$(Build.ArtifactStagingDirectory)/**/*.nupkg"
    nuGetFeedType: "internal"
    publishVstsFeed: "MyFeed"
```

See also [Publish packages with Azure Pipelines](/azure/devops/pipelines/artifacts/nuget).
