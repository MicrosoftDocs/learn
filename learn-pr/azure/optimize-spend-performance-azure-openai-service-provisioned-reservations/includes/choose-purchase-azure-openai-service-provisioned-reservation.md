<!-- ## Understanding billing for provisioned deployments -->

Provisioned deployments by default are billed on an hourly basis. Customers can realize additional savings by purchasing provisioned reservations.

The hourly model is useful for short-term deployment needs, such as validating new models or acquiring capacity for a hackathon.  However, the discounts provided by the Azure Reservation for Azure OpenAI Provisioned are considerable. Because of this, most customers with consistent long-term usage will find a reserved model to be a better value proposition.

Provisioned throughput deployments are charged an hourly rate (\\$/PTU/hour) on the number of PTUs that have been deployed.  For example, a 300 PTU deployment will be charged the hourly rate times 300.

If a deployment exists for a partial hour, it will receive a prorated charge based on the number of minutes it was deployed during that hour.  For example, a deployment that exists for 15 minutes during an hour will receive 1/4 the hourly charge.

If you change the deployment size, the costs of the deployment will adjust to match the new number of PTUs.

:::image type="content" source="../media/5-hourly-billing.png" alt-text="A diagram illustrating how hourly billing works." border="true":::

Paying for provisioned deployments on an hourly basis is ideal for short-term deployment scenarios such as quality and performance benchmarking of new models, or temporarily increasing PTU capacity to cover an event such as a hackathon.

However, customers that require long-term usage of provisioned deployments might pay significantly less per month by purchasing a term discount via an Azure Reservation as discussed in the next section.

## Azure OpenAI Service provisioned reservation

You can obtain discounts on top of the hourly usage price by purchasing an Azure OpenAI Service provisioned reservation. An *Azure Reservation* is a term-discounting mechanism shared by many Azure products such as Compute and Cosmos DB. For Azure OpenAI Provisioned, the reservation provides a discount for committing to pay for a fixed number of PTUs for a one-month or one-year period.

You can purchase Azure Reservations through the Azure portal. Reservations are purchased regionally and can be flexibly scoped to cover usage from a group of deployments. Reservation scopes include:

- Individual resource groups or subscriptions
- A group of subscriptions in a Management Group
- All subscriptions in a billing account

You can purchase a new reservation that covers the same scope as existing reservations to take advantage of the discounting of newly provisioned deployments. You can also update the scope of existing reservations at any time without penalty—for example, to cover a new subscription. If needed, you can cancel a reservation after purchase, but credits are limited.

The Azure OpenAI reservation size should be based on the total PTUs that you consume via deployments.

For example, assume that your total consumption of PTUs is 100 units. You want to purchase a reservation for all of it, so you should purchase 100 of reservation quantity.

> [!NOTE]
> Reservation purchases are made in 1 PTU increments.

If the size of provisioned deployments within the scope of a reservation exceeds the amount of the reservation, the excess is charged at the hourly rate. For example, if deployments amounting to 250 PTUs exist within the scope of a 200 PTU reservation, 50 PTUs will be charged on an hourly basis until the deployment sizes are reduced to 200 PTUs, or a new reservation is created to cover the remaining 50.

> [!NOTE]
> Reservations are not deployments. Reservations provide a discounted price for the selected term.  They do not, however, reserve capacity on the service or guarantee that it will be available when a deployment is created. We highly recommend that customers create deployments prior to purchasing a reservation to prevent over-purchasing a reservation.

Provisioned reservations provide the following benefits:

- **Cost savings**: Significantly save on PTUs as compared to hourly pricing.
- **Commit on your terms**: Utilize one-month or one-year terms to support budget goals.
- **Agile and simple**: Savings are applied automatically to provisioned units that are deployed in the region and reservation scope. Reservations are not model specific and will cover deployments for all model types.

When you purchase a reservation, the Azure OpenAI PTU that matches the reservation attributes is no longer charged at the hourly rate.

A reservation applies to provisioned deployments only and doesn't include other offerings such as standard deployments or fine tuning. As previously stated, provisioned reservations also don't guarantee capacity availability.

> [!NOTE]
> As a best practice, you should always purchase a reservation after you've created the deployment. This prevents purchasing a reservation and then finding out that the required capacity isn't available for the desired region or model and being charged without any deployments.

