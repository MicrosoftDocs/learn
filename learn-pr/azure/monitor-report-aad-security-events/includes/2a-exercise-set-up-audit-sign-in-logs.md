In this exercise, you view your Azure AD instance sign-in logs, select columns and filter data for the logs, and then download the logs. You also view your Azure AD instance audit logs through the **Users** menu.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## View Azure AD sign-in logs

To see the sign-in logs for your Azure AD tenant:

1. In the Azure portal, go to your Azure Active Directory instance.

1. In the left menu under **Monitoring**, select **Sign-ins**:

:::image type="content" source="../media/sign-in-activity.png" alt-text="Screenshot that shows the default table columns in the sign-in logs.":::

## Change columns for sign-in logs

To change the columns that appear for sign-in logs:

1. In the menu bar, select **Columns**.

   :::image type="content" source="../media/columns-menu.png" alt-text="Screenshot that shows selecting the Columns option in the sign-in logs menu.":::

1. In the **Columns** pane, add a couple columns, like **Operating system** and **Flagged for review**. Clear **IP address**.

1. Select **Save**.

:::image type="content" source="../media/columns-select.png" alt-text="Screenshot that shows selecting Save to select and clear columns for the sign-in logs.":::

## Filter data in sign-in logs

To use add filters for the data in your sign-in logs:

1. In the menu bar, select **Add filters**

   :::image type="content" source="../media/add-filters-menu.png" alt-text="Screenshot of the Add filters button in the sign-in logs menu.":::

1. In the **Pick a field** dialog, select a filter, like **Flagged for review**, and then select **Apply**:

   :::image type="content" source="../media/filter-pick.png" alt-text="Screenshot of the filter pick a field dialog.":::

1. In the **Flag for review** dialog, select **Yes**, and then select **Apply**.

## Download the sign-in logs

To download the data in your view:

1. In the menu bar, select **Download**:

   :::image type="content" source="../media/download-menu.png" alt-text="Screenshot of the menu bar with the Download button selected.":::

1. In the **Download Sign-ins** pane, select a format to use for the data, CSV or JSON. Enter a file name, and then select **Download**.

   :::image type="content" source="../media/download-select.png" alt-text="Screenshot of the Download dialog details.":::

## View audit logs through the Users menu

You access audit log data through your Azure AD instance. But you can also access the audit log directly through users, groups, and enterprise applications.

To access audit logs through your Azure AD **Users** menu:

1. In the left menu under **Manage**, select **Users**

   :::image type="content" source="../media/users-menu.png" alt-text="Screenshot of the Users menu.":::

1. Under **Activity** in the **Users** menu, select **Audit logs**:

   :::image type="content" source="../media/audit-logs-users.png" alt-text="Screenshot of the Audit logs in the Users menu.":::
