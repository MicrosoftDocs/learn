Now that you understand how to control your environments and secure your deployment pipelines, you can take the final step: disabling human access to your controlled environments. In this unit, you'll learn how you can structure your users' permissions to Azure environments, how to allow access in emergency situations, and how to audit any changes that happen in your Azure estate.

## Block human access

Use Azure RBAC to restrict or block human access to controlled environments. At most, humans should get *Reader* access. Ensure access is granted at the appropriate scope. Don't allow any wiggle room. (Example scenario - someone has the prod and dev environments open in the portal, switches tabs a few times, and accidentally breaks or deletes prod.)

### What about emergencies?

Plan for emergency access.

Use [break-glass accounts](https://docs.microsoft.com/azure/active-directory/roles/security-emergency-access):

:::image type="content" source="../media/4-break-glass-account.png" alt-text="Diagram showing the sequence of operations for using a break glass account to access Azure." border="false":::

Or, use [Azure AD PIM](TODO), which you can configure by using Bicep - [1]](https://docs.microsoft.com/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta&preserve-view=true#migrate-to-the-azure-resource-manager-arm-pim-api-for-azure-resource-roles), [2](https://docs.microsoft.com/rest/api/authorization/privileged-role-policy-rest-sample#update-a-role-management-policy).

:::image type="content" source="../media/4-privileged-identity-management.png" alt-text="Diagram showing the sequence of operations for Privileged Identity Management elevation and access to Azure." border="false":::

If you use PIM or another emergency access method, ensure that you update your IaC with the latest changes after the emergency ends.

## Audit changes to your environment

Consider using a SIEM like Azure Sentinel. You can stream/import pipeline event/audit logs to a SIEM and even trigger alerts based on some criteria (e.g. when a project admin changes a branch protection policy).

## Audit your security configuration

Audit your privileged accounts, and your role assignments, regularly. Ensure you haven't accidentally granted access to the wrong people, or granted access that's too wide.
