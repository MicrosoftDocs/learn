In the following lab exericse you will be provided step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. 

But in the meantime, in this unit we will be reviewing the three phases of a GitHub Actions Importer Migration: **planning, testing,** and **migrating** and their associated commands.

- We’ll walk through the **planning phase** of your migration and introduce you to the:
  - The ```audit```
  - And the ```forecast``` commands
- Then we'll introduce you to the **testing phase**, which includes
  - The ```dry-run``` command
  - As well as custom transformers
- And for the **migration phase**, we’ll introduce you to the ```migration``` command.
- And we will round things out with a review of what is not automatically migrated over with GitHub Actions Importer. 

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

In this section we’ll be going over the basics of the ```audit``` command with GitHub Actions Importer.

The ```audit``` command does the following:

- Fetches all of the pipelines defined in a specified scope of the existing CI/CD environment
- Attempts a conversion of these pipelines to their equivalent Actions workflow
- Writes a summary report with statistics gathered from the audit

The ```audit``` command is designed to help analyze the complexity of a potential migration, which can be used to formulate a migration plan. 

Running an audit on the command line will look something like this:

```bash
gh actions-importer audit jenkins --output-dir 
```

Once you initiate the command it will provide an Audit summary report.

Let’s go over the details the Audit summary report will provide you.

#### What is in an Audit summary report?

There are four sections of the Audit summary:

- **Pipelines:** This section contains high-level aggregated statistics on GitHub Actions Importer’s ability to migrate the targeted pipeline automatically.
- **Build steps:** This section presents an aggregated summary of the individual build steps that are used across all of the target pipelines and how many could be converted automatically.
- **Manual tasks:** This section presents an overview of the manual tasks that can be identified.
- **File manifest:** The final section of the audit summary report provides a manifest of all the files generated during the audit.

:::image type="content" source="../media/Audit_summary.jpg" alt-text="Audit summary for an Jenkins instance with sections of Pipelines and Job types.":::

Next, let's get into the ```forecast``` command.

### What is the forecast command?

In this section we’ll be reviewing the ```forecast``` command and walking through a Forecast report.

The ```forecast``` command fetches jobs that have been completed over a specified time period and uses that data to calculate usage metrics.

Running a forecast on the command line will look something like the image below.

:::image type="content" source="../media/Forecast_report.jpg" alt-text="Forecast report for Jenkins with Job count, Pipeline count, Execution time, Queue time, and Concurrent jobs sections.":::


#### What is in a Forecast report?

The Forecast report includes these metrics:

- **Job count:** The total number of completed jobs.
- **Pipeline count:** The number of unique pipelines used.
- **Execution time:** The amount of time a runner spent on a job. This metric can be used to help set expectations for the cost of GitHub-hosted runners.
- **Queue time:** The amount of time a job spent waiting for a runner to be available.
- **Concurrent jobs:** The number of jobs running at any given time. This metric can be used to understand the number of concurrent runners necessary at current levels.

Additionally, these metrics are presented for each runner queue defined in the source CI/CD system. This is useful if you will need a mix of hosted and self-hosted runners and/or if you use a mix of platforms.

In the next section, we’ll be diving into the ```dry-run``` command.

## The testing phase

The testing phase of a GitHub Actions Importer migration allows you test run what your mirgration will look like.

By using the ```dry-run``` command you can see what might not be automatically converted and utilize custom transformers to convert items into your new GitHub environment.

Let's first review the ```dry-run``` command.

### What is the dry-run command?

In this section we will review what the ```dry-run``` command does.

You can use the ```dry-run``` command to convert an existing pipeline to its equivalent GitHub Actions workflow.

The console output of the command will list the path to the file or files that GitHub Actions Importer generated. Before migrating, you should perform a dry-run of a pipeline and validate the contents are suitable.

If the conversion of a pipeline was only “partially successful” (that is, it included tasks that could not be converted automatically), the task that was not converted will be included in a commented section.

If you have "partially successful" items you can utilize custom transformers to extend GitHub Actions Importer's mapping logic.

Let's touch upon custom transformers in our next section.

### Custom transformers

A custom transformer contains mapping logic that GitHub Actions Importer can use to transform your plugins, tasks, runner labels, or environment variables to work with GitHub Actions.

Custom transformers can be used to:

- Convert items that GitHub Actions Importer does not automatically convert, or modify how items are converted.
- Convert references to runners to use different runner labels.
- Convert environment variable values from your existing pipelines to GitHub Actions workflows.

Once you have built custom transformers for your items that needed to be converted into your new environment, the next step is to finally migrate.

Next up, we'll be tackling how to migrate your environment.

## The migration phase

You can use the ```migrate``` command to convert an existing pipeline to its equivalent action and open a pull request with the converted workflows and associated files.

```bash
gh actions-importer migrate jenkins --source-url $SOURCE_URL –target-url $TARGET_URL --output-dir 
```

Any necessary manual tasks will be included in the description of the pull request. Once these manual tasks and the code reviews are complete, the pull request can be merged and the workflow will have been successfully migrated to GitHub Actions.

:::image type="content" source="../media/PR_for_Migration.jpg" alt-text="New PR once a migration is completed.":::

Now, let’s take a moment to review and dive a bit deeper into what is not automatically migrated with GitHub Actions Importer.

### Understand what is not migrated automatically

GitHub Actions Importer cannot migrate everything. It’s important to be mindful of its limitations, which include:

- **Secrets and encrypted values** are not automatically converted to repository secrets. References to secrets will be converted into context expressions and populating these values will be a manual task.
- **Self-hosted build agents** are not automatically converted to self-hosted runners. Determining whether to use GitHub-hosted runners or create equivalent self-hosted runners will be a manual task. References to these self-hosted runners will be converted to the same set of labels in a ```needs``` statement in the resulting workflow.
- **Historical packages** are not migrated to GitHub Packages. Any steps that publish or consume pipeline artifacts and caches will be converted using the equivalent actions.
- **Permissions for CI/CD pipelines** are not migrated automatically and will need to be manually configured.
- **Build steps or build triggers** that are less commonly used may not be automatically converted by GitHub Actions Importer. This can be a factor for migrations involving Azure DevOps, Jenkins, and CircleCI, all of which can be extended through marketplace customizations.

Like we had mentioned earlier, the upcoming [lab exercise](https://github.com/actions/importer-labs) will provide step-by-step guidelines on how to run all four commands for each of the supported CI/CD platforms. Let's go there next!
