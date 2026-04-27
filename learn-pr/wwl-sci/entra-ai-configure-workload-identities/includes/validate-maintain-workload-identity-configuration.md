Before the workload goes into production, run a pre-production checkpoint: confirm sign-in works from the actual hosting environment, verify permissions match what you documented, check that audit logs capture the right activity, and make sure a credential rotation plan is in place.

## Test sign-in behavior from the actual hosting environment

Token acquisition from a developer workstation confirms the credential is configured correctly, but it doesn't confirm the workload can authenticate from its production environment. Network restrictions, conditional access policies, and managed identity availability can all differ between environments.

1. Deploy the workload to its production hosting environment, or to a staging environment that matches the production configuration.
1. Trigger a sign-in from the workload's actual runtime context.
1. Confirm the sign-in succeeds by checking the service principal sign-in logs in Microsoft Entra.
1. Verify the sign-in log entry shows the expected credential type (managed identity, federated credential, or certificate), the expected service principal, and the expected resource.

If sign-in fails only from the production environment, check whether the hosting environment supports the credential type, whether network restrictions block token acquisition, and whether conditional access policies for workload identities are blocking the service principal. Conditional access policies that target workload identities require Microsoft Entra Workload ID Premium licensing to create, so check with the tenant administrators whether any policies apply to the service principal.

## Review permissions and consent status

The question isn't whether permissions exist. It's whether you can explain why each one is there. If any permission doesn't map to a specific workload task, it shouldn't survive this review.

1. Open the enterprise application (service principal) for the workload in Microsoft Entra.
1. Review the **Permissions** section. Confirm that each listed API permission matches a specific workload task. Check that admin consent has been granted where required.
1. Review the **Azure role assignments** for the service principal. Confirm each role assignment matches the scope and role you documented during permission configuration.
1. Check for unexpected permissions. Look for roles or Graph permissions that weren't part of the original assignment. These can accumulate from testing, copy-paste from other identities, or default permissions.

If you find permissions that don't map to a documented workload task, investigate how they were assigned and remove them.

## Review Azure activity logs for role assignment operations

Role assignments don't always come from where you expect. Automation pipelines, management group policies, and leftover test configurations can all create assignments that nobody deliberately chooses. The activity log is where you confirm that what's assigned matches what you intend.

1. Open the Azure activity log for the resource or resource group where the workload's roles were assigned.
1. Filter for the **Create role assignment** and **Delete role assignment** operations.
1. Verify that each logged operation matches an assignment you intended to make.
1. Check the caller identity for each operation. Confirm the assignments were made by an authorized administrator, not by an unexpected principal.

If the activity log shows role assignments you didn't create, investigate the source before the workload goes into production.

## Know how to rotate credentials before you need to

Rotation isn't a day-one task, but day one is the right time to confirm you know how to do it. Document the credential's expiration date and the rotation timeline now, so that when the time comes the process is already understood and tested.

For managed identities, Azure handles credential rotation automatically. No additional rotation planning is needed.

For certificate credentials, rotation follows a create-verify-remove workflow that keeps both credentials valid during the transition:

1. Document the certificate's expiration date and the rotation timeline.
1. Before the existing certificate expires, generate a new certificate and upload the public key to the app registration. Both certificates are valid during the overlap period.
1. Update the workload to use the new certificate's private key.
1. Verify the workload authenticates with the new certificate.
1. Remove the old certificate from the app registration after confirming the new one works.

For client secrets (development and testing scenarios), the same create-verify-remove pattern applies, but with shorter timelines:

1. Create a new client secret on the app registration with a short expiration period.
1. Update the workload to use the new secret.
1. Verify the workload authenticates with the new secret.
1. Delete the old secret from the app registration.

The create-verify-remove workflow avoids downtime. Both credentials are valid during the overlap, and the old credential is removed only after the new one is confirmed.

> [!NOTE]
> If the workload stores credentials in Azure Key Vault, update the Key Vault secret or certificate at the same time. Confirm the workload retrieves the new credential from Key Vault after rotation.

## Remove unnecessary access after validation

Validation often reveals leftover access from development or testing that has no purpose in production. This is the right time to clean it up, before the workload goes live and the extra permissions become the new baseline.

1. Compare the identity's current permissions against the documented production requirements.
1. Remove any Azure RBAC role assignments, Graph permissions, or app roles that don't map to a current production task.
1. Revoke admin consent for Graph permissions that are no longer required.
1. Confirm the workload still functions correctly after removing the excess permissions.

Removing unnecessary access before production reduces the identity's blast radius and simplifies future access reviews.
