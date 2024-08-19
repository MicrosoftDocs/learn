In the following lab exercises, you get step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. 

But in the meantime, in this unit, you review the three phases of a GitHub Actions Importer Migration: **planning, testing,** and **migrating** and their associated commands.

- Let's walk through the **planning phase** of your migration and learn about:
  - The ```audit``` command.
  - The ```forecast``` commands.

- Then you learn about the **testing phase**, which includes:
  - The ```dry-run``` command.
  - Custom transformers.

- For the **migration phase**, you learn about the ```migration``` command.
- To finish, you review what GitHub Actions Importer doesn't automatically migrate.

But for now, let’s examine the planning phase of your migration.

## The planning phase

The planning phase of a migration typically starts with an analysis of your existing CI/CD usage and approach, which includes addressing such questions as:

- How many pipelines are currently defined?
- What is the typical makeup of these pipelines? Are they defined using out-of-the-box tasks, or is the product being extended to provide custom behavior?
- Which pipelines are the highest priority to be migrated? Should any pipelines not be migrated?
- What type and how many runners are being used? What mix of GitHub-hosted and self-hosted runners should you select when migrating?

If you find yourself leaving these questions unanswered, you can run GitHub Actions Importer commands to help you find answers to these questions.

Let's get started by getting to know the ```audit``` command.

### What is the audit command?

In this section, you learn the basics of the ```audit``` command in GitHub Actions Importer.

The ```audit``` command does the following actions:

- Fetches all of the pipelines defined in a specified scope of the existing CI/CD environment.
- Attempts a conversion of these pipelines to their equivalent Actions workflow.
- Writes a summary report by gathering statistics from the audit.

The ```audit``` command is designed to help analyze the complexity of a potential migration. You can use this command to formulate a migration plan.

Running an audit on the command line looks something like this:

```bash
gh actions-importer audit jenkins --output-dir 
```

After you initiate the command, it provides an Audit summary report.

Let’s go over the details the Audit summary report provides you.

#### What's in an Audit summary report?

There are four sections of the Audit summary:

- **Pipelines:** This section contains high-level aggregated statistics on GitHub Actions Importer’s ability to migrate the targeted pipeline automatically.

  :::image type="content" source="../media/audit-summary.jpg" alt-text="Screenshot of an audit report showing pipeline information for a Jenkins instance.":::

- **Build steps:** This section presents an aggregated summary of the individual build steps that are used across all the target pipelines and how many could be converted automatically.

  :::image type="content" source="../media/build-steps.jpg" alt-text="Screenshot of an audit report showing build step information for a Jenkins instance.":::

- **Manual tasks:** This section presents an overview of the manual tasks that can be identified.

  :::image type="content" source="../media/manual-tasks.jpg" alt-text="Screenshot of an audit report showing manual task information for a Jenkins instance.":::

- **File manifest:** The final section of the audit summary report provides a manifest of all the files generated during the audit.

Next, let's get into the ```forecast``` command.

### What is the forecast command?

In this section, you review the ```forecast``` command and walk through a Forecast report.

The ```forecast``` command fetches jobs that were completed over a specified time period and uses that data to calculate usage metrics.

Running a forecast on the command line looks something like the following image.

:::image type="content" source="../media/forecast-report.jpg" alt-text="Screenshot of a forecast report showing metrics for a Jenkins migration.":::


#### What's in a Forecast report?

The Forecast report includes these metrics:

- **Job count:** The total number of completed jobs.
- **Pipeline count:** The number of unique pipelines used.
- **Execution time:** The amount of time a runner spent on a job. This metric can be used to help set expectations for the cost of GitHub-hosted runners.
- **Queue time:** The amount of time a job spent waiting for a runner to be available.
- **Concurrent jobs:** The number of jobs running at any given time. This metric can be used to understand the number of concurrent runners necessary at current levels.

In addition, these metrics are presented for each runner queue defined in the source CI/CD system. This information is useful if you need a mix of hosted and self-hosted runners and/or if you use a mix of platforms.

In the next section, you dive into the ```dry-run``` command.

## The testing phase

The testing phase of a GitHub Actions Importer migration allows you to test run what your migration looks like.

By using the ```dry-run``` command, you can see what might not be automatically converted and utilize custom transformers to convert items into your new GitHub environment.

Let's first review the ```dry-run``` command.

### What is the dry-run command?

In this section, you review what the ```dry-run``` command does.

You can use the ```dry-run``` command to convert an existing pipeline to its equivalent GitHub Actions workflow.

The console output of the command lists the path to the file or files that GitHub Actions Importer generated. Before migrating, you should perform a dry-run of a pipeline and validate the contents are suitable.

What if the conversion of a pipeline was only "partially successful" (that is, it included tasks that couldn't be converted automatically)? Then, the task that wasn't converted is included in a commented section.

If you have "partially successful" items, you can use custom transformers to extend GitHub Actions Importer's mapping logic.

Let's touch upon custom transformers in our next section.

### Custom transformers

A custom transformer contains mapping logic that GitHub Actions Importer can use to transform items to work with GitHub Actions. These items include your plugins, tasks, runner labels, or environment variables.

You can use custom transformers to:

- Convert items that GitHub Actions Importer doesn't automatically convert, or modify how items are converted.
- Convert references to runners to use different runner labels.
- Convert environment variable values from your existing pipelines to GitHub Actions workflows.

After you build custom transformers for your items that needed to be converted into your new environment, the next step is to finally migrate.

Next, you learn how to migrate your environment.

## The migration phase

You can use the ```migrate``` command to convert an existing pipeline to its equivalent action and open a pull request that contains the converted workflows and associated files.

```bash
gh actions-importer migrate jenkins --source-url $SOURCE_URL –target-url $TARGET_URL --output-dir 
```

Any necessary manual tasks are included in the description of the pull request. After these manual tasks and the code reviews are complete, the pull request can be merged, and the workflow is successfully migrated to GitHub Actions.

:::image type="content" source="../media/pr-for-migration.png" alt-text="Screenshot of a merged pull request showing completed manual tasks and an approved code review.":::

Now, let’s take a moment to review and dive into what GitHub Actions Importer doesn't automatically migrate.

### Understand what isn't migrated automatically

GitHub Actions Importer can't migrate everything. Be mindful of its limitations, which include:

- **Secrets and encrypted values** aren't automatically converted to repository secrets. References to secrets are converted into context expressions. Populating these values is a manual task.
- **Self-hosted build agents** aren't automatically converted to self-hosted runners. Determining whether to use GitHub-hosted runners or create equivalent self-hosted runners is a manual task. References to these self-hosted runners are converted to the same set of labels in a ```needs``` statement in the resulting workflow.
- **Historical packages** aren't migrated to GitHub Packages. Any steps that publish or consume pipeline artifacts and caches are converted using the equivalent actions.
- **Permissions for CI/CD pipelines** aren't migrated automatically and need to be manually configured.
- **Build steps or build triggers** that are less commonly used might not be automatically converted by GitHub Actions Importer. These build steps can be a factor for migrations involving Azure DevOps, Jenkins, and CircleCI, all of which can be extended through marketplace customizations.

As mentioned earlier, the upcoming [lab exercise](https://github.com/actions/importer-labs) provides step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. Let's go there next!
