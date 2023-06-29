
You can organize your build or release pipeline into jobs. Every build or deployment pipeline has at least one job.

A job is a series of tasks that run sequentially on the same target. It can be a Windows server, a Linux server, a container, or a deployment group.

A release job is executed by a build/release agent. This agent can only run one job at the same time.

You specify a series of tasks you want to run on the same agent during your job design.

When the build or release pipeline is triggered at runtime, each job is dispatched to its target as one or more.

A scenario that speaks to the imagination, where Jobs plays an essential role, is the following.

Assume that you built an application with a backend in .NET, a front end in Angular, and a native IOS mobile App. It might be developed in three different source control repositories triggering three other builds and delivering three other artifacts.

The release pipeline brings the artifacts together and wants to deploy the backend, frontend, and Mobile App all together as part of one release.

The deployment needs to take place on different agents.

If an IOS app needs to be built and distributed from a Mac, the angular app is hosted on Linux, so best deployed from a Linux machine.

The backend might be deployed from a Windows machine.

Because you want all three deployments to be part of one pipeline, you can define multiple Release Jobs targeting the different agents, servers, or deployment groups.

By default, jobs run on the host machine where the agent is installed.

It's convenient and typically well suited for projects just beginning to adopt continuous integration (CI).

Over time, you may want more control over the stage where your tasks run.

:::image type="content" source="../media/jobs-d850fd27.png" alt-text="Screenshot of release jobs and tasks with multiple stages.":::


For more information, see [Jobs in Azure Pipelines](/azure/devops/pipelines/process/phases).
