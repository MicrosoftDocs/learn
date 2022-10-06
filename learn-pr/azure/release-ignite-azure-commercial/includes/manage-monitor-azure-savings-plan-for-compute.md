Although you can’t cancel savings plans or receive a refund following their purchase, you can manage some of their settings and set up their automatic renewal. In addition, you should actively monitor their usage to track the corresponding savings. This might help you adjust usage patterns of compute resources to optimize the plans’ benefits.

### Savings plans management and monitoring permissions

By default, the following users can review and manage savings plans:

- The person who buys a savings plan, and the account administrator of the billing subscription used to buy the savings plan are added to the reservation order.

- EA and MCA billing administrators.

- Users with elevated access to manage all Azure subscriptions and management groups.

EA and MCA billing readers have permissions to view amortized cost data for savings plans. Users with an individual subscription can get the amortized cost data from their usage file.

If you're a billing administrator, you don't need to be an owner on the subscription. The savings plan lifecycle is independent of an Azure subscription, so the savings plan isn't a resource under the Azure subscription. Instead, it's a tenant-level resource with its own Azure Role Based Access Control (RBAC) permission separate from subscriptions. Savings plans don't inherit permissions from subscriptions after the purchase.

The following conditions are required to renew a savings plan:

- For EA, you must be an EA admin with write access.

- For MCA, you must be a billing profile contributor.

- For MPA:

  - You must be an owner of the existing savings plan.

  - You must be an owner of the subscription if the savings plan is scoped to a single subscription or resource group.

  - You must be an owner of the subscription if it has a shared scope or management group scope.

#### Add billing administrators

You can add a user as billing administrator to an EA or an MCA in the Azure portal.

- In EA scenarios, add users with the *Enterprise Administrator* role to view and manage all savings plan orders that apply to EA. Enterprise administrators can view and manage savings plans in **Cost Management + Billing**.

  - Users with the *Enterprise Administrator (read only)* role can only view the savings plan from **Cost Management + Billing**.

  - Department admins and account owners can't view savings plans *unless* they're explicitly added to them by using *Access control (IAM)*.

- In MCA scenarios, users with the billing profile owner role or the billing profile contributor role can manage all savings plan purchases made using the billing profile. Billing profile readers and invoice managers can view all savings plans that are paid for with the billing profile. However, they can't make changes to savings plans.

Users who have owner access on the savings plans and billing administrators can delegate access management for an individual savings plan order in the Azure portal. Delegate access management for an individual savings plan order by assigning the Owner role to a user at the resource scope of the savings plan order. If you want to give limited access, select a different role.

### Savings plans scope management

To view and manage all savings plans and to their transactions, use the following steps:

1. Sign in to the Azure portal and navigate to **Cost Management + Billing**.

   - If you're an EA admin, in the navigation menu, select **Billing scopes** and then, in the list of billing scopes, select the target billing scope.

   - If you're an MCA billing profile owner, in the navigation menu, select **Billing profiles** and then, in the list of billing profiles, select the target billing profile.

2. In the navigation menu, select **Products + services** > **Savings plan**. This will display the complete list of savings plans for your EA enrollment or billing profile.

With sufficient permissions, you can update the scope after you purchase a savings plan. You can perform this task from the savings plan’s **Configuration** page in the Azure portal. Rescoping a savings plan isn't a commercial transaction and does not affect the savings plan’s term.

If you change from shared to single scope, you can only select subscriptions where you're the owner. If you are a billing administrator, you don’t need to be an owner on the subscription. Only subscriptions within the same billing scope as the savings plan can be selected.

If all subscriptions are moved out of a management group, the scope of the savings plan is automatically changed to **Shared**.

### Savings plan renewal

You can automatically purchase a replacement savings plan when an existing savings plan expires. Automatic renewal provides an effortless way to continue getting savings plan discounts without having to closely monitor a savings plan's expiration. The renewal setting is turned off by default. Enable or disable the renewal setting anytime, up to the expiration of the existing savings plan.

