Review the checklist below to prepare for an Azure Stack Hub update.

### Prepare for Azure Stack Hub update

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
    List of known issues.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Review security updates
  :::column-end:::
  :::column:::
    List of security updates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Review add-on resource provider updates.
  :::column-end:::
  :::column:::
    App Service Event Hubs MySQL SQL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Apply latest OEM package.
  :::column-end:::
  :::column:::
    Contact your OEM to ensure your system meets the minimum OEM package requirements for the Azure Stack Hub version your system is being updated to. Ensure your OEM package is compatible with the Azure Stack Hub version you are updating to. If your OEM package is not compatible with the Azure Stack Hub version you are updating to, you will need to perform an OEM package update before running an Azure Stack Hub update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Optional: Configure automatic log collection.
  :::column-end:::
  :::column:::
    It is recommended that you configure automatic log collection on your Azure Stack Hub environment to streamline the process of collecting system logs when you need to open a support ticket. To configure automatic log collection, see the instructions in Send logs proactively.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Apply latest hotfixes.
  :::column-end:::
  :::column:::
    Apply the latest hotfixes that apply to the currently installed release. For a list of the latest hotfixes, see the release notes Hotfixes section.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run capacity planner tool.
  :::column-end:::
  :::column:::
    Make sure to use the latest version of the Azure Stack Hub Capacity Planner tool to perform your workload planning and sizing. The latest version contains bug fixes and provides new features that are released with each Azure Stack Hub update.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Run `Test-AzureStack`
  :::column-end:::
  :::column:::
    Run `Test-AzureStack -Group UpdateReadiness` to identify operational issues. The cmdlet is accessible through the Privileged Endpoint Session (PEP). For more information, see Validate Azure Stack Hub system state.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resolve issues.
  :::column-end:::
  :::column:::
    Resolve any operational issues identified by `Test-AzureStack`.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Update available.
  :::column-end:::
  :::column:::
    In connected scenarios only, Azure Stack Hub deployments periodically check a secured endpoint and automatically notify you if an update is available for your cloud. Disconnected customers can download and import new packages.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Schedule a maintenance window and notify your users.
  :::column-end:::
  :::column:::
    Notify users of any maintenance operations, and schedule normal maintenance windows during non-business hours if possible. Maintenance operations can affect existing tenant workloads and cause new tenants operations (for example, creating, reconfiguring, or deleting virtual machines) to fail - whether the operation is initiated from the portal or programmatically from the Azure Resource Manager API.
  :::column-end:::
:::row-end:::
