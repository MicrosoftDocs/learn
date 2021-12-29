Update your registration in the following circumstances:

 -  After you renew your capacity-based yearly subscription.
 -  When you change your billing model.
 -  When you scale changes (add/remove nodes) for capacity-based billing.

You need the following information from the administrator portal to renew or change registration:

:::row:::
  :::column:::
    **Administrator portal**
  :::column-end:::
  :::column:::
    **Cmdlet parameter**
  :::column-end:::
  :::column:::
    **Notes**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    REGISTRATION SUBSCRIPTION ID
  :::column-end:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Subscription ID used during previous registration
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    REGISTRATION RESOURCE GROUP
  :::column-end:::
  :::column:::
    ResourceGroupName
  :::column-end:::
  :::column:::
    Resource group under which the previous registration resource exists
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    REGISTRATION NAME
  :::column-end:::
  :::column:::
    RegistrationName
  :::column-end:::
  :::column:::
    Registration name used during previous registration
  :::column-end:::
:::row-end:::


### Change the subscription you use

If you want to change the subscription you use, you must first run the **Remove-AzsRegistration** cmdlet, then ensure you're signed in to the correct Azure PowerShell context. Then run **Set-AzsRegistration** with any changed parameters, including &lt; billing model &gt;. While running **Remove-AzsRegistration**, you must be signed in to the subscription used during the registration and use values of the `RegistrationName` and `ResourceGroupName` parameters as shown in the administrator portal:

```powershell

# select the subscription used during the registration (shown in portal)
Select-AzSubscription -Subscription '<Registration subscription ID from portal>'
# unregister using the parameter values from portal
Remove-AzsRegistration -PrivilegedEndpointCredential $YourCloudAdminCredential -PrivilegedEndpoint $YourPrivilegedEndpoint -RegistrationName '<Registration name from portal>' -ResourceGroupName '<Registration resource group from portal>'
# switch to new subscription id
Select-AzSubscription -Subscription '<New subscription ID>'
# register
Set-AzsRegistration -PrivilegedEndpointCredential $YourCloudAdminCredential -PrivilegedEndpoint $YourPrivilegedEndpoint -BillingModel '<Billing model>' -RegistrationName '<Registration name>' -ResourceGroupName '<Registration resource group name>'

```

### Change billing model, how features are offered, or re-register your instance

This section applies if you want to change the billing model, how features are offered, or you want to re-register your instance. For all of these cases, you call the registration function to set the new values. You don't need to first remove the current registration. Sign in to the subscription ID shown in the administrator portal, and then rerun registration with a new `BillingModel` value while keeping the `RegistrationName` and `ResourceGroupName` parameters values same as shown in the administrator portal:

```powershell

# select the subscription used during the registration
Select-AzSubscription -Subscription '<Registration subscription ID from portal>'
# rerun registration with new BillingModel (or same billing model in case of re-registration) but using other parameters values from portal
Set-AzsRegistration -PrivilegedEndpointCredential $YourCloudAdminCredential -PrivilegedEndpoint $YourPrivilegedEndpoint -BillingModel '<New billing model>' -RegistrationName '<Registration name from portal>' -ResourceGroupName '<Registration resource group from portal>'

```

### Disable or enable usage reporting

For Azure Stack Hub environments that use a capacity billing model, turn off usage reporting with the **UsageReportingEnabled** parameter using either the **Set-AzsRegistration** or the **Get-AzsRegistrationToken** cmdlets. Azure Stack Hub reports usage metrics by default. Operators with capacity uses or supporting a disconnected environment need to turn off usage reporting.

Run the following PowerShell cmdlets:

```
$CloudAdminCred = Get-Credential -UserName <Privileged endpoint credentials> -Message "Enter the cloud domain credentials to access the privileged endpoint."
$RegistrationName = "<unique-registration-name>"
Set-AzsRegistration `
  -PrivilegedEndpointCredential $CloudAdminCred `
  -PrivilegedEndpoint <PrivilegedEndPoint computer name> `
  -BillingModel Capacity
  -RegistrationName $RegistrationName
  -UsageReportingEnabled:$false

```

## Move a registration resource

Moving a registration resource between resource groups under the same subscription is supported for all environments. However, moving a registration resource between subscriptions is only supported for CSPs when both subscriptions resolve to the same Partner ID.