Renewing a savings plan creates a new savings plan when the existing one expires. It doesn't extend the term of the existing savings plan. By default, the renewal inherits all properties except automatic renewal setting from the expiring savings plan. A savings plan renewal purchase has the same billing subscription, term, billing frequency, and savings plan commitment. However, you can update the renewal commitment, billing frequency, and commitment term to optimize your savings.

There's no obligation to renew and you can opt out of the renewal at any time before the existing savings plan expires. If you don't automatically renew, your services will continue to run normally. You'll be charged pay-as-you-go rates for your usage after the savings plan expires. If the savings plan wasn't set for automatic renewal before expiration, you can't renew an expired savings plan. To continue to receive savings, you can buy a new savings plan.

### Savings plan monitoring tasks

With sufficient permissions, you can retrieve the savings plan cost details and usage data in the Azure portal or programmatically by using APIs. Enhanced data for savings plan cost details and usage data are available in EA and MCA subscriptions as part of the Azure Cost Management functionality. This allows you to:

- Obtain savings plan purchase data.

- Identify subscription, resource group or resources that are in scope of a savings plan.

- Calculate monetary benefits of a savings plan.

- Retrieve under-utilization data of a savings plan.

- Amortize savings plan costs.

#### Saving plan data fields and values

Azure Cost Management content relevant to savings plan cost details and usage data includes the following field and values:

- *BenefitId* and *BenefitName* correspond to the savings plan identifier and savings plan name associated with your purchase.
- *PricingModel* is set to the “SavingsPlan” value in purchase, cost details, and usage data records that are associated with a savings plan.
- *ProductOrderId* designates the savings plan order identifier.
- *ProductOrderName* designates the product name of the purchased savings plan.
- *Term* represents the time period associated with the savings plan purchase.
- *EffectivePrice* represents (in this context) the savings plan benefits. Its value depends on the type of dataset (Actual Cost vs Amortized Cost) being reviewed.
- *ChargeType* designates whether the charge represents a purchase (Purchase), usage (Usage), a refund (Refund), or an unused benefit (UnusedBenefit).
- *UnitPrice* designates the price of a resource from the customer’s price sheet.

####  Actual Cost and Amortized Cost

In Azure Cost Management, savings plan cost details are composed of two separate datasets:  Actual Cost and Amortized Cost:

- Actual Cost provides data to reconcile with your monthly bill. This data includes savings plan purchase costs and savings plan application details. With this data, you can determine which subscription or resource group or resource received the savings plan benefits on a particular day (the *EffectivePrice* for the usage that receives the savings plan benefits is zero).

- Amortized Cost dataset is similar to the Actual Cost dataset except that the *EffectivePrice* for the usage that receives savings plan benefits is the prorated cost of the savings plan (instead of being zero). This helps you determine the monetary value of savings plan consumption by a subscription, resource group or a resource, which, in turn, helps you with the internal charge back for the savings plan utilization. The dataset also has unused hours in the savings plan that have been charged for the hourly commitment amount. This dataset does not include savings plan purchase records.

| **Data**                                                     | **Actual Cost dataset**                                      | **Amortized Cost dataset**                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Savings plan purchases                                       | Available. To get this data, filter on *ChargeType* =  "Purchase". Refer to *BenefitID* or *BenefitName* to determine  which savings plan the charge is for. | Not available.                                               |
| *EffectivePrice*                                             | The value is zero for usage that receives savings plan benefits. | The value is the per-hour prorated cost of the savings plan  for usage that receives the savings plan benefits. |
| Unused benefit (the number of hours the savings plan wasn’t used  in a day and the corresponding monetary value) | Not available.                                               | Available. To get this data, filter on *ChargeType* =  "UnusedBenefit". Refer to *BenefitID* or *BenefitName* to  determine which savings plan was underutilized. |
| *UnitPrice*                                                  | Available                                                    | Available                                                    |

