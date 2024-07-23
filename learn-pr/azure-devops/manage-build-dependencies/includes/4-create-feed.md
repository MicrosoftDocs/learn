In this unit, you'll set up Azure Artifacts and create a new feed. You'll use this feed later to store your new Models package and to consume the package in your app pipeline.

## Set up Azure Artifacts

1. From Azure DevOps, go to the **Artifacts** tab, and then select **+ Create feed**.
    1. Name the feed *Tailspin.SpaceGame.Web.Models*.
    1. Under **Visibility**, select **Members of (your organization name)**.
    1. Under **Upstream sources**, unselect **Include packages from common public sources**.

        The other choice, to use public sources, is if you want to create an *upstream* from this feed, meaning you can access your packages and packages from public package managers like NuGet or npmjs from this feed.

    1. Under **Scope**, leave the **Project** option selected.
    1. Select **Create**.

        :::image type="content" source="../media/4-setup-azure-artifacts-feed.png" alt-text="A screenshot showing the details of the Create new feed dialog.":::

1. Select **Connect to feed**.

    This has a list of links, commands, and a credential provider you could use if you wanted to run this locally by using Visual Studio.

    > [!NOTE]
    > In practice, you'd connect your application to the feed so that you can pull down packages and include them when you build and run your application locally. For brevity, we'll skip this part.

**Andy:** I've got Azure Artifacts set up. Now, we need to create a pipeline that creates the new package there.
