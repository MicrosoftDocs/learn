**Versioning** is a critical aspect of software development and package management. As software evolves, proper versioning ensures that dependencies are tracked accurately, changes are communicated effectively, and systems remain stable.

## Why versioning matters

Software changes over time. The **requirements** for the software don't stay the same.

**Evolution of software:**

- **Functionality growth:** The functionality it offers and its use will grow, change, and adapt based on feedback.
- **Platform evolution:** The hosting of an application might evolve as well, with new operating systems, new frameworks, and versions thereof.
- **Bug fixes:** The original implementation might contain flaws and bugs.
- **Continuous change:** Whatever the reason for the change, it's unlikely that the software is stable and doesn't need to change.

**Dependency impact:**

Since the software you build takes **dependencies** on other components, the same holds for the components and packages you build or use while building your software.

Correct **versioning** becomes essential to maintaining a codebase to keep track of which piece of software is currently being used.

## Versioning and dependency management

**Versioning** is also relevant for **dependency management**, as it relates to the versions of the packages and the components within.

**Tracking dependencies:**

Each **dependency** is identified by its **name** and **version**. It allows keeping track of the exact packages being used.

- **Unique identification:** Name + version uniquely identifies a package.
- **Independent lifecycle:** Each of the packages has its lifecycle and rate of change.
- **Version control:** Enables precise control over which package versions are used.

**Benefits of proper versioning:**

- **Reproducible builds:** Ensure builds produce consistent results.
- **Dependency resolution:** Package managers can resolve correct versions.
- **Impact assessment:** Understand the scope of changes in new versions.
- **Rollback capability:** Revert to previous versions when issues arise.

## Immutable packages

As packages get new **versions**, your codebase can choose when to use a new version of the packages it consumes.

### Version specification

It does so by specifying the **specific version** of the package it requires. This implies that packages themselves should always have a new version when they change.

**Why immutability matters:**

Whenever a package is **published** to a feed, it shouldn't be allowed to change anymore. If changed, it would be at the risk of introducing potential **breaking changes** to the code.

**Core principle:**

In essence, a published package is **immutable**.

### Package immutability rules

**Replacing or updating an existing version of a package isn't allowed.** Most package feeds don't allow operations that would change a current version.

**Impact of immutability:**

- **Reliability:** Consumers can trust that a version doesn't change unexpectedly.
- **Consistency:** All consumers get the same package for a given version.
- **Security:** Prevents malicious modification of existing versions.
- **Auditability:** Version history remains intact and traceable.

### Version progression

Regardless of the size of the change, a package can only be updated by **introducing a new version**.

**The new version should indicate the type of change and impact it might have.**

**Version numbering communicates:**

- **Scope of changes:** Major, minor, or patch updates.
- **Compatibility:** Breaking versus non-breaking changes.
- **Quality level:** Prerelease versus stable release.
- **Intent:** What the update is meant to accomplish.

## Module overview

This module explains **versioning strategies** for packaging, best practices for versioning, and **package promotion**.

**Topics covered:**

- **Artifact versioning fundamentals:** Understanding version types and schemes.
- **Semantic versioning:** Adopting SemVer 2.0 for consistent communication.
- **Azure Artifacts views:** Using @Local, @Prerelease, and @Release views.
- **Package promotion:** Moving packages between quality levels.
- **Automated versioning:** Pushing packages from CI/CD pipelines.
- **Best practices:** Implementing effective versioning strategies.

## Learning objectives

After completing this module, students and professionals can:

- **Understand versioning importance:** Recognize why proper versioning is critical for dependency management and software stability.
- **Implement versioning strategies:** Design and apply effective version numbering schemes for packages.
- **Use semantic versioning:** Apply Semantic Versioning (SemVer 2.0) principles for consistent version communication.
- **Manage package quality:** Use Azure Artifacts views to separate packages by quality level.
- **Promote packages:** Move packages through quality gates from prerelease to production.
- **Automate versioning:** Push packages from build pipelines with appropriate version numbers.
- **Apply best practices:** Follow industry standards for versioning and package management.

## Prerequisites

- **DevOps understanding:** Basic understanding of what DevOps is and its concepts.
- **Version control knowledge:** Familiarity with version control principles is helpful but isn't necessary.
- **Software delivery experience:** Beneficial to have experience in an organization that delivers software.
- **Azure DevOps access:** You need to create an Azure DevOps Organization and a Team Project for some exercises. If you don't have it yet, see:
  - [Create an organization - Azure DevOps](/azure/devops/organizations/accounts/create-organization).
- **Package management basics:** Understanding of packages, feeds, and dependency management from previous modules.
