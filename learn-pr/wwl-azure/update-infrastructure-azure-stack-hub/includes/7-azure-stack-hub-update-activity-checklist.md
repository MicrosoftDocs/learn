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
    [List of known issues](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/known-issues.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Review security updates.
  :::column-end:::
  :::column:::
    [List of security updates](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/release-notes-security-updates.md).
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
    It is recommended that you configure automatic log collection on your Azure Stack Hub environment to streamline the process of collecting system logs if you need to open a support ticket. To configure automatic log collection, see the instructions in [Send logs proactively](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/diagnostic-log-collection.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Apply latest hotfixes.
  :::column-end:::
  :::column:::
    Apply the latest hotfixes that apply to the currently installed release. For a list of the latest hotfixes, see the [release notes Hotfixes](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/release-notes.md) section.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run capacity planner tool.
  :::column-end:::
  :::column:::
    Make sure to use the latest version of the [Azure Stack Hub Capacity Planner tool](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-capacity-planning-overview.md) to perform your workload planning and sizing. The latest version contains bug fixes and provides new features that are released with each Azure Stack Hub update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run Test-AzureStack.
  :::column-end:::
  :::column:::
    Run Test-AzureStack -Group UpdateReadiness to identify operational issues. The cmdlet is accessible through the Privileged Endpoint Session (PEP). For more information, see [Validate Azure Stack Hub system state](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-diagnostic-test.md).
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
    In connected scenarios only, Azure Stack Hub deployments periodically check a secured endpoint and automatically notify you if an update is available for your cloud. Disconnected customers can download and import new packages using the [process described here](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-apply-updates.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schedule a maintenance window and notify your users.
  :::column-end:::
  :::column:::
    Notify users of any maintenance operations, and schedule normal maintenance windows during non-business hours if possible. Maintenance operations can affect existing tenant workloads and cause new tenants operations (for example, creating, reconfiguring, or deleting virtual machines) to fail - whether the operation is initiated from the portal or programmatically from the Azure Resource Manager API. Other operations such as backup may also be unavailable until the update is complete. For Azure Stack Hub express and full updates, you can check the [release notes](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/release-notes.md) for a forecast of how long the update is expected to take for the version you are applying.
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
    [Manage updates in Azure Stack Hub using the operator portal](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-updates.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Monitor the update.
  :::column-end:::
  :::column:::
    If the operator portal is unavailable, [monitor updates in Azure Stack Hub using the privileged endpoint](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-monitor-update.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resume updates.
  :::column-end:::
  :::column:::
    After remediating a failed update, [resume updates in Azure Stack Hub using the privileged endpoint](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-monitor-update.md).
  :::column-end:::
:::row-end:::


> [!IMPORTANT]
> Do not run `Test-AzureStack` during an update, as this causes the update to stall. Do not run node repair during an update regardless of its state. Contact Microsoft Support if node repair is needed during update.

## After Azure Stack Hub update

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
    Apply latest hotfixes.
  :::column-end:::
  :::column:::
    Apply the latest hotfixes applicable to the updated version.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Retrieve encryption keys.
  :::column-end:::
  :::column:::
    Retrieve the data at rest encryption keys and securely store them outside of your Azure Stack Hub deployment. Follow the [instructions on how to retrieve the keys](https://github.com/MicrosoftDocs/azure-stack-docs/blob/master/azure-stack/operator/azure-stack-security-bitlocker.md).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Re-enable multi-tenancy.
  :::column-end:::
  :::column:::
    For a multi-tenanted Azure Stack Hub, make sure you configure all guest directory tenants after a successful update.
  :::column-end:::
:::row-end:::