When the reservation expires, Azure OpenAI deployments continue to run but are billed at the hourly rate. To prevent reservation expiration, you can choose to enable automatic renewal of reservations by selecting the option in the renewal settings, or at the time of purchase. When you enable auto-renewal, the reservation renews using the same reservation order ID, and a new reservation isn't purchased.

You can also choose to replace this reservation with a new reservation purchase. You select this option in renewal settings and a replacement reservation is purchased when the reservation expires. By default, the replacement reservation has the same attributes as the expiring reservation. You can optionally change the name, billing frequency, term, or quantity in the renewal settings as well. Any user with owner access on the reservation and the subscription used for billing can set up renewal.

## Purchasing Azure OpenAI Service provisioned reservations

To purchase an Azure OpenAI Service provisioned reservation, choose an Azure region and quantity, and then add the Azure OpenAI SKU to your cart. Then choose the quantity of PTUs that you want to purchase.

> [!NOTE]
> Reservations for Global, Data Zone, and Regional deployments aren't interchangeable. You need to purchase a separate reservation for each deployment type.

To buy a reservation, you must have the owner role or the reservation purchaser role on an Azure subscription that's of one of the following types:

- Enterprise (MS-AZR-0017P or MS-AZR-0148P)
- Pay-As-You-Go (MS-AZR-0003P or MS-AZR-0023P)
- Microsoft Customer Agreement.

Cloud solution providers (CSP) can use the Azure portal or [Partner Center](/partner-center/azure-reservations) to purchase Azure reservations. CSP partners can buy reservations for them in Partner Center when authorized by their customers. For more information, refer to [Buy Microsoft Azure reservations on behalf of your customers](/partner-center/azure-reservations-buying). Alternatively, once the partner has given permission to the end customer and they have the reservation purchaser role, they can purchase reservations in the Azure portal.

You can't buy a reservation if you have a custom role that mimics the owner role or the reservation purchaser role on an Azure subscription. You must use the built-in Owner or the built-in Reservation Purchaser role.

Enterprise Agreement (EA) customers can limit purchases to EA admins by disabling the **Reserved Instances** policy option in the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_GTM/ModernBillingMenuBlade/BillingAccounts). Navigate to the **Policies** menu to change settings.

