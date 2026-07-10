Managed service accounts move password and SPN management into Active Directory, which removes the manual burdens described in the introduction. Windows Server offers three types.

- Standalone Managed Service Account
- Group Managed Service Account
- Delegated Managed Service Account

> [!NOTE]
> A virtual account (from the previous unit) is a managed *local* account that authenticates on the network as the computer (`DOMAIN\computer$`) and exists only on that one machine. A managed service account is a separate security principal in Active Directory, with its own name, password, and SPNs that Active Directory manages automatically. Use a virtual account when a single-machine service can act as the computer. Use a managed service account when a service needs its own domain identity, must share one identity across multiple servers, or requires machine-bound credential protection.

## Standalone Managed Service Account (sMSA)

An sMSA is bound to a **single** computer. Active Directory manages its password and SPNs automatically. An sMSA can't be shared across a cluster, network load balancing (NLB), or a server farm.

## Group Managed Service Account (gMSA)

A gMSA extends the sMSA model across **multiple** servers, including farms, NLB, and clusters. The Microsoft Key Distribution Service (`kdssvc.dll`) and the domain controller compute a complex password (rotated every 30 days by default) that authorized hosts retrieve on demand. A gMSA requires a one-time **KDS root key** in the forest.

## Delegated Managed Service Account (dMSA)

New in **Windows Server 2025**, a dMSA is a machine account with fully randomized keys held only on the domain controller and bound to **device identity**. Only machine identities that are mapped in Active Directory can use it. A dMSA is designed to defeat **Kerberoasting** and credential harvesting attacks, and it can be hardened with **Credential Guard**.

You create a dMSA as a standalone account, or you have it **supersede** an existing account. After migration, the old account's password authentication is disabled, and requests are redirected to the Local Security Authority (LSA), which authenticates as the dMSA with the same access.

Key constraints:

- You can't migrate an sMSA or gMSA to a dMSA.
- Every machine that uses the account must support dMSA, or authentication fails once the old account is disabled.
- Migration needs a read-write domain controller and time to replicate. Allow two ticket lifetimes (about 14 days) after you change the security descriptor; keeping the service in the *start* state for up to four ticket lifetimes (about 28 days) is recommended.

> [!NOTE]
> A gMSA password is retrievable by every authorized member host, whereas a dMSA secret never leaves the domain controller.

## Choose a managed account

Use the following table to match each managed account type to a workload:

| Requirement | sMSA | gMSA | dMSA |
| --- | --- | --- | --- |
| Runs on a single server | Yes | Yes | Yes |
| Runs on multiple or load-balanced servers | No | Yes | No |
| Bound to device identity | No | No | Yes |
| High security (anti-Kerberoasting) | No | No | Yes |

## Create the KDS root key

Run this once per forest on a domain controller. It's a prerequisite for gMSAs.

```powershell
# Production: wait up to 10 hours for replication before use
Add-KdsRootKey -EffectiveImmediately

# Lab only: make the key usable immediately
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))
```

## Create and install an sMSA

Create the sMSA in Active Directory, then install and validate it on the host that runs the service:

```powershell
New-ADServiceAccount -Name svcApp1 -RestrictToSingleComputer

# On the host that runs the service:
Install-ADServiceAccount -Identity svcApp1
Test-ADServiceAccount -Identity svcApp1
```

## Create and install a gMSA

Create the gMSA, authorize the hosts that can use it, then install and validate it on each member server:

```powershell
New-ADServiceAccount -Name gmsaWeb -DNSHostName gmsaWeb.contoso.com `
  -PrincipalsAllowedToRetrieveManagedPassword "WebServers"

# On each member server:
Install-ADServiceAccount -Identity gmsaWeb
Test-ADServiceAccount -Identity gmsaWeb
```

Assign the account to a service, for example IIS application pool, or scheduled task as `CONTOSO\gmsaWeb$` with a **blank** password.

## Create a dMSA and migrate an account

Create the dMSA, then migrate a legacy account so the dMSA supersedes it:

```powershell
# Create a standalone dMSA
New-ADServiceAccount -Name dmsaApp1 -DNSHostName dmsaApp1.contoso.com `
  -CreateDelegatedServiceAccount -KerberosEncryptionType AES256

# Migrate a legacy account so the dMSA supersedes it
Start-ADServiceAccountMigration -Identity dmsaApp1 `
  -SupersededAccount "CN=svcLegacy,CN=Users,DC=contoso,DC=com"

# After replication and ticket-lifetime settling, complete the migration
Complete-ADServiceAccountMigration -Identity dmsaApp1
```

Confirm that the superseded account is disabled and that its SPNs moved to the dMSA.
