When building packages from a pipeline, the package needs to have a version before being consumed and tested.

Only after testing is the quality of the package known.

Since package versions can't and shouldn't be changed, it becomes challenging to choose a specific version beforehand.

Azure Artifacts recognizes a quality level of packages in its feeds and the difference between prerelease and release versions.

It offers different views on the list of packages and their versions, separating these based on their quality level.

It fits well with the use of semantic versioning of the packages for predictability of the intent of a particular version.

Still, its extra metadata from the Azure Artifacts feed is called a `descriptor`.

Feeds in Azure Artifacts have three different views by default. These views are added when a new feed is created. The three views are:

 -  **Release.** The `@Release` view contains all packages that are considered official releases.
 -  **Prerelease.** The `@Prerelease` view contains all packages that have a label in their version number.
 -  **Local.** The `@Local` view contains all release and prerelease packages and the packages downloaded from upstream sources.

## Using views

You can use views to offer help consumers of a package feed filter between released and unreleased versions of packages.

Essentially, it allows a consumer to make a conscious decision to choose from released packages or opt-in to prereleases of a certain quality level.

By default, the `@Local` view is used to offer the list of available packages. The format for this URI is:

```URL
https://pkgs.dev.azure.com/{yourteamproject}/_packaging/{feedname}/nuget/v3/index.json

```

When consuming a package feed by its URI endpoint, the address can have the requested view included. For a specific view, the URI includes the name of the view, which changes to be:

```URL
https://pkgs.dev.azure.com/{yourteamproject}/_packaging/{feedname}@{Viewname}/nuget/v3/index.json

```

The tooling will show and use the packages from the specified view automatically.

Tooling may offer an option to select prerelease versions, such as shown in this Visual Studio 2017 NuGet dialog. It doesn't relate or refer to the `@Prerelease` view of a feed. Instead, it relies on the presence of prerelease labels of semantic versioning to include or exclude packages in the search results.

See also:

 -  [Views on Azure DevOps Services feeds](/azure/devops/artifacts/concepts/views).
 -  [Communicate package quality with prerelease and release views](/azure/devops/artifacts/feeds/views).
