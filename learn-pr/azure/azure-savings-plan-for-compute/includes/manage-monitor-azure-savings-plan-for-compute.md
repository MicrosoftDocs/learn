You can’t cancel savings plans or receive a refund following their purchase. However, you can manage some of their settings and set up their automatic renewal. In addition, you should actively monitor their usage to track the corresponding savings. It might help you adjust usage patterns of compute resources to optimize the plans’ benefits.

### Savings plans management and monitoring permissions

By default, the following users can review and manage savings plans:

- The person who buys a savings plan and the account administrator of the billing subscription used to buy the savings plan are added to the reservation order
- EA and MCA billing administrators
- Users with elevated access to manage all Azure subscriptions and management groups

EA and MCA billing readers have permissions to view amortized cost data for savings plans. Users with an individual subscription can get the amortized cost data from their usage file.

If you're a billing administrator, you don't need to be an owner on the subscription.

In MCA scenarios, users with the billing profile owner role or the billing profile contributor role can manage all savings plan purchases made using the billing profile. Billing profile readers and invoice managers can view all savings plans that are paid for with the billing profile. However, they can't make changes to savings plans.

### Savings plans scope management

With sufficient permissions, you can update the scope after you purchase a savings plan. You can update the scope from the savings plan’s **Configuration** page in the Azure portal. Rescoping a savings plan isn't a commercial transaction and doesn't affect the savings plan’s term.

If you change from shared to single scope, you can only select subscriptions where you're the owner. If you're a billing administrator, you don’t need to be an owner on the subscription. You can only select subscriptions within the same billing scope as the savings plan.

If all subscriptions are moved out of a management group, the savings plan scope is automatically changed to **Shared**.

### Savings plan renewal

You can automatically purchase a replacement savings plan when an existing savings plan expires. Automatic renewal provides an effortless way to continue getting savings plan discounts without having to closely monitor a savings plan's expiration. The renewal setting is turned off by default. Enable or disable the renewal setting anytime up to the expiration of the existing savings plan.

Renewing a savings plan creates a new savings plan when the existing one expires. It doesn't extend the term of the existing savings plan. By default, the renewal inherits all properties except automatic renewal setting from the expiring savings plan. A savings-plan renewal purchase has the same billing subscription, term, billing frequency, and savings plan commitment. However, you can update the renewal's hourly commitment, billing frequency, and commitment term to optimize your savings.

There's no obligation to renew, and you can opt out of the renewal at any time before the existing savings plan expires. If you don't automatically renew, your services continue to run normally. You'll be charged pay-as-you-go rates for your usage after the savings plan expires. If the savings plan wasn't set for automatic renewal before expiration, you can't renew an expired savings plan, so you must buy a new savings plan to continue to receive savings.

### Savings plan monitoring tasks

With sufficient permissions, you can retrieve the savings-plan cost details and usage data in the Azure portal or programmatically by using APIs. Enhanced data for savings-plan cost details and usage data are available in EA and MCA subscriptions as part of the Azure Cost Management functionality. Monitoring allows you to:

- Obtain savings plan purchase data.
- Identify subscriptions, resource groups, or resources that are in scope of a savings plan.
- Calculate monetary benefits of a savings plan.
- Retrieve under-utilization data of a savings plan.
- Amortize savings plan costs.
