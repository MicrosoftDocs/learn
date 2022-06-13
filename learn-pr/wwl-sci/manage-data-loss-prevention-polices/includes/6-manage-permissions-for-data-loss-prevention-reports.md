To view DLP reports in the Microsoft Purview compliance portal, you must be assigned to the:

| **Role**| **Roles assigned to Role group:**| **Purpose**|
| :--- | :--- | :--- |
| Security Reader (Exchange)| Organization Management, Security Reader| Assigning users to role groups containing this role grants them the same permissions as assigning those users to the Microsoft Purview compliance portal Security Reader role because permissions are synchronized between them.|
| View-Only DLP Compliance Management| Compliance Administrator, Organization Management, Security Administrator, Security Reader| This is a base role that grants read-only access to the DLP Reports in the Microsoft Purview compliance portal. Use it to create new role groups in your organization.|

Members of your compliance team who read DLP policy reports need permissions to the Microsoft Purview compliance portal. By default, your tenant admin will have access to this location and can give compliance officers and other people access to the Microsoft Purview compliance portal, without giving them all the permissions of a tenant admin. To do this, you should:

1. Create a role group on the **Permissions** page of the **Purview portal**. Select **Roles** under **Microsoft Purview solutions**.

1. While creating the role group, use the **Choose Roles** section to add the following role to the Role Group: **View-Only DLP Compliance Management**.

1. Use the **Choose Members** section to add the members to the role group.

You can also create a role group with administrative privileges to the DLP policies and DLP reports by granting the **DLP Compliance Management** role.

Instead of creating a new role group you can also assign one of the existing role groups in the Microsoft Purview compliance portal under Permissions. If you want users to have read-only access to the existing reports pages, you can assign the Security Reader role.

> [!NOTE]
> Role groups for the Purview portal might have similar names to the role groups in Exchange Online, but they are not the same.

