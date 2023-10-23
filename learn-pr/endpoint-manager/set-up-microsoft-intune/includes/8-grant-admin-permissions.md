After you've added users to your Intune tenant, we recommend that you grant a few users administrative permission. Microsoft Intune includes a set of administrator roles for users in your organization. Assign roles by using the Microsoft Endpoint Manager admin center. Each admin role maps to common business functions and gives people permissions to do specific tasks in the admin centers. 

The account that you use to create your Microsoft Intune subscription is a *global administrator*. As a best practice, don't use a global administrator for day-to-day management tasks. An administrator doesn't require an Intune license to access Intune within the Microsoft Intune admin center. An administrator must have an Intune license to perform certain management tasks, such as setting up the Exchange service Connector.

### Give permissions in Microsoft Intune admin center

Because Intune is a part of Microsoft Endpoint Manager. You can add roles using Microsoft Intune admin center. To grant permissions, follow these steps:

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?azure-portal=true&linkid=2109431) with a global administrator account and then select **Users** > **All users** > *the user's name*. You see the user's **Profile**.
1. Select **Assigned roles** > **Add assignments**.
1. In the **Directory roles** pane, select the roles you want to assign to the user.
1. Select **Add**.

### Give permissions in Microsoft 365 admin center

You can also use the Microsoft 365 admin center to add roles. There are several other roles available in the Microsoft 365 admin center that you can use with various Microsoft services. The Microsoft 365 admin center also lets you manage Microsoft Entra roles and Microsoft Intune roles.

> [!TIP]
> To access the Microsoft 365 admin center, your account must have a **Sign-in allowed** set. In the Azure portal under **Profile**, set **Block sign in** to **No** to allow access. This status is different from having a license to the subscription. By default, all user accounts are **Allowed**. Users without administrator permissions can use the Microsoft 365 admin center to reset Intune passwords.

To grant permissions, follow these steps:

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com?azure-portal=true) with a global administrator account and then select **Users** > **Active users** > *choose the user to give admin permissions*.
1. In the user pane, choose **Manage roles** under **Roles**.

   > [!NOTE]
   > If you don't see a **Roles** section in the user pane, check whether the user has a license in the **Active users** list.

1. In the **Manage admin roles** pane, choose the admin permissions to grant from the list of available roles.
1. Select **Save changes**.

### Common types of administrators

Assign users one or more administrator permissions. These permissions define the administrative scope for users and the tasks they can manage. Administrator permissions are common between the different Microsoft cloud services. Some services might not support some permissions. Both the Microsoft Intune admin center and Microsoft 365 admin center list limited administrator roles that aren't used by Intune. Common Intune administrator permissions include the following options:

- **Global administrator** (Microsoft 365 and Intune). Accesses all administrative features in Intune. By default, the person who signs up for Intune becomes a Global admin. Global admins are the only admins who can assign other admin roles. You can have more than one global admin in your organization. As a best practice, we recommend that only a few people in your company have this role to reduce the risk to your business.
- **Password administrator** (Microsoft 365 and Intune). Resets passwords, manages service requests, and monitors service health. Password admins are limited to resetting passwords for non-admin users and some admin roles.
- **Service support administrator** (Microsoft 365 and Intune). Opens support requests with Microsoft, and views the service dashboard and message center. They have *view only* permissions except for opening support tickets and reading them.
- **Billing administrator** (Microsoft 365 and Intune). Makes purchases, manages subscriptions, manages support tickets, and monitors service health.
- **User administrator** (Microsoft 365 and Intune). Resets passwords, monitors service health, adds and deletes user accounts, and manages service requests. The user admin can't delete a global admin, create other admin roles, or reset passwords for other admins.
- **Intune administrator**. Full access to Intune, manages users and devices to associate policies, and creates and manages groups. All Intune Global administrator permissions except permission to create administrators with **Directory Role** options.

For more information about roles, see [Admin roles in Microsoft 365](/microsoft-365/admin/add-users/about-admin-roles?azure-portal=true).
