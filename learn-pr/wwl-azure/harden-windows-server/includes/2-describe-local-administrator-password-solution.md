Each computer that is member of a domain keeps a local Administrator account. This is the account that you configure when you first deploy the computer manually, or which is configured automatically when you use software deployment tools such as Microsoft Endpoint Configuration Manager. The local Administrator account allows IT staff to sign in to the computer if they cannot establish connectivity to the domain.

Managing passwords for the local Administrator account for every computer in the organization can be extremely complicated. An organization with 5,000 computers has 5,000 separate local Administrator accounts to manage. What often happens is that organizations assign a single, common local Administrator account password to all local Administrator accounts. The drawback to this approach is that people beyond the IT operations team often figure out this password, and then use it to gain unauthorized local Administrator access to computers in their organization.

Local Administrator Password Solution (LAPS) provides organizations with a central local administrator passwords repository for domain-member machines, and provides several features:

- Local administrator passwords are unique on each computer that LAPS manages.

- LAPS randomizes and changes local administrator passwords regularly.

- LAPS stores local administrator passwords and secrets securely within AD DS (Active Directory).

- Configurable permissions control access to passwords in AD DS.

- Passwords that LAPS retrieves are transmitted to the client in a secure, encrypted manner.

You can download LAPS from Microsoft’s website.

## Prerequisites

LAPS is supported on all currently supported Windows Server and client operating system versions. To get LAPS to function, you must update the AD DS schema. You perform this update by running the **Update-AdmPwdADSchema** cmdlet, which is included in a Windows PowerShell module that's made available when you install LAPS on a computer.

The person running this cmdlet must be a member of the Schema Admins group, and you should run this cmdlet on a computer that's in the same AD DS site as the computer hosting the Schema Master FSMO role for the forest.

Once deployed, you configure the LAPS agent within Active Directory through a Group Policy client-side extension. Client computers that have their local administrator password managed by LAPS require installation of the LAPS client, available as an MSI in the download files.

## How LAPS works

The LAPS (Local Administrator Password Solution) process occurs each time Group Policy refreshes. When a Group Policy refresh occurs, the following steps take place:

1. LAPS determines if the password of the local Administrator account has expired.

1. If the password hasn’t expired, LAPS does nothing.

1. If the password has expired, LAPS performs the following steps:

   1. Changes the local Administrator password to a new, random value based on the configured parameters for local Administrator passwords.

   1. Transmits the new password to AD DS, which stores it in a special, confidential attribute associated with the computer account of the computer that has had its local Administrator account password updated.

   1. Transmits the new password-expiration date to AD DS, where it's stored in a special, confidential attribute associated with the computer account of the computer that has had its local Administrator account password updated.

Authorized users can read passwords from AD DS, and an authorized user can trigger a local Administrator password change on a specific computer.

## Configure and manage passwords using LAPS

There are several steps that you need to take to configure and manage passwords by using LAPS. The first set of steps involve configuring AD DS (Active Directory). First, you move the computer accounts of computers that you want to use LAPS to an OU (Organizational Unit). After you’ve moved the computer accounts into an OU, you use the **Set-AdmPwdComputerSelfPermission** cmdlet to assign the computer accounts the ability to update their computer’s local Administrator account password when it expires.

For example, to allow computers in the Sydney OU with expired passwords to update their passwords by using LAPS, you would use the following command:

```powershell
Set-AdmPwdComputerSelfPermission -Identity "Sydney"

```

By default, accounts that are members of the Domain Admins and Enterprise Admins groups can access and find stored passwords. You use the **Set-AdmPwdReadPasswordPermission** cmdlet to provide additional groups the ability to find the local administrator password.

For example, to assign the Sydney_ITOps group the ability to find the local administrator password on computers in the Sydney OU, you would use the following command:

```powershell
Set-AdmPwdReadPasswordPermission -Identity "Sydney" -AllowedPrincipals "Sydney_ITOps"

```

The next step is to run the LAPS installer to install the Group Policy Object (GPO) templates into AD DS. After you have installed the templates, you can configure the following policies:

- Enable local admin password management. This policy enables LAPS and enables you to manage the local Administrator account password centrally.

- Password settings. This policy allows you to configure the complexity, length, and maximum age of the local Administrator password. The default password requirements are:

  - Uppercase and lowercase letters

  - Numbers

  - Special characters

  - 14-character password length

  - 30 days maximum password age

  - Do not allow password expiration time longer than required. When enabled, the password updates according to the domain password expiration policy.

  - Name of administrator account to manage. Use this policy to identify custom local Administrator accounts.

You can examine passwords assigned to a computer by using one of the following methods:

- Active Directory Users and Computers. Enable Advanced Features to view the computer account properties and examine a LAPS managed computer account’s ms-Mcs-AdmPwd attribute.

- LAPS GUI application. This application allows you to retrieve a computer’s local administrator password

- **Get-AdmPwdPassword** cmdlet. Run this cmdlet, available from the AdmPwd.PS module, which is available when you install LAPS to retrieve the computer’s local administrator password.

