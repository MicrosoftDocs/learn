:::image type="content" border="true" source="../media/assign-roles-surface-portal.png" alt-text="Photograph of a person using a Surface device in an office setting.":::

Microsoft provides a range of built-in administrator roles designed for managing Surface devices through both the Surface Management Portal and the Surface Support Portal. These roles are tailored to facilitate efficient management and maintenance of Surface hardware within your organization. Let's review some of the available roles and the permissions that they have access to:

| **Role type** | **Permissions** | **Description** |
| :---: | :---: | :---: |
| Global Admin | View service requests Create/manage device replacement requests Add/edit/delete ship-to addresses | Provides broad administrative control over Surface devices, but use is discouraged for specific Surface management tasks to minimize security risks. |
| Service Support Admin | View service requests Create/manage device replacement requests | Focused role for managing service requests and device replacements without broader system access. |
| Billing Admin | View service requests Create/manage device replacement requests Add/edit/delete ship-to addresses | Manages billing and shipping address aspects of device replacements and service requests. |
| Global Reader | View all administrative settings and configurations across Microsoft Entra Read-only access to Microsoft 365 tenant and associated services | Perfect for audit, compliance, and oversight roles requiring view-only access to configurations and settings. |
| Microsoft Hardware Warranty Admin | View all service requests. Create/manage device replacement requests. Add/edit/delete ship-to addresses. Read-only access to the Microsoft 365 tenant outside of the Surface Support Portal. | Best suited for managing comprehensive warranty-related tasks and service requests for Surface devices. |
| Microsoft Hardware Warranty Specialist | View own service requests. Create/manage device replacement requests. Read-only access to the Microsoft 365 tenant outside of the Surface Support Portal. | Ideal for specialists handling specific service requests and device management tasks. |

>[!NOTE]
> To access Surface Management Portal (Intune), users assigned the Microsoft Hardware Warranty Admin or Microsoft Hardware Warranty Specialist role must also be assigned the Read Only Operator role.

To assign new roles to users:

- Open the necessary Admin Center (Microsoft 365 Admin Center for Surface Support Portal, Intune Admin Center for Surface Management Portal).
- Select **Users**.
- Select **Active Users**.
- Select **Manage Roles**.

A recommended role for access to both portals is the Microsoft Hardware Warranty Administrator role. This role is suited for overseeing the comprehensive management of Surface devices—granting access to view all support requests, service orders, and updating shipping and billing addresses. These functions are all crucial for overseeing the entire lifecycle of Surface device management.

>[!IMPORTANT]
> For Surface Management Portal access only, users assigned the Microsoft Hardware Warranty Administrator role must also be assigned the Global Reader role, which provides visibility into administrative settings and configurations across Microsoft Entra.

Other roles that may be valuable are the Microsoft Hardware Warranty Specialist role, which allows for the creation and management of device replacement requests and a read-only view of the Microsoft 365 tenant outside of the support portals. However, this role doesn't have the ability to add, edit, or delete billing and shipping addresses.

Implementing one or more of these roles ensures your team is equipped with the necessary permissions to manage Surface devices efficiently and securely. Let's review the available roles for accessing the portals and what their capabilities are:

| **User roles and access level** | **View service requests** | **Create/manage device replacement requests** | **Add, edit, delete ship to addresses** |
| :---: | :---: | :---: | :---: |
| Global Admin | ✔️ | ✔️ | ✔️ |
| Service Support Admin | ✔️ | ✔️ | ❌ |
| Billing Admin | ✔️ | ✔️ | ✔️ |
| Global Reader | ✔️ | ❌ | ❌ |
| Microsoft Hardware Warranty Administrator | ✔️ | ✔️ | ✔️ |
| Microsoft Hardware Warranty Specialist | ✔️ | ✔️ | ❌ |

This information can help you or your IT team assign the appropriate role before proceeding with portal access. Now that you understand the key admin roles and how they unlock access to the Surface Management and Support Portals, you're ready to move forward with confidence.
