With pull requests you can have an additional review with additional sets of eyes on the changes that were made. It would be good as well that during that review process, you can also have some automatic checks be run, so you can build up your confidence while you are running a review.

In this unit you will learn how to leverage _PR validation_ for your pull requests.

## Pull request validation

A pull request is a way in which you can additionally review any changes that someone wants to merge into your main repository branch. During a pull request this review can be done manually, where someone reviews each and every file for the changes that were made, or you could also run automated checks during a pull request. This is called pull request validation.

GitHub Action workflows have multiple events that can trigger a workflow. One of these ways is based on when a pull request is created, updated or closed. These events can be used to trigger a workflow that executes validation steps.

### Why it’s a good idea to lint, test, deploy, etc during the review process

With _Pull Request validation_ or _PR validation_ you can run an automatic build for each pull request that gets created or updated. 

Typically you will execute CI steps in this workflow. You will not run a workflow that also deploys code to any subsequent environments like QA or production. Remember that the code changes in a pull request have not been reviewed yet, so you want to build up just enough confidence to be able to merge the changes in the main branch. After the changes are merged into main the code can get deployed to any subsequent environments, but not before that point in time.

Good checks to run at this point of PR validation in a pull request are things like:

- [Lint]: Run a sanity check on the changes, like validating and linting the code with a `bicep build` command.
- [Unit Test]: Run any automated tests on the code, like unit tests. For Bicep templates this will be less relevant, but adding it here in case your Bicep project contains other code pieces.
- [Preflight validation]: Preflight validation will check whether your templates are likely to deploy in your Azure environment. You perform preflight validation with the `az deployment group validate` command. It will add additional checks like:
  - Are the names you've specified for your Bicep resources valid?
  - Are the names you've specified for your Bicep resources already taken?
  - Are the regions you're deploying your resources to valid?
- [What-if validation]: It might also be good to know with the changes that were made to your Bicep template, in what changes these will result in your environment. You run what-if validation with the `az deployment group what-if` command. 
  - Even though What-if validation might be useful to perform during pull request validation, it also contains a risk. Preferably you run what-if validation against your QA, test or production environment. This means that to be able to run this test, your workflow will need the secret for connecting to this environment. With this secret anyone running your workflow may also run additional commands against these environments, which is a clear risk. In case you do decide to run what-if checks against one of these environments, consider using a credential with limited permissions on the environment to limit this risk.

These extra checks are not only useful for the person reviewing any pull request, but also for the person submitting a pull request. It will give you a first view of the validity of the changes that were made.

### Running workflows from PR events

GitHub Action workflows have many activities that have events that can trigger workflows. For the pull requests activity there are events for when a pull request is opened, edited, closed, reopened, ... and many more. You can use these events as a trigger to your workflow. The next example triggers your workflow when a pull request is opened:

```yaml
on:
  pull_request:
    types: [opened]
```

Or you could trigger your workflow when a pull request is opened, edited or reopened:

```yaml
on:
  pull_request:
    types: [opened, edited, reopened]
```

> [!NOTE]
> In case there are merge conflicts in your pull requests, your workflow will not run.

In case you don't mention any event types for a pull request trigger, it will trigger for the _opened_, _synchronize_ and _reopened_ events. These are the events that trigger when the pull request is created, there are extra code pushes to the branch your pull request originates from or a closed pull request is reopened.

```yaml
on:
  pull_request
```

###	Pull request status checks

When you are using pull requests in your repository, you will notice that the result of your automated workflows that trigger for these pull requests, are also visible in the pull request detail. This gives reviewers a good view of whether the code in a pull request is valid or not. With the synchronize event for a pull request these pull request workflows will also trigger each time an update is made to the pull request branch.

**Note to John: we may want to add an image here**

By default though, any failing pull request workflows will not stop the pull request from being merged by a reviewer. A reviewer will by default be able to select the _merge pull request_ button. To be able to block the merge operation in case workflows are failing, you need to additionally configure a required status check on your main branch based on your workflow. Once configured and in case your workflow is failing, no reviewer will be able to merge the pull request until the failure is fixed through a next commit.

## reusable workflows – a quick refresher

As you can see in the above list of checks you may want to run for PR validation, a lot of these steps you would also run in your regular deployment workflow. Since there is repetition of steps between both workflows, here it would be a good point to use a reusable workflow to avoid repetition between your workflows.

You would create a reusable workflow with the joined review and validation steps and then reuse that workflow across workflows. This will include all steps of the reusable workflow in your caller workflow.

We explain all about reusable workflows in the module on environments. We link to more info in the summary.