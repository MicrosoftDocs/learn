A pipeline is one or more stages that describe a CI/CD process. Stages are the primary divisions in a pipeline.

The stages "Build this app," "Run these tests," and "Deploy to preproduction" are good examples.

A stage is one or more jobs, which are units of work assignable to the same machine.

You can arrange both stages and jobs into dependency graphs.

Examples include "Run this stage before that one" and "This job depends on the output of that job."

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

Simple pipelines don't require all these levels.

For example, you can omit the containers for stages and jobs in a single job build because there are only steps.

Because many options shown in this article aren't required and have reasonable defaults, your YAML definitions are unlikely to include all of them.

## Pipeline

The schema for a pipeline...

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
  jobs:

  - job: TestOnWindows
    steps:

    - script: echo Testing on Windows!
  - job: TestOnLinux
    steps:

    - script: echo Testing on Linux!
- stage: Deploy
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

## Steps

A step is a linear sequence of operations that make up a job.

Each step runs its process on an agent and accesses the pipeline workspace on a local hard drive.

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
