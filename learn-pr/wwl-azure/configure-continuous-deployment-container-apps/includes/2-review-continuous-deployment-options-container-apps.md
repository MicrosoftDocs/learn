Continuous deployment to a container apps instance is implemented as an app versioning process. Azure Container Apps implements container app versioning by creating revisions. A revision is defined as an immutable snapshot of a container app version.

## Revision management

Azure Container Apps implements and manages revisions as follows:

- The first revision is automatically provisioned when you deploy your container app.
- New revisions are automatically provisioned when you make a revision-scope change to your container app.
- While revisions are immutable, they're affected by application-scope changes, which apply to all revisions.
- You can create new revisions by updating a previous revision.
- You can retain up to 100 revisions, giving you a historical record of your container app updates.
- You can run multiple revisions concurrently.
- You can split external HTTP traffic between active revisions.

![Diagram showing revisions associated with two container app instances.](../media/azure-container-apps-revisions.png)

## Continuous deployment to Azure Container Apps

Azure Container Apps provides support for continuous deployment using either GitHub Actions or Azure Pipelines. The scenarios below describe continuous deployments to a container app connected to container registry. Although the tools are distinct, they implement a similar process.

### Continuous deployment using GitHub Actions

Azure Container Apps allows you to use GitHub Actions to publish revisions to your container app. As commits are pushed to your GitHub repository, a workflow is triggered which updates the container image in the container registry. Azure Container Apps creates a new revision based on the updated container image.

![Diagram showing a GitHub Actions workflow deploying to Azure Container Apps connected to Container Registry.](../media/azure-container-apps-github-actions.png)

The GitHub Actions workflow is triggered by commits to a specific branch in your repository. When creating the workflow, you decide which branch triggers the workflow.

### Continuous deployment using Azure Pipelines

Azure Container Apps allows you to use Azure Pipelines to publish revisions to your container app. As commits are pushed to your Azure DevOps repository, a pipeline is triggered which updates the container image in the container registry. Azure Container Apps creates a new revision based on the updated container image.

The pipeline is triggered by commits to a specific branch in your repository. When creating the pipeline, you decide which branch is the trigger.

Azure DevOps and Azure Pipelines are examined in more detail in upcoming units.
