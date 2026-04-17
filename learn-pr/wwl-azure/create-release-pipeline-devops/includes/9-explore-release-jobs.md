Build and release pipelines can be organized into jobs. Every build or deployment pipeline contains at least one job.

A job is a series of tasks that run sequentially on the same target. Targets include Windows servers, Linux servers, containers, or deployment groups.

Release jobs are executed by build/release agents. Each agent can only run one job at a time.

Job design involves specifying a series of tasks to run on the same agent.

When the build or release pipeline is triggered at runtime, each job is dispatched to its target.

Consider the following scenario demonstrating the essential role of jobs.

Consider an application with a .NET backend, an Angular frontend, and a native iOS mobile app. These components may be developed in separate source control repositories, triggering different builds and producing separate artifacts.

The release pipeline combines these artifacts and deploys the backend, frontend, and mobile app together as part of a single release.

Deployment requires different agent types for each component:

- iOS apps require building and distribution from macOS machines
- Angular apps hosted on Linux are best deployed from Linux machines
- .NET backends can be deployed from Windows machines

To include all three deployments in a single pipeline, define multiple release jobs targeting different agents, servers, or deployment groups.

By default, jobs run on the host machine where the agent is installed.

This approach is suitable for projects beginning continuous integration (CI) adoption.

Advanced scenarios require greater control over the execution environment for tasks.

:::image type="content" source="../media/jobs-d850fd27.png" alt-text="Screenshot of release jobs and tasks with multiple stages.":::

For more information, see [Jobs in Azure Pipelines](/azure/devops/pipelines/process/phases).
