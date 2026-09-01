Azure Update Manager supports immediate and recurring update deployments. Before you deploy updates, review the latest assessment results and confirm that each machine can reach its configured update source.

## Install one-time updates

Use a one-time deployment to install selected updates immediately:

1. In the Azure portal, open **Azure Update Manager**.
2. On **Overview**, select a subscription, and then select **One-time update**.
3. Select **Install now**, add up to 20 machines, and then select **Next**.
4. Select update classifications, or include or exclude specific Knowledge Base (KB) IDs and Linux packages.
5. Configure the reboot behavior and maximum duration, and then select **Next**.
6. On **Review + install**, verify the deployment, and then select **Install**.

For a one-time deployment, the maximum duration is 235 minutes. Update Manager doesn't start remaining updates after the duration expires, but it doesn't stop an update that's already installing.

> [!NOTE]
> Update Manager doesn't support driver updates. Installation results can differ from the assessment preview when the assessment data is outdated or the available updates change before deployment.

## Schedule recurring updates

Recurring deployments use Azure Maintenance Configurations with the **Guest** maintenance scope. Before you create a schedule, register the **Microsoft.Maintenance** resource provider in the subscription.

For Azure VMs, set patch orchestration to **Customer Managed Schedules** before you assign a schedule. Azure Arc-enabled servers don't require this patch-orchestration setting.

To create a recurring deployment:

1. In **Azure Update Manager**, select **Schedule updates**.
2. Enter the maintenance configuration details, and select **Guest (Azure VM, Azure Arc-enabled VMs/servers)** for the maintenance scope.
3. Add a schedule with a start time, time zone, recurrence, and maintenance window.
4. Add machines or define a dynamic scope, and then select **Next**.
5. Select the update classifications and any included or excluded KB IDs or packages.
6. Review the maintenance configuration, and then select **Create**.

Guest-scope maintenance windows must last from 1 hour 30 minutes through 3 hours 55 minutes. The recurrence interval must be at least 6 hours. Set the initial start time at least 15 minutes after you create the schedule.

During the maintenance window, Update Manager skips updates when insufficient time remains and doesn't attempt updates that remain after the window. It doesn't terminate an installation already in progress. Allow enough time for update installation and any required restart.

Start each machine at least 15 minutes before the maintenance window begins. Update Manager can't apply scheduled updates to a machine that's shut down.

## Target machines at scale

Assign individual machines for a fixed target list. Use a dynamic scope when membership should change as resources are added or modified. Dynamic scopes can filter machines by subscription, resource group, resource type, location, operating system, and tags. Update Manager evaluates the scope when the maintenance configuration runs, so the final machine list can differ from the preview.

Use separate maintenance configurations when workloads require different schedules or isolation. For example, assign development and production servers to nonoverlapping maintenance windows.

## Learn more

- [Deploy updates now and track results with Azure Update Manager](/azure/update-manager/deploy-updates)
- [Schedule recurring updates by using the Azure portal and Azure Policy](/azure/update-manager/scheduled-patching)
- [Manage dynamic scopes](/azure/update-manager/manage-dynamic-scoping)
