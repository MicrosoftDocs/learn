You can use multiple build agents to support multiple build machines. Either distribute the load, run builds in parallel, or use different agent capabilities.

As an example, components of an application might require different incompatible versions of a library or dependency.

## Multiple jobs in a pipeline

Adding multiple jobs to a pipeline lets you:

 -  Break your pipeline into sections that need different agent pools or self-hosted agents.
 -  Publish artifacts in one job and consume them in one or more subsequent jobs.
 -  Build faster by running multiple jobs in parallel.
 -  Enable conditional execution of tasks.

To add another agent job to an existing pipeline, click on the ellipsis and choose as shown in this image:

:::image type="content" source="../media/devops-ci-image-028-86cb5076.png" alt-text="Screenshot of the Add an Agent Job page.":::


## Parallel jobs

At the organization level, you can configure the number of parallel jobs that are made available.

:::image type="content" source="../media/devops-ci-image-027-d0c04920.png" alt-text="Screenshot of the Retention and Parallel Jobs page.":::


The free tier allows for one parallel job of up to 1800 minutes per month. The self-hosted agents have higher levels.

> [!NOTE]
> You can define a build as a collection of jobs rather than as a single job. Each job consumes one of these parallel jobs that run on an agent. If there aren't enough parallel jobs available for your organization, the jobs will be queued and run sequentially.

## Build Related Tooling

Azure DevOps can be integrated with a wide range of existing tooling used for builds or associated with builds.

Which build-related tools do you currently use?

What do you like or don't like about the tools?
