Local identity with Azure Key Vault lets an Azure Local instance use local administrator accounts and deployment-configured certificate-based authentication without joining its nodes to an AD DS domain. This choice applies to the physical platform; guest operating systems and applications still need their own identity design.

The main benefit of local identity is reduced infrastructure and preparation at sites without a suitable AD DS environment. You don't need to establish domain controllers, create an instance OU, or delegate directory permissions solely for Azure Local. This can simplify branch and edge deployments and remove the platform's reliance on domain authentication. Key Vault also provides protected storage for supported recovery material, such as BitLocker recovery keys and the platform recovery account's credentials.

The trade-off is a different operating model, not the removal of identity administration. The operations team must maintain consistent local administrator credentials across the nodes, monitor certificate health, manage vault permissions, and verify recovery backups. Existing administration tools and procedures might not transfer: Windows Admin Center is unsupported for this model, and compatibility varies for other management tools. A team with established AD DS administration might therefore need additional procedures and training rather than finding local identity simpler.

DNS, time synchronization, and the Azure connectivity required by this deployment remain prerequisites. Assign owners for local accounts, certificates, DNS, vault access, and recovery before deployment; creating a vault alone doesn't establish that the system can be recovered.

## Prepare the customer-managed local administrator

Create an approved, **non-built-in** local administrator on each node, using the same username and password across the instance as required by the workflow. Use the documented complex password of at least 14 characters and protect it through the organization's approved credential process.

This isn't the built-in Administrator account, and it isn't the recovery account discussed later. The customer-managed local administrator account remains necessary for supported add-node and repair operations. The customer owns this account's expiration, rotation, and security.

Changing the password on one node independently can create an inconsistent administrative state. When managing this identity, use the supported cluster-wide lifecycle procedure rather than treating each machine as an unrelated server.

## Understand certificate-based integration

A digital certificate associates a public key with an identity and a validity period. Operations that rely on that certificate need the corresponding protected private key and a valid trust relationship. Certificate validity is one reason that correct time remains important without AD DS.

Deployment establishes the supported certificate-based integration for the local-identity platform. It doesn't authorize an improvised scheme that copies private keys between machines or manually replaces certificates outside the supported workflow.

Prepare an owner for certificate health, expiration monitoring, and documented lifecycle operations. Don't invent a renewal interval or assume that every certificate is maintained by the same mechanism as the customer-managed administrator password.

## Treat vault access and backup as separate evidence

Azure Key Vault protects supported secrets, keys, and certificates through explicit authorization. Local-identity guidance requires a dedicated vault for the cluster. Record the vault's purpose, resource identity, permitted callers, network configuration, and operational owner.

There are two important boundaries. The deployment user needs its documented Azure permissions. The Arc machines' managed identities need the documented vault permissions for their backup extension, including **Key Vault Secrets Officer** and **Key Vault Certificates Officer**. Granting a human access doesn't prove that the extension can write recovery material.

The deployment vault must use the network configuration supported by Azure Local. Current deployment guidance requires public network access and doesn't support selecting an existing deployment vault with Private Endpoints enabled. If organizational policy conflicts with that requirement, resolve the supported design with the security owner before deployment.

> [!IMPORTANT]
> Don't equate "a vault exists" with "recovery is available." The current portal guidance distinguishes a deployment vault from a preview backup-vault option, while local-identity guidance describes its recovery integration. Follow the selected build and identity workflow, record each vault's purpose, and verify the actual extension state and expected backup contents. Don't assume that every Azure Local deployment automatically backs up all system secrets.

After deployment, the local-identity recovery workflow includes BitLocker recovery material and the **RecoveryAdmin** credential. BitLocker protects data at rest; recovery material enables authorized recovery when normal unlock or administrative access is unavailable.

RecoveryAdmin is a platform recovery account, not the customer-managed deployment administrator. Don't assume that rotation of recovery material in Key Vault rotates the customer-managed account.

Design protected emergency access in advance. Identify who can retrieve recovery material, how access is approved and audited, and how the runbook can be reached during an incident. Readiness evidence should record that expected objects, permissions, and recovery procedures were verified; don't include the secret values.

## Prepare DNS before deployment

For local identity, configure static node IP addresses as DHCP is unsupported for the nodes in this model. With existing enterprise DNS, create the required host A records for every node and for the system. An *A record* maps a DNS name to an IPv4 address. The system record uses the first infrastructure-pool address.

An *authoritative DNS zone* contains the records for its namespace. A *forwarder* sends queries that the local DNS service can't resolve to another resolver. Prepare both the internal records and the forwarding path needed for required external endpoints.

The alternative **Internal DNS** capability provides infrastructure name resolution, not primary application DNS. Its setup still requires the documented zone and forwarding configuration, including a forwarder capable of resolving required external endpoints.

Don't point virtual machines, Kubernetes workloads, enterprise applications, or service discovery at Internal DNS as a substitute for their supported DNS design. In this module's exercise, Contoso's branch uses existing enterprise DNS.

## Establish local-identity readiness

Use the following sequence to establish local-identity readiness:

1. Confirm that the selected build, workloads, administration tools, and support requirements fit the local-identity model.
1. Prepare and verify the same approved non-built-in local administrator credentials on all nodes.
1. Establish static addressing, required DNS records, forwarding, and consistent time.
1. Prepare the dedicated vault and the documented human and machine-identity permissions, network access, and audit logging.
1. Define the supported account and certificate lifecycle procedures, protected recovery access, and postdeployment backup verification.
1. Confirm that the operations team can use supported PowerShell and portal workflows without relying on Windows Admin Center.

Before deployment, approve the recovery **design** and its prerequisites. During deployment handoff, verify the **resulting** extensions and recovery material. Don't claim that a backup of a not-yet-deployed system already exists.

After a vault recovery, restoring the vault resource alone is insufficient. The relevant role assignments, extension success, and backup behavior must also be restored and verified. Where a vault must be replaced, use the documented Azure Local workflow rather than deleting the existing vault or moving secrets ad hoc.

**Scenario decision:** The branch's platform owner accepts local identity only after the operations team demonstrates a supported management route and the security owner approves protected recovery access. Avoiding a domain doesn't justify avoiding lifecycle ownership.
