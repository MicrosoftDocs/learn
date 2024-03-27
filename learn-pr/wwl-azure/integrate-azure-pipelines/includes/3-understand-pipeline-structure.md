
A pipeline is one or more stages that describe a CI/CD process.

Stages are the primary divisions in a pipeline. The stages "Build this app," "Run these tests," and "Deploy to preproduction" are good examples.

A stage is one or more jobs, units of work assignable to the same machine.

You can arrange both stages and jobs into dependency graphs. Examples include "Run this stage before that one" and "This job depends on the output of that job."

A job is a linear series of steps. Steps can be tasks, scripts, or references to external templates.

This hierarchy is reflected in the structure of a YAML file like:

 -  Pipeline
     -  Stage A
         -  Job 1
             -  Step 1.1
             -  Step 1.2
             -  ...
         -  Job 2
             -  Step 2.1
             -  Step 2.2
             -  ...
     -  Stage B
         -  ...

Simple pipelines don't require all these levels. For example, you can omit the containers for stages and jobs in a single job build because there are only steps.

Because many options shown in this article aren't required and have reasonable defaults, your YAML definitions are unlikely to include all of them.

## Pipeline

The schema for a pipeline:

```YAML
name: string  # build numbering format
resources:
  pipelines: [ pipelineResource ]
  containers: [ containerResource ]
  repositories: [ repositoryResource ]
variables: # several syntaxes
trigger: trigger
pr: pr
stages: [ stage | templateReference ]

```

If you have a single-stage, you can omit the stages keyword and directly specify the jobs keyword:

```YAML
# ... other pipeline-level keywords
jobs: [ job | templateReference ]

```

If you've a single-stage and a single job, you can omit the stages and jobs keywords and directly specify the steps keyword:

```YAML
# ... other pipeline-level keywords
steps: [ script | bash | pwsh | powershell | checkout | task | templateReference ]

```

## Stage

A stage is a collection of related jobs. By default, stages run sequentially. Each stage starts only after the preceding stage is complete.

Use approval checks to control when a stage should run manually. These checks are commonly used to control deployments to production environments.

Checks are a mechanism available to the resource owner. They control when a stage in a pipeline consumes a resource.

As an owner of a resource like an environment, you can define checks required before a stage that consumes the resource can start.

This example runs three stages, one after another. The middle stage runs two jobs in parallel.

```YAML
stages:

- stage: Build
  jobs:

  - job: BuildJob
    steps:

    - script: echo Building!
- stage: Test
  dependsOn: Build
  jobs:

  - job: TestOnWindows
    steps:

    - script: echo Testing on Windows!
  - job: TestOnLinux
    steps:

    - script: echo Testing on Linux!
- stage: Deploy
  dependsOn: Test
  jobs:

  - job: Deploy
    steps:

    - script: echo Deploying the code!

```

## Job

A job is a collection of steps run by an agent or on a server. Jobs can run conditionally and might depend on previous jobs.

```YAML
jobs:

- job: MyJob
  displayName: My First Job
  continueOnError: true
  workspace:
    clean: outputs
  steps:

  - script: echo My first job

```

## Deployment strategies

Deployment strategies allow you to use specific techniques to deliver updates when deploying your application.

Techniques examples:

 -  Enable initialization.
 -  Deploy the update.
 -  Route traffic to the updated version.
 -  Test the updated version after routing traffic.
 -  If there's a failure, run steps to restore to the last known good version.

### RunOnce

runOnce is the most straightforward deployment strategy in all the presented lifecycle hooks.

```YAML
strategy:
    runOnce:
        preDeploy:
            pool: [ server | pool ] # See pool schema.
            steps:
            - script: [ script | bash | pwsh | powershell | checkout | task | templateReference ]
        deploy:
            pool: [ server | pool ] # See pool schema.
            steps: ...
        routeTraffic:
            pool: [ server | pool ]
            steps:
            ...
        postRouteTraffic:
            pool: [ server | pool ]
            steps:
            ...
        on:
            failure:
                pool: [ server | pool ]
                steps:
                ...
            success:
                pool: [ server | pool ]
                steps:
                ...
```

*For details and examples, see [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs).*

### Rolling

A rolling deployment replaces instances of the previous version of an application with instances of the new version. It can be configured by specifying the keyword rolling: under the strategy: node.

```YAML
strategy:
    rolling:
        maxParallel: [ number or percentage as x% ]
        preDeploy:       
            steps:
            - script: [ script | bash | pwsh | powershell | checkout | task | templateReference ]
        deploy:         
            steps:
            ...
        routeTraffic:       
            steps:
            ...       
        postRouteTraffic:         
            steps:
            ...
        on:
            failure:       
                steps:
                ...
            success:         
                steps:
                ...
```

*For details and examples, see [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs).*

### Canary

Using this strategy, you can first roll out the changes to a small subset of servers. The canary deployment strategy is an advanced deployment strategy that helps mitigate the risk of rolling out new versions of applications.

As you gain more confidence in the new version, you can release it to more servers in your infrastructure and route more traffic to it.

```YAML
strategy:
    canary:
        increments: [ number ]
        preDeploy:       
            pool: [ server | pool ] # See pool schema.       
            steps:
            - script: [ script | bash | pwsh | powershell | checkout | task | templateReference ]
        deploy:         
            pool: [ server | pool ] # See pool schema.       
            steps:
            ...
        routeTraffic:       
            pool: [ server | pool ]       
            steps:
            ...       
        postRouteTraffic:         
            pool: [ server | pool ]       
            steps:
            ...
        on:
            failure:       
                pool: [ server | pool ]         
                steps:
                ...
            success:         
                pool: [ server | pool ]         
                steps:
                ...
```

*For details and examples, see [Deployment jobs](/azure/devops/pipelines/process/deployment-jobs).*

## Lifecycle hooks

You can achieve the deployment strategies technique by using lifecycle hooks. Depending on the pool attribute, each resolves into an agent or [server job](/azure/devops/pipelines/process/phases).

Lifecycle hooks inherit the pool specified by the deployment job. Deployment jobs use the `$(Pipeline.Workspace)` system variable.

Available lifecycle hooks:

 -  **preDeploy:** Used to run steps that initialize resources before application deployment starts.
 -  **deploy:** Used to run steps that deploy your application. Download artifact task will be auto-injected only in the deploy hook for deployment jobs. To stop downloading artifacts, use - download: none or choose specific artifacts to download by specifying [Download Pipeline Artifact task](/azure/devops/pipelines/yaml-schema/steps-download).
 -  **routeTraffic:** Used to run steps that serve the traffic to the updated version.
 -  **postRouteTraffic:** Used to run the steps after the traffic is routed. Typically, these tasks monitor the health of the updated version for a defined interval.
 -  **on: failure** or **on: success:** Used to run steps for rollback actions or clean-up.

## Steps

A step is a linear sequence of operations that make up a job. Each step runs its process on an agent and accesses the pipeline workspace on a local hard drive.

This behavior means environment variables aren't preserved between steps, but file system changes are.

```YAML
steps:

- script: echo This run in the default shell on any machine
- bash: |
    echo This multiline script always runs in Bash.
    echo Even on Windows machines!

- pwsh: |
    Write-Host "This multiline script always runs in PowerShell Core."
    Write-Host "Even on non-Windows machines!"

```

## Tasks

Tasks are the building blocks of a pipeline. There's a catalog of tasks available to choose from.

```YAML
steps:

- task: VSBuild@1
  displayName: Build
  timeoutInMinutes: 120
  inputs:
    solution: '**\*.sln'

```
