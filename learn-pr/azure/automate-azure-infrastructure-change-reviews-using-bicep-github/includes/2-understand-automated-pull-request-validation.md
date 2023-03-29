When you use pull requests, you can ensure that any updates to your Azure deployments are reviewed by another person. But it's often helpful to have automated _checks_ run on your code changes, too. In this unit, you'll learn how automated pull request validation and checks can be used to increase your team's confidence in your code changes.

## Pull request validation

When you review a pull request for Bicep code, you might have some common steps that you go through to assess the change. These steps might include:

- Checking to see whether the Bicep file has any errors or linter warnings.
- Ensuring that any resources previously defined in the Bicep file continue to work.
- Testing any newly defined resources to ensure that they're deployed successfully and that they work as you expect.

_Pull request validation_ involves automating some of these activities. When you automate pull request checks, your reviewers can spend their time on other, more important review steps, such as ensuring that the code meets your team's quality standards and achieves the business goal.

In a GitHub Actions workflow, you can define triggers that invoke the workflow at certain points during the pull request process, including when a pull request is created, updated, merged, or closed.

### Test your Bicep code in a pull request validation workflow

In previous modules, you learned how to build comprehensive GitHub Actions workflows for linting, validating, deploying, and testing your Azure infrastructure changes, including across multiple environments. These workflows run after your changes are merged to your main branch.

You can also run many of the same activities in a pull request validation workflow. For example:

> [!div class="checklist"]
>
> - **Linting** your Bicep code helps to ensure that the code is semantically correct, and that it follows some baseline recommended Bicep practices.
> - **Preflight validation** helps to build your confidence that the code will be deployed successfully, without having to actually deploying the file. Depending on the resource type, preflight validation might look for issues such as invalid resource names, invalid regions for specific resources, and whether you've specified a configuration that can't be deployed successfully.
> - **What-if**, which lists the changes that will be made to your Azure environment as a result of the deployment.
> - **Deployments**, to actually deploy your resources and ensure that there are no deployment errors.
> - **Testing** your resources after deployment, to ensure that they're configured according to your business requirements.

A pull request validation workflow is a normal GitHub Actions workflow, so it can run any of these tasks. However, it's worth thinking about the types of checks that make sense to run within a pull request. Many of the validation activities listed here require access to an Azure environment. For example, the _what-if_ operation compares the resources defined in your Bicep files with those in your Azure subscription. It makes sense to run this comparison against a production environment. But, because doing so introduces some additional risk, you might not be comfortable running operations against a production environment from a workflow designed for code that isn't yet completed or merged.

In this module, you'll add two kinds of checks to your pull request validation workflow:

- Linting your Bicep code to run an initial set of checks on it.
- Deploying the code to a brand new temporary environment.

These two activities don't require connecting to your production Azure environment, or even to any of your regular non-production environments, such as Test, QA, or Staging. By running these two activities, you can still build up a good amount of confidence in your code changes so that you can merge them into the main branch of your repository.

The checks are useful for your reviewers, because they save time that would otherwise be spent running the activities manually. The checks are also useful for you, as the pull request author, because you can use them to get an initial view into how your changes will work later in the deployment process.

In your own pull request validation workflows, you might choose to extend the validation checks with additional activities.

## Pull request lifecycle triggers

A pull request in GitHub can go through many different _lifecycle events_. For example, a pull request is _opened_. Then, the author might push changes to the source branch (_synchronize_), which affects the contents of the pull request. Next, the pull request can be _merged_, _closed_ without being merged, and even _reopened_ again in the future.

:::image type="content" source="../media/2-pull-request-states.png" alt-text="Diagram that shows some of the pull request events." border="false":::

With GitHub Actions, you can define _workflow triggers_ that respond to any of these events. For example, you can define a workflow that runs automatically whenever a pull request is opened, synchronized, or reopened by simply specifying the `pull_request` trigger without any additional configuration:

```yaml
on: pull_request
```

You can also specify pull request events that trigger a workflow. For example, the following workflow runs automatically whenever a pull request is closed:

```yaml
on:
  pull_request:
    types: [closed]
```

> [!IMPORTANT]
> If there are merge conflicts in a pull request, the workflow won't run. You need to resolve the conflict and push the resolution so that the workflow can run.

### Pull request status checks

The results of a pull request workflow are shown on the pull request's details page as _checks_. Checks enable authors and reviewers to quickly get feedback on whether the automated activities have succeeded or failed, as shown in the following example:

:::image type="content" source="../media/2-pull-request-status-checks.png" alt-text="Screenshot of GitHub pull request showing two successful status checks." border="true":::

By default, even if a check fails, the pull request can be merged. You might not want to allow this, so you can configure _branch protection rules_ to enforce that specific checks must succeed before a pull request can be merged.

### Updating files

After a pull request is created, it's common for an author to need to make updates. For example:

- A reviewer might ask the author to make changes to the code.
- If an automated check fails, the author can change the code to fix the problem, and then commit and push the changes.

By using the `pull_request` trigger, you can configure your validation workflow to run every time the source branch is updated. The results of the workflow's latest run are shown on the pull request's details page.

### Reusable workflows

If you look at the list of possible checks for pull request validation, you'll notice that they're the same steps that you would run in a regular deployment workflow. To avoid repetition, it's a good practice to use the GitHub _reusable workflows_.

You can define reusable workflows for each of the jobs that you'll use in the various workflow definitions. You'll see how to do this in the next exercise.

## Draft pull requests

As an author, you would ordinarily open a pull request when you're ready for your changes to be reviewed, approved, and merged. But it can be helpful to get access to the automated pull request validation checks throughout the process of writing your code, even if you're not yet ready for your changes to be merged.

When you open a pull request on GitHub, you can mark it as a _draft_. GitHub runs all the same automated checks, and reviewers can still provide feedback. When your pull request is in draft status, though, it's clear to everybody that the work isn't yet ready for a full review, and it can't be merged.

It's especially common to create draft pull requests when your pull request validation workflow creates ephemeral environments, because you can preview your changes in a live, working environment. As you continue to push changes, your ephemeral environment is updated to incorporate your latest changes.
