
Packages should be stored in a centralized place for distribution and consumption to take dependencies on the components it contains.

The centralized storage for packages is commonly called a `package feed`. There are other names in use, such as repository or registry.

We'll refer to all of these as package feeds unless it's necessary to use the specific name for clarity. Each package type has its type of feed.

Put another way. One feed typically contains one type of packages. There are NuGet feeds, npm feeds, Maven repositories, PyPi feed, and Docker registries.

Package feeds offer versioned storage of packages. A particular package can exist in multiple versions in the feed, catering for consumption of a specific version.

## Private and public feeds

The package feeds are centralized and available for many different consumers.

Depending on the package, purpose, and origin, it might be generally available or to a select audience.

Typically, open-source projects for applications, libraries, and frameworks are shared with everyone and publically available.

The feeds can be exposed in public or private to distinguish in visibility. Anyone can consume public feeds.

There might be reasons why you don't want your packages to be available publicly.

It could be because it contains intellectual property or doesn't make sense to share with other software developers.

Components developed for internal use might be available only to the project, team, or company that developed it.

In such cases, you can still use packages for dependency management and choose to store the package in a private package feed.

Private feeds can only be consumed by those who are allowed access.
