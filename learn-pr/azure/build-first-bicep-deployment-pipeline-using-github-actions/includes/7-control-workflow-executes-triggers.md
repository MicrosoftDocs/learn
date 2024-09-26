You now have a working workflow that deploys your Bicep file to your Azure environment. However, whenever you change your file, you must manually run your workflow. In this unit, you'll learn how to trigger your workflow to run automatically whenever your Bicep code changes.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## What is a workflow trigger?

A workflow trigger is a condition that, when met, automatically runs your workflow based on rules you create. You can set triggers to run your workflow at scheduled intervals. You can also set triggers to run your workflow every time a file in your repository changes. You might choose the second option, because it's a good idea to run all your tests and deployment steps every time someone changes your code.

If you don't use an automatic trigger, someone might make a change to a Bicep file, and even commit it and push it to the repository, but if they forget to run the workflow, there will be a difference between the resource definitions in your Bicep file and the resources that are deployed to your Azure environment. Suppose a couple more commits and pushes are made, but not deployed. If someone introduces an error or misconfiguration in the Bicep file in one of these changes, it might be hard to track down the error among the multiple commits that are later deployed at once. After a while, you won't trust that your Bicep code truly represents your infrastructure, and its value is eroded.

When you set up your workflow to run every time you update your files, the moment your changes are pushed, your workflow starts running. You get instant feedback on your change's validity, and you can be sure that your production environment is always up to date.

## Push event triggers

A common type of trigger is a _push event trigger_, also called a _continuous integration trigger_ or _CI trigger_. When you use a push event trigger, every time you make a change to a specific branch, the workflow runs. If you commit and push a change to a different branch, the workflow isn't triggered and it doesn't run. It's common to use this type of trigger against your default or _main_ branch, with this code:

```yaml
on:
  push:
    branches:
      - main
```

### Trigger when multiple branches change

You can set up triggers to run your workflow on a specific branch or on sets of branches. For example, suppose you create _release branches_ that contain the code you'll deploy for a specific release of your project. You can use branch names like _release/v1_, _release/v2_, and so on. You want to run your workflow anytime your code changes on a branch that begins with the name _release/_. You can use a `**` wildcard:

```yaml
on:
  push:
    branches:
      - main
      - 'release/**'
```

You can exclude specific branches, too. Suppose you're collaborating with team members on your project. Your colleagues create _feature branches_ to try out their ideas in Bicep files. All feature branches have names like _feature/add-database_, _feature/improve-performance_, and so on. You want to run your workflow automatically on all branches except for the feature branches that your colleagues create. By using the `exclude` property, you ensure that the workflow isn't automatically triggered for changes to feature branches:

```yaml
on:
  push:
    branches-ignore:
      - 'feature/**'
```

> [!NOTE]
> You can exclude certain branches by using the `!` character. Suppose you want to trigger your workflow for your main branch and all release branches, except for the alpha releases. You can use the `!` character to express this:
>
> ```yaml
> on:
>   push:
>     branches:
>       - main
>       - 'release/**'
>       - '!release/**-alpha'
> ```
>
> You can't use `branches` and `branches-ignore` together in one trigger, so the `!` character provides you with flexibility to control your trigger's behavior.

### Path filters

Sometimes, you have files in your repository that aren't related to your deployment. For example, you might have a _deploy_ folder in your repository that contains your Bicep code and a _docs_ subfolder that contains your documentation files. You want to trigger your workflow when anyone makes a change to any of the Bicep files in the _deploy_ folder, but you don't want to trigger the workflow if someone only changes a documentation file. To set up a trigger to respond to changes in a specific folder in your repository, you can use a _path filter_:

```yaml
on:
  push:
    paths:
      - 'deploy/**'
      - '!deploy/docs/**'
```

If someone commits a change that updates only a documentation file, the workflow doesn't run. But if someone changes a Bicep file, or even if they change a Bicep file in addition to a documentation file, the trigger runs the workflow.

> [!NOTE]
> You can also use `paths-ignore`, which works in a similar manner to the `branches-ignore` keyword. However, you can't use `paths` and `paths-ignore` in the same trigger.

## Schedule your workflow to run automatically

You can run your workflow on a set schedule, and not in response to a file change. For example, you might run a nightly release of your Bicep code or automatically deploy a test environment every morning. Use the `schedule` keyword, and set the frequency by using a cron expression:

```yaml
on:
  schedule:
    - cron: '0 0 * * *'
```

> [!NOTE]
> A _cron expression_ is a specially formatted sequence of characters that specify how often something should happen. In this example, `0 0 * * *` means _run every day at midnight UTC_.
>
> In a YAML file, you need to add quotation marks around strings that contain the `*` character, such as cron expressions.

The schedule event always runs your workflow on the default branch of your repository.

## Use multiple triggers

You can combine triggers and schedules, like in this example:

```yaml
on:
  push:
    branches:
      - main
  schedule:
    - cron: '0 0 * * *'
```

When you create a branch trigger _and_ a scheduled trigger in the same workflow, the workflow runs every time a file changes on the branch that's set in the trigger _and_ on the schedule you set. In this example, the workflow runs every day at midnight UTC and also whenever a change is pushed to the _main_ branch.

> [!TIP]
> It's a good practice to set triggers for each workflow. If you don't set triggers, by default, your workflow automatically runs whenever any file changes on any branch, which often isn't what you want.

## Webhook triggers

GitHub also provides webhook events, which run automatically when certain events happen in your repository. These events include someone creating a branch, updates to your GitHub issues, or changes to pull requests. Generally, these events don't require your Bicep deployment workflow to run, but you might run other automation instead.

## Concurrency control

By default, GitHub Actions allows multiple instances of your workflow to run simultaneously. This can happen when you make multiple commits to a branch within a short time, or if a previous run hasn't finished when your schedule next triggers.

In some situations, having multiple concurrent runs of your workflow isn't a problem. When you work with deployment workflows, however, it can be challenging to ensure that your workflow runs aren't overwriting your Azure resources or configuration in ways that you don't expect.

To avoid these problems, you can apply _concurrency control_. Use the `concurrency` keyword, then specify a string that's consistent across all of the runs for your workflow. It's usually a hard-coded string, like in this example:

```yaml
concurrency: MyWorkflow
```

GitHub Actions then ensures that it waits for any active workflow run to complete before starting a new run.
