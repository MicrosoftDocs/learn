**Proper software development practice** requires indicating changes to code with the introduction of an **increased version number**. Understanding how to version artifacts correctly is essential for maintaining stable and predictable software systems.

## Version increment principles

However small or large a change, it **requires a new version**. A component and its package can have **independent versions** and versioning schemes.

**Key versioning concepts:**

- **Always increment:** Every change requires a new version number.
- **Independent versioning:** Components can version separately from their packages.
- **Immutability:** Published versions cannot be changed.
- **Communication:** Version numbers communicate the nature of changes.

## Version numbering schemes

The **versioning scheme** can differ per package type. Typically, it uses a scheme that can indicate the kind of change that is made.

### Three types of changes

Most commonly, it involves **three types of changes**:

#### 1. Major change

**Major** indicates that the package and its contents have changed significantly.

**Characteristics:**

- **Significant changes:** It often occurs at the introduction of a new version of the package.
- **Redesign:** It can be a redesign of the component.
- **Breaking changes:** Major changes aren't guaranteed to be compatible and usually have breaking changes from older versions.
- **High effort:** Major changes might require a large amount of work to adopt the consuming codebase to the new version.

**When to use major versions:**

- **API changes:** Breaking changes to public APIs.
- **Removed features:** Functionality that was deprecated and now removed.
- **Architectural changes:** Fundamental redesign of the component.
- **Dependency updates:** Major version updates to critical dependencies.

**Example:**

- `1.5.2` → `2.0.0` indicates breaking changes

#### 2. Minor change

**Minor** indicates that the package and its contents have **extensive modifications** but are smaller than a major change.

**Characteristics:**

- **New features:** Addition of functionality without breaking existing code.
- **Backward compatibility:** These changes can be backward compatible with the previous version, although they aren't guaranteed to be.
- **Moderate effort:** Usually requires minimal changes to consuming code.
- **Additive changes:** New methods, classes, or features added.

**When to use minor versions:**

- **New functionality:** Adding new features or capabilities.
- **Enhancements:** Improving existing features without breaking them.
- **Deprecations:** Marking features as deprecated (but still functional).
- **Performance improvements:** Non-breaking performance optimizations.

**Example:**

- `1.5.2` → `1.6.0` indicates new features added

#### 3. Patch

A **patch** or **revision** is used to indicate that a flaw, bug, or malfunctioning part of the component has been fixed.

**Characteristics:**

- **Bug fixes:** Usually, it's a backward-compatible version compared to the previous version.
- **No new features:** Only fixes to existing functionality.
- **Low risk:** Minimal risk to consuming applications.
- **Quick adoption:** Consumers can update with confidence.

**When to use patch versions:**

- **Bug fixes:** Correcting defects in existing functionality.
- **Security patches:** Addressing security vulnerabilities.
- **Documentation fixes:** Correcting documentation errors.
- **Minor improvements:** Small improvements that don't add features.

**Example:**

- `1.5.2` → `1.5.3` indicates bug fixes

## Technical implementation of versioning

How artifacts are **versioned technically** varies per package type. Each type has its way of indicating the **version** in the **metadata**.

### Package-specific versioning

**Different package types store version information differently:**

#### NuGet packages

- **Metadata location:** Version stored in `.nuspec` file or project file.
- **Format:** Supports Semantic Versioning 2.0.
- **Example:** `<version>1.2.3-beta1</version>`

**NuGet version format:**

```xml
<package>
  <metadata>
    <id>MyPackage</id>
    <version>1.2.3</version>
    <title>My Package Title</title>
  </metadata>
</package>
```

#### npm packages

- **Metadata location:** Version in `package.json`.
- **Format:** SemVer 2.0 compliant.
- **Example:** `"version": "1.2.3"`

**npm version format:**

```json
{
  "name": "my-package",
  "version": "1.2.3",
  "description": "My package description"
}
```

#### Maven packages

- **Metadata location:** Version in `pom.xml`.
- **Format:** `major.minor.patch` or `major.minor.patch-SNAPSHOT`.
- **Example:** `<version>1.2.3</version>`

**Maven version format:**

```xml
<project>
  <groupId>com.example</groupId>
  <artifactId>my-artifact</artifactId>
  <version>1.2.3</version>
</project>
```

#### Python packages

- **Metadata location:** Version in `setup.py` or `pyproject.toml`.
- **Format:** PEP 440 compliant.
- **Example:** `version="1.2.3"`

**Python version format:**

```python
setup(
    name="my-package",
    version="1.2.3",
    description="My package description"
)
```

#### Universal Packages

- **Metadata location:** Azure Artifacts Universal Package format.
- **Format:** SemVer 2.0.
- **Example:** Specified during publish with Azure CLI.

## Package manager interaction

The corresponding **package manager** can inspect the **version information**. The tooling can query the package feed for packages and the available versions.

**Package manager capabilities:**

- **Version discovery:** List all available versions of a package.
- **Version comparison:** Determine which versions are newer.
- **Dependency resolution:** Select appropriate versions based on constraints.
- **Range queries:** Find versions matching version ranges (e.g., `>=1.0.0 <2.0.0`).

**Query examples:**

```bash
# NuGet - list versions
nuget list MyPackage -AllVersions

# npm - list versions
npm view my-package versions

# Maven - list versions (in repository)
mvn versions:display-dependency-updates

# Python - list versions
pip index versions my-package
```

## Versioning conventions

Additionally, a package type might have its **conventions** for versioning and a particular **versioning scheme**.

**Common conventions by ecosystem:**

### .NET (NuGet)

- **Semantic Versioning 2.0:** Primary standard.
- **Assembly versioning:** Separate assembly version and file version.
- **Prerelease labels:** Common labels include `alpha`, `beta`, `rc`, `preview`.

### JavaScript (npm)

- **Strict SemVer:** Enforces Semantic Versioning 2.0.
- **Caret ranges:** `^1.2.3` (compatible with 1.x.x).
- **Tilde ranges:** `~1.2.3` (compatible with 1.2.x).

### Java (Maven)

- **SNAPSHOT versions:** Development versions with `-SNAPSHOT` suffix.
- **Release versions:** Stable versions without suffix.
- **Qualifier support:** Additional qualifiers like `-GA`, `-RELEASE`.

### Python (pip)

- **PEP 440:** Python Enhancement Proposal for versioning.
- **Development releases:** `.dev0` suffix for development versions.
- **Pre-releases:** `.a0` (alpha), `.b0` (beta), `.rc0` (release candidate).

## Best practices for artifact versioning

**Consistent numbering:**

- **Follow conventions:** Use the versioning convention for your package ecosystem.
- **Be predictable:** Increment versions consistently and predictably.
- **Communicate clearly:** Version numbers should clearly indicate change scope.

**Automation:**

- **Automated versioning:** Use build tools to generate version numbers automatically.
- **CI/CD integration:** Integrate versioning into your CI/CD pipelines.
- **Avoid manual versioning:** Reduce human error with automated processes.

**Documentation:**

- **Changelog:** Maintain a changelog documenting changes in each version.
- **Release notes:** Provide detailed release notes for each version.
- **Migration guides:** For major versions, provide migration guides.

See also [Publish to NuGet feeds](/azure/devops/pipelines/artifacts/nuget#package-versioning).
