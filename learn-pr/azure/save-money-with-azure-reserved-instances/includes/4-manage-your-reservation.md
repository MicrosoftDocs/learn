After you buy a reservation, you can view it in the Azure portal. The reservation purchaser has owner access on the reservation order and the reservation. The purchaser can change the reservation scope, exchange, refund, split, or merge the reservation.

## View reservations after purchase

By default, the following users can view and manage reservations:

- The person who buys a reservation and the account administrator of the billing subscription used to buy the reservation are added to the reservation order. To view reservations that you have explicit access to in the Azure portal, navigate to **Reservations**.
- Enterprise Agreement (EA) and Microsoft Customer Agreement billing administrators. Billing access is granted by your role. To view and manage reservations in the Azure portal, navigate to **Cost Management + Billing** > **Reservations Transactions**.

You can also manage reservation purchases programmatically. For more information, see [Get reservations and utilization using APIs, PowerShell, CLI](/azure/cost-management-billing/reservations/view-reservations#get-reservations-and-utilization-using-apis-powershell-cli).

## Assign permissions

You can delegate access management for a reservation order in the Azure portal using the **Reservation order** with **Access control (IAM)**.

The reservation is a child object of the *Reservation Order*. When granting someone permissions, it's best to grant permissions to the reservation order. Access on the order allows the user to make commercial transactions, such as an exchange or refund.

:::image type="content" source="../media/4-role-assignment.png" alt-text="Screenshot showing how to add role assignment using access control." lightbox="../media/4-role-assignment.png" :::

## Change the reservation scope

You can update the reservation scope from a shared scope to a single subscription, resource group, or vice-versa after the purchase. To update the reservation scope, select the reservation. Then select **Settings** > **Configuration** and change the scope.

Changing the scope doesn’t affect the reservation’s end date, and no new billing transaction takes place.

## Split or merge existing reservations

Although not commonly done, splitting a reservation enables you to distribute instances for granular scope management. You can split a reservation by using PowerShell, CLI, or through the API. For more information, see [Split a single reservation into two reservations](/azure/cost-management-billing/reservations/manage-reserved-vm-instance#split-a-single-reservation-into-two-reservations).