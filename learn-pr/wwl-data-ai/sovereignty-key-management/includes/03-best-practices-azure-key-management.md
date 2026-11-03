The following sections outline the best practices for effective key management in Azure Key Vault services.

## Access controls

To maintain secure key management in Azure Key Vault services, implementing robust access controls is essential. Azure Key Vault operates across two access planes:

- **Control plane** - Controls administrative tasks, such as vault creation, deletion, and configuration settings.
- **Data plane** - Governs access to stored keys, secrets, and certificates, managing their use directly.

Regardless of the SKU, access should be carefully regulated through Azure role-based access control (RBAC) to ensure that only authorized users and applications have access to vaults.

To limit exposure, you should grant permissions at the lowest possible level among the following scopes to users, groups, or applications:

- **Subscription level** - Use this level only for roles that need broad access across all resources in a subscription.
- **Resource Group level** - Use this level to provide access to all resources in a specific resource group. This level is suitable for roles that manage related resources.
- **Key Vault level** - For sensitive or specific access needs, you can assign roles directly at the Key Vault level. This approach restricts access to the resources exclusively.

Restricting access on the control and data planes aligns with the least privilege principle, ensuring that even administrative users don't have unnecessary access to sensitive keys and secrets unless required.

- Azure Key Vault supports Standard and Premium SKUs, each with specific deployment considerations. While you're using key vaults, deploy one vault for each application, environment, and region to enforce least privilege. While you're using Azure Key Vault Managed HSM, deploying a smaller number of centralized vaults might be a preferred way to manage costs.
- Azure Key Vault Managed HSM local role-based access control (RBAC) has several built-in roles. You can assign these roles to users, service principals, groups, and managed identities. To allow a principal to perform an operation, you must assign them a role that grants them permissions to perform that operation. These roles and operations allow you to manage permissions only for data plane operations. Azure Key Vault Managed HSM local RBAC access control model allows HSM cluster administrators to have complete control over the HSMs that even the management group, subscription, or resource group administrators can't override. For more information on using RBAC for access control, see [Local RBAC built-in roles for Azure Key Vault Managed HSM | Microsoft Learn](/azure/key-vault/managed-hsm/built-in-roles).

Organizations that are considering the incorporation of Azure Key Vault Managed HSM need to understand the access control models and role assignments for administrative and cryptographic tasks. This understanding should help them plan for addressing the following operation scenarios:

- **Create new keys in managed HSM** - Currently, creating a new key requires assigning a role with permissions beyond creation. For instance, the Crypto User role grants capabilities, such as key rotation and deletion alongside key creation. These permissions can create challenges for organizations that follow strict least-privilege principles because it might result in a broader scope of permissions than necessary.
- **Manage existing keys (control plane)** – The control plane requires appropriate RBAC roles. It's essential to assign these permissions carefully to ensure that only authorized personnel can alter or rotate keys to maintain security and compliance.
- **Use existing keys (data plane)** - The data plane encompasses key usage by applications and services. Ensuring that only permitted applications or services can use keys is critical for maintaining security.

To address scenarios where a broader permission set might compromise least-privilege policies, organizations can consider establishing a dedicated team with elevated privileges, specifically for key creation. This team can handle requests for new keys, ensuring that application teams don't need expanded permissions that could compromise security. Automating key creation through IT service management (ITSM) workflows can streamline this process. By using [Managed HSM's REST API](/rest/api/keyvault/managedhsm/managed-hsms), IT teams can automate key requests while restricting direct access to elevated roles.

## Compliance constraints for FIPS-140 Level 3 validation

Azure Key Vault Premium and Azure Key Vault Managed HSM comply with FIPS 140-2 Level 3, ensuring a high standard of data protection. Compliance in these tiers is achieved through the shared infrastructure design in Azure, where Azure manages the access control, compliance, and validation. However, the design and operational implications of this compliance differ between the services.

- **Azure Key Vault Premium** relies on FIPS-validated hardware in a shared infrastructure rather than providing dedicated HSMs. This tier applies Microsoft Entra ID and role-based access control (RBAC) for access management, which allows for more granular permissions for each key that can be tailored for application-specific needs. This control for each key provides flexibility, particularly in environments where multiple applications or tenants need distinct access policies. It provides application-specific flexibility by recommending the use of separate key vaults for each application, which allows for isolated management of access and compliance.
- **Azure Key Vault Managed HSM** service is designed to achieve this requirement through stricter, hardware-enforced, identity-based controls. In a managed HSM, RBAC can also be implemented at the hardware level, with permissions enforced across the entire HSM instance or security domain rather than at an individual key level only. This configuration provides administrative permissions over the entire security domain for tasks, such as key creation, because permissions can't be applied to keys that don't yet exist. Therefore, if your organization policy needs to store or manage a key in a managed HSM instance, you must hold comprehensive permissions for the entire security domain or you should work with a centralized team with those required permissions.

