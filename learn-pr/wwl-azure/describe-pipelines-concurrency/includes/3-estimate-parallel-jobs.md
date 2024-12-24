## Determine how many parallel jobs you need

You could begin by seeing if the free tier offered in your organization is enough for your teams.

When you've reached the 1,800 minutes per month limit for the free tier of Microsoft-hosted parallel jobs, you can start by buying one parallel job to remove this monthly time limit before deciding to purchase more.

As the number of queued builds and releases exceeds the number of parallel jobs you have, your build and release queues will grow longer.

When you find the queue delays are too long, you can purchase extra parallel jobs as needed.

## Simple estimate

A simple rule of thumb: Estimate that you'll need one parallel job for every four to five users in your organization.

## Detailed estimate

In the following scenarios, you might need multiple parallel jobs:

 -  If you have multiple teams, and if each of them requires a CI build, you'll likely need a parallel job for each team.
 -  If your CI build trigger applies to multiple branches, you'll likely need a parallel job for each active branch.
 -  If you develop multiple applications by using one organization or server, you'll likely need more parallel jobs: one to deploy each application simultaneously.

## View available parallel jobs

Browse to `Organization settings > Pipelines > Parallel jobs.`

## Location of parallel jobs in organization settings

URL example: `https://{your_organization}/_settings/buildqueue?_a=concurrentJobs`

View the maximum number of parallel jobs that are available in your organization.

Select View in-progress jobs to display all the builds and releases that are actively consuming an available parallel job or queued waiting for a parallel job to be available.

:::image type="content" source="../media/parallel-jobs-organization-settings-679bb5c6.png" alt-text="Screenshot of parallel jobs in organization settings.":::


## Sharing of parallel jobs across projects in a collection

Parallel jobs are purchased at the organization level, and they're shared by all projects in an organization.

Currently, there isn't a way to partition or dedicate parallel job capacity to a specific project or agent pool. For example:

 -  You purchase two parallel jobs in your organization.
 -  You queue two builds in the first project, and both the parallel jobs are consumed.
 -  You queue a build in the second project. That build won't start until one of the builds in your first project is completed.
