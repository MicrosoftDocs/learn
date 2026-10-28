AD DS-based deployment uses directory services provided by Windows Server domain controllers. A *forest* contains one or more domains that share a directory schema, configuration, and global catalog. A *domain* holds accounts and computer objects and provides domain authentication. Azure Local uses a selected domain within that structure; an Azure Local instance isn't itself an AD DS domain or forest.

You can use a suitable domain in an existing organizational forest. Azure Local doesn't require a new forest or domain for every instance or node. Instead, prepare a dedicated organizational unit (OU) and deployment account for each Azure Local instance. Reusing an existing forest lets the organization retain established identity administration, DNS infrastructure, and compatible management tools. The trade-off is continued dependence on directory availability, account maintenance, and effective policy. A dedicated OU narrows delegation and policy scope, but it doesn't isolate the platform from forest administrators.

If no suitable directory exists, the organization can establish a new forest and domain before preparing Azure Local, or evaluate the local-identity alternative described in the next unit. Azure Local deployment doesn't create the forest or its domain controllers. A separate management forest can provide administrative separation from the corporate directory, but adds domain controllers, DNS, replication, backup, monitoring, and account-recovery responsibilities. It's an architecture and governance choice, not a standard Azure Local prerequisite.

A *trust* provides an authentication path between domains; it doesn't automatically grant permission to administer resources. Domains within the same forest have automatic two-way, transitive trust paths, allowing authentication requests to pass between those domains. Separate forests don't automatically trust each other. Administrators can explicitly establish one-way or two-way forest trusts when cross-forest access is required. For example, if a resource forest trusts a corporate account forest, corporate users can authenticate to resources in the resource forest, subject to authentication restrictions and assigned permissions. A one-way trust doesn't provide the reverse access path.

No additional forest trust is needed merely to deploy Azure Local when the required accounts and objects are in the selected domain. The workflow in this module prepares the deployment account and instance OU there. Don't assume that a trust makes an account from another domain or forest suitable for deployment or lifecycle operations; confirm support for the specific workflow and required delegation. Any cross-forest design also needs working DNS resolution, required network connectivity, and an approved authentication scope. AD DS trusts don't grant Azure RBAC permissions or replace Microsoft Entra identities used for Azure management.

Make the domain, OU, account ownership, policy boundaries, and any required trust paths explicit before deployment. The goal isn't a successful one-time domain join; it's a directory relationship that remains supportable through deployment, servicing, node replacement, and recovery.

## Understand the objects and their purpose

An *organizational unit* (OU) is an AD DS container used to organize objects, delegate administration, and apply Group Policy. A *distinguished name* identifies an object's directory location. For example, `OU=AzureLocal01,OU=Infrastructure,DC=contoso,DC=com` describes an OU in the fictional `contoso.com` domain.

Use a dedicated OU for the instance's machine and cluster objects. Don't place unrelated servers there, because delegation and policy intended for the platform can affect every applicable object in that scope.

The *Lifecycle Manager* (LCM) account is the deployment identity used for required lifecycle operations. It needs retained rights for activities such as servicing and joining machines during add-node or repair workflows.

The *cluster name object* (CNO) represents the cluster identity in AD DS. A *virtual computer object* (VCO) represents a supported clustered role that needs its own directory identity. Delegating rights only to the human who runs setup doesn't establish the CNO's required rights.

The following table summarizes the directory objects, delegation, and DNS configuration to prepare, along with their importance to ongoing operations.

| Object or configuration | Required preparation | Why it matters later |
| --- | --- | --- |
| Instance OU | Dedicated location and reviewed policy links | Provides a stable delegation and policy boundary |
| Unique LCM account | Compliant name and password; documented lifecycle rights | Supports deployment, servicing, and machine add or repair |
| LCM computer-object delegation | Documented rights on the OU and descendants | Allows supported computer-object lifecycle operations |
| CNO delegation | Documented read and computer-object creation rights | Supports cluster identity operations |
| BitLocker recovery-information delegation | Required rights on descendant recovery-information objects | Supports protected recovery material in the directory |
| DNS records and update policy | Supported dynamic updates or documented precreated records | Allows callers to locate machines and cluster services |

The preparation helper normally creates the LCM account in the chosen OU. The documented manual approach can place the deployment user elsewhere while delegating the required OU rights. Distinguish a helper's layout from a universal account-location requirement.

## Configure and secure the Lifecycle Manager account

Use a dedicated LCM account for each Azure Local instance. Grant it only the necessary documented permissions rather than using a general-purpose domain administrator account. The documented naming rules require 1 to 20 characters, using letters, numbers, hyphens, or underscores, without beginning with a hyphen or number. The name can't be `admin` or the same as the local administrator's name.

The documented password requirement is at least 14 characters with uppercase, lowercase, a number, and a special character. Apply any additional compatible organizational requirements. Supply credentials through a protected prompt or approved secret-handling process, never in a script, transcript, or readiness report.

Required rights include interactive logon and **Log on as a batch job**. A batch logon allows the account to execute a noninteractive task. Deployment adds the LCM account to the nodes' local Administrators groups. That local membership doesn't replace delegated directory rights.

Plan account expiration, password maintenance, ownership, and lifecycle availability. Removing the account's rights immediately after deployment can break later servicing even if workloads continue to run.

## Review effective policy, not just linked policy

A *Group Policy Object* (GPO) contains settings applied through AD DS scope and inheritance. The important question is what settings actually take effect on the target computers and account.

Blocking inheritance on the dedicated OU doesn't block **enforced** GPOs. A deny-logon setting can also prevent the required logon even when an allow right exists. Adding a more privileged group isn't a safe or reliable substitute for resolving the effective policy conflict.

Work with the directory and security owners to identify the applicable settings and implement an approved, narrowly scoped exclusion when required. Don't disable a domain-wide security policy to unblock one deployment.

## Use the supported preparation workflow

The documented helper is **AsHciADArtifactsPreCreationTool**. The preparation guidance identifies package version `10.2402` and the command `New-HciAdObjectsPreCreation`, with `-AzureStackLCMUserCredential` and `-AsHciOUName` parameters. Manual preparation is also documented.

Use a domain-joined administrative host with the approved helper version and sufficient delegated authority. Installing or running this helper changes the environment; it isn't one of this module's read-only inspections. An unpinned installation command doesn't prove that a specific package version was installed.

Complete preparation through the following controlled sequence:

1. Agree the instance OU distinguished name, unique LCM account, password requirements, and directory owner.
1. Review existing objects, delegation, and effective Group Policy before running the approved helper or the documented manual process.
1. Verify the resulting machine-object, CNO, and recovery-information permissions against the dedicated AD DS guidance.
1. Confirm the required account logon rights, domain name resolution, and time consistency from every proposed node.
1. Retain sanitized delegation and policy evidence, then run the appropriate directory validation with its documented prerequisites.

The manual BitLocker recovery-information delegation requires the documented PowerShell approach; the AD delegation wizard alone doesn't establish all the required permissions. Where secure dynamic DNS updates are unavailable, follow the documented precreation requirements for node, CNO, and VCO host records.

After deployment, moving the computer objects to another OU is unsupported. Don't delete the OU as routine repair or cleanup: it can contain BitLocker recovery information. Any reversal of unused predeployment objects must be coordinated with the directory owner.

**Check your understanding:** The helper completes successfully, but an enforced policy denies batch logon. Is the directory ready? No. Object creation proves only that part of preparation. The effective logon policy still blocks the lifecycle operation.
