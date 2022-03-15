The AD DS (Active Directory) security group Protected Users helps you protect highly privileged user accounts against compromise. The Protected Users group members have several security-related configuration settings applied that cannot be modified except by leaving the group.

## Protected Users group prerequisites

To provide protection for members of the Protected Users group:

- The group must be replicated to all domain controllers.

- The user must sign in to a device running Windows 8.1 or Windows Server 2012 R2 or later.

- Domain controller protection requires that domains must be running at a Windows Server 2012 R2 or higher domain functional level. Lower functional levels still support protection on client devices.

## Protected Users group protections

When a user is a member of the Protected Users group, on their workstation or local device:

- User credentials are not cached locally.

- Credential delegation (CredSSP) will not cache user credentials

- Windows Digest will not cache user credentials.

- NTLM will not cache user credentials.

- Kerberos will not create DES (Data Encryption Standard) or RC4 keys, or cache credentials or long-term keys.

- The user can no longer sign-in offline.

On domain controllers running Windows Server 2012 R2 or later:

- NTLM authentication is not allowed.

- DES and RC4 encryption in Kerberos preauthentication cannot be used.

- Credentials cannot be delegated using constrained delegation.

- Cannot be delegated using unconstrained delegation.

- Ticket-granting tickets (TGTs) cannot renew past the initial lifetime.

## Authentication policies

Authentication policies enable you to configure TGT lifetime and access-control conditions for a user, service, or computer account. For user accounts, you can configure the user’s TGT lifetime, up to the maximum set by the Protected Users group’s 600-minute maximum lifetime. You can also restrict which devices the user can sign in to, and the criteria that the devices need to meet.

## Authentication policy silos

Authentication policy silos allow administrators to assign authentication policies to user, computer, and service accounts. Authentication policy silos work with the Protected Users group to add configurable restrictions to the group’s existing non-configurable restrictions. In addition, policy silos ensure that the accounts belong to only a single authentication policy silo.

When an account signs in, a user that is part of an Authentication policy silo is granted an Authentication Policy Silo claim. This silo claim controls access to claims-aware resources to verify whether the account is authorized to access that device. For example, you might associate accounts that can access sensitive servers with a specific Authentication policy silo.

Additional reading: For more information about authentication policies and authentication policy silos, see [Authentication Policies and Authentication Policy Silos](https://aka.ms/authentication-policies-and-policy-silos).

