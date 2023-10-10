
In this exercise, you'll investigate Delivery Cadence.

## Steps

Let's look at when our release pipeline is used to create deployments. Mainly, it will involve the use of triggers.

When we refer to deployment, we refer to each stage. Each stage can have its triggers that determine when the deployment occurs.

1.  Click the lightning bolt on the **\_Parts Unlimited-ASP.NET-CI** artifact.

    :::image type="content" source="../media/continuous-deployment-trigger-ae5f36c9.png" alt-text="Screenshot of the continuous deployment trigger.":::


2.  In the Continuous Deployment trigger pane, click the **Disabled** option to enable continuous deployment. It will then say **Enabled**.

    :::image type="content" source="../media/continuous-deployment-enabled-6306dc80.png" alt-text="Screenshot of the continuous deployment enabled.":::


Once it's selected, every time a build completes, deployment of the release pipeline will start.

> [!NOTE]
> You can filter which branches affect it; for example, you could choose the main branch or a particular feature branch.

## Scheduled deployments

You might not want to have a deployment start every time a build completes.

It might be disruptive to testers downstream if it was happening too often.

Instead, it might make sense to set up a deployment schedule.

3.  Click on the **Scheduled release trigger** icon to open its settings.

    :::image type="content" source="../media/scheduled-release-trigger-ed9c4ea1.png" alt-text="Screenshot of the scheduled release trigger.":::


4.  In the Scheduled release trigger pane, click the **Disabled** option to enable the scheduled release. It will then say **Enabled** and extra options will appear.

    :::image type="content" source="../media/scheduled-release-timing-805e6e8a.png" alt-text="Screenshot of the scheduled release timing.":::


You can see in the screenshot that a deployment using the release pipeline would now occur each weekday at 3 AM.

For example, it might be convenient when you share a stage with testers who work during the day.

You don't want to constantly deploy new versions to that stage while they're working. This setting would create a clean, fresh environment for them at 3 AM each weekday.

> [!NOTE]
> The default timezone is UTC. You can change it to suit your local timezone, as it might be easier to work with when creating schedules.

5.  For now, we don't need a scheduled deployment. Click the **Enabled** button again to turn off the scheduled release trigger and close the pane.

## Pre-deployment triggers

6.  Click the lightning bolt on the **Development** stage to open the pre-deployment conditions.

    :::image type="content" source="../media/pre-deployment-conditions-9bf2a1cc.png" alt-text="Screenshot of the pre-deployment conditions.":::


> [!NOTE]
> Both artifact filters and schedules can be set at the pre-deployment for each stage rather than just at the artifact configuration level.

Deployment to any stage doesn't happen automatically unless you have chosen to allow that.
