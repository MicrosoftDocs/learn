You can save money on the storage costs for Azure NetApp Files with reservations. Azure NetApp Files reservations offer a discount on capacity for storage costs when you commit to a reservation for one or three years, optimizing your total cost of ownership (TCO).

How much you save depends on the total capacity you choose to reserve, and the chosen service level.
Azure NetApp Files reservations are available for Standard, Premium, and Ultra service levels in units of one hundred TiB or 1 PiB.

## Reservation quantity

You can purchase a reservation in 100-TiB and 1-PiB units per month for a one- or three-year term for a particular service level within a region.

## Reservation scope

When you purchase the reservation, you choose the subscription scope. You can change the scope after the purchase. The scope options are:

- **Single resource group scope:** The reservation discount applies to the selected resource group only.
- **Single subscription scope:** The reservation discount applies to the matching resources in the selected subscription.
- **Shared scope:** The reservation discount applies to matching resources in eligible subscriptions in the billing context. If a subscription moves to a different billing context, the benefit no longer applies to the subscription.
- **Management group:** the reservation discount applies to the matching resource in the list of subscriptions that are a part of both the management group and billing scope. The management group scope applies to all subscriptions throughout the entire management group hierarchy.

## Requirements for purchase

To purchase a reservation:

- You must be in the Owner role for at least one Enterprise or individual subscription with pay-as-you-go rates.
- For Enterprise subscriptions, Add Reserved Instances must be enabled in the EA portal. Or, if that setting is disabled, you must be an EA Admin on the subscription.
- For the Cloud Solution Provider (CSP) program, only admin agents or sales agents can buy Azure NetApp Files reservations.

## Purchase an Azure NetApp Files reservation

- When you purchase an Azure NetApp Files reservation, you must choose the region and tier for the reservation. 
- Your reservation is valid only for data stored in that region and tier. 
- Reservations are available in 100-TiB or 1-PiB increments; higher discounts are available for 1-PiB increments. 
- You can pay for the reservation up front or with monthly payments.
- You can purchase Azure NetApp Files reservation through the Azure portal.

:::image type="content" source="../media/3-azure-reservations.png" alt-text="Screenshot of Azure Reservations." lightbox="../media/3-azure-reservations.png":::
