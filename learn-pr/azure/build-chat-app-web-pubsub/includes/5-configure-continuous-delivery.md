In this module, GitHub provides source control for the Static Web Apps application. Every time there's a code change to the source repo, which you control, a new build of your web app is automatically triggered by GitHub Actions and deployed to Azure. Static Web Apps detects the new build and automatically delivers it to the end users.

- With continuous delivery, many features of the chat app can be updated and integrated without interrupting customers' real-time use.
- Depending on updates to functionality of the static web app, you might need to update or reconfigure event handlers in the Web PubSub instance.

> [!NOTE]
> This module uses a GitHub repo and GitHub Actions to implement continous delivery of the static web app. You could configure similar functionality using [Azure Repos](/azure/devops/repos/) and [Azure Pipelines](/azure/devops/pipelines/).