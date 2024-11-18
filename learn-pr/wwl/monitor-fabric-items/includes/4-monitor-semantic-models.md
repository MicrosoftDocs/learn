You can use the reports in the [**admin monitoring workspace**](/fabric/admin/monitoring-workspace#reports-and-semantic-models) for getting insights about user activity, content sharing, capacity performance, and more in your Fabric tenant. You can also connect to the semantic models in the workspace to create reporting solutions optimized for your organization's needs

## Refreshing and monitoring semantic Models in the admin monitoring workspace

- Only users with directly assigned admin roles can set up the admin monitoring workspace. If the admin role is assigned through a group, data refreshes in the workspace fails.
- The admin monitoring workspace is read-only. Workspace roles don't have the same capabilities as in other workspaces. Users, including admins, can't edit or view properties of items such as semantic models and reports.
- Users with build permissions for a semantic model in the admin monitoring workspace are shown as with read permissions.
- Granular delegated admin privileges (GDAP) aren't supported.
- Once access is provided to the admin monitoring workspace or its underlying content, it can't be removed without reinitializing the workspace. However, sharing links can be modified as in a typical workspace.

### Refreshes

The semantic models in the workspace are automatically refreshed once per day, around the same time that the workspace was first installed.

- To maintain the scheduled refresh process, consider the following limitations:
  - If the user who first accessed the workspace is no longer an admin, scheduled refreshes fail. This failure can be mitigated by having another admin log into Fabric, as their credentials will be assigned to all semantic models in the workspace to support future data refreshes.
  - If the admin who first accessed the workspace uses Privileged Identity Management (PIM), their PIM access must be active during the scheduled data refresh time, otherwise the refresh fails.

### Reinitializing the workspace

Occasionally, administrators might need to reinitialize the workspace to reset access to the workspace or its underlying content.

Admins can reinitialize the workspace using the following steps:

1. Retrieve the ID of the admin monitoring workspace from the URL when viewing the workspace.
2. Execute the semantic model deletion API, replacing 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' with the ID of your admin monitoring workspace:

   ```bash
   api.powerbi.com/v1/admin/workspaces/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -Method Delete

3. Select the Workspaces menu and select Admin monitoring to trigger the reinitialization of the workspace, similar to the first installation process. Occasionally, refreshing the page is also required.

## Refreshing and monitoring semantic models using pipelines

Refreshing semantic models is a crucial task to ensure that the data presented in reports and dashboards is up-to-date. In Microsoft Fabric, the **Semantic Model Refresh Activity** in Data Factory allows you to automate this process efficiently.

### Refreshing semantic models

To refresh a semantic model, you can configure the Semantic Model Refresh Activity within your Data Factory pipeline. This activity supports various configurations, including:

- **Max Parallelism**: This setting allows you to control the number of parallel refresh operations, optimizing performance based on your system's capabilities.
- **Retry Count**: You can specify the number of retry attempts if there's a refresh failure, ensuring robustness in your data refreshes process.
- **Commit Type**: Choose between transactional (commit all refreshes at once) or partial batch (commit in batches) based on your requirements.

Once configured, you can save and run the pipeline directly or schedule it for automatic execution. The run history and other settings can be viewed and managed from the pipeline editor's Home tab.

### Monitoring semantic models

Monitoring the refresh status of semantic models is essential to ensure data integrity and timely updates. The Semantic Models Refresh Activity provides several monitoring features:

- **Run history**: View the history of refresh operations to track their success or failure.
- **Error notifications**: Receive notifications for any refresh failures, allowing you to quickly address issues.
- **Detailed logs**: Access detailed logs to investigate and resolve any errors that occur during the refresh process.

> **Important:** Regularly monitoring the refresh status and addressing any errors promptly is crucial to maintaining the reliability and accuracy of your semantic models.

By applying these features, you can maintain the reliability and accuracy of your semantic models, ensuring that your data-driven insights are always based on the latest information.
