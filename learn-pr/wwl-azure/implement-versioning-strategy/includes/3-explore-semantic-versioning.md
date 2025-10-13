One of the predominant ways of versioning is the use of **Semantic Versioning** (SemVer).

**Semantic Versioning** isn't a standard but does offer a consistent way of expressing the **intent** and **semantics** of a particular version.

It describes a version for its **backward compatibility** with previous versions.

## Semantic versioning format

**Semantic versioning** uses a **three-part version number** and an optional **label**.

### Major.Minor.Patch format

The version has the form of **Major.Minor.Patch** which corresponds to the three types of changes covered in the previous section.

**Version structure:**

- **Major:** First number, indicates breaking changes.
- **Minor:** Second number, indicates new features (backward compatible).
- **Patch:** Third number, indicates bug fixes (backward compatible).

**Examples of versions using the semantic versioning scheme:**

- `1.0.0` - Initial stable release
- `3.7.129` - Version 3 with many minor and patch updates
- `2.0.0` - Major version 2 with breaking changes

These versions don't have any labels.

### Version increment rules

**When to increment each number:**

#### Increment Major (X.0.0)

- **Breaking changes:** Make incompatible API changes.
- **Remove functionality:** Delete deprecated features.
- **Architectural changes:** Fundamental redesign.

**Example:**

- `1.5.3` → `2.0.0` when breaking changes are introduced

#### Increment Minor (x.Y.0)

- **New features:** Add functionality in a backward-compatible manner.
- **Deprecate functionality:** Mark features as deprecated (but still functional).
- **Enhancements:** Substantial improvements to existing features.

**Example:**

- `1.5.3` → `1.6.0` when adding new features

#### Increment Patch (x.y.Z)

- **Bug fixes:** Make backward-compatible bug fixes.
- **Security patches:** Fix security vulnerabilities.
- **Performance improvements:** Minor performance optimizations.

**Example:**

- `1.5.3` → `1.5.4` for bug fixes

## Prerelease versions

For **prerelease versions**, it's customary to use a **label** after the regular version number.

### Label format

A **label** is a textual suffix separated by a **hyphen** from the rest of the version number.

The label itself can be any text describing the **nature of the prerelease**.

**Label structure:**

```
Major.Minor.Patch-label
```

### Common prerelease labels

Examples of these are `rc1`, `beta27`, and `alpha`, forming version numbers like:

- **`1.0.0-alpha`** - Early development version, unstable.
- **`1.0.0-beta`** - Feature complete, but potentially buggy.
- **`1.0.0-beta.2`** - Second beta version.
- **`1.0.0-rc1`** - Release candidate, potentially ready for release.
- **`1.0.0-preview`** - Preview version for early feedback.

**Version progression example:**

```
1.0.0-alpha.1
1.0.0-alpha.2
1.0.0-beta.1
1.0.0-beta.2
1.0.0-rc1
1.0.0-rc2
1.0.0
```

### Prerelease label conventions

**Common label prefixes:**

- **alpha:** Very early version, expect bugs and breaking changes.
- **beta:** Feature complete, undergoing testing.
- **rc (Release Candidate):** Potentially final version, last testing phase.
- **preview:** Early preview for feedback.
- **dev:** Development snapshot.

**Numeric suffixes:**

Labels often include numbers for sequential prereleases:

- `1.0.0-beta.1` → `1.0.0-beta.2` → `1.0.0-beta.3`

## Using prerelease versions

**Prereleases** are a common way to prepare for the release of the label-less version of the package.

### Benefits of prereleases

**Early feedback:**

**Early adopters** can take a dependency on a prerelease version to build using the new package.

- **Test integration:** Validate the package works with existing systems.
- **Report issues:** Find bugs before official release.
- **Provide feedback:** Suggest improvements or changes.

**Gradual rollout:**

- **Staged release:** Release to small audience first.
- **Risk mitigation:** Catch issues before wide release.
- **Confidence building:** Build confidence in stability.

### Prerelease cautions

Generally, **using a prerelease version of packages and their components for released software isn't a good idea**.

