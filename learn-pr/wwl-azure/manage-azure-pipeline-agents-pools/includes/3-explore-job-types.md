Azure DevOps supports four types of jobs to handle different execution scenarios:

## Agent pool jobs

The most common type of job. These jobs run on an agent that's part of an agent pool. Use these for standard build and deployment tasks that require an execution environment.

## Container jobs

Similar to agent pool jobs but run inside a container on an agent. This provides consistency and isolation by packaging your job environment with all its dependencies.

## Deployment group jobs

Jobs that run on systems in a deployment group. These are useful when you need to deploy to multiple target machines simultaneously, such as web servers in a farm.

## Agentless jobs

Jobs that run directly on Azure DevOps servers without requiring an agent. Also called server jobs, these are useful for tasks like approvals, REST API calls, or Azure Function executions that don't need a build environment.
