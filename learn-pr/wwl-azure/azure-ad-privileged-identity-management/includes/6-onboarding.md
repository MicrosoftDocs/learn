To use PIM, you need one of the following paid or trial licenses: Azure AD Premium P2, Enterprise Mobility + Security (EMS) E5, or Microsoft 365 M5.

**PIM Access**

:::image type="content" source="../media/az500-privileged-role-administrator-de17711a.png" alt-text="Screenshot of the Privileged Role Administrator page with members being assigned to the role.":::


The first Global Administrator to use PIM in your instance of Azure AD is automatically assigned the Security Administrator and Privileged Role Administrator roles in the directory. This person must be an eligible Azure AD user. Only privileged role administrators can manage the Azure AD directory role assignments of users. In addition, you can choose to run the security wizard that walks you through the initial discovery and assignment experience.

Users or members of a group assigned to the Owner or User Access Administrator roles, and Global Administrators that enable subscription management in Azure AD, are Resource Administrators. These administrators can assign roles, configure role settings, and review access by using PIM for Azure resources.

No one else in your Azure Active Directory (Azure AD) organization gets write access by default, though, including other Global administrators. Other Global administrators, Security administrators, and Security readers have read-only access to Privileged Identity Management. To grant access to Privileged Identity Management, the first user can assign others to the **Privileged Role Administrator** role.

> [!IMPORTANT]
> Make sure there are always at least two users in a Privileged Role Administrator role, in case one user is locked out or their account is deleted.
