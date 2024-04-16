You can use PowerShell to configure and deliver services by using offers, plans, and subscriptions.

Before you begin, verify the Azure Stack Hub PowerShell module is loaded. In a PowerShell console, type `Import-Module AzureStack`.

## Create a plan

Quotas are required when creating a plan. You can use existing quotas or create new quotas.

```PowerShell
$serviceQuotas = @()
$serviceQuotas += (New-AzsStorageQuota -Name "Example storage quota with defaults").Id
$serviceQuotas += (New-AzsComputeQuota -Name "Example compute quota with defaults").Id
$serviceQuotas += (New-AzsNetworkQuota -Name "Example network quota with defaults").Id

```

To create or update a base or add-on plan, use `New-AzsPlan`.

```PowerShell
$testPlan = New-AzsPlan -Name "testplan" -ResourceGroupName "testrg" -QuotaIds $serviceQuotas -Description "Test plan"

```

## Create an offer

To create an offer, use `New-AzsOffer`.

```PowerShell
New-AzsOffer -Name "testoffer" -ResourceGroupName "testrg" -BasePlanIds @($testPlan.Id)

```

Once you have an offer, you can add plans to the offer. Use ‘Add-AzsPlanToOffer\`. The -**PlanLinkType** parameter distinguishes the plan type.

```PowerShell
Add-AzsPlanToOffer -PlanName "addonplan" -PlanLinkType Addon -OfferName "testoffer" -ResourceGroupName "testrg" -MaxAcquisitionCount 18

```

If you want to change the state of an offer, use the `Set-AzsOffer` cmdlet.

```PowerShell
$offer = Get-AzsAdminManagedOffer -Name "testoffer" -ResourceGroupName "testrg"
$offer.state = "Public"
$offer | Set-AzsOffer -Confirm:$false

```

## Create subscription to an offer

After you create an offer, users need a subscription to that offer before they can use it. There are two ways that users can subscribe to an offer:

 -  As a cloud operator, you can create a subscription for a user. Subscriptions you create can be for both public and private offers.
 -  As a user, you can subscribe to a public offer.

To create a subscription for a user as a cloud operator, use `New-AzsUserSubscription`.

```PowerShell
New-AzsUserSubscription -Owner "user@contoso.com" -DisplayName "User subscription" -OfferId "/subscriptions/<Subscription ID>/resourceGroups/testrg/providers/Microsoft.Subscriptions.Admin/offers/testoffer"

```

To subscribe to a public offer as a user, use 'New-AzsSubscription'. *New-AzsSubscription* requires connection to the user Azure Resource Manager environment.

```PowerShell
$testOffer = Get-AzsOffer | Where-Object Name -eq "testoffer"
New-AzsSubscription -OfferId "User subscription" -OfferId $testOffer.Id -DisplayName "My subscription"

```

## Delete quotas, plans, offers, and subscriptions

There are companion PowerShell cmdlets to delete Azure Stack Hub quotas, plans, offers, and subscriptions. The following show examples for each.

Use `Remove-AzsUserSubscription` to remove a subscription from an offer.

```PowerShell
Remove-AzsUserSubscription -TargetSubscriptionId "c90173b1-de7a-4b1d-8600-b8325ca1eab1e"

```

To remove a plan from an offer, use `Remove-AzsPlanFromOffer`.

```PowerShell
Remove-AzsPlanFromOffer -PlanName "addonplan" -PlanLinkType Addon -OfferName "testoffer" -ResourceGroupName "testrg"
Remove-AzsPlanFromOffer -PlanName "testplan" -PlanLinkType Base -OfferName "testoffer" -ResourceGroupName "testrg"

```

Use `Remove-AzsPlan` to remove a plan.

```PowerShell
Remove-AzsPlan -Name "testplan" -ResourceGroupName "testrg"

```

Use `Remove-AzsOffer` to remove an offer.

```PowerShell
Remove-AzsOffer -Name "testoffer" -ResourceGroupName "testrg"

```

To remove quotas, use `Remove-AzsStorageQuota`, `Remove-AzsComputeQuota`, Remove-AzsNetworkQuota\`.

```PowerShell
Remove-AzsStorageQuota -Name "Example storage quota with defaults"
Remove-AzsComputeQuota -Name "Example compute quota with defaults"
Remove-AzsNetworkQuota -Name "Example network quota with defaults"

```

