After your team packages a data asset bundle, deploying it to Azure Databricks becomes your next responsibility. The **Databricks CLI** provides a direct path from your local development environment to production workspaces. You control when and where your pipelines, jobs, and other resources go live. Understanding this **deployment workflow** enables you to move code reliably across environments while maintaining consistency.

## Validate bundle configuration

Before deploying, confirm that your bundle configuration is **syntactically correct** and complete. The `bundle validate` command checks your configuration files and reports any issues that would prevent successful deployment.

```bash
databricks bundle validate
```

When validation succeeds, you see a summary of your bundle identity:

```output
Name: my_data_pipeline
Target: dev
Workspace:
  Host: https://adb-1234567890123456.7.azuredatabricks.net
  User: someone@example.com
  Path: /Users/someone@example.com/.bundle/my_data_pipeline/dev

Validation OK!
```

This output confirms the **bundle name**, **target environment**, and **workspace details**. If your configuration contains errors, such as missing required fields or invalid property names, the command outputs warnings or errors that you need to address before proceeding.

> [!TIP]
> Run `bundle validate` after making changes to your bundle configuration files. Catching syntax errors early saves time compared to discovering them during deployment.

## Preview deployment changes

After validation, you can **preview exactly what the deployment will create, update, or remove** without making actual changes. The `bundle plan` command builds your bundle and displays the planned actions.

```bash
databricks bundle plan
```

The output shows what resources will be affected:

```output
Building python_artifact...
create jobs.data_ingestion_job
create pipelines.transform_pipeline
```

This preview lets you verify that the deployment matches your expectations. If you see unexpected changes, such as resources being removed that you intended to keep, adjust your configuration before committing to the deployment. For targets other than the default, specify the target:

```bash
databricks bundle plan -t production
```

## Deploy bundle to a target workspace

With validation complete and the plan reviewed, you deploy the bundle using the `bundle deploy` command. This command **uploads your artifacts** and **creates or updates resources** in the target workspace.

```bash
databricks bundle deploy
```

By default, deployment uses the **default target** defined in your bundle configuration. To deploy to a specific target such as development, staging, or production, use the `-t` flag:

```bash
databricks bundle deploy -t dev
```

During deployment, the CLI **tracks which resources it creates** by storing state in the workspace. This tracking enables several behaviors:

- **New resources** defined in your configuration are created in the workspace
- **Existing resources** that you previously deployed are updated to match your current configuration
- **Removed resources** that no longer appear in your configuration are deleted from the workspace

> [!IMPORTANT]
> Each bundle deployment has a unique identity based on the bundle name, target name, and the deploying user's identity. If multiple team members deploy the same bundle to the same target, their deployments will conflict. Coordinate with your team to establish who deploys to shared environments.

For automated deployments in **CI/CD pipelines**, add the `--auto-approve` flag to skip confirmation prompts:

```bash
databricks bundle deploy -t production --auto-approve
```

## Verify deployed resources

After deployment completes, verify that your resources are available and configured correctly in the workspace. The `bundle summary` command outputs information about **deployed resources**, including **direct links** to view them in the Azure Databricks UI:

```bash
databricks bundle summary
```

```output
Name: my_data_pipeline
Target: dev
Workspace:
  Host: https://adb-1234567890123456.7.azuredatabricks.net
  User: someone@example.com
  Path: /Users/someone@example.com/.bundle/my_data_pipeline/dev
Resources:
  Jobs:
    data_ingestion_job:
      Name: [dev someone] data_ingestion_job
      URL:  https://adb-1234567890123456.7.azuredatabricks.net/jobs/123456789?o=1234567890123456
  Pipelines:
    transform_pipeline:
      Name: [dev someone] transform_pipeline
      URL:  https://adb-1234567890123456.7.azuredatabricks.net/pipelines/abc-123-def?o=1234567890123456
```

You can also navigate directly to a specific resource using the `bundle open` command:

```bash
databricks bundle open data_ingestion_job
```

This command opens your browser to the resource in the Azure Databricks workspace.

## Troubleshoot common deployment issues

Even with careful preparation, deployments sometimes encounter problems. Here are common issues and how to resolve them:

**Authentication errors**: If you see permission denied or authentication failures, verify that your CLI is configured with **valid credentials**. Check your profile configuration or reauthenticate with your workspace.

```bash
databricks auth login --host https://adb-1234567890123456.7.azuredatabricks.net
```

**Lock conflicts**: When a deployment is in progress, Azure Databricks acquires a **lock** to prevent concurrent modifications. If a previous deployment was interrupted, you might see lock errors. Use the `--force-lock` flag to override.

```bash
databricks bundle deploy --force-lock
```

**Active run conflicts**: If jobs or pipelines from your bundle are **currently running**, deployment fails by default to prevent disruption. You can choose to fail explicitly with the `--fail-on-active-runs` flag, or handle running resources in your deployment strategy.

**Validation warnings**: If `bundle validate` reports warnings about unknown properties, your configuration might reference features not available in your current CLI version or workspace. Update your CLI or review the property names against the current schema.

With these deployment commands, you can reliably move your data engineering work from development through staging to production environments, maintaining control over what gets deployed and when.
