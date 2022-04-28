You can use the Azure Stack Hub administrative endpoints to monitor and manage your updates. They're accessible with PowerShell.

You can use the following PowerShell cmdlets to manage your updates:

:::row:::
  :::column:::
    **Cmdlet**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    [Get-AzsUpdate](/powershell/module/azs.update.admin/get-azsupdate?view=azurestackps-1.8.0)
  :::column-end:::
  :::column:::
    Get the list of available updates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    [Get-AzsUpdateLocation](/powershell/module/azs.update.admin/get-azsupdatelocation?view=azurestackps-1.8.0)
  :::column-end:::
  :::column:::
    Get the list of update locations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    [Get-AzsUpdateRun](/powershell/module/azs.update.admin/get-azsupdaterun?view=azurestackps-1.8.0)
  :::column-end:::
  :::column:::
    Get the list of update runs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    [Install-AzsUpdate](/powershell/module/azs.update.admin/install-azsupdate?view=azurestackps-1.8.0)
  :::column-end:::
  :::column:::
    Apply a specific update at an update location.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    [Resume-AzsUpdateRun](/powershell/module/azs.update.admin/resume-azsupdaterun?view=azurestackps-1.8.0)
  :::column-end:::
  :::column:::
    Resumes a previously started update run that failed.
  :::column-end:::
:::row-end:::


### Get a list of update runs

To get the list of update runs, run the following command:

```
Get-AzsUpdateRun -UpdateName Microsoft1.0.180302.1

```

### Resume a failed update operation

If the update fails, you can resume the update run where it left off by running the following command:

```
Get-AzsUpdateRun -Name 5173e9f4-3040-494f-b7a7-738a6331d55c -UpdateName Microsoft1.0.180305.1 | Resume-AzsUpdateRun

```
