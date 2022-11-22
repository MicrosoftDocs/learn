Most Azure users will only ever have a single subscription. However, if you're part of more than one organization or your organization has divided up access to certain resources across groupings, you might have multiple subscriptions within Azure.

In Azure PowerShell, accessing the resources for a subscription requires changing the subscription associated with your current Azure session. You can do this by modifying the active session context, which is the information about which tenant, subscription, and user the cmdlets should be run against. To change subscriptions, you need to first retrieve an Azure PowerShell Context object with **Get-AzSubscription**, and then change the current context with **Set-AzContext**.

The **Get-AzSubscription** cmdlet gets the subscription ID, subscription name, and home tenant for subscriptions that the current account can access.

To get all Azure subscriptions active on all tenants, run the following command:

```powershell
Get-AzSubscription

Name                               Id                      TenantId                        State
----                               --                      --------                        -----
Subscription1                      yyyy-yyyy-yyyy-yyyy     aaaa-aaaa-aaaa-aaaa             Enabled
Subscription2                      xxxx-xxxx-xxxx-xxxx     aaaa-aaaa-aaaa-aaaa             Enabled
Subscription3                      zzzz-zzzz-zzzz-zzzz     bbbb-bbbb-bbbb-bbbb             Enabled
```

To focus on subscriptions assigned to a specific tenant, run the following command:

```powershell
Get-AzSubscription -TenantId "aaaa-aaaa-aaaa-aaaa"

Name                               Id                      TenantId                        State
----                               --                      --------                        -----
Subscription1                      yyyy-yyyy-yyyy-yyyy     aaaa-aaaa-aaaa-aaaa             Enabled
Subscription2                      xxxx-xxxx-xxxx-xxxx     aaaa-aaaa-aaaa-aaaa             Enabled
```

The **Set-AzContext** cmdlet sets authentication information for cmdlets that you run in the current session. The context includes tenant, subscription, and environment information.

To set the subscription context, run the following command:

```powershell
Set-AzContext -Subscription "xxxx-xxxx-xxxx-xxxx"

Name    Account             SubscriptionName    Environment         TenantId
----    -------             ----------------    -----------         --------
Work    test@outlook.com    Subscription1       AzureCloud          xxxxxxxx-x...
```

The next example depicts how to get a subscription in the currently active tenant and set it as the active session:

```powershell
$context = Get-AzSubscription -SubscriptionId ...
Set-AzContext $context
```
