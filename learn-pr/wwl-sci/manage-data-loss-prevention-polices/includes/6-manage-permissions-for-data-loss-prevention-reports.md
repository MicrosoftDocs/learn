To view DLP reports in the Microsoft Purview compliance portal, you must be assigned to the:

- **Security Reader** role in the Exchange admin center. By default, this role is assigned to the Organization Management and Security Reader role groups in the Exchange admin center.
- **View-Only DLP Compliance Management** role in the Purview compliance portal. By default, this role is assigned to the Compliance Administrator, Organization Management, Security Administrator, and Security Reader role groups in the Purview compliance portal.
- **View-Only Recipients** role in the Exchange admin center. By default, this role is assigned to the Compliance Management, Organization Management, and View-Only Organization Management role groups in the Exchange admin center.

Members of your compliance team who read DLP policy reports need permissions to the Microsoft Purview compliance portal. By default, your tenant admin has access to this location and can give compliance officers and other people access to the Microsoft Purview compliance portal, without giving them all the permissions of a tenant admin. To perform this action, you should:

1. Create a role group on the **Permissions** page of the **Purview portal**. Select **Roles** under **Microsoft Purview solutions**.
1. While creating the role group, use the **Choose Roles** section to add the following role to the Role Group: **View-Only DLP Compliance Management**.
1. Use the **Choose Members** section to add the members to the role group.

You can also create a role group with administrative privileges to the DLP policies and DLP reports by granting the **DLP Compliance Management** role.

Instead of creating a new role group you can also assign one of the existing role groups in the Microsoft Purview compliance portal under Permissions. If you want users to have read-only access to the existing reports pages, you can assign the Security Reader role.

> [!NOTE]
> Role groups for the Purview portal might have similar names to the role groups in Exchange Online, but they are not the same.
