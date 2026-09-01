Azure Update Manager provides fleet-level views for Azure virtual machines (VMs) and Azure Arc-enabled servers. Use these views to compare compliance, update machine settings, start deployments, and investigate failures.

## Manage multiple machines

On the **Machines** page, filter resources by subscription, resource group, location, resource type, operating system, and update status. Select one or more machines to perform these tasks:

- Check for updates.
- Install a one-time update.
- Schedule recurring updates.
- Change update settings, including periodic assessment and patch orchestration.

Select a machine to review its assessment status, recommended updates, update settings, assigned maintenance configurations, and history.

## Review deployment history

In **Azure Update Manager**, select **History** to review one-time and scheduled deployments. Each deployment includes an operation identifier, status, installed update count, and time details.

Select a deployment to review results for each machine and update. Common result values include:

- **Succeeded**: The update installed successfully.
- **Failed**: The update installation failed.
- **Not attempted**: Update Manager didn't start the update because insufficient time remained in the maintenance window.
- **Not selected**: The deployment criteria didn't include the update.

Use the Azure activity log to review an update operation while it runs. To investigate failures on Azure Arc-enabled servers, also review the update extension logs on the machine.

## Create reports and alerts

Update Manager stores update data in Azure Resource Graph. Use predefined queries or Azure Workbooks to report on pending updates, assessment results, installation results, and maintenance runs across subscriptions. Update Manager displays up to 7 days of assessment data and up to 30 days of installation results.

Azure Update Manager alerts are in preview and aren't available in Azure US Government or Azure operated by 21Vianet. The alert rules use Azure Resource Graph queries to identify conditions such as failed installations or machines with missing security updates.

Before you create an alert rule, configure a managed identity and assign the **Reader** role to it on the target resources. Connect the alert rule to an action group that defines the notification or automated response.

## Learn more

- [Manage multiple machines with Azure Update Manager](/azure/update-manager/manage-multiple-machines)
- [Query Azure Resource Graph logs](/azure/update-manager/query-logs)
- [Create alerts in Azure Update Manager](/azure/update-manager/manage-alerts)
