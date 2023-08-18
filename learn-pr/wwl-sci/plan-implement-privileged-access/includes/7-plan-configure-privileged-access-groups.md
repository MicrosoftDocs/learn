In Privileged Identity Management (PIM), you can now assign eligibility for membership or ownership of privileged access groups. You can assign Azure Active Directory (Azure AD) built-in roles to cloud groups and use PIM to manage group member and owner eligibility and activation. With the privileged access groups preview, you can give workload-specific administrators quick access to multiple roles with a single just-in-time request.

**Example**: Your **Tier 0 Office Admins** might need just-in-time access to the **Exchange Admin**, **Office Apps Admin**, **Teams Admin**, and **Search Admin** roles to thoroughly investigate incidents daily.

You can create a role-assignable group called “Tier 0 Office Admins”, and make it eligible for assignment to the four roles previously mentioned (or any Azure AD built-in roles). Then you enable it for Privileged Access in the group’s Activity section. Once enabled for privileged access, you can assign your admins and owners to the group. When the admins elevate the group into the roles, your staff will have permissions from all four Azure AD roles.

## Require different policies for each role assignable group

Some organizations use tools like Azure AD business-to-business (B2B) collaboration to invite their partners as guests to their Azure AD organization. Instead of a single just-in-time policy for all assignments to a privileged role, you can create two different privileged access groups with their own policies. You can enforce less strict requirements for your trusted employees, and stricter requirements like approval workflow for your partners when they request activation into their assigned role.

:::image type="content" source="../media/privileged-groups-assignments-f64567b1.png" alt-text="Screenshot of the Azure Privileged Identity Manager with the Groups Assignments page open.":::
