When building packages from a pipeline, the package needs to have a **version** before being consumed and tested.

Only after testing is the **quality** of the package known.

Since **package versions can't and shouldn't be changed**, it becomes challenging to choose a specific version beforehand.

## Quality levels and views

**Azure Artifacts** recognizes the **quality level** of packages in its feeds and the difference between **prerelease** and **release** versions.

It offers different **views** on the list of packages and their versions, separating these based on their **quality level**.

**The challenge:**

- **Version first:** Package must have version before testing.
- **Quality unknown:** Quality is determined after testing.
- **Immutability:** Can't change version after publishing.
- **Solution:** Use views to indicate quality without changing version.

### Views as quality descriptors

It fits well with the use of **semantic versioning** of the packages for predictability of the intent of a particular version.

Still, its extra metadata from the **Azure Artifacts feed** is called a **descriptor**.

**Views provide:**

- **Quality indicator:** Separate packages by maturity level.
- **Consumer choice:** Allow consumers to choose quality level.
- **Promotion workflow:** Move packages through quality gates.
- **Immutability maintained:** Package version doesn't change.

## Default feed views

**Feeds** in Azure Artifacts have **three different views** by default. These views are added when a new feed is created.

### The three default views

#### 1. @Local view

**The `@Local` view contains all release and prerelease packages and the packages downloaded from upstream sources.**

**Characteristics:**

- **Complete feed:** Shows all packages regardless of promotion status.
- **Upstream packages:** Includes packages cached from upstream sources.
- **Default view:** Used by default when no view is specified.
- **Development usage:** Typically used during development.

**Use cases:**

- **Development builds:** Developers testing latest packages.
- **CI builds:** Build pipelines that need all package versions.
- **Package discovery:** Finding all available packages.

#### 2. @Prerelease view

**The `@Prerelease` view contains all packages that have a label in their version number.**

**Characteristics:**

- **Labeled versions only:** Only shows versions with prerelease labels (e.g., `1.0.0-beta`).
- **Quality gate:** Packages promoted here have passed initial quality checks.
- **Testing phase:** Indicates packages ready for broader testing.
- **Not production-ready:** Not recommended for production use.

**Use cases:**

- **QA testing:** Quality assurance teams testing prerelease versions.
- **Beta testing:** Early adopters testing new features.
- **Integration testing:** Testing integration with other systems.

#### 3. @Release view

**The `@Release` view contains all packages that are considered official releases.**

**Characteristics:**

- **Production-ready:** Only contains packages approved for production.
- **No labels:** Typically contains only versions without prerelease labels.
- **Stable versions:** Highest quality level.
- **Supported:** Packages in this view are officially supported.

**Use cases:**

- **Production deployments:** Applications deployed to production.
- **Stable builds:** Release builds for customers.
- **Official releases:** Packages distributed to end users.

## Using views

You can use **views** to offer help consumers of a package feed filter between released and unreleased versions of packages.

Essentially, it allows a consumer to make a **conscious decision** to choose from released packages or opt-in to prereleases of a certain quality level.

### Default view URI format

By default, the **`@Local` view** is used to offer the list of available packages. The format for this URI is:

```
https://pkgs.dev.azure.com/{organization}/_packaging/{feedname}/nuget/v3/index.json
```

**Components:**

- **{organization}:** Your Azure DevOps organization name.
- **{feedname}:** The name of your feed.
- **No view specified:** Defaults to @Local view.

**Example:**

```
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/nuget/v3/index.json
```

### View-specific URI format

When consuming a package feed by its **URI endpoint**, the address can have the requested **view** included. For a specific view, the URI includes the name of the view, which changes to be:

```
https://pkgs.dev.azure.com/{organization}/_packaging/{feedname}@{Viewname}/nuget/v3/index.json
```

**View-specific examples:**

```
# @Local view (explicit)
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Local/nuget/v3/index.json

# @Prerelease view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Prerelease/nuget/v3/index.json

# @Release view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/nuget/v3/index.json
```

### Automatic view filtering

The **tooling** will show and use the packages from the specified view automatically.

**Package manager behavior:**

