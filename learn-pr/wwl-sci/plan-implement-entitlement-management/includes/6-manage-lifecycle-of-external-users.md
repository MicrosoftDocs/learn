## Manage the lifecycle of external users in Microsoft Entra ID Governance settings

You can select what happens when an external user, who was invited to your directory through an access package request being approved, no longer has any access package assignments. This situation can happen if the user relinquishes all their access package assignments, or their last access package assignment expires. By default, when an external user no longer has any access package assignments, they're blocked from signing in to your directory. After 30 days, their guest user account is removed from your directory.

1. Sign in to the Microsoft Entra admin center as an Administrator. An account with User administrator is required to complete these tasks.
2. Open **ID Governance**.
3. In the left navigation menu, under **Entitlement management**, select **Settings**.
4. On the top menu, select **Edit**.

   :::image type="content" source="../media/manage-lifecycle-of-external-users.png" alt-text="Screenshot of the Identity governance settings page with manage the lifecycle of external users highlighted.":::

5. In the **Manage the lifecycle of external users** section, review the different settings for external users. When an external user loses their last assignment to any access packages, if you want to block them from signing in to this directory, set the **Block external user from signing in to this directory** to **Yes**. If a user is blocked from signing in to the directory, the user is unable to re-request the access package or request another access in this directory. Don't configure blocking them from signing in if they'll later need to request access to other access packages.
6. Once an external user loses their last assignment to any access packages, if you want to remove their guest user account in this directory, set **Remove external** user to **Yes**.

   > [!NOTE]
   > Entitlement management only removes accounts that were invited through entitlement management. Also a user is blocked from signing in. The user is removed from this directory even if that user was added to resources in this directory that weren't access package assignments. If the guest was present in this directory before receiving access package assignments, they'll remain. However, if the guest was invited through an access package assignment, they'll still be removed.

7. If you want to remove the guest user account in this directory, you can set the number of days before it's removed. If you want to remove the guest user account as soon as they lose their last assignment to any access packages, set **Number of days before removing external user from this directory** to **0**.
8. If you made any changes, select **Save**.
