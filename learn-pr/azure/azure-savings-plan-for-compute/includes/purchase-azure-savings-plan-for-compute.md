You can purchase savings plans by using the Azure portal. You have two available payment options—pay all upfront or monthly. The monthly payment option divides the total cost of the savings plan evenly over each month of the term. The total cost of up-front and monthly savings plans is the same, with no extra fees when you choose to pay monthly.

> [!Note]
> Savings plan commitments are priced in local currency for EA customers and in USD for MCA/MPA customers. For MCA/MCP customers transacting in currencies other than USD, billing follows standard currency rules based on the monthly invoice on which the charge is issued. Effectively, monthly payment amounts may vary, depending on the current month's market exchange rate for the customer’s local currency.

### Savings plans purchase permissions

Holders of any of the following roles can purchase a savings plan for a subscription:

- EA. EA admins (regardless of the subscription-level permissions) and subscription-level owners.

- MCA/MPA. Billing profile contributors, billing profile owners, billing account contributors, billing account owners, and subscription-level owners (MCA). Partners with MPA can purchase Azure savings plans for their customers.

> [!Note]
> EA customers can limit purchases to EA admins only by disabling the **Add Savings Plan** option in the **Policies** menu in the Azure portal. In the case of MCA customers, the qualified billing profile role holders can use the **Azure Savings Plan** option in the **Policies** menu to disallow savings plan purchases.

To purchase a savings plan for a management group, you require at least the read permission on the management group, along with the savings plan owner role on the billing subscription.

### Savings plan and reservations trade-in

You can purchase a savings plan by making a new commitment, or you can trade in one or more active reservations for a savings plan. When you purchase a savings plan via reservation trade-in, the reservation will be canceled, and the monetary value of the unused reservation benefits will be converted to the equivalent hourly commitment for the savings plan. If the resulting commitment is not sufficient for your needs, you can increase it, but you do not have the option of reducing it.

You can trade in one or more eligible reservations (including VM, Dedicated Host, and App Service resources) for a savings plan. When you trade in reservations, the hourly commitment of the new savings plan must be greater than the leftover payments that are canceled for the returned reservation(s). There are no other limits or fees for trade ins. You can trade in a reservation that's paid for up front to purchase a new savings plan that's billed monthly. However, the lifetime value of the new savings plan must be greater than the prorated value of the reservations traded in.

:::image type="content" source="../media/5-savings-plan-reservations-trade-in.svg" alt-text="Diagram illustrating an example of how you can trade in one or more active reservations for a savings plan." border="false":::

### Saving plan billing

A savings plan is charged to the payment method tied to the subscription hosting compute resources in the plan’s scope. The savings plan cost is deducted from your Azure Prepayment (previously called monetary commitment) balance, if available. When your Azure Prepayment balance doesn't cover the cost of the savings plan, you're billed the overage. If you have a subscription from an individual plan with pay-as-you-go rates, the credit card you have on your account is billed immediately for up-front purchases. Monthly payments appear on your invoice and your credit card is charged monthly. When you're billed by invoice, you see the charges on your next invoice.
