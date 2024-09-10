The Active Directory Domain Services (AD DS) security group Protected Users helps you protect highly privileged user accounts against compromise. The Protected Users group members have several security-related configuration settings applied that can't be modified except by leaving the group.

## Protected Users group prerequisites

To provide protection for members of the Protected Users group:

 -  The group must be replicated to all domain controllers.
 -  The user must sign in to a device running Windows 8.1 or Windows Server 2012 R2 or later.
 -  Domain controller protection requires that domains must be running at a Windows Server 2012 R2 or higher domain functional level. Lower functional levels still support protection on client devices.

## Protected Users group protections

When a user is a member of the Protected Users group, on their workstation or local device:

 -  User credentials aren't cached locally.
 -  Credential delegation (CredSSP) won't cache user credentials.
 -  Windows Digest will not cache user credentials.
 -  NTLM won't cache user credentials.
 -  Kerberos won't create DES (Data Encryption Standard) or RC4 keys, or cache credentials or long-term keys.
 -  The user can no longer sign-in offline.

On domain controllers running Windows Server 2012 R2 or later:

 -  NTLM authentication isn't allowed.
 -  DES and RC4 encryption in Kerberos pre-authentication can't be used.
 -  Credentials can't be delegated using constrained delegation.
 -  Can't be delegated using unconstrained delegation.
 -  Ticket-granting tickets (TGTs) can't renew past the initial lifetime.

To add users to privileged groups and the Protected Users group using the Active Directory Administrative Center (ADAC), follow these steps:

1.  Open the **Active Directory Administrative Center (ADAC)**.
2.  In the left-hand navigation pane, expand your domain and navigate to the Users container or the specific Organizational Unit (OU) where the privileged group or the Protected Users group is located.
3.  In the main pane, find and select the group to which you want to add users.
4.  In the right-hand Tasks pane, click **Properties**.
5.  In the group properties window, navigate to the **Members** tab.
6.  Click **Add** to open the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box.
7.  Search for the user accounts you want to add to the group, select them, and then click **OK**.
8.  Confirm the additions by clicking **OK** and then **OK** again in the group properties window.<br>

> [!NOTE]
> The Protected Users group, which is designed to provide additional protections against credential theft attacks, uses the same steps to add users. However, ensure that the domain functional level is Windows Server 2012 R2 or later, as it's a prerequisite for deploying a Protected Users group.

## Authentication policies

Authentication policies enable you to configure TGT lifetime and access-control conditions for a user, service, or computer account. For user accounts, you can configure the user’s TGT lifetime, up to the maximum set by the Protected Users group’s 600-minute maximum lifetime. You can also restrict which devices the user can sign in to, and the criteria that the devices need to meet.

### Authentication policy silos

Authentication policy silos allow administrators to assign authentication policies to user, computer, and service accounts. Authentication policy silos work with the Protected Users group to add configurable restrictions to the group’s existing non-configurable restrictions. In addition, policy silos ensure that the accounts belong to only a single authentication policy silo.

When an account signs in, a user that is part of an Authentication policy silo is granted an Authentication Policy Silo claim. This silo claim controls access to claims-aware resources to verify whether the account is authorized to access that device. For example, you might associate accounts that can access sensitive servers with a specific Authentication policy silo.

Additional reading: For more information about authentication policies and authentication policy silos, see [Authentication Policies and Authentication Policy Silos](https://aka.ms/authentication-policies-and-policy-silos).
