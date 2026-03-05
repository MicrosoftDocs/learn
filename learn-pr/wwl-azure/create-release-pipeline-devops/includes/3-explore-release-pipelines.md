A release pipeline takes artifacts and releases them through stages and finally into production.

:::image type="content" source="../media/pipeline-7793ffc6.png" alt-text="Screenshot of a release pipeline with dev, QA and production stages.":::

Each component serves a specific purpose in the deployment workflow.

The first component is an artifact:

- Artifacts originate from various sources.
- The most common source is a package from a build pipeline.
- Another common artifact source is source control repositories.

Release pipelines include triggers that initiate new releases.

Trigger types include:

- Manual triggers initiated by team members.
- Scheduled triggers activated at specific times.
- Continuous deployment triggers activated by events such as completed builds.

Another vital component is stages (also called environments), where artifacts are deployed. For example, a compiled website artifact is installed on a web server or cloud platform. Multiple stages can exist in a pipeline; selecting the appropriate combination of stages is part of the release strategy.

Another component of a release pipeline is approval.

People often want to sign a release before installing it in the environment.

In more mature organizations, this manual approval process can be replaced by an automatic process that checks the quality before the components move on to the next stage.

Tasks within stages define the specific steps required to install, configure, and validate deployed artifacts.

This module covers all release pipeline components and considerations for each element.

Release pipeline components create individual releases. The release pipeline serves as the blueprint for the release process, distinct from the actual releases themselves. The module explores these concepts when discussing release quality and processes.

See also [Release pipelines](/azure/devops/pipelines/release).
