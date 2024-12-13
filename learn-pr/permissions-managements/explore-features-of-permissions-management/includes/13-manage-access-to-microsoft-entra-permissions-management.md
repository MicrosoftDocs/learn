Permissions Management has its own group-based access system that provides granular control over what cloud environments, authorization systems, and permissions users have access to. The settings to manage these areas are found under the User Management tab of the product, which is in your profile dropdown menu.

There are three types of permissions that can be granted in Permissions Management:

- **Viewer** – Gives access to view data and insights related to a specific authorization system (ex: read-only status) and allows you to request permissions on demand.  
- **Controller** – Gives access to perform controller actions within the product, such as performing remediation tasks.
- **Approver** – Gives access to approve Permission On-Demand requests.

:::image type="content" source="../media/group-permissions-setup.png" alt-text="Screenshot of the Permissions Management set up group permissions."lightbox="../media/group-permissions-setup.png":::

:::image type="content" source="../media/group-permissions-custom-selection.png" alt-text="Screenshot of the Permissions Management create custom group permissions."lightbox="../media/group-permissions-custom-selection.png":::

After specifying the Microsoft Entra ID Security Group that you want to assign permissions to, you have three different options for determining the level of permissions that users within that security group should be granted:

1. **Admin for all Authorization System Types** – Provides your specified security group with Viewer, Controller, and Approver permissions for all authorization system types.
2. **Admin for selected Authorization System Types** – Provides your specified security group with Viewer, Controller, and Approver permissions for the authorization system types that you specify.  
3. **Custom** – Provides you with the ability to specify which combination of Viewer, Controller, and Approver permissions you want to provide your specified security group with for each authorization system. With the Custom setting, users can also request permissions on demand on behalf of another identity.

Setting and modifying permissions within Permissions Management is done on a Microsoft Entra ID Security Group level.
