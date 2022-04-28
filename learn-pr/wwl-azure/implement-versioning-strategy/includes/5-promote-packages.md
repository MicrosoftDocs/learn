Azure Artifacts has the notion of promoting packages to views to indicate that a version is of a certain quality level.

By selectively promoting packages, you can plan when packages have a certain quality and are ready to be released and supported by the consumers.

You can promote packages to one of the available views as the quality indicator.

Release and Prerelease's two views might be sufficient, but you can create more views when you want finer-grained quality levels if necessary, such as `alpha` and `beta`.

**Packages** will always show in the Local view, but only in a particular view after being promoted.

Depending on the URL used to connect to the feed, the available packages will be listed.

**Upstream** sources will only be evaluated when using the @Local view of the feed.

After they've been downloaded and cached in the @Local view, you can see and resolve the packages in other views after being promoted to it.

It's up to you to decide how and when to promote packages to a specific view.

This process can be automated by using an Azure Pipelines task as part of the build pipeline.

Packages that have been promoted to a view won't be deleted based on the retention policies.