#### Savings plan notifications

Depending on how a customer pays for your Azure subscription, savings plan email notifications are sent to the designated users in the customer’s organization. Notifications are sent for various events including:

- Purchase

- Upcoming savings plan expiration

- Expiry

- Renewal

- Cancellation

- Scope change

For customers with EA subscriptions:

- Notifications are sent only to the EA notification contacts.

- Users added to a savings plan by using Azure RBAC permission don't receive any email notifications.

For customers with individual subscriptions:

- The purchaser receives a purchase notification.

- At the time of purchase, the subscription’s billing account owner receives a purchase notification.

- The account owner receives all other notifications.

#### Savings plan purchases and amortization in cost analysis

To review savings plan costs, you can use the Cost Analysis page of Cost Management in the Azure portal. By default, this page displays the **Actual cost** view, which matches the way costs will appear on your bill. To review savings plan purchases broken down by and associated with the resources that used the plan, switch to the **Amortized cost** view.

> [!Note]
> The Actual cost and Amortized cost views represent the  Actual Cost and Amortized Cost datasets, respectively.

:::image type="content" source="../media/6-amortized-and-actual-costs.png" alt-text="Screenshot depicting the actual costs and amortized costs view." border="false":::

:::image type="content" source="../media/6-amortized-costs-resource-groups.png" alt-text="Screenshot depicting the amortized costs resource groups." border="false":::

To review a break-down of usage, purchases, and refunds, group by *Charge Type* or, for a break-down of savings plan and on-demand costs, group by *Pricing Model*. You can also group by *Benefit* and use the *BenefitId* and *BenefitName* associated with your savings plan to identify the costs related to specific savings plan purchases. Note that the only savings plan costs that will be listed as the actual cost are purchases, but costs will be allocated to the individual resources that used the benefit when reviewing the amortized cost. The amortized cost view will also include an *UnusedBenefit* plan charge type.

#### Savings plan purchase costs

Savings plan purchase costs are available in the Actual Cost dataset. Filter for *ChargeType* set to *Purchase*. Refer to *ProductOrderID* to determine which savings plan order the purchase is for.

#### Saving plan payments

You can review savings plan payments by referencing usage data and cost analysis. For savings plans paid monthly, the frequency value is set to *recurring* in usage data and Savings Plan Charges API. For savings plans paid up front, the value is set to *onetime*.

Cost analysis includes monthly purchases in the default view. Apply the *purchase* filter to *Charge type* and *recurring* to *Frequency* to list all purchases. To limit results to savings plans only, apply a filter to *Savings Plan*.

#### Underutilized savings plan quantity and costs

To identify unused savings plan quantity and cost (the number of hours the savings plan wasn’t used in a day and the corresponding monetary value), use the Amortized Cost dataset and filter on *ChargeType* = *UnusedBenefit* and *PricingModel* = *SavingsPlan*. You can additionally filter data for a savings plan or savings plan order using the *BenefitId* and *ProductOrderId* fields, respectively. If a savings plan was 100% utilized, the corresponding record has the value of 0.

#### Amortize savings plan costs

To identify daily amortized costs for a savings plan, use the Amortized Cost dataset and filter for a savings plan order using the *ProductOrderID* field.

#### Savings realized by a savings plan

You can identify savings that were realized by a specific savings plan by using the Amortized Costs dataset and filtering the data for that savings plan. Then:

1. Get estimated pay-as-you-go costs. To accomplish this, multiply the *UnitPrice* value by the *Quantity* values to obtain estimated pay-as-you-go costs.

2. Get the savings plan costs. To accomplish this, add the *Cost* values to obtain the monetary value of what you paid for the savings plan. This includes the used and unused costs of the savings plan.
3. Subtract the savings plan costs from the estimated pay-as-you-go costs to calculate the estimated savings.

