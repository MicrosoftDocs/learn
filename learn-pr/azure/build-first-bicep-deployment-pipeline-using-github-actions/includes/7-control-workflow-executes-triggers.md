You now have a working workflow that deploys your Bicep file to your Azure environment. However, whenever you change your files, you manually start your workflow. In this unit, you'll learn how to trigger your workflow automatically whenever your Bicep code changes.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## What are workflow triggers?

Triggers automatically run your workflow based on rules you specify. You can configure them to run your workflow at scheduled intervals. You can also configure triggers to run your workflow every time the files in your repository changes. You do this because it's a good idea to run all of your tests and deployment steps every time someone changes your code.

If you don't use an automatic trigger, someone might make a change to a Bicep file, and even commit it and push it to the repository. If they forget to run the workflow, there'll be a difference between the resource definitions in your Bicep file and the resources that are actually deployed to your Azure environment. Suppose this happens for a couple of subsequent commits and pushes. If someone introduces an error or misconfiguration in the Bicep file during one of these changes, it's hard to track down the error, since you have several commits to work through. After a while, you won't trust that your Bicep code truly represents your infrastructure, and its value is eroded.

When you configure your workflow to run every time you update your files, the moment your changes are pushed, your workflow will start running. This gives you instant feedback on the validity of your change and ensures that everything is always up to date.

In GitHub there are several types of events that can trigger your workflow. There is the manual _workflow_dispatch_ event we have been using up till now. There are scheduled events, in case you want to trigger your workflow based on a schedule. There are also webhook events, which can trigger workflows based on all the webhooks that GitHub has. There is a webhook event for when someone pushes code to your repository. There is also a webhook event for when someone creates an issue in your repository. In the latter case you will probably not want to deploy your Azure environment with a workflow, but you may want to run some other automation. There is quite a list of webhook events you can trigger your workflows on, however in this module we will focus on push events.  

## Push event triggers

A common trigger is a _push event trigger_, which sometimes called a _continuous integration trigger_ or _CI trigger_. When you use this trigger, every time you make a change to a specified file in the repository and this file is committed and pushed to the repository, the workflow is run. 

```yaml
on: push
```

This event type can also be configured to only run when pushes happen to certain branches. If you commit and push a change to a different branch, the workflow ignores it. It's common to use this trigger against your **main**  branch, like this:

```yaml
on:
  # Trigger the workflow on push or pull request,
  # but only for the main branch
  push:
    branches:
      - main
```

### Trigger when multiple branches change

You can customize the branches that cause your workflow to run. For example, suppose you create _release branches_ that contain the code you'll deploy for a specific release of your project. You use branch names like **release/v1**, **release/v2**, and so forth. You want to run your workflow anytime your code changes on a branch that begins with the name **release/**. You can use a `*` wildcard to express this:

```yaml
on:
  push:
    branches:    
      - main
      - 'release/**'
```

You can exclude certain branches with the `!` charachter. Suppose you want to trigger your workflow for your main branch and all release branches, except for the alpha releases: 

```yaml
on:
  push:
    branches:    
      - main
      - 'release/**'
      - '!release/**-alpha'
```

You can also decide to trigger your workflow based on all branches, but exclude specific branches. Suppose you're collaborating with team members on your project. Your colleagues create _feature branches_ to try out their ideas in Bicep files. All of these feature branches are given names like **feature/add-database**, **feature/improve-performance**, and so forth. You want to run your workflow automatically on all branches, except for the feature branches that your colleagues create. By using `branches-ignore`, you ensure the workflow isn't automatically triggered for changes to feature branches:

```yaml
on:
  push:
    branches-ignore:
      - 'feature/**'
```

> [!NOTE]
> You cannot use `branches` and `branches-ignore` for the same event type, so you either go for a pattern where you indicate what branches you want to trigger on with the `branches` keyword, or you go for a pattern where you want to trigger on all branches except for the ones you indicate with `branches-ignore`. 
> You can off course use the `branches` keyword in combination with the `!` charachter as in the above.


### Path filters

Sometimes, you have files in your repository that don't relate to your deployment. For example, in your repository you might have a _deploy_ folder that contains your Bicep code, and you only want to trigger your workflow in case there is a change to any of the Bicep files in that deploy folder: 

```yaml
on:
  push:
    paths:
      - 'deploy/**'
```

In case you have a _docs_ folder in your deploy folder with just documentation files and you don't want to trigger your workflow when anyone makes a change to those documentation files, you can ignore that subfolder with the `!` charachter: 

```yaml
on:
  push:
    paths:
      - 'deploy/**'
      - '!deploy/docs/**'
```

> [!NOTE]
> There is also a `paths-ignore` keyword you can use, which works in a similar manner to the `branches-ignore` keyword. Here as well you can not use `paths` and `paths-ignore` on the same event, so either you go for an inclusive setup or you go for an exclusive one.


## Schedule your workflow to run automatically

You can also run your workflow on a schedule. For example, you might run a nightly release of your Bicep code, or automatically deploy a test environment every morning. For setting this up you use the `schedule` keyword, and specify the frequency by using a cron expression:

```yaml
on:
  schedule:
    # * is a special character in YAML so you have to quote this string
    - cron:  '0 0 * * *'
```

> [!NOTE]
> A _cron expression_ is a specially formatted sequence of characters that specify how often something should happen. In this example, `0 0 * * *` means _run every day at midnight UTC_.

The schedule event will always run your workflow on the default branch of your repository. 

## Use multiple events

You can combine events, like in this example:

```yaml
on:
  push:
    branches:
      - main
  schedule:
    # * is a special character in YAML so you have to quote this string
    - cron:  '0 0 * * *'
```

When you specify a push event and a schedule event in the same workflow, then the workflow will run every time a file changes on the specified branch, _and_ on the schedule you specify. In this example, the workflow runs every day at midnight UTC, and also whenever a change is pushed to the **main** branch.

> [!TIP]
> It's a good practice to specify the events and branches for each workflow. If you don't, then by default your workflow will automatically run whenever any files change on any branch, which isn't often what you want.