Overall, while both services meet FIPS 140-2 Level 3 standards, Azure Key Vault Premium offers a more flexible model for individual application requirements. Contrarily, Azure Key Vault Managed HSM aligns with a centralized security approach, where permissions are managed broadly across the security domain.

## Security domain

To operate, the Azure Key Vault Managed HSM must have a *customer-controlled security domain*. The security domain is an encrypted blob file that contains artifacts, such as the HSM backup, user credentials, the signing key, and the data encryption key that's unique to the managed HSM.

A managed HSM security domain serves the following purposes:

- Establishes "ownership" by cryptographically tying each managed HSM to root-of-trust keys under your sole control. This step ensures that Microsoft doesn't have access to your cryptographic key material on the managed HSM.
- Sets the cryptographic boundary for key material in a managed HSM instance.
- Allows you to fully recover a managed HSM instance if a disaster occurs.

Without the security domain, disaster recovery isn't possible. Microsoft has no way to recover the security domain, and Microsoft can't access your keys without the security domain. Therefore, protecting the security domain is of the utmost importance for your business continuity and to ensure that you aren't cryptographically locked out.

## Back up and restore

Azure Key Vault Managed HSM supports the creation of a full backup of the entire contents of the HSM, including all keys, versions, attributes, tags, and role assignments. The backup is encrypted with cryptographic keys that are associated with the HSM's security domain. Be sure that you create regular backups of your managed HSM. You can create backups at the HSM level and for specific keys.

To safeguard against accidental or intentional deletions, we recommend that you turn on [soft-delete and purge protection features](/azure/key-vault/general/key-vault-recovery?tabs=azure-portal#what-are-soft-delete-and-purge-protection) in a managed HSM. These features ensure that, even if a deletion occurs, that the keys and HSM resources can be recovered within a set retention period, adding an extra layer of protection. Soft-delete holds deleted resources in a "soft-deleted" state, while purge protection prevents permanent deletion within the retention period, allowing administrators time to recover assets if needed.

For more information, see [Security domain in Azure Key Vault Managed HSM | Microsoft Learn](/azure/key-vault/managed-hsm/security-domain#security-domain-protection-best-practices)

## Key rotation

Key rotation in Azure Key Vault automatically generates a new key version at a specified frequency. Key rotation is crucial when an administrator who has access to the keys leaves the organization or changes roles, or if evidence suggests that customer-managed keys are compromised, necessitating immediate action to protect sensitive data.

The frequency of key rotation should align with your organization's security policy, ensuring that keys are refreshed regularly to minimize the risk of exposure. Regular rotation of customer-managed keys is a critical security practice.

Azure Key Vault and Azure Key Vault Managed HSM support *autorotation* of keys, which allows organizations to automate the rotation process. Automating key rotation enhances security by reducing the potential for human error and ensuring that key refreshes occur consistently according to policy. Automated key rotation can significantly reduce operational overhead and ensure that keys are rotated without human intervention.

It's essential to regularly test the automation process to ensure its effectiveness. Conduct routine audits and simulate rotation scenarios to verify that the system functions correctly and that all dependencies handle the new keys seamlessly.

In the event of a compromised key, it's critical to have a robust system in place to regenerate secrets immediately. If automating the key rotation process isn't feasible, it's crucial to implement alert systems to prevent issues, such as certificate expirations and potential outages. Setting up alerts ensures that administrators receive timely notifications about upcoming key rotations or expirations, which allows for proactive management of keys and secrets.

## BYOK

For added assurance, in Azure Key Vault Premium and Azure Key Vault Managed HSM, you can [bring your own key (BYOK)](/azure/key-vault/keys/hsm-protected-keys-byok) and import HSM-protected keys from an on-premises HSM. You can also generate HSM-protected keys on-premises and import them into Azure Key Vault Managed HSM more securely. If you're interested in generating or escrowing your encryption keys, you can do so by generating the keys in an external HSM.

For more information, see [How to generate and transfer HSM-protected keys – Azure Key Vault | Microsoft Learn](/azure/key-vault/keys/hsm-protected-keys).

## Monitor and audit

You can get complete logs of all activity through Microsoft Azure Monitor, which is fully integrated with Azure Key Vault Managed HSM, providing critical monitoring and logging capabilities. With Azure Monitor, administrators can track and log access to key vaults, monitor system performance, and receive alerts for unusual activity. This integration ensures that administrators have visibility into operations and access, which is essential for promptly detecting and responding to potential security incidents.

After you create one or more managed HSMs, you likely want to monitor how and when your HSMs are accessed and by who. You can do so by turning on logging, which saves information in an Azure storage account that you provide. A new container named **insights-logs-auditevent** is automatically created for your specified storage account. You can use this same storage account for collecting logs for multiple managed HSMs. You can also use Microsoft Azure Log Analytics for analytics and alerts.
