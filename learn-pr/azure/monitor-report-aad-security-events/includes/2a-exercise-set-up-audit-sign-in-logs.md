In this exercise, you view your Microsoft Entra sign-in logs, select columns and filter data for the logs, and then download the logs. You also view your Microsoft Entra instance audit logs through the **Users** menu.

In this exercise, you'll:

- View sign-in logs for your Microsoft Entra instance.
- Change columns to view in your sign-in logs.
- Filter data to include in your sign-in logs view.
- Download sign-in logs.
- View audit logs through the **Users** menu.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics to view your sign-in and audit logs.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

<a name='view-azure-active-directory-sign-in-logs'></a>

## View Microsoft Entra sign-in logs

To see the sign-in logs for Microsoft Entra ID:

1. In the Azure portal, go to your Microsoft Entra instance.

1. In the left menu under **Monitoring**, select **Sign-in logs**:

:::image type="content" source="../media/sign-in-activity.png" alt-text="Screenshot that shows the default table columns in the sign-in logs.":::

## Change columns to use in your sign-in logs view

Then, change the columns that appear for sign-in logs:

1. In **Sign-in logs** in your Microsoft Entra instance, in the menu bar, select **Columns**.

   :::image type="content" source="../media/columns-menu.png" alt-text="Screenshot that shows selecting the Columns option in the sign-in logs menu.":::

1. In the **Columns** pane, for this exercise, select **Operating system** and **Flagged for review** to add those columns. Clear **Resource ID** to remove that column.

1. Select **Save**.

:::image type="content" source="../media/columns-select.png" alt-text="Screenshot that shows selecting Save to select and clear columns for the sign-in logs.":::

## Filter data in sign-in logs

Next, add filters for the data in your sign-in logs:

1. In **Sign-in logs** in your Microsoft Entra instance, in the menu bar, select **Add filters**:

   :::image type="content" source="../media/add-filters-menu.png" alt-text="Screenshot of the Add filters button in the sign-in logs menu.":::

1. In the **Pick a field** dialog, select a filter, like **Flagged for review**, and then select **Apply**:

   :::image type="content" source="../media/filter-pick.png" alt-text="Screenshot of the filter pick a field dialog.":::

1. In the **Flagged for review** dialog, select **Yes**, and then select **Apply**.

## Download the sign-in logs

Now, download the data in your view:

1. In **Sign-in logs** in your Microsoft Entra instance, in the menu bar, select **Download**:

   :::image type="content" source="../media/download-menu.png" alt-text="Screenshot of the menu bar with the Download button selected.":::

1. In the **Download Sign-ins** pane, select a format to use for the data: CSV or JSON. Enter a file name, and then select **Download**:

   :::image type="content" source="../media/download-select.png" alt-text="Screenshot of the Download dialog details.":::

## View audit logs by using the Users menu

To access audit logs through the **Users** menu in your Microsoft Entra instance:

1. In the left menu under **Manage**, select **Users**:

   :::image type="content" source="../media/users-menu.png" alt-text="Screenshot of the Users menu.":::

1. In the **Users** menu under **Activity**, select **Audit logs**:

   :::image type="content" source="../media/audit-logs-users.png" alt-text="Screenshot of the Audit logs in the Users menu.":::