**Risks of using prereleases in production:**

- **Instability:** Prereleases may have undiscovered bugs.
- **Breaking changes:** Future prereleases may introduce breaking changes.
- **No guarantees:** No backward compatibility guarantees.
- **Support limitations:** Limited or no support for prerelease versions.

### Testing prerelease versions

**It's good to expect the impact of the new components by creating a separate branch in the codebase and using the prerelease version of the package.**

**Best practices for testing prereleases:**

- **Separate branch:** Create a feature branch for testing.
- **Isolated environment:** Test in non-production environment.
- **Monitor behavior:** Watch for unexpected behavior or performance issues.
- **Document issues:** Track any problems found.

**Chances are that there will be incompatible changes from a prerelease to the final version.**

## Metadata and build information

**SemVer 2.0** also supports **build metadata** appended with a plus sign:

```
1.0.0-beta.1+20231015.abc123
```

**Build metadata:**

- **Not considered in version precedence:** Two versions differing only in build metadata are considered equal.
- **Information purposes:** Useful for tracking build numbers, commit hashes.
- **Example:** `1.0.0+build.123` or `1.0.0-beta+exp.sha.5114f85`

## Version precedence

**SemVer defines clear rules for version precedence:**

### Comparison rules

1.  **Compare major, minor, patch:** In that order numerically.
2.  **Prerelease versions:** Always have lower precedence than associated normal version.
3.  **Label comparison:** Alphanumeric segments compared lexically, numeric segments compared numerically.

**Examples in order (lowest to highest):**

```
1.0.0-alpha
1.0.0-alpha.1
1.0.0-alpha.beta
1.0.0-beta
1.0.0-beta.2
1.0.0-beta.11
1.0.0-rc.1
1.0.0
1.0.1
1.1.0
2.0.0
```

## Semantic versioning benefits

**Clear communication:**

- **Intent:** Version number clearly communicates the nature of changes.
- **Compatibility:** Easy to determine if update is safe.
- **Predictability:** Consistent versioning across packages.

**Automated dependency management:**

- **Version constraints:** Package managers can resolve versions automatically.
- **Safe updates:** Tools can safely update to compatible versions.
- **Conflict resolution:** Easier to resolve dependency conflicts.

**Ecosystem adoption:**

- **Industry standard:** Widely adopted across many ecosystems.
- **Tooling support:** Package managers understand SemVer.
- **Community expectations:** Developers expect SemVer compliance.

## Semantic versioning in Azure Artifacts

**Azure Artifacts** supports **Semantic Versioning** across all package types:

- **NuGet:** Native SemVer 2.0 support.
- **npm:** SemVer is the standard.
- **Maven:** Compatible with SemVer principles.
- **Python:** PEP 440 is compatible with SemVer concepts.
- **Universal Packages:** Uses SemVer 2.0.

**Feed views and SemVer:**

- **@Prerelease view:** Automatically includes versions with labels.
- **@Release view:** Only includes versions without labels.
- **@Local view:** Shows all versions regardless of label.

## Implementing semantic versioning

**Manual versioning:**

- **Update package files:** Manually update version in `package.json`, `.nuspec`, etc.
- **Commit with tag:** Tag commit with version number.

**Automated versioning:**

```bash
# Using npm version command
npm version patch  # Increment patch: 1.0.0 -> 1.0.1
npm version minor  # Increment minor: 1.0.1 -> 1.1.0
npm version major  # Increment major: 1.1.0 -> 2.0.0

# With prerelease
npm version prerelease --preid=beta  # 1.0.0 -> 1.0.1-beta.0
```

**In CI/CD pipelines:**

```yaml
# Azure Pipelines example
- task: GitVersion@5
  inputs:
    runtime: "core"
    configFilePath: "GitVersion.yml"

- script: |
    echo "Semantic Version: $(GitVersion.SemVer)"
    echo "NuGet Version: $(GitVersion.NuGetVersion)"
  displayName: "Display version"
```

See also [Semantic Versioning 2.0.0](https://semver.org/).
