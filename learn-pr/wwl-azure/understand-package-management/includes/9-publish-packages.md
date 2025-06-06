As software is developed and components are written, you'll most likely produce components as dependencies packaged for reuse.

Discussed previously was guidance to find components that can be isolated into dependencies.

These components need to be managed and packaged. After that, they can be published to a feed, allowing others to consume the packages and use the components it contains.

## Create a feed

The first step is to create a feed where your packages will be stored. Azure Artifacts allows you to create multiple feeds as needed.

When creating a feed, you can specify the name, set the visibility, and choose whether to include packages from common public sources such as NuGet.org and npmjs.com.

## What are feeds in Azure Artifacts?

In Azure Artifacts, you can create multiple feeds within your projects. Feeds can be scoped to your project or made available across your entire organization.

Feeds can store packages of different types such as npm, NuGet, Maven, Python, Cargo, and Universal Packages. Each feed can include one or more upstream sources and has its own configurable security settings.

Azure Artifacts enables developers to store, manage, and share their packages while maintaining access control. Developers can control how packages are shared, restricting access to specific users, teams, or organizations, or making packages publicly available.
 
## Publish packages to a feed

Azure Artifacts supports a wide range of package types and technologies. Each package manager has a different workflow for authenticating with Azure Artifacts and publishing packages to a feed.

To find the right workflow for your technology, sign in to your Azure DevOps organization, navigate to **Artifacts**, then select **Connect to feed**. From the left panel, choose the package type you're working with and follow the **Project setup** instructions. See [Get started with Azure Artifacts](/azure/devops/artifacts/start-using-azure-artifacts#get-started) for more details.

## Updating packages

Packages might need to be updated during their lifetime. Technically, updating a package is made by pushing a new version of the package to the feed.

The package feed manager manages to properly store the updated package with the existing packages in the feed.

> [!NOTE]
> Updating packages requires a versioning strategy.
