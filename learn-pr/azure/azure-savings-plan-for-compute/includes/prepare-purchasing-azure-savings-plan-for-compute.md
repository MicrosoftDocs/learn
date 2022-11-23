You should purchase savings plans based on consistent base usage. As mentioned earlier, committing to greater spending than your historical usage can result in an underutilized commitment, which you should avoid whenever possible. Unused commitment doesn't carry over from one hour to next. Usage exceeding the savings plan commitment is charged using more expensive pay-as-you-go rates.

You make a commitment of one or three years at purchase. The term and its conditions remain in effect until the term ends and are not modifiable, so make sure to properly evaluate your longer-term usage needs. The commitment is not coterminous with other pricing agreements and can span beyond these agreement terms.

In addition to choosing the optimal commitment period, as part of preparations for purchasing Azure savings for compute usage terms, perform the following tasks:

- Decide whether to scope a plan to a subscription, a resource group, a management group, or an entire account.

- Identify the optimal hourly commitment amount by using personalized recommendations based on your recent resource usage patterns.

### Savings plan scopes

You can scope a savings plan to a shared scope, a management group, a subscription, or a resource group. Setting the scope determines where the savings will apply.

You have four options to scope a savings plan, depending on your expected resource usage:

- ·    Shared scope. Applies savings to all qualified resources in eligible subscriptions that are in the same billing context. If a subscription is moved to a different billing context, the benefit will no longer be applied to this subscription but will continue to apply to other subscriptions that remain in the current billing context.

  - For EA customers, the billing context is the enrollment. The savings plan shared scope could include subscriptions associated with different Azure Active Directory tenants provided these subscriptions are part of the same enrollment.

  - For MCA customers, the billing context is the billing profile.

- Single subscription scope. Applies savings to the matching resources in the selected subscription.

- Management group. Applies savings to the matching resources in the subscriptions that are a part of both the same management group and billing scope.

- Single resource group scope. Applies savings to the matching resources in the selected resource group only.

:::image type="content" source="../media/4-savings-plan-scopes.png" alt-text="Screenshot depicting the scope description for a shared scope, a management group, a subscription, or a resource group." border="false":::

In case there are multiple savings plans with different scopes, Azure processes them in the following order:

1. Savings plans scoped to a resource group
2. Savings plans scoped to a subscription
3. Savings plans scoped to a management group
4. Savings plans with a shared scope (multiple subscriptions)

You can update the scope after you purchase a savings plan. Changing the scope of a savings plan isn't a commercial transaction and does not alter the savings plan terms.

### Savings plan purchase recommendations

Consider savings plan purchases based on your consistent compute usage. You can determine your optimal commitment by analyzing your usage data or by using the savings plan recommendation. Recommendations are available in:

- Azure Advisor

- Reservation purchase experience in the Azure portal

- APIs

:::image type="content" source="../media/4-savings-plan-purchase-recommendations.svg" alt-text="Diagram illustrating an example of how to analyze, purchase, and pay for a savings plan based on your consistent compute usage." border="false":::

Azure calculates savings plan purchase recommendations by analyzing your hourly usage data over the last 7, 30, and 60 days. Azure calculates what your costs would have been if you had a savings plan and compares it with your actual pay-as-you-go costs incurred over the time duration. It performs this calculation for every quantity that you used during the time frame. The quantity that maximizes your savings is recommended.

For example, you might use 500 VMs most of the time, but sometimes your usage spikes to 700 VMs. In this example, Azure calculates your savings for both the 500 and 700 VM quantities. Since the 700 VM usage is sporadic, the recommendation calculation determines that savings are maximized for a savings plan commitment that is sufficient to cover 500 VMs and the recommendation is provided for that commitment.

Note the following points:

- Savings plan recommendations are calculated using the on-demand usage rates that apply to you.

- Recommendations are calculated using individual sizes, not for the instance size family.

- The recommended commitment for a scope is reduced on the same day that you purchase commitment for the scope. However, an update for the commitment amount recommendation across scopes can take up to 25 days. For example, if you purchase based on shared scope recommendations, the single subscription scope recommendations can take up to 25 days to adjust down.

- Currently, Azure doesn't generate recommendations for the management group scope.

You can estimate costs with savings plan prices using the Azure Calculator or find specific savings plan prices on the pricing page for each service.