- **View filtering:** Only packages in the specified view are visible.
- **Automatic resolution:** Dependency resolution uses only visible packages.
- **Transparent:** No additional configuration needed.

## Views across package types

**Views work consistently across all package types:**

### NuGet

```
# Default (Local)
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/nuget/v3/index.json

# Release view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/nuget/v3/index.json
```

### npm

```
# Default (Local)
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/npm/registry/

# Release view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/npm/registry/
```

### Maven

```
# Default (Local)
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/maven/v1

# Release view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/maven/v1
```

### Python

```
# Default (Local)
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/pypi/simple/

# Release view
https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/pypi/simple/
```

## Prerelease label versus view

**Tooling** may offer an option to select prerelease versions, such as shown in this Visual Studio 2017 NuGet dialog.

**Important distinction:**

It **doesn't relate or refer** to the `@Prerelease` view of a feed. Instead, it relies on the presence of **prerelease labels** of semantic versioning to include or exclude packages in the search results.

**Two separate concepts:**

### 1. Prerelease labels (SemVer)

- **Version-based:** Part of the version number (e.g., `1.0.0-beta`).
- **Semantic versioning:** Follows SemVer conventions.
- **Package manager feature:** Package managers can filter based on labels.
- **Universal:** Works across all package systems.

**Example:**

```
1.0.0-alpha.1  ← Prerelease label
1.0.0          ← Stable version
```

### 2. @Prerelease view (Azure Artifacts)

- **Feed metadata:** Azure Artifacts-specific quality indicator.
- **Promotion-based:** Packages promoted to this view.
- **Quality gate:** Indicates a certain quality level.
- **Azure-specific:** Only applies to Azure Artifacts feeds.

**How they work together:**

- **Complementary:** Both help manage package quality.
- **Independent:** A package can have a label but not be in @Prerelease view.
- **Workflow:** Typically, labeled versions are promoted to @Prerelease view.

## Configuring package consumers

### Development configuration

**Use @Local view for active development:**

```bash
# NuGet - Add source with Local view
dotnet nuget add source "https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/nuget/v3/index.json" --name MyFeed-Local

# npm - Configure in .npmrc
registry=https://pkgs.dev.azure.com/contoso/_packaging/MyFeed/npm/registry/
```

### QA/Testing configuration

**Use @Prerelease view for testing:**

```bash
# NuGet - Add source with Prerelease view
dotnet nuget add source "https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Prerelease/nuget/v3/index.json" --name MyFeed-Prerelease
```

### Production configuration

**Use @Release view for production:**

```bash
# NuGet - Add source with Release view
dotnet nuget add source "https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/nuget/v3/index.json" --name MyFeed-Release

# npm - Configure in .npmrc for production
registry=https://pkgs.dev.azure.com/contoso/_packaging/MyFeed@Release/npm/registry/
```

## Custom views

Beyond the three default views, you can create **custom views** for finer-grained quality levels.

**Custom view examples:**

- **@Alpha:** Very early versions.
- **@Beta:** Feature-complete testing versions.
- **@RC:** Release candidate versions.
- **@Stable:** Long-term stable versions.

**Creating custom views:**

1.  **Navigate to feed settings:** Go to your feed in Azure Artifacts.
2.  **Views tab:** Select the Views section.
3.  **Add view:** Click "Add view" and provide a name.
4.  **Configure:** Set visibility and promotion rules.

## View benefits

**Quality control:**

- **Staged releases:** Move packages through quality gates.
- **Risk mitigation:** Prevent untested packages in production.
- **Clear communication:** Views indicate quality level.

**Consumer flexibility:**

- **Choice:** Consumers choose their risk tolerance.
- **Opt-in:** Consciously opt into prerelease versions.
- **Safety:** Production systems only see released packages.

**Workflow integration:**

- **CI/CD:** Integrate promotion into pipelines.
- **Automation:** Automate promotion based on test results.
- **Governance:** Enforce quality gates through views.

See also:

- [Views on Azure DevOps Services feeds](/azure/devops/artifacts/concepts/views).
- [Communicate package quality with prerelease and release views](/azure/devops/artifacts/feeds/views).
