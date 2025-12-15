When you work on data engineering projects, you need a systematic way to define, package, and deploy your Databricks resources across environments. **Databricks Asset Bundles (DABs)** provide an **infrastructure-as-code** approach that lets you describe jobs, pipelines, and other resources in YAML configuration files. By configuring and customizing these bundles, you can **automate deployments** and ensure consistency between development and production workspaces.

:::image type="content" source="../media/5-configure-package-databricks-asset-bundles.png" alt-text="Diagram explaining Databricks asset bundles." border="false" lightbox="../media/5-configure-package-databricks-asset-bundles.png":::

## Understand the bundle configuration structure

A Databricks Asset Bundle consists of **YAML configuration files** that define your project's resources and deployment settings. The primary configuration file, `databricks.yml`, must exist at the **root of your bundle project**. This file establishes the bundle's identity and can reference additional configuration files for better organization.

The `databricks.yml` file contains several key sections that control how your bundle behaves:

```yaml
bundle:
  name: my-data-pipeline

include:
  - resources/*.yml

workspace:
  host: https://adb-1234567890123456.7.azuredatabricks.net

resources:
  jobs:
    daily-ingestion-job:
      name: daily-ingestion-job
      tasks:
        - task_key: ingest-data
          notebook_task:
            notebook_path: ./notebooks/ingest.py

targets:
  dev:
    default: true
  prod:
    workspace:
      host: https://adb-9876543210987654.3.azuredatabricks.net
```

The **bundle** mapping defines the bundle's programmatic name. The **resources** mapping specifies the Databricks resources you want to deploy, such as jobs and pipelines. The **targets** mapping defines different **deployment environments**, each potentially pointing to different workspaces with different configurations.

> [!TIP]
> Split your configuration into separate files for resources and targets to keep configurations manageable. Use the `include` mapping to reference additional YAML files in your bundle.

## Customize deployment parameters with variables

**Variables** make your bundle configurations flexible and reusable across environments. Rather than hardcoding values like cluster IDs or job names, you define variables that can be set differently for each deployment target.

To define a variable, add it to the **variables** section of your configuration:

```yaml
variables:
  cluster_id:
    description: The cluster to use for job execution
    default: 1234-567890-abcde123
  environment:
    description: The deployment environment name
    default: development

resources:
  jobs:
    my-job:
      name: ${var.environment}-data-pipeline
      tasks:
        - task_key: process-data
          existing_cluster_id: ${var.cluster_id}
          notebook_task:
            notebook_path: ./notebooks/process.py
```

The **substitution syntax** `${var.variable_name}` inserts the variable's value wherever you reference it. This approach allows you to use the same bundle configuration while adjusting specific parameters for different environments.

You can provide variable values in several ways:

- Set default values in the variable definition
- Override values in target-specific configurations
- Pass values through command-line options: `--var="cluster_id=5678-901234-fghij567"`
- Use environment variables with the `BUNDLE_VAR_` prefix

When deploying to different targets, you can override variable values for each environment:

```yaml
targets:
  dev:
    default: true
    variables:
      cluster_id: 1234-567890-abcde123
      environment: development
  prod:
    variables:
      cluster_id: 9876-543210-zyxwv987
      environment: production
```

## Configure resources and task definitions

The **resources** section defines the Databricks objects your bundle manages. **Jobs** are the most common resource type, and you can configure various task types within each job.

A job definition includes the job name, tasks, and optional settings like schedules and notifications:

```yaml
resources:
  jobs:
    etl-pipeline:
      name: etl-pipeline
      tasks:
        - task_key: extract-task
          notebook_task:
            notebook_path: ./notebooks/extract.py
        - task_key: transform-task
          depends_on:
            - task_key: extract-task
          notebook_task:
            notebook_path: ./notebooks/transform.py
            base_parameters:
              source_table: ${var.source_table}
```

Each task specifies its type, such as **notebook_task** for running notebooks or **spark_python_task** for Python scripts. The `depends_on` setting creates **task dependencies**, ensuring tasks run in the correct order. Parameters passed through `base_parameters` let you customize task behavior at runtime.

> [!IMPORTANT]
> When configuring tasks, use paths relative to the bundle's root directory. The Databricks CLI resolves these paths when deploying the bundle to your workspace.

For compute configuration, you can reference existing clusters or define job clusters:

```yaml
resources:
  jobs:
    my-job:
      job_clusters:
        - job_cluster_key: shared-cluster
          new_cluster:
            spark_version: 14.3.x-scala2.12
            node_type_id: Standard_DS3_v2
            num_workers: 2
      tasks:
        - task_key: my-task
          job_cluster_key: shared-cluster
          notebook_task:
            notebook_path: ./notebooks/analysis.py
```

## Set up deployment targets

**Targets** represent different deployment environments, each with its own configuration overrides. A typical bundle includes development and production targets with distinct workspace URLs and settings.

**Development mode** automatically applies behaviors that simplify testing:

```yaml
targets:
  dev:
    default: true
    mode: development
```

When you deploy with `mode: development`, the CLI **prefixes resource names** with `[dev username]`, **pauses all schedules**, and enables **concurrent job runs**. These defaults help prevent development resources from interfering with production workloads.

**Production mode** enforces stricter validation:

```yaml
targets:
  prod:
    mode: production
    workspace:
      host: https://adb-prod.7.azuredatabricks.net
```

In production mode, the CLI validates that your local Git branch matches the specified branch and recommends using **service principals** for deployments. You can customize these behaviors with the **presets** mapping:

```yaml
targets:
  staging:
    presets:
      name_prefix: staging_
      trigger_pause_status: PAUSED
      tags:
        environment: staging
```

Presets let you fine-tune deployment behaviors without relying solely on the development or production mode defaults. This flexibility is useful for staging environments or specialized deployment scenarios.

With your bundle configuration complete, you're ready to validate and deploy your resources. The `databricks bundle validate` command checks your configuration for errors before deployment, while `databricks bundle deploy` pushes your resources to the target workspace.
