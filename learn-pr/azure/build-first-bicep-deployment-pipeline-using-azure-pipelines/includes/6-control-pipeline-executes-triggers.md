You now have a working pipeline that deploys your Bicep file to your Azure environment. However, you still need to manually run your pipeline. In this unit, you'll learn how to trigger your pipeline automatically when your Bicep code changes.

## What are pipeline triggers?

Pipeline triggers automatically run your pipeline based on rules you specify. You can configure them to run your pipeline at scheduled intervals. You can also configure triggers to run your pipeline every time the files in your repository changes. You do this because it's a good idea to run all of your tests and deployment steps every time your code changes.

If you don't use an automatic trigger, someone might make a change to a Bicep file, and even commit it and push it to the repository. If they forget to run the pipeline, then you have a difference between the resource definitions in your Bicep file and the resources that are actually deployed to your Azure environment. Suppose this happens for a couple of subsequent commits and pushes. If someone now introduces an error or misconfiguration in the Bicep file during one of these changes, it's hard to track back to where the error was introduced, since you have several commits to work through. After a while, you won't trust that your Bicep code truly represents your infrastructure, and its value is eroded.

When you configure your pipeline to run every time you update your files, the moment your changes are pushed, your pipeline will start running. This gives you instant feedback on the validity of your change and ensures that everything is always up to date.

## Types of pipeline triggers

Until now, you've been using a manual pipeline trigger:

```yaml
trigger: none
```

> [!NOTE]
> You can always manually trigger a pipeline, even if you've configured another trigger type.

Another common trigger is a _branch trigger_, which sometimes called a _continuous integration trigger_ or _CI trigger_. When you use this trigger, every time you make a change to a specified branch, the pipeline is run. If you commit and push a change to a different branch, the pipeline ignores it. It's common to use this trigger against your **main**  branch, like this:

```yaml
trigger: 
- main
```

You can also run your pipeline on a schedule. For example, you might run a nightly release of your Bicep code, or automatically deploy a test environment every morning. Use the `schedule` keyword instead of `trigger`, and specify the frequency by using a cron expression:

```yaml
schedules:
- cron: "0 0 * * *"
  displayName: Daily environment restore
  branches:
    include:
    - main
```

> [!NOTE]
> A _cron expression_ is a specially formatted sequence of characters that specify how often something should happen. In this example, `0 0 * * *` means _run every day at midnight UTC_.

You can also specify the branch of your repository that should be used when the schedule starts. When the pipeline begins, it will use the most recent version of the code from that branch.

You can combine triggers, like this:

```yaml
trigger: 
- main

schedules:
- cron: "0 0 * * *"
  displayName: Deploy test environment
  branches:
    include:
    - main
```

When you specify a branch trigger and a scheduled trigger in the same pipeline, then the pipeline will run every time a file changes on the specified branch, _and_ on the schedule you specify.

> [!TIP]
> It's a good practice to specify the triggers for each pipeline. If you don't, then by default your pipeline will automatically run whenever any files change on any branch, which isn't often what you want.

<!-- TODO here down -->

## Filtering pipeline execution through triggers

You might want more fine-grained control over when your pipeline runs. Suppose you have a situation where collaborators on your project create feature branches where they try things out in Bicep template files. These deployments also need to happen, but to their own personal Azure subscription and not to your shared development environment. In that case you may want to exclude these feature branches from triggering your pipeline. For doing this you can use the exclude statement: 

```YAML
trigger:
  branches:
    include:
    - main
    - releases/*
    exclude:
    - feature/*
```

In the above example the pipeline will trigger for every change that is made in the main branch, but also for every change that happens in any of the release branches. In this case all release branches use a naming convention, so releases/v1 will trigger a run as will releases/v2.4. If someone uses releases-v5 the pipeline will not be triggered. 
On top of that any feature branch will not trigger a pipeline run in the above example. 

Apart from using branches to determine when your pipeline triggers, you can also make use of path filters. This is handy when for certain changes you do want your pipeline to trigger, but not for other changes. Suppose that in your current repository you have your Bicep templates in a deploy folder and you also have a docs folder that holds documentation files. You want to trigger your pipeline when anyone makes a change to any of the Bicep templates in the deploy folder, however a change to one of the files in the docs folder does not need to trigger your pipeline. To configure this you can use a path filter: 

```YAML
# specific path build
trigger:
  branches:
    include:
    - main
  paths:
    exclude:
    - docs
    include:
    - deploy
```

