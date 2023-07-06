
Previously you learned about packaging dependencies and the various packaging formats, feeds, sources, and package managers.

Now, you'll know more about package management, creating a feed, and publishing packages.

During this module, NuGet and Azure Artifacts are used as an example of a package format and a particular package feed and source type.

Microsoft Azure DevOps provides various features for application lifecycle management, including:

 -  Work item tracking.
 -  Source code repositories.
 -  Build and release pipelines.
 -  Artifact management.

The artifact management is called `Azure Artifacts` and was previously known as `Package management`. It offers public and private feeds for software packages of various types.

## Types of packages supported

Azure Artifacts currently supports feeds that can store five different package types:

 -  NuGet packages
 -  npm packages
 -  Maven
 -  Universal packages
 -  Python

Previously, we discussed the package types for NuGet, npm, Maven, and Python. Universal packages are an Azure Artifacts-specific package type. In essence, it's a versioned package containing multiple files and folders.

A single Azure Artifacts feed can contain any combination of such packages. You can connect to the feed using the package managers and the corresponding tooling for the package types. For Maven packages, this can also be the Gradle build tool.

## Selecting package sources

When creating your solution, you'll decide which packages you want to consume to offer the dependent components.

The next step is to determine the sources for these packages. The main choice is selecting public and private feeds or a combination of it.

Publically available packages can usually be found in the public package sources. It would be nuget.org, npmjs, and pypi.org.

Your solution can select these sources if it only consumes packages available there.

Whenever your solution also has private packages that can't be available on public sources, you'll need to use a private feed.

In the previous module, you learned that public package sources could be upstream sources to private feeds.

Azure Artifacts allows its feeds to specify one or more upstream sources, public, or other private feeds.
