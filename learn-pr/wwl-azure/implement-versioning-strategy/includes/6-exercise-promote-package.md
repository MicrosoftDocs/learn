> [!IMPORTANT]
> Have access to an existing Azure DevOps project and the connected package feed from the previous demo [Create a package feed](/training/modules/understand-package-management/10-create-package-feed).

## Steps to demonstrate the views on package feeds in Azure Artifacts

1. Go to dev.azure.com and open your team project.
1. Open **Artifacts** and select the feed **PartsUnlimited**. :::image type="content" source="../media/azure-devops-feed-0c78c191.png" alt-text="Screenshot of PartsUnlimited feed from Artifacts.":::
    
1. Go to **Artifacts** and click **Feed Settings**. :::image type="content" source="../media/azure-devops-feed-settings-d3fe46fe.png" alt-text="Screenshot of PartsUnlimited feed settings from Artifacts.":::
    
1. Open the **Views** tab. By default, there will be three views. Local: includes all packages in the feed and all cached from upstream sources. Prerelease and Release. In the **Default view** column is a check behind Local. It's the default view that will always be used.

## Steps to use the release view instead

1. Open Visual Studio and open NuGet Package Manager.
1. Click the settings wheel and check the source address for the PartsUnlimited feed. If you want to use a different view than the local view, you need to include that in the Source URL of your feed by adding @Release.
1. Add `@Release` to the source URL `../PartsUnlimited@Release/nuget/..` And click **Update**.
1. **Refresh** the Browse tab. You'll see there are **No packages found** in the Release feed. Before any packages appear, you need to promote them.

## Steps to promote packages to views

1. Go back to your feed in Azure Artifacts.
1. Click on the created NuGet Package **PartsUnlimited.Security**.
1. Click **Promote**.
1. Select the feed you want to use, in this case, **PartsUnlimited@Release,** and Promote.
1. Go back to the **Overview**. If we look again at our package in the feed, you'll notice a Release tag is now associated with this package.
1. Go back to Visual Studio, **NuGet Package Manager**.
1. **Refresh** the Browse tab. You'll see that your version is promoted to this view.
1. Select **PartsUnlimited.Security** and click **Update** and **OK**. The latest version of this package is now used.
