TODO

## Block human access

Use Azure RBAC to restrict or block human access to controlled environments. At most, humans should get *Reader* access. Ensure access is granted at the appropriate scope. Don't allow any wiggle room. (Example scenario - someone has the prod and dev environments open in the portal, switches tabs a few times, and accidentally breaks or deletes prod.)

### What about emergencies?

Plan for emergency access. Use [break-glass accounts](https://docs.microsoft.com/azure/active-directory/roles/security-emergency-access), or use [Azure AD PIM](TODO), which you can configure by using Bicep - [1]](https://docs.microsoft.com/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta&preserve-view=true#migrate-to-the-azure-resource-manager-arm-pim-api-for-azure-resource-roles), [2](https://docs.microsoft.com/rest/api/authorization/privileged-role-policy-rest-sample#update-a-role-management-policy).

If you use PIM or another emergency access method, ensure that you update your IaC with the latest changes after the emergency ends.

## Audit changes to your environment

Consider using a SIEM like Azure Sentinel. You can stream/import pipeline event/audit logs to a SIEM and even trigger alerts based on some criteria (e.g. when a project admin changes a branch protection policy).

## Audit your security configuration

Audit your privileged accounts, and your role assignments, regularly. Ensure you haven't accidentally granted access to the wrong people, or granted access that's too wide.