Microsoft Customer Agreement (MCA), Billing Profile Owners can restrict the reservation purchase by disabling the **Reserved Instances** policy option in the [Azure portal](https://portal.azure.com/#blade/Microsoft_Azure_GTM/ModernBillingMenuBlade/BillingAccounts). Navigate to the **Policies** menu under **Billing Profile** to change settings.

EA admins or Billing Profile Owners must have owner or reservation purchaser access on at least one EA or MCA subscription to purchase a reservation. The option is useful for enterprises that want a centralized team to purchase reservations.

A reservation discount only applies to resources associated with subscriptions purchased through Enterprise, CSP, MCA and individual plans with pay-as-you-go rates.

To buy an Azure OpenAI reservation, perform the following steps:

1. Sign in to the Azure portal.

2. Select **All services**, select **Reservations**, and then select **Azure OpenAI**.

3. Select a subscription using the **Subscription** list to choose the subscription that you want to use to pay for the reservation. (The payment method of the subscription will be charged the costs for the reservation.)

   ​The subscription type must be one of the following types:

   - An enterprise agreement (offer numbers: MS-AZR-0017P or MS-AZR-0148P)

   - A Microsoft Customer Agreement

   - A pay-as-you-go (offer numbers: MS-AZR-0003P or MS-AZR-0023P)

      - For an enterprise subscription, the charges are deducted from the enrollment's Azure Prepayment (previously, the *monetary commitment*) balance, or charged as overage.

      - For a pay-as-you-go subscription, the charges are billed to the credit card or invoice payment method on the subscription.

4. Select a subscription scope from the **Scope** list. (Note that you can change the reservation scope after purchase.) Choose from the following scope types:

   - **Single resource group scope.** Applies the reservation discount to the matching resources in the selected resource group only.

   - **Single subscription scope.** Applies the reservation discount to the matching resources in the selected subscription.

   - **Shared scope.** Applies the reservation discount to matching resources in eligible subscriptions that are in the billing context. If you move a subscription to a different billing context, the benefit no longer applies to the subscription. It instead continues to apply to other subscriptions in the billing context.

      - For enterprise customers, the billing context is the Enterprise Agreement (EA) enrollment. The reservation shared scope would include multiple Microsoft Entra tenants in an enrollment.

      - For Microsoft Customer Agreement customers, the billing scope is the billing profile.

      - For pay-as-you-go customers, the shared scope is all pay-as-you-go subscriptions created by the account administrator.

   - **Management group.** Applies the reservation discount to the matching resource in the list of subscriptions that are a part of both the management group and billing scope. The management group scope applies to all subscriptions throughout the entire management group hierarchy. To buy a reservation for a management group, you must have at least read permission on the management group and be a reservation owner or reservation purchaser on the billing subscription.

5. Select a region to choose an Azure region that the reservation covers.
6. Select the products to cover your deployment type (Global, Data Zone, or Regional) and select **Add to cart**.

   :::image type="content" source="../media/5-select-product-you-want-to-purchase-small.png" alt-text="A screenshot of the Select the product you want to purchase dialog box." border="true" lightbox="../media/5-select-product-you-want-to-purchase.png":::

7. In the cart, choose the quantity of PTUs that you want to purchase. For example, a quantity of 64 would cover up to 64 deployed PTUs every hour.

8. Select **Next: Review + Buy** and review your purchase choices and their prices.

9. Select **Buy now**.

10. After purchase, you can select **View this Reservation** to review your purchase status.

## How reservation discounts apply to Azure OpenAI

After you buy a reservation for Azure OpenAI, the discount associated with the reservation automatically gets applied to any units you deploy in the specified region, provided they fall within the scope of the reservation. The reservation discount applies to the usage emitted by the provisioned throughput pay-as-you-go meters.

The Azure OpenAI reservation application is based on an hourly comparison between the reserved and deployed PTUs. The sum of deployed PTUs up to the amount reserved is covered (paid for) through the reservation, while any deployed PTUs in excess of the reserved PTUs get charged the hourly, pay-as-you-go rate. You must also consider the following points:

- PTUs for partial-hour deployments are prorated based on the number of minutes the deployment is active during the hour. For example, a 100 PTU deployment that exists for only 15 minutes of an hour period is considered as a 25-PTU deployment. Specifically, 15 minutes is 1/4 of an hour, so only 1/4 of the deployed PTUs are considered for billing and reservation application during that hour.

- Deployments are matched to reservations based on the reservation scope prior to when the reservation is applied. For example, a reservation scoped to a single subscription only covers deployments within that subscription. Deployments in other subscriptions are charged the hourly pay-as-you-go rate unless they're covered by other reservations that have them in scope.

- The reservation price assumes a 24x7 deployment of the reserved PTUs. In periods with fewer deployed PTUs than reserved PTUs, all deployed PTUs get covered by the reservation, but the excess reserved PTUs aren't used. These excess reserved PTUs are lost and don't carry over to other periods.

### Discount examples

The following examples illustrate how the Azure OpenAI reservation discount applies, depending on the deployments.

- **A regional reservation that's exactly the same size as the regional deployed units.** For example, you purchase 100 PTUs on a regional reservation and you deploy 100 regional PTUs. In this example, you only pay the reservation price.
- **A global reservation that's larger than your global deployed units.** For example, you purchase 300 PTUs on a global reservation and you only deploy 100 global PTUs. In this example, the global reservation discount is applied to 100 global PTUs. The remaining 200 PTUs, in the global reservation will go unused, and won't carry forward to future billing periods.
- **A data zone reservation that's smaller than the data zone deployed units.** For example, you purchase 200 PTUs on a data zone reservation and you deploy 600 data zone PTUs. In this example, the data zone reservation discount is applied to the 200 data zone PTUs that were used. The remaining 400 data zone PTUs are charged at the pay-as-you-go rate.
- **A regional reservation that's the same size as the total of two regional deployments.** For example, you purchase 200 regional PTUs on a reservation and you have two deployments of 100 regional PTUs each. In this example, the discount is applied to the sum of deployed units.

## Summary

In this unit, you learned about how PTUs are billed and how you can save with PTU reservations by committing to a one-month or one-year term. You also learned that you'll be billed on the PTU hourly rate unless you purchase PTU reservations that can cover the PTUs purchased in that same region. You went through step by step how to purchase PTU reservations in the Azure portal and how the reservation price is applied to the hourly rate.

Finally, you learned that the best practice is always to purchase a reservation after creating deployments. This prevents purchasing a reservation and then finding out that the required capacity isn't available for the desired region or model.