Note that if you have an underutilized savings plan, the *UnusedBenefit* entry for *ChargeType* becomes a factor to consider. When you have a fully utilized savings plan, you receive the maximum savings possible. Any *UnusedBenefit* quantity reduces savings.

#### Download the usage CSV file with new data

If you're an EA admin, you can download the CSV file that contains cost data. This data isn't available from the EA portal (ea.azure.com). Instead, you must download the cost file from Azure portal (portal.azure.com).

1. Sign in to the Azure portal.
2. Navigate to **Cost Management + Billing**.
3. Select the billing account.
4. Select **Usage + charges**.
5. Select **Download**.
6. In **Usage Details Version** , select **Amortized charges**.

> [!Note]
> The CSV files that you download contain actual costs and amortized costs.

##### Charge back Azure savings plan costs

EA and MCA billing readers can view amortized cost data for savings plans. They can use the cost data to charge back the monetary value for a subscription, resource group, resource, or a tag to their partners. In amortized data, the effective price is the prorated hourly savings plan cost. The cost is the total cost of savings plan usage by the resource on that day.

Users with an individual subscription can get the amortized cost data from their usage file. When a resource gets a savings plan discount, the *AdditionalInfo* section in the usage file contains the savings plan details.

To view savings plan usage data for show back and charge back, use the following steps:

1. Sign in to the Azure portal.
2. Navigate to **Cost Management + Billing**.
3. Select **Cost analysis** from the left navigation menu.
4. Under **Actual Cost**, select the **Amortized Cost** metric.
5. To identify which resources were used by a savings plan, apply a filter to **Pricing Model**, and then select **SavingsPlan**.
6. Set the **Granularity** to **Monthly** or **Daily**.
7. Set the chart type to **Table**.
8. Set the **Group by** option to **Resource**.

To get the data for show back and charge back, use the following steps:

1. Sign in to the Azure portal.
2. Navigate to **Cost Management + Billing**.
3. Select **Export** from the left navigation menu.
4. Select **Add**.
5. Select **Amortized cost** as the metric and set up your export.

The *EffectivePrice* for the usage that is subject to a savings plan is the prorated cost of the savings plan (instead of being zero). This helps you determine the monetary value of savings plan consumption by a subscription, resource group, or a resource, facilitating the charge back process. The dataset also has unused savings plan benefits.

##### Azure consumption and savings plan usage data using API

You can download the usage data from Azure portal or retrieve it by using the Usage Details API. The following table provides information about the common types of API data and the corresponding API call actions.

| **Type of API data**                          | **API call action**                                          |
| --------------------------------------------- | ------------------------------------------------------------ |
| All Charges (usage and purchases)             | Request for an *ActualCost* report.                          |
| Usage that benefited from a savings plan      | Request for an *ActualCost* report.    After you have ingested all of the usage, filter for records with *ChargeType*  = ‘*Usage*’ and *PricingModel* = ‘*SavingsPlan*’. |
| Usage that didn't benefit from a savings plan | Request for an *ActualCost* report.    After you have ingested all of the usage, filter for usage records with *PricingModel*  = ‘*OnDemand*’. |
| Amortized charges (usage and purchases)       | Request for an *AmortizedCost* report.                       |
| Unused savings plan report                    | Request for an *AmortizedCost* report.    After you have ingested all of the usage, filter for usage records with *ChargeType*  = ‘*UnusedBenefit*’ and *PricingModel* =‘*SavingsPlan*’. |
| Savings plan purchases                        | Request for an *AmortizedCost* report.    After you have ingested all of the usage, filter for usage records with *ChargeType*  = ‘*Purchase*’ and *PricingModel* = ‘*SavingsPlan*’. |
| Refunds                                       | Request for an *AmortizedCost* report.    After you have ingested all of the usage, filter for usage records with *ChargeType*  = ‘*Refund*’. |
