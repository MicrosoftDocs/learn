You should purchase savings plans based on consistent base usage. As mentioned earlier, committing to greater spending than your historical usage can result in an underutilized commitment. Unused commitment doesn't carry over from one hour to the next. Usage exceeding the savings plan commitment is charged using more expensive pay-as-you-go rates.

You can buy one- or three-year savings plans, but the term start or end dates aren't modifiable. The commitment isn't coterminous with other pricing agreements and can span beyond these agreement terms.

In addition to choosing the optimal commitment period, as part of preparations for purchasing Azure savings for compute usage terms, perform the following tasks:

- Decide whether to restrict the plan's benefits to a subscription, a resource group, a management group, or an entire account.
- Identify the optimal hourly commitment amount by using personalized recommendations based on your recent resource usage patterns.

### Savings plan scopes

You can scope a savings plan to a shared scope, a management group, a subscription, or a resource group. Setting the scope determines where the savings apply.

You have four options to scope a savings plan, depending on your expected resource usage:

- **Shared scope**: Applies savings to all qualified resources in eligible subscriptions that are in the same billing context (enrollment for EA and billing profile for MCA). For EA customers, the shared scope could include subscriptions associated with different Azure Active Directory tenants provided these subscriptions are part of the same enrollment. If a subscription is moved to a different billing context, the benefit no longer applies to the subscription. It continues to apply to other subscriptions that remain in the current billing context.
- **Single subscription scope**: Applies savings to the matching resources in the selected subscription.
- **Management group**: Applies savings to the matching resources in the subscriptions that are a part of both the same management group and billing scope.
- **Single resource group scope**: Applies savings to the matching resources in the selected resource group only.

:::image type="content" source="../media/4-savings-plan-scopes.png" alt-text="Screenshot depicting the scope description for a shared scope, a management group, a subscription, or a resource group." border="false":::

You can update the scope after you purchase a savings plan. Changing the scope of a savings plan isn't a commercial transaction and doesn't alter the savings plan terms.

### Savings plan purchase recommendations

Consider savings-plan purchases based on your recent on-demand compute usage. You can determine your optimal commitment by using the savings-plan recommendation. Recommendations are available in:

- Azure Advisor
- Reservation purchase experience in the Azure portal
- Recommendation API

:::image type="content" source="../media/4-savings-plan-purchase-recommendations.svg" alt-text="Diagram illustrating an example of how to analyze, purchase, and pay for a savings plan based on your consistent compute usage." border="false":::

Azure calculates savings-plan purchase recommendations by analyzing your hourly usage data over the last seven, 30, and 60 days. Azure calculates what your costs would've been if you had a savings plan and compares it with your actual pay-as-you-go costs incurred over the time duration.

You can also estimate costs with savings plan prices using the Azure Calculator or find specific savings plan prices on the pricing page for each service.
