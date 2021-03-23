Here, we discuss the components and common configurations within a workflow file. We also take a closer look at the categories of event types, disabling and deleting workflows, and using specific versions of an action for security best practices. 

## The components of GitHub Actions

![workflow](https://user-images.githubusercontent.com/6351798/106820078-ff74a100-6637-11eb-80f1-9b629806dacd.png)

There are several components that work together to run tasks or jobs within a GitHub Actions workflow. In short, an event triggers the workflow, which contains a job. This job then uses steps to dictate which actions will run within the workflow. To better see how these components work together, let's take a quick look at each one.

### Workflows

A workflow is an automated process that you add to your repository. A workflow needs to have at least one job and can be triggered by different events. It can be used to build, test, package, release, or deploy your repository's project on GitHub.

### Jobs

The job is the first major component within the workflow. A job is a section of the workflow that will be associated with a runner. A runner can be GitHub-hosted or self-hosted and the job can run on a machine or in a container. You specify the runner with the `runs-on:` attribute. Here, you are telling the workflow to run this job on `ubuntu-latest`. We will talk more about runners in the next unit.

### Steps

A step is an individual task that can run commands in a job. In our example above, the step uses the action `actions/checkout@v2` to checkout the repository. What's interesting is the `using: ./action-a` value. This is the path to the container action that you build in an `action.yml` file.

### Actions

The actions inside your workflow are the standalone commands that are executed. These standalone commands can reference GitHub actions such as using your own custom actions, or community actions like the one we use above, `actions/checkout@v2`. You can also run commands such as `run: npm install -g bats` to execute a command on the runner. 

For more information on the components of a GitHub Actions workflow, check out [The components of GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions#the-components-of-github-actions).

## Configuring workflows to run for scheduled events

As mentioned previously, you can configure your workflows to run when specific activity occurs on GitHub, when an event outside of GitHub happens, or at a scheduled time. The `schedule` event allows you to trigger a workflow to run at specific UTC times using [POSIX cron syntax](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html#tag_20_25_07). This cron syntax has five `*` fields, and each field represents a unit of time.

![schedule](https://user-images.githubusercontent.com/6351798/106652373-98c98780-6552-11eb-8030-8f109b6b1735.png)

For example, if you wanted to run a workflow every 15 minutes, the `schedule` event would look like the following:

```yml
on:
  schedule:
    - cron:  '*/15 * * * *'
```

And if you wanted to run a workflow every Sunday at 3:00am, the `schedule` event would look like this:


```yml
on:
  schedule:
    - cron:  '0 3 * * SUN'
```

You can also use operators to specify a range of values or to dial-in your scheduled workflow. The shortest interval you can run scheduled workflows is once every 5 minutes and they run on the latest commit on the default or base branch. 

For more information on scheduled events, and to see a  list of available operators, check out [Scheduled events](https://docs.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events).

## Configuring workflows to run for manual events

In addition to scheduled events, you can manually trigger a workflow by using the `workflow_dispatch` event. This event allows you to run the workflow using the GitHub REST API or by selecting the "Run workflow" button in the Actions tab within your repository on GitHub. Using `workflow_dispatch`, you can choose which branch you want the workflow to run on as well as set optional `inputs` that GitHub will present as form elements in the UI.

```yml
on:
  workflow_dispatch:
    inputs:
      logLevel:
        description: 'Log level'     
        required: true
        default: 'warning'
      tags:
        description: 'Test scenario tags'  
```

In addition to `workflow_dispatch`, you can use the GitHub API to trigger a webhook event called `repository_dispatch`. This event allows you to trigger a workflow for activity that occurs outside of GitHub and essentially serves as an HTTP request to your repository asking GitHub to trigger a workflow off an action or webhook. Using this manual event requires you to do two things, send a `POST` request to the GitHub endpoint `/repos/{owner}/{repo}/dispatches` with the webhook event names in the request body, and configure your workflow to use the `repository_dispatch` event.

```bash
curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/octocat/hello-world/dispatches \
  -d '{"event_type":"event_type"}'
```

```yml
on:
  repository_dispatch:
    types: [opened, deleted]
```

For more information on triggering manual events, check out [Manual events](https://docs.github.com/en/actions/reference/events-that-trigger-workflows#manual-events).

## Configuring workflows to run for webhook events

Lastly, you can configure a workflow to run when specific webhook events occur on GitHub. Most webhook events can be triggered from more than one activity for a webhook, so if multiple activities exist for a webhook, you can specify an activity type to trigger the workflow. For example, you can run a workflow for the `check_run` event but only for the `rerequested` or `requested_action` activity types.

```yml
on:
  check_run:
    types: [rerequested, requested_action]
```

For more information on webhook events, check out [Webhook events and payloads](https://docs.github.com/en/developers/webhooks-and-events/webhook-events-and-payloads).

## Using conditional keywords

Within your workflow file, you can access context information and evaluate expressions. Although expressions are commonly used with the conditional `if` keyword in a workflow file to determine whether a step should run or not, you can use any supported context and expression to create a conditional. It's important to know that when using conditionals in your workflow, you need to use the specific syntax `${{ <expression> }}`, which tells GitHub to evaluate an expression rather than treat it as a string.

For example, a workflow that uses the `if` conditional to check if the `github.ref`, the branch or tag ref that triggered the workflow run matches `refs/heads/main` in order to proceed with the following steps in the workflow, would look something like this:

```yml
name: CI
on: push
jobs:
  prod-check:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      ...
```

Notice that in this example, the `${{ }}` are missing from the syntax. With some expressions, as in the case of the `if` conditional, you may omit the expression syntax. GitHub automatically evaluates some of these common expressions but you can always include them in case you forget which expressions GitHub automatically evaluates.

For more information about  workflow syntax and expressions, check out [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsif).


## Disabling and deleting workflows

After adding a workflow to your repository, you may find a situation where you want to temporarily disable the workflow. You can stop a workflow from being triggered without having to delete the file from the repo, either in the GitHub UI or through the GitHub REST API. When you wish to enable the workflow again, you can easily do it using the same methods.

![Screen Shot 2021-02-18 at 2 50 36 PM](https://user-images.githubusercontent.com/6351798/108426237-c4a66780-71f8-11eb-9bbf-ee0c4580bcd4.png)

Disabling a workflow can be useful in some situations, for example:

- An error on a workflow is producing too many or wrong requests impacting external services negatively.
- You want to temporarily pause a workflow that is not critical and is consuming too many minutes on your account.
- You want to pause a workflow that is doing requests to a service that is down.
- You are working on a fork and you don't need all the functionality of some workflows it includes (e.g. scheduled workflows).

You can also cancel a workflow run that is in progress in the GitHub UI within the **Actions** tab or using the GitHub API endpoint `DELETE /repos/{owner}/{repo}/actions/runs/{run_id}`. Keep in mind that when you cancel a workflow run, GitHub will cancel all of its jobs and steps within that run.

For more information on disabling or canceling a workflow run, check out [Disabling and enabling a workflow](https://docs.github.com/en/actions/managing-workflow-runs/disabling-and-enabling-a-workflow).

## Using an organization's templated workflow

If you have a workflow that multiple teams use within an organization, instead of re-creating the same workflow for each repository, you can promote consistency across your organization by using a workflow template that is defined in the organization's `.github` repository. Any member within the organization can use an organization template workflow and any repository within that organization has access to those template workflows.

You can find these workflows by navigating to the **Actions** tab of a repository within the organization, selecting **New workflow**, and then finding the organization's workflow template section titled "Workflows created by *organization name*". For example, the organization called Mona has a template workflow as shown below.

![Screen Shot 2021-02-18 at 4 50 36 PM](https://user-images.githubusercontent.com/6351798/108436868-7a79b200-7209-11eb-83cb-d324ccf5f337.png)

For more information on creating and using organization template workflows, check out [Sharing workflows with your organization](https://docs.github.com/en/actions/learn-github-actions/sharing-workflows-with-your-organization).

## Using specific versions of an action

When referencing actions in your workflow, it's strongly recommended that you refer to a specific version of that action rather than just the action itself. By referencing a specific version, you are placing a safeguard from unexpected changes pushed to the action that could potentially break your workflow. Below are several ways you can reference a specific version of an action.

```yml
steps:    
  # Reference a specific commit
  - uses: actions/setup-node@c46424eee26de4078d34105d3de3cc4992202b1e
  # Reference the major version of a release
  - uses: actions/setup-node@v1
  # Reference a minor version of a release
  - uses: actions/setup-node@v1.2
  # Reference a branch
  - uses: actions/setup-node@main
```

Some references are more safe than others. For example, referencing a specific branch will run that action off of the latest changes from that branch - which you may or may not want. By referencing a specific version number or commit SHA hash, you are being more specific about the version of the action you are running. For more stability and security, it is recommended that you use the commit SHA of a released action within your workflows. 
