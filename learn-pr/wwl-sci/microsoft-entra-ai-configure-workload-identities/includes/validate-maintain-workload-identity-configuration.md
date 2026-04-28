Before the workload goes into production, run a preproduction checkpoint: confirm sign-in works from the actual hosting environment, verify permissions match what you documented, check that audit logs capture the right activity, and make sure a credential rotation plan is in place.

## Test sign-in behavior from the actual hosting environment

Token acquisition from a developer workstation confirms the credential is configured correctly, but it doesn't confirm the workload can authenticate from its production environment. Network restrictions, conditional access policies, and managed identity availability can all differ between environments.

1. Deploy the workload to its production hosting environment, or to a staging environment that matches the production configuration.
1. Trigger a sign-in from the workload's actual runtime context.
1. Confirm the sign-in succeeds by checking the service principal sign-in logs in Microsoft Entra.
1. Verify the sign-in log entry shows the expected credential type, the expected service principal, and the expected resource.

If sign-in fails only from the production environment, start by checking whether the hosting environment supports the credential type. Then check whether network restrictions block token acquisition. Finally, check whether conditional access policies for workload identities are blocking the service principal. These policies require Microsoft Entra Workload ID Premium licensing, so check with the tenant administrators whether any apply.

## Review permissions and consent status

Every permission should map to a specific workload task. If you can't explain why a permission exists, it shouldn't survive this review.

1. Open the enterprise application (service principal) for the workload in Microsoft Entra.
1. Confirm that each API permission matches a documented workload task. Check that admin consent has been granted where required.
1. Confirm each Azure role assignment matches the scope and role you intended.
1. Look for permissions that accumulated from testing, copy-paste from other identities, or default settings.
1. For AI workloads, confirm the identity doesn't hold model management roles when it only needs inference access. A workload that sends prompts to Azure OpenAI shouldn't also have the ability to redeploy or delete model endpoints.

If you find permissions that don't map to a documented workload task, investigate how they were assigned and remove them.

## Review Azure activity logs for role assignment operations

Role assignments don't always come from where you expect. Automation pipelines, management group policies, and leftover test configurations can all create assignments that nobody deliberately chooses. Filter the Azure activity log for **Create role assignment** and **Delete role assignment** operations on the relevant resources. Verify each operation was made by an authorized administrator and matches an assignment you intended. If the log shows role assignments you didn't create, investigate the source before the workload goes into production.

## Know how to rotate credentials before you need to

You won't rotate credentials on day one, but confirm the process works before the workload reaches production. Document the credential's expiration date and the rotation timeline now, so that when the time comes the process is already understood and tested.

For managed identities, Azure handles credential rotation automatically. No additional rotation planning is needed.

For certificates and client secrets, rotation follows a create-verify-remove pattern. Generate the new credential and add it to the app registration while the old one is still valid, update the workload to use the new credential, verify authentication succeeds, then remove the old credential. Both credentials are valid during the overlap, so there's no downtime. For certificates, document the expiration date and test rotation before you need it. For client secrets in development and testing scenarios, apply the same pattern with shorter timelines.

> [!NOTE]
> If the workload stores credentials in Azure Key Vault, update the Key Vault secret or certificate at the same time. Confirm the workload retrieves the new credential from Key Vault after rotation.

## Remove unnecessary access after validation

Validation often reveals leftover access from development or testing that has no purpose in production. This is the right time to clean it up, before the workload goes live and the extra permissions become the new baseline. Compare the identity's current permissions against the documented production requirements.

- Remove any Azure RBAC role assignments, Graph permissions, or app roles that don't map to a current production task.
- Revoke admin consent for permissions that are no longer required.
- Confirm the workload still functions correctly after removing the excess permissions.

After this cleanup, the identity carries only the access the workload needs in production.
