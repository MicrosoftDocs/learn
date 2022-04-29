Its proper software development practice to indicate changes to code with the introduction of an increased version number.

However small or large a change, it requires a new version. A component and its package can have independent versions and versioning schemes.

The versioning scheme can differ per package type. Typically, it uses a scheme that can indicate the kind of change that is made.

Most commonly, it involves three types of changes:

 -  **Major change** Major indicates that the package and its contents have changed significantly. It often occurs at the introduction of a new version of the package. It can be a redesign of the component. Major changes aren't guaranteed to be compatible and usually have breaking changes from older versions. Major changes might require a large amount of work to adopt the consuming codebase to the new version.
 -  **Minor change** Minor indicates that the package and its contents have extensive modifications but are smaller than a major change. These changes can be backward compatible with the previous version, although they aren't guaranteed to be.
 -  **Patch** A patch or revision is used to indicate that a flaw, bug, or malfunctioning part of the component has been fixed. Usually, It's a backward-compatible version compared to the previous version.

How artifacts are versioned technically varies per package type. Each type has its way of indicating the version in the metadata.

The corresponding package manager can inspect the version information. The tooling can query the package feed for packages and the available versions.

Additionally, a package type might have its conventions for versioning and a particular versioning scheme.

See also [Publish to NuGet feeds](/azure/devops/pipelines/artifacts/nuget#package-versioning).
