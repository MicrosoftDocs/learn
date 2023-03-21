In the following lab exercises, you're provided with step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. 

But in the meantime, in this unit we're reviewing the three phases of a GitHub Actions Importer Migration: **planning, testing,** and **migrating** and their associated commands.

- Let's walk through the **planning phase** of your migration and introduce you to the:
  - The ```audit```
  - And the ```forecast``` commands
- Then we introduce you to the **testing phase**, which includes
  - The ```dry-run``` command
  - And custom transformers
- For the **migration phase**, we introduce you to the ```migration``` command.
- And to finish, we end with a review of what isn't automatically migrated over with GitHub Actions Importer.

But for now, let’s start with the planning phase of your migration.

## The planning phase

The planning phase of a migration typically starts with an analysis of your existing CI/CD usage and approach, which includes addressing such questions as:

- How many pipelines are currently defined?
- What is the typical makeup of these pipelines? Are they defined using out-of-the-box tasks, or is the product being extended to - provide custom behavior?
- Which pipelines are the highest priority to be migrated? Should any pipelines not be migrated?
- What type and how many runners are being used? What mix of GitHub-hosted and self-hosted runners should you select when migrating?

If you find yourself leaving these questions unanswered, fear not, GitHub Actions Importer can help you find out your answers to these questions with its commands.

Let's get started with getting to know the ```audit``` command.

### What is the audit command?

In this section, we’ll be going over the basics of the ```audit``` command with GitHub Actions Importer.

The ```audit``` command does the following actions:

- Fetches all of the pipelines defined in a specified scope of the existing CI/CD environment
- Attempts a conversion of these pipelines to their equivalent Actions workflow
- Writes a summary report with statistics gathered from the audit

The ```audit``` command is designed to help analyze the complexity of a potential migration, which can be used to formulate a migration plan. 

Running an audit on the command line looks something like this:

```bash
gh actions-importer audit jenkins --output-dir 
```

Once you initiate the command, it provides an Audit summary report.

Let’s go over the details the Audit summary report provides you.

#### What is in an Audit summary report?

There are four sections of the Audit summary:

- **Pipelines:** This section contains high-level aggregated statistics on GitHub Actions Importer’s ability to migrate the targeted pipeline automatically.
- **Build steps:** This section presents an aggregated summary of the individual build steps that are used across all of the target pipelines and how many could be converted automatically.
- **Manual tasks:** This section presents an overview of the manual tasks that can be identified.
- **File manifest:** The final section of the audit summary report provides a manifest of all the files generated during the audit.

:::image type="content" source="../media/Audit_summary.jpg" alt-text="Audit summary for a Jenkins instance with sections of Pipelines and Job types.":::

Next, let's get into the ```forecast``` command.

### What is the forecast command?

In this section, we are reviewing the ```forecast``` command and walking through a Forecast report.

The ```forecast``` command fetches jobs that have been completed over a specified time period and uses that data to calculate usage metrics.

Running a forecast on the command line looks something like the following image.

:::image type="content" source="../media/Forecast_report.jpg" alt-text="Forecast report for Jenkins with Job count, Pipeline count, Execution time, Queue time, and Concurrent jobs sections.":::


#### What is in a Forecast report?

The Forecast report includes these metrics:

- **Job count:** The total number of completed jobs.
- **Pipeline count:** The number of unique pipelines used.
- **Execution time:** The amount of time a runner spent on a job. This metric can be used to help set expectations for the cost of GitHub-hosted runners.
- **Queue time:** The amount of time a job spent waiting for a runner to be available.
- **Concurrent jobs:** The number of jobs running at any given time. This metric can be used to understand the number of concurrent runners necessary at current levels.

Additionally, these metrics are presented for each runner queue defined in the source CI/CD system. This is useful if you'll need a mix of hosted and self-hosted runners and/or if you use a mix of platforms.

In the next section, we dive into the ```dry-run``` command.

## The testing phase

The testing phase of a GitHub Actions Importer migration allows you to test run what your migration looks like.

By using the ```dry-run``` command, you can see what might not be automatically converted and utilize custom transformers to convert items into your new GitHub environment.

Let's first review the ```dry-run``` command.

### What is the dry-run command?

In this section, we review what the ```dry-run``` command does.

You can use the ```dry-run``` command to convert an existing pipeline to its equivalent GitHub Actions workflow.

The console output of the command lists the path to the file or files that GitHub Actions Importer generated. Before migrating, you should perform a dry-run of a pipeline and validate the contents are suitable.

If the conversion of a pipeline was only “partially successful”, meaning it included tasks that couldn't be converted automatically, then the task that wasn't converted will be included in a commented section.

If you have "partially successful" items you can utilize custom transformers to extend GitHub Actions Importer's mapping logic.

Let's touch upon custom transformers in our next section.

### Custom transformers

A custom transformer contains mapping logic that GitHub Actions Importer can use to transform your plugins, tasks, runner labels, or environment variables to work with GitHub Actions.

Custom transformers can be used to:

- Convert items that GitHub Actions Importer doesn't automatically convert, or modify how items are converted.
- Convert references to runners to use different runner labels.
- Convert environment variable values from your existing pipelines to GitHub Actions workflows.

Once you have built custom transformers for your items that needed to be converted into your new environment, the next step is to finally migrate.

Next up, we are tackling how to migrate your environment.

## The migration phase

You can use the ```migrate``` command to convert an existing pipeline to its equivalent action and open a pull request with the converted workflows and associated files.

```bash
gh actions-importer migrate jenkins --source-url $SOURCE_URL –target-url $TARGET_URL --output-dir 
```

Any necessary manual tasks are included in the description of the pull request. Once these manual tasks and the code reviews are complete, the pull request can be merged and the workflow is successfully migrated to GitHub Actions.

:::image type="content" source="../media/PR_for_Migration.jpg" alt-text="New PR once a migration is completed.":::

Now, let’s take a moment to review and dive a bit deeper into what isn't automatically migrated with GitHub Actions Importer.

### Understand what isn't migrated automatically

GitHub Actions Importer can't migrate everything. It’s important to be mindful of its limitations, which include:

- **Secrets and encrypted values** aren't automatically converted to repository secrets. References to secrets are converted into context expressions and populating these values are a manual task.
- **Self-hosted build agents** aren't automatically converted to self-hosted runners. Determining whether to use GitHub-hosted runners or create equivalent self-hosted runners is a manual task. References to these self-hosted runners are converted to the same set of labels in a ```needs``` statement in the resulting workflow.
- **Historical packages** aren't migrated to GitHub Packages. Any steps that publish or consume pipeline artifacts and caches are converted using the equivalent actions.
- **Permissions for CI/CD pipelines** aren't migrated automatically and need to be manually configured.
- **Build steps or build triggers** that are less commonly used may not be automatically converted by GitHub Actions Importer. These build steps can be a factor for migrations involving Azure DevOps, Jenkins, and CircleCI, all of which can be extended through marketplace customizations.

Like we mentioned earlier, the upcoming [lab exercise](https://github.com/actions/importer-labs) provides step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. Let's go there next!
