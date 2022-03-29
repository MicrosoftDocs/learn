Review this checklist in order to prepare for an Azure Stack Hub update. This unit contains a checklist of update-related activities for Azure Stack Hub operators.

## Prepare for Azure Stack Hub update

:::row:::
  :::column:::
    **Activity**
  :::column-end:::
  :::column:::
    **Details**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Review known issues.
  :::column-end:::
  :::column:::
    [List of known issues](/azure-stack/operator/known-issues?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Review security updates.
  :::column-end:::
  :::column:::
    [List of security updates](/azure-stack/operator/release-notes-security-updates?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Apply latest OEM package.
  :::column-end:::
  :::column:::
    Contact your OEM to ensure your system meets the minimum OEM package requirements for the Azure Stack Hub version your system is being updated to. Ensure your OEM package is compatible with the Azure Stack Hub version you are updating to. If your OEM package is not compatible with the Azure Stack Hub version you are updating to, you will need to perform an OEM package update before running an Azure Stack Hub update. For instructions, see "Apply Azure Stack Hub original equipment manufacturer (OEM) updates."
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Optional: Configure automatic log collection.
  :::column-end:::
  :::column:::
    It is recommended that you configure automatic log collection on your Azure Stack Hub environment to streamline the process of collecting system logs if you need to open a support ticket. To configure automatic log collection, see the instructions in [Send logs proactively](https://docs.microsoft.com/azure-stack/operator/diagnostic-log-collection?view=azs-2102#:~:text=You%20can%20share%20diagnostic%20logs,your%20Azure%20Stack%20Hub%20instance.).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Apply latest hotfixes.
  :::column-end:::
  :::column:::
    Apply the latest hotfixes that apply to the currently installed release. For a list of the latest hotfixes, see the [release notes Hotfixes](/azure-stack/operator/release-notes?view=azs-2102#hotfixes) section.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run capacity planner tool.
  :::column-end:::
  :::column:::
    Make sure to use the latest version of the [Azure Stack Hub Capacity Planner tool](/azure-stack/operator/azure-stack-capacity-planning-overview?view=azs-2102) to perform your workload planning and sizing. The latest version contains bug fixes and provides new features that are released with each Azure Stack Hub update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run Test-AzureStack.
  :::column-end:::
  :::column:::
    Run Test-AzureStack -Group UpdateReadiness to identify operational issues. The cmdlet is accessible through the Privileged Endpoint Session (PEP). For more information, see [Validate Azure Stack Hub system state](/azure-stack/operator/azure-stack-diagnostic-test?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resolve issues.
  :::column-end:::
  :::column:::
    Resolve any operational issues identified by Test-AzureStack.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Update available.
  :::column-end:::
  :::column:::
    In connected scenarios only, Azure Stack Hub deployments periodically check a secured endpoint and automatically notify you if an update is available for your cloud. Disconnected customers can download and import new packages using the [process described here](/azure-stack/operator/azure-stack-apply-updates?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schedule a maintenance window and notify your users.
  :::column-end:::
  :::column:::
    Notify users of any maintenance operations, and schedule normal maintenance windows during non-business hours if possible. Maintenance operations can affect existing tenant workloads and cause new tenants operations (for example, creating, reconfiguring, or deleting virtual machines) to fail - whether the operation is initiated from the portal or programmatically from the Azure Resource Manager API. Other operations such as backup may also be unavailable until the update is complete. For Azure Stack Hub express and full updates, you can check the release notes for a forecast of how long the update is expected to take for the version you are applying.
  :::column-end:::
:::row-end:::


## During Azure Stack Hub update

:::row:::
  :::column:::
    **Activity**
  :::column-end:::
  :::column:::
    **Details**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Manage the update.
  :::column-end:::
  :::column:::
    [Manage updates in Azure Stack Hub using the operator portal](/azure-stack/operator/azure-stack-updates?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitor the update.
  :::column-end:::
  :::column:::
    If the operator portal is unavailable, [monitor updates in Azure Stack Hub using the privileged endpoint](/azure-stack/operator/azure-stack-monitor-update?view=azs-2102).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resume updates.
  :::column-end:::
  :::column:::
    After remediating a failed update, [resume updates in Azure Stack Hub using the privileged endpoint](/azure-stack/operator/azure-stack-monitor-update?view=azs-2102).
  :::column-end:::
:::row-end:::


> [!IMPORTANT]
> Do not run Test-AzureStack during an update, as this causes the update to stall. Do not run node repair during an update regardless of its state. Contact Microsoft Support if node repair is needed during update.
