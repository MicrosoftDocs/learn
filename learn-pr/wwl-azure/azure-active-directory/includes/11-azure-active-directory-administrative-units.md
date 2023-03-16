
An administrative unit is an Azure AD resource that can be a container for other Azure AD resources. An administrative unit can contain only users and groups. Administrative units restrict permissions in a role to any portion of your organization that you define. You could, for example, use administrative units to delegate the Helpdesk Administrator role to regional support specialists, so they can manage users only in the region that they support.

> [!NOTE]
> To use administrative units, you need an Azure Active Directory Premium license for each administrative unit admin, and Azure Active Directory Free licenses for administrative unit members.

:::image type="content" source="../media/administrative-units-dialog-1878e4c5.png" alt-text="Screenshot of the Administrative Units user interface in Azure AD.  Shows that you can Add Users, Groups, and Set up Roles for your Administrative Unit.":::


## Available roles

:::row:::
  :::column:::
    **Role**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication Administrator
  :::column-end:::
  :::column:::
    Has access to view, set, and reset authentication method information for any non-admin user in the assigned administrative unit only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Groups Administrator
  :::column-end:::
  :::column:::
    Can manage all aspects of groups and groups settings, such as naming and expiration policies, in the assigned administrative unit only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Helpdesk Administrator
  :::column-end:::
  :::column:::
    Can reset passwords for non-administrators and Helpdesk administrators in the assigned administrative unit only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    License Administrator
  :::column-end:::
  :::column:::
    Can assign, remove, and update license assignments within the administrative unit only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Password Administrator
  :::column-end:::
  :::column:::
    Can reset passwords for non-administrators and Password Administrators within the assigned administrative unit only.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    User Administrator
  :::column-end:::
  :::column:::
    Can manage all aspects of users and groups, including resetting passwords for limited admins within the assigned administrative unit only.
  :::column-end:::
:::row-end:::
