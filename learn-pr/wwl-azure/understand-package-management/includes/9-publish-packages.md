
As software is developed and components are written, you'll most likely produce components as dependencies packaged for reuse.

Discussed previously was guidance to find components that can be isolated into dependencies.

These components need to be managed and packaged. After that, they can be published to a feed, allowing others to consume the packages and use the components it contains.

## Creating a feed

The first step is to create a feed where the packages can be stored. In Azure Artifacts, you can create multiple feeds, which are always private.

During creation, you can specify the name, visibility and prepopulate the default public upstream sources for NuGet, npm, and Python packages.

## What are feeds in Azure Artifacts?

Most package management systems provide endpoints where you can request packages to install in your applications. Those endpoints are called feeds.

In Azure Artifacts, you can have multiple feeds in your projects, and you can make them available to only users authorized in your project or for your entire organization.

Each feed can contain any packages, even mixed types, but it's recommended that you create one feed per type you want to support in your organization, this way, it's clear what the feed contains.

Each feed can contain one or more upstream and can manage its security.

## Controlling access

The Azure Artifacts feed you created is always private and not available publically.

You need access to it by authenticating to Azure Artifacts with an account with access to Azure DevOps and a team project.

By default, a feed will be available to all registered users in Azure DevOps.

You can select it to be visible only to the team project where the feed is created.

Whichever option is chosen, you can change the permissions for a feed from the settings dialog.

## Push packages to a feed

Once you've authenticated to Azure DevOps, you can pull and push packages to the package feed, provided you have permission to do so.

Pushing packages is done with the tooling for the package manager. Each of the package managers and tooling has a different syntax for pushing.

To manually push a NuGet package, you would use the `NuGet.exe` command-line tool. For a package called `MyDemoPackage,` the command would resemble:

```Cmd
nuget.exe push -Source {NuGet package source URL} -ApiKey YourKey YourPackage\YourPackage.nupkg

```

## Updating packages

Packages might need to be updated during their lifetime. Technically, updating a package is made by pushing a new version of the package to the feed.

The package feed manager manages to properly store the updated package with the existing packages in the feed.

> [!NOTE]
> Updating packages requires a versioning strategy.
