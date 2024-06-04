## How a parallel job is consumed by a build or release

Consider an organization that has only one Microsoft-hosted parallel job.

This job allows users in that organization to collectively run only one build or release job at a time.

When more jobs are triggered, they're queued and will wait for the previous job to finish.

:::image type="content" source="../media/parallel-job-consumption-8af32918.png" alt-text="Screenshot of Parallel job consumption.":::


A release consumes a parallel job only when it's being actively deployed to a stage.

While the release is waiting for approval or manual intervention, it doesn't consume a parallel job.

## A simple example of parallel jobs

 -  FabrikamFiber CI Build 102 (main branch) starts first.
 -  Deployment of FabrikamFiber Release 11 is triggered by the completion of FabrikamFiber CI Build 102.
 -  FabrikamFiber CI Build 101 (feature branch) is triggered. The build can't start yet because Release 11's deployment is active. So, the build stays queued.
 -  Release 11 waits for approvals. Fabrikam CI Build 101 starts because a release waiting for approvals doesn't consume a parallel job.
 -  Release 11 is approved. It resumes only after Fabrikam CI Build 101 is completed.

## Relationship between jobs and parallel jobs

The term job can refer to multiple concepts, and its meaning depends on the context:

 -  When you define a build or release, you can define it as a collection of jobs. When a build or release runs, you can run multiple jobs as part of that build or release.
 -  Each job consumes a parallel job that runs on an agent. When there aren't enough parallel jobs available for your organization, then the jobs are queued up and run one after the other.

You don't consume any parallel jobs when you run a server job or deploy to a deployment group.
