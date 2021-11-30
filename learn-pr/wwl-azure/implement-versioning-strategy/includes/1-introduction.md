Software changes over time. The requirements for the software do not stay the same.

The functionality it offers and its use will grow, change, and adapt based on feedback.

The hosting of an application might evolve as well, with new operating systems, new frameworks, and versions thereof.

The original implementation might contain flaws and bugs. Whatever reason for the change, it is unlikely that software is stable and doesn't need to change.

Since the software you build takes dependencies on other components, the same holds for the components and packages you build or use while building your software.

To keep track of which piece of software is currently being used, correct versioning becomes essential to maintaining a codebase.

Versioning is also relevant for dependency management, as it relates to the versions of the packages and the components within.

Each dependency is identified by its name and version. It allows keeping track of the exact packages being used. Each of the packages has its lifecycle and rate of change.

## Immutable packages

As packages get new versions, your codebase can choose when to use a new version of the packages it consumes.

It does so by specifying the specific version of the package it requires. This implies that packages themselves should always have a new version when they change.

Whenever a package is published to a feed, it should not be allowed to change anymore.

If it were, it would be at the risk of introducing potential breaking changes to the code. In essence, a published package is immutable.

Replacing or updating an existing version of a package is not allowed. Most of the package feeds do not allow operations that would change a current version.

Regardless of the size of the change, a package can only be updated by introducing a new version.

The new version should indicate the type of change and impact it might have.

This module explains versioning strategies for packaging, best practices for versioning, and package promotion.

## Learning objectives

After completing this module, students and professionals can:

 -  Implement a versioning strategy.
 -  Promote packages.
 -  Push packages from pipeline.
 -  Describe semantic and explore best practices for versioning.

## Prerequisites

 -  Understanding of what DevOps is and its concepts.
 -  Familiarity with version control principles is helpful but isn't necessary.
 -  Beneficial to have experience in an organization that delivers software.
