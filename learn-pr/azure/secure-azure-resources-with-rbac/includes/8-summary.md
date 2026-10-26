In this module, you learned about Azure RBAC, and how you can use it to secure your Azure resources. To grant access, you assign users a role at a particular scope. Using Azure RBAC, you can grant only the amount of access to users that they need to perform their jobs. 

Azure RBAC has more than 200 built-in roles. However, if your organization needs specific permissions, you can create your own custom roles. Azure keeps track of your Azure RBAC changes in case you need to see what changes were made in the past.

## More info

Use these resources to prepare for the exercises:

- [Azure portal](https://portal.azure.com)
- [Create an Azure account with an active subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn)
- [Create resource groups in the Azure portal](/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups)

Explore Azure RBAC concepts, role definitions, and built-in permissions:

- [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)
- [Azure and Microsoft Entra role models](/azure/role-based-access-control/rbac-and-directory-admin-roles)
- [Understand Azure role definitions](/azure/role-based-access-control/role-definitions)
- [NotActions in role definitions](/azure/role-based-access-control/role-definitions#notactions)
- [Azure built-in role catalog](/azure/role-based-access-control/built-in-roles)
- [Owner permissions](/azure/role-based-access-control/built-in-roles#owner)
- [Contributor role permissions](/azure/role-based-access-control/built-in-roles/privileged#contributor)
- [User Access Administrator permissions](/azure/role-based-access-control/built-in-roles#user-access-administrator)
- [Role Based Access Control Administrator permissions](/azure/role-based-access-control/built-in-roles/privileged#role-based-access-control-administrator)
- [Virtual Machine Contributor permissions](/azure/role-based-access-control/built-in-roles/compute#virtual-machine-contributor)
- [Azure role-assignment conditions FAQ](/azure/role-based-access-control/conditions-faq)
- [List Azure role definitions in the portal](/azure/role-based-access-control/role-definitions-list#azure-portal)

Use these references to manage and troubleshoot role assignments:

- [Prerequisites for listing role assignments](/azure/role-based-access-control/role-assignments-list-portal#prerequisites)
- [Check access and activate an eligible role](/azure/role-based-access-control/check-access)
- [Check your access at a selected scope](/azure/role-based-access-control/check-access#step-2-check-your-access)
- [Select a role assignment type](/azure/role-based-access-control/role-assignments-portal#step-6-select-assignment-type)
- [Remove Azure role assignments in the portal](/azure/role-based-access-control/role-assignments-remove#azure-portal)
- [Troubleshoot Azure RBAC](/azure/role-based-access-control/troubleshooting#symptom---role-assignment-changes-are-not-being-detected)
- [Role assignments - Create REST API](/rest/api/authorization/role-assignments/create?view=rest-authorization-2022-04-01&preserve-view=true)
- [Edit a role-assignment condition with the REST API](/azure/role-based-access-control/conditions-role-assignments-rest#edit-a-condition)

Review these PIM permission, licensing, and assignment requirements:

- [PIM API permissions for Azure resources](/entra/id-governance/privileged-identity-management/pim-apis#pim-for-azure-resources)
- [PIM permissions overview](/entra/id-governance/privileged-identity-management/pim-configure#who-can-do-what)
- [PIM licensing overview](/entra/id-governance/licensing-fundamentals#privileged-identity-management)
- [Licenses required for PIM](/entra/id-governance/licensing-fundamentals#licenses-you-must-have-for-pim)
- [Azure resource role assignment in PIM](/entra/id-governance/privileged-identity-management/pim-resource-roles-assign-roles)
- [Update or remove an existing Azure resource role assignment in PIM](/entra/id-governance/privileged-identity-management/pim-resource-roles-assign-roles#update-or-remove-an-existing-role-assignment)

Use these resources to investigate access changes and plan audit retention:

- [View activity logs for Azure RBAC changes](/azure/role-based-access-control/change-history-report)
- [Azure Activity Log retention and export](/azure/azure-monitor/fundamentals/activity-log)
- [Export activity log](/azure/azure-monitor/fundamentals/activity-log#export-activity-log)
- [Export the activity log to a file](/azure/azure-monitor/fundamentals/activity-log#export-the-activity-log-to-a-file)
- [Azure Activity Log event schema](/azure/azure-monitor/fundamentals/activity-log-schema)
- [Activity Log schema property descriptions](/azure/azure-monitor/fundamentals/activity-log-schema#property-descriptions)
- [Monitoring Reader permissions](/azure/azure-monitor/fundamentals/roles-permissions-security#monitoring-reader)
- [View audit report for Azure resource roles in PIM](/entra/id-governance/privileged-identity-management/azure-pim-resource-rbac)
- [View PIM resource audit history](/entra/id-governance/privileged-identity-management/azure-pim-resource-rbac#view-resource-audit-history)
- [Get reason, approver, and ticket number for approval events](/entra/id-governance/privileged-identity-management/azure-pim-resource-rbac#get-reason-approver-and-ticket-number-for-approval-events)
- [Prerequisites for accessing Microsoft Entra activity logs](/entra/identity/monitoring-health/howto-access-activity-logs#prerequisites)
- [Microsoft Entra data retention](/entra/identity/monitoring-health/reference-reports-data-retention)
- [Microsoft Entra activity-report retention](/entra/identity/monitoring-health/reference-reports-data-retention#activity-reports)

Review identity synchronization and offboarding guidance:

- [User access revocation procedure](/entra/identity/users/users-revoke-access)
- [Identity synchronization decision guide](/entra/identity/hybrid/cloud-sync/connect-to-cloud-sync-decision-guide)
- [Microsoft Entra Connect version history](/entra/identity/hybrid/connect/reference-connect-version-history)

Explore supported deployment-management tools:

- [Deployment stacks](/azure/azure-resource-manager/bicep/deployment-stacks)
- [Template specs](/azure/azure-resource-manager/bicep/template-specs)

The following video provides an overview of Azure RBAC:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=0c2fa19a-79e6-4922-a1c6-03041e8369e7]
