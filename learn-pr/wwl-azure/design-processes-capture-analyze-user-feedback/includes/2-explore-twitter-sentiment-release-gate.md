Any responsible DevOps practice uses techniques to limit the damage done by bugs that get deployed into production.

One of the standard techniques is to break up a production environment into a set of separate instances of an app and then configure deployments to only update one instance at a time, with a waiting period between them.

During that waiting period, you watch for any signs (telemetry, customer complaints, and so on.) of a problem. If so, halt the deployment, fix the issue, and then continue the deployment. This way, any bug you deploy only affects a small fraction of your user base.

The first-product environment in the sequence is often only available to internal people in your organization to validate the changes before they hit “real” customers. Nonetheless, sometimes issues make it through.

Release gates automate the waiting period between environments in release pipelines. They enable you to configure conditions that will cause the release wait. A few conditions are supported out of the box, namely Azure monitoring alerts and Work item queries.

Using the first, you can have your release hold if your monitoring alerts indicate that the environments you have already deployed to are unhealthy. And the second allows you to automatically pause releases if anyone files a “blocking bug” against the release.

However, one of the things you'll quickly learn is that no amount of monitoring will catch every single problem, particularly if you have a popular application. Your users will know within seconds and turn quickly to Twitter to start asking about the problem.

Twitter can be an excellent “alert” to let you know something is wrong with your app. The Twitter sentiment release gate that can be downloaded from the Visual Studio Marketplace enables precisely it.

It uses Azure DevOps, Azure functions, and Microsoft AI to analyze sentiment on your Twitter handle and gate your release progress based on it.

The current implementation of the analysis is relatively simple and serves as a sample as much as anything else. It shows how easy it's to extend Azure DevOps release gates to measure any signal you choose and use that signal to manage your release process.

Once you install the Twitter sentiment extension from the marketplace, you'll need to follow the instructions to configure an Azure function to measure and analyze your sentiment. Then you can go into your Azure DevOps release pipelines, and you'll find a new release gate enabled.

Start by clicking on Post-deployment conditions on one of your environments.

:::image type="content" source="../media/post-deployment-environment-213ab6d4.png" alt-text="Demo. Environment.":::


Then enable the release gates.

:::image type="content" source="../media/enable-release-gates-65c96de8.png" alt-text="Enable release gates.":::


Then choose the Twitter Sentiment item and configure it.

:::image type="content" source="../media/twitter-sentiment-6333b023.png" alt-text="Twitter sentiment.":::


You can read up more about release gates at [Release deployment control-using gates](/azure/devops/pipelines/release/approvals/gates).
