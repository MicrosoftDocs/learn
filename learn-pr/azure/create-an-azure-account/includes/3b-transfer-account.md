Many large organizations buy their Azure subscriptions through Enterprise Agreements (EAs). Typically, they assign their subscriptions to various business units in the company.

Occasionally, you might need to transfer a subscription from one billing account to another - for example if an employee leaves the organization and they want to take their subscription with them. The steps required for transfer are straightforward:

1. Sign in at the [Azure Account Center](https://account.windowsazure.com/subscriptions) as the account administrator.
1. Select the subscription to transfer.
1. Verify that your subscription is eligible for self-serve transfer by checking the **Offer** and **Offer ID** against the [supported offers list](https://docs.microsoft.com/azure/billing/billing-subscription-transfer).

    ![Screenshot that depicts subscription info.](../media/3b-transfer-sub1.png)

1. Select **Transfer subscription**.

    ![Screenshot that depicts the Transfer subscription link.](../media/3b-transfer-sub2.png)

1. Specify the recipient.

    > [!NOTE]
    > If you transfer a subscription to a new Azure AD tenant, all role assignments in RBAC will be permanently deleted from the source tenant and not migrated to the target tenant.

    ![Screenshot that depicts where you specify the recipient when transferring a subscription.](../media/3b-transfer-sub3.png)

1. The recipient automatically gets an email with an acceptance link.
1. The recipient selects the link and follows the instructions, including entering their payment information.

    ![Screenshot that depicts where the recipient enters payment and other information to receive the subscription transfer.](../media/3b-transfer-sub4.png)

1. Azure completes the subscription transfer.

At this point, billing ownership of the Azure subscription would be transferred to the new owner. The details for this process are [in the documentation](https://docs.microsoft.com/azure/billing/billing-subscription-transfer).
