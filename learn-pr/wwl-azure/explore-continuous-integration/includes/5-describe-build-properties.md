
You may have noticed that in some demos, the build number was just an integer, yet in other demos, there's a formatted value that was based upon the date.

It is one of the items that can be set in the **Build Options**.

## Build number formatting

The example shown below is from the build options that were configured by the ASP.NET Web Application build template:

:::image type="content" source="../media/devops-continuous-integration-image-020-cc23bdae.png" alt-text="Screenshot of Build Options the build number format is shown.":::


In this case, the date has been retrieved as a system variable, then formatted via yyyyMMdd, and the revision is then appended.

## Build status

While we have been manually queuing each build, we'll soon see that builds can be automatically triggered.

It's a key capability required for continuous integration.

But there are times that we might not want the build to run, even if it's triggered.

It can be controlled with these settings:

:::image type="content" source="../media/devops-continuous-integration-image-021-e73bc37f.png" alt-text="Screenshot of the Build Status selections. Enabled is selected.":::


> [!NOTE]
> You can use the **Paused** setting to allow new builds to queue but to hold off then starting them.

## Authorization and timeouts

You can configure properties for the build job as shown here:

:::image type="content" source="../media/devops-continuous-integration-image-022-cd0ca433.png" alt-text="Screenshot of the Build Job Properties page. The build scope is project collection. The build timeout is 60. The build cancel timeout is 5 minutes.":::


The authorization scope determines whether the build job is limited to accessing resources in the current project. Or accessing resources in other projects in the project collection.

The build job timeout determines how long the job can execute before being automatically canceled.

A value of zero (or leaving the text box empty) specifies that there's no limit.

The build job cancel timeout determines how long the server will wait for a build job to respond to a cancellation request.

## Badges

Some development teams like to show the state of the build on an external monitor or website.

These settings provide a link to the image to use for it. Here's an example Azure Pipelines badge that has Succeeded:

:::image type="content" source="../media/devops-continuous-integration-image-023-0eca3a2b.png" alt-text="Screenshot of Azure Pipelines badge button that has Succeeded.":::


For more information, see [Build Pipeline Options](/azure/devops/pipelines/build/options).
