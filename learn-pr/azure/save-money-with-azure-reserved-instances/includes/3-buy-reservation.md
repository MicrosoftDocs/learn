This unit describes who can buy a reserved instance, how reservations are scoped, how to make a purchase, and who gets notifications for purchases.

## Who can buy a reservation?

To buy a plan, you must have a subscription owner or reservation purchaser role for a subscription. Enterprise Agreement and Microsoft Customer Agreement billing admins (owners and contributors) can use the reservation purchase experience to give themselves reservation purchaser access on a subscription.

Only the following types of subscriptions support reservation purchases:

- Enterprise offers MS-AZR-0017P or MS-AZR-0148P
- Pay-As-You-Go offers MS-AZR-0003P or MS-AZR-0023P
- Microsoft Customer Agreement offer

Cloud solution providers can use the Azure portal or [Partner Center](/partner-center/azure-reservations) to purchase Azure reservations, or they can enable their customers to buy reservations from the Azure portal. 

Enterprise Agreement (EA) admins can limit purchases by disabling the **Add Reserved Instances** option in the EA portal. Disabling the option prevents everyone except EA admins from purchasing reservations.

## Scope reservations

You can choose from four different options for your reservation, depending on your needs.

- **Shared scope**: Applies the reservation discount to matching resources in eligible subscriptions that are in the billing context.
  - For Enterprise Agreement customers, the billing context is the enrollment.
  - For Microsoft Customer Agreement customers, the billing scope is the billing profile.
  - For individual subscriptions with pay-as-you-go rates, the billing scope includes all eligible subscriptions created by the account administrator.
- **Single subscription scope**: Applies the reservation discount to the matching resources in the selected subscription.
- **Single resource group scope**: Applies the reservation discount to the matching resources in the selected resource group only.
- **Management group**: Applies the reservation discount to the matching resource in the list of subscriptions that are a part of both the management group and billing scope. To buy a reservation for a management group, you must have at least read permission on the management group and be a reservation owner or reservation purchaser on the billing subscription.

## Purchase a reservation

To buy a reserved instance:

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. Navigate to **Reservations**.

1. In the top menu bar, select **Add** to purchase a new reservation. The **Purchase reservations** pane appears.

1. Select the product that you want to purchase reservations for. The **Select the product you want to purchase** pane appears. Azure recommends products and quantities that maximize your savings.

    :::image type="content" source="../media/3-select-product-ri.png" alt-text="Screenshot showing the Select the product you want to purchase window to choose a reservation to buy." lightbox="../media/3-select-product-ri.png" :::

1. Select **Add to cart**, and then select **Close**.

1. Select **Next: Review + buy**.

Reservation utilization can take up to a day to update after the purchase.

You can also make reservation purchases programmatically using any of the following methods:

- [REST API](/rest/api/reserved-vm-instances/reservationorder)
- [Azure PowerShell](/powershell/module/azurerm.reservations)
- [Azure CLI](/cli/azure/reservations/reservation-order)

After you make a reservation purchase, you can manage it in several ways outlined in the next unit.