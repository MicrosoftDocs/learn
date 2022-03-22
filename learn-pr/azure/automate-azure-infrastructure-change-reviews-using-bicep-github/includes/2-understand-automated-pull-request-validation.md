When you use pull requests, you can ensure that any updates to your Azure deployments are reviewed by another person. But it's often helpful to have automated checks run on your code changes, too. In this unit, you'll learn how pull request *checks* and automated validation can be used to increase your team's confidence in your code changes.

## Pull request validation

When you review a pull request for Bicep code, you might have some common steps that you go through to assess the change. These steps might include the following:

- Checking if the Bicep file has any errors or linter warnings.
- Ensuring that any resources already defined in the Bicep file continue to work.
- Testing any newly defined resources to ensure that they deploy successfully and that they work as you expect.

*Pull request validation* involves automating some of these activities. By automating pull request checks, you ensure that reviewers spend their time on other, more important, review steps like ensuring the code meets your team's quality standards and achieves the business goal.

In a GitHub Actions workflow, you can define triggers that invoke the workflow at certain points during the pull request process, including when a pull request is created, updated, merged, or closed.

### Testing your Bicep code in a pull request validation workflow

In previous modules, you learned how to build comprehensive GitHub Actions workflows for linting, validating, deploying, and testing your Azure infrastructure changes, including across multiple environments, and with other components like applications and databases. These workflows run after a change is merged to your main branch.

You can also run many of the same activities in a pull request validation workflow. For example:

> [!div class="checklist"]
>
> * **Linting** your Bicep code helps to ensure that the code is semantically correct, and that it follows some baseline Bicep best practices.
> * **Preflight validation** helps to build your confidence that the code will deploy successfully, without actually deploying the file. Depending on the resource type, preflight validation checks for issues like invalid resource names, invalid regions for specific resources, and whether you've specified configuration that can't be deployed successfully.
> * **What-if**, which lists the changes that will be made to your Azure environment as a result of the deployment.
> * **Deployments**, to actually deploy your resources.
> * **Testing** your resources after deployment, to ensure that they're configured according to your business requirements.

Pull request validation workflows are normal GitHub Actions workflows, so you can run any of these tasks. However, it's worth thinking about the types of checks that make sense to run within a pull request.

Many of the validation activities listed above require access to an Azure environment. For example, the what-if operation compares the resources defined in your Bicep files against those in your Azure subscription. It makes sense to run this comparison against a production environment. But, you might not be comfortable running operations against a production environment from within a workflow designed for code that isn't yet merged.

In this module, you'll add two levels of checks to your pull request validation workflow:

- Linting, which runs an initial set of checks on your Bicep code.
- Deployment of your code to a brand new temporary environment.

These two activities don't require connecting to your production Azure environment, or even to any of your regular non-production environments like Test, QA, or Staging. By running these two activities, you can still build up a good amount of confidence in your code changes so that you can merge them into the *main* branch of your repository.

The checks are useful for the reviewers of your pull request, and also for you as the pull request author: you can use the pull request as a way to get an initial view into how your changes will work later in your deployment process.

In your own workflows, you might choose to extend the PR validation checks with additional activities.

## Pull request lifecycle triggers

A pull request in GitHub can go through many different *lifecycle events*. For example, a pull request is *opened*. Then, the author might push changes to the source branch (*synchronize*), which affects the contents of the pull request. Next, the pull request can be *merged* - or, it might be *closed* without merging, and even *reopened* again in the future.

:::image type="content" source="../media/2-pull-request-states.png" alt-text="Diagram that shows some of the pull request events." border="false":::

GitHub Actions enables you to define *workflow triggers* that respond to any of these events. For example, you can define a workflow that runs automatically whenever a pull request is opened, synchronized, or reopened by simply specifying the `pull_request` trigger:

```yaml
on: pull_request
```

> [!IMPORTANT]
> If there are merge conflicts in a pull request, the workflow won't run. You need to resolve the merge conflict and push the resolution so that the workflow can run again.

You can also specify specific pull request events that trigger a workflow. For example, the following workflow runs automatically whenever a pull request is closed:

```yaml
on:
  pull_request:
    types: [closed]
```

###	Pull request status checks

The results of a pull request workflow are shown on the pull request page as *checks*. This enables authors and reviewers to quickly get feedback on whether the automated activities have succeeded or failed, like in the following example:

:::image type="content" source="../media/2-pull-request-status-checks.png" alt-text="Screenshot of GitHub pull request showing two successful status checks." border="true":::

By default, even if a check fails, the pull request can be merged. You might not want to allow this, so you can configure *branch protection rules* to enforce that specific checks succeed before a pull request can be merged.

### Updating files

After a pull request is created, it's common for the author to need to make updates. For example:

- A reviewer might request the author to make changes to the code.
- If an automated check fails, the author can make changes to their code, and then commit and push their changes.

If you configure your pull request validation workflow to run based on the *synchronized* event then every time the source branch is updated, the workflow is re-run, and the results are updated on the pull request description.

## Reusable workflows

If you look at the list of possible checks for pull request validation, you'll notice that these are the same steps you'll run in your regular deployment workflow. To avoid repetition, it's a good practice to use GitHub's *reusable workflows*.

You can define reusable workflows for each of the jobs that you'll use in different workflow definitions. You'll see how to do this in the next exercise.

## Draft pull requests

Normally, an author opens a pull request when they're ready for their changes to be reviewed, approved, and merged. But it can be helpful for authors to get access to the automated pull request validation checks throughout the process of writing their code - even when they're not ready.

When you open a pull request on GitHub, you can mark it as a *draft*. GitHub still runs all of the automated checks for draft pull requests, and reviewers still can provide feedback. But, by setting a pull request to draft status, it's clear to everybody that the work isn't yet ready for a full review.

It's especially common to create draft pull requests when your pull request validation workflow creates ephemeral environments, because you can preview your changes in a live, working environment. As you continue to push changes, your ephemeral environment will get updated to incorporate your latest changes.
