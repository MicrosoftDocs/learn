Version control and validation ensure your content is correct and reviewed. Deployment pipelines control how that content moves from development to production, preventing untested changes from reaching end users.

## What are deployment pipelines?

Deployment pipelines in Microsoft Fabric provide a structured way to promote content through multiple stages. Each stage maps to a separate workspace. When you deploy content from one stage to the next, Fabric copies the selected items to the target workspace.

The default pipeline has three stages: **Development**, **Test**, and **Production**. You can customize the number of stages (between two and 10) and rename them to match your team's workflow. For example, a team might use Development, QA, Staging, and Production for more granular control.

Each stage serves a specific purpose:

- **Development**: Where you author and iterate on content. This stage receives the most frequent changes and is where individual contributors do their work.
- **Test**: Where reviewers validate content with larger data volumes and verify the end-user experience. Testers check that reports render correctly, measures return expected results, and performance meets requirements.
- **Production**: Where approved content is available to business users. Only promoted, validated content should reach this stage.

## Create and configure a pipeline

To create a deployment pipeline:

1. In the Fabric portal, select **Workspaces** in the navigation pane.
1. Select **Deployment pipelines** and then **Create pipeline**.
1. Name the pipeline and configure the number of stages.
1. Assign a workspace to each stage. Each workspace must be on Fabric or Premium capacity.

After you assign workspaces, you can see the content in each stage side by side. The pipeline view shows which items are identical, which differ, and which exist only in one stage. This comparison view helps you understand the current state across all environments at a glance.

> [!NOTE]
> Deployment pipelines support many Fabric item types beyond Power BI, including notebooks, lakehouses, warehouses, and Data Factory pipelines. You can promote all supported items through the same pipeline.

## Deployment rules

Deployment rules let you change configuration values when content moves between stages. This is important because development, test, and production environments often connect to different data sources or use different parameter values.

You can configure two types of rules:

- **Data source rules**: Change the server, database, or connection path when deploying between stages. For example, development connects to a test database while production connects to the live database.
- **Parameter rules**: Override Power BI parameter values per stage. For example, a `MaxRows` parameter might be set to 1,000 in development for fast iteration but unlimited in production for complete data.

Deployment rules ensure that each stage has the correct configuration without manual intervention. When you promote content from development to test, the rules automatically substitute the test data source. When you promote from test to production, the production rules apply.

> [!IMPORTANT]
> Configure deployment rules before the first deployment. Rules only apply during pipeline deployment and don't change the source item. If you modify a deployment rule after initial setup, redeploy to apply the updated rule.

## Compare and deploy content

Before deploying, compare content between stages to understand what's changing:

1. Open the pipeline and select the source stage.
1. Review the comparison indicators. Items marked with an orange icon differ between stages. Items with a green icon are identical. Items that exist only in the source stage show a "new" indicator.
1. Select the items to deploy. You can deploy everything or selectively choose specific items.
1. Select **Deploy** to promote the selected items to the next stage.

Selective deployment is useful when some items are ready for promotion but others need more work. You can deploy a validated semantic model while keeping an in-progress report in the development stage. This flexibility lets different items move through the pipeline at different speeds.

The comparison also shows when items have been deleted or renamed. If a semantic model exists in production but not in development, the pipeline flags the discrepancy so you can handle it intentionally rather than accidentally.

## Automate deployment pipelines

For teams that want to reduce manual steps, deployment pipelines support automation through the Fabric REST API. You can trigger deployments programmatically, which enables integration with CI/CD systems and scheduled workflows.

Common automation patterns include:

- Triggering deployment after a successful pull request merge.
- Scheduling nightly deployments from development to test.
- Running validation scripts before promoting from test to production.

Automation reduces human error in the deployment process and ensures consistent deployment practices across the team.

## Complement Git with pipelines

Git integration and deployment pipelines work together but serve different purposes:

| Capability | Git integration | Deployment pipelines |
|---|---|---|
| Primary purpose | Source control and collaboration | Stage promotion |
| Tracks | Change history, branching, pull requests | Content movement between environments |
| Configuration management | Same configuration across branches | Environment-specific rules per stage |
| Typical users | Developers authoring content | Team leads promoting validated content |

A common workflow combines both: developers commit changes to Git, a pull request triggers a code review, approved changes sync to the development workspace through Git integration, and then a team lead promotes the validated content through pipeline stages to test and production.

Git answers the question "What changed and who approved it?" Deployment pipelines answer the question "Is the right content in the right environment with the correct configuration?"

> [!TIP]
> Configure deployment rules early. Setting up data source and parameter rules before the first deployment prevents configuration mistakes that can cause production issues and are time-consuming to troubleshoot.

With deployment pipelines managing your releases, the **Deploy** stage is complete. Next, you move to the **Monitor** stage — keeping deployed content reliable through scheduled refresh and ongoing monitoring.
