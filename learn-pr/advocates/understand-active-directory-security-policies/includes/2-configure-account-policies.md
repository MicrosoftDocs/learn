Account Policies define the credential rules for user accounts: how strong passwords must be, how long they last, what happens after repeated bad sign-ins, and how Kerberos tickets behave. They live under `Security Settings` > `Account Policies` and contain three subareas: **Password Policy**, **Account Lockout Policy**, and **Kerberos Policy**.

## The domain-scope rule

For *domain* accounts, Password, Account Lockout, and Kerberos settings take effect **only** when they're defined in a GPO linked at the **domain** level. Historically this is the Default Domain Policy. If you set Password or Account Lockout settings in a GPO linked to an OU, they apply only to the **local** SAM accounts of the computers in that OU, not to domain users. **Kerberos Policy** has no local-account equivalent; it's honored only by the domain KDC.

> [!IMPORTANT]
> A single account policy applies to all domain accounts. You can't give one OU a stronger password policy through an OU-linked GPO. To vary the rules per user or group, use a fine-grained password policy (covered later in this unit).

## Password Policy

The following table lists each Password Policy setting and its function:

| Setting | Function |
| --- | --- |
| Enforce password history | Number of previous passwords remembered, to prevent reuse. |
| Maximum password age | Days before a password must be changed. |
| Minimum password age | Days a password must be kept, which stops a user from cycling through the history to reuse a favorite password. |
| Minimum password length | Fewest characters a password may contain. |
| Minimum password length audit | Logs Directory-Services-SAM audit events on domain controllers when a password shorter than the audit target is set or encountered during password operations, without enforcing that length. Use it to measure compatibility before increasing **Minimum password length**. |
| Password must meet complexity requirements | Requires passwords to avoid the user's full `samAccountName` and three-character-or-longer tokens parsed from the display name, and to include characters from three of five character categories. |
| Store passwords using reversible encryption | Stores a decryptable password. Keep this policy set to **Disabled** except for the rare legacy protocol that requires it. |
| Relax minimum password length limits | Lets you raise the enforceable minimum length above 14 characters, up to 128. |

> [!NOTE]
> Password complexity uses Windows `Passfilt.dll` rules. The `samAccountName` check is case-insensitive and skipped only when the account name is fewer than three characters. The display name is split on delimiters such as commas, periods, hyphens, underscores, spaces, pound signs, and tabs; tokens shorter than three characters are ignored. Passwords must also contain characters from three of the five supported categories.

**Real-world example.** Contoso must move to 14-character passphrases. Rather than immediately enforcing the new length, you first set **Minimum password length audit** to 14 and monitor the **System** event log on domain controllers for Event ID 16978 (source `Directory-Services-SAM`) for 3-6 months while users, service accounts, and applications change passwords. Treat the event as a compatibility signal for password changes that are shorter than the audit target; it doesn't scan every existing password or provide a complete password inventory. After you remediate the accounts and applications that generate events, you enforce **Minimum password length**. To require longer administrator passphrases, you enable **Relax minimum password length limits** and set the minimum higher.

## Account Lockout Policy

Account lockout defends against password-guessing (brute-force) attacks by disabling an account after too many failed attempts:

| Setting | Function |
| --- | --- |
| Account lockout threshold | Number of failed sign-ins that triggers a lockout. `0` disables lockout. |
| Account lockout duration | Minutes the account stays locked. `0` means it stays locked until an administrator unlocks it. |
| Reset account lockout counter after | Minutes of no failed attempts before the running count resets to zero. |
| Allow Administrator account lockout | Extends lockout to the built-in Administrator account for network sign-ins. Enabled by default on current installations. |

> [!CAUTION]
> A low threshold with a long duration increases help-desk calls and lets an attacker cause a denial of service by deliberately locking accounts. Balance the threshold against operational impact.

**Real-world example.** Contoso's security audit requires brute-force protection. You set a threshold of 10 failed attempts, a 15-minute duration, and a 15-minute reset window, and you enable **Allow Administrator account lockout** so the built-in Administrator can't be brute-forced over the network. The console sign-in remains available so a locked-out administrator can still recover the server locally.

## Kerberos Policy

Kerberos Policy settings apply to domain accounts and are meaningful only on domain controllers. They control ticket lifetimes and clock tolerance:

| Setting | Function |
| --- | --- |
| Enforce user logon restrictions | Has the KDC validate each Kerberos session or service ticket request against the account's user-rights policy. This is more secure, but adds KDC processing overhead. |
| Maximum lifetime for service ticket | Minutes a service (TGS) ticket is valid. |
| Maximum lifetime for user ticket | Hours a ticket-granting ticket (TGT) is valid. |
| Maximum lifetime for user ticket renewal | Days a TGT can be renewed. |
| Maximum tolerance for computer clock synchronization | Time difference Kerberos tolerates between systems. |

Tight clock tolerance depends on reliable time synchronization across the domain. Reducing ticket lifetimes shrinks the window in which a stolen ticket is useful, which helps counter pass-the-ticket attacks.

## The exception: fine-grained password policies

A *fine-grained password policy* (FGPP), also called a Password Settings Object (PSO), lets you apply different password and lockout rules to specific users or global security groups. This is the answer to "one domain, several password standards." Common uses include stricter rules for administrators and separate rules for service accounts. FGPPs aren't Group Policy; you manage them with the Active Directory Administrative Center or PowerShell. When a user matches more than one PSO, a PSO linked directly to the user account wins over any PSO linked through a group. Otherwise the PSO with the lowest **precedence** value (the `msDS-PasswordSettingsPrecedence` attribute) applies, and an exact tie is resolved by the lowest object GUID. Use `Get-ADUserResultantPasswordPolicy` to confirm the resultant PSO for a user.

## Configure Account Policies

Edit the domain account policy:

1. In `gpmc.msc`, edit the domain-linked GPO.
1. Go to `Computer Configuration` > `Policies` > `Windows Settings` > `Security Settings` > `Account Policies`.
1. Select **Password Policy**, **Account Lockout Policy**, or **Kerberos Policy**, then double-click a setting to define it.

Create a fine-grained password policy for administrators:

```powershell
New-ADFineGrainedPasswordPolicy -Name "AdminPSO" -Precedence 10 `
  -MinPasswordLength 16 -ComplexityEnabled $true `
  -LockoutThreshold 5 -LockoutDuration "00:30:00" -LockoutObservationWindow "00:30:00"

Add-ADFineGrainedPasswordPolicySubject -Identity "AdminPSO" -Subjects "Domain Admins"
```

Validate the policy source you're changing:

```powershell
# Default domain password policy for domain accounts
Get-ADDefaultDomainPasswordPolicy -Current LoggedOnUser
net accounts /domain

# Fine-grained password policy (PSO) for a specific user
Get-ADUserResultantPasswordPolicy -Identity "adminuser"

# Local SAM account policy on the current computer
net accounts
```

If `Get-ADUserResultantPasswordPolicy` returns a Password Settings Object (PSO), that PSO is the user's effective fine-grained password policy. If no PSO applies, the default domain password policy applies to the domain account.

Refresh policy on the computers that enforce the setting:

```powershell
# Run on domain controllers for domain-linked account-policy changes.
gpupdate /target:computer /force

# Run on member computers targeted by OU-linked local SAM account-policy GPOs.
gpupdate /target:computer /force
```

Use `net accounts /domain` or `Get-ADDefaultDomainPasswordPolicy` for the default domain password policy. Use `net accounts` without `/domain` only when you're validating local SAM account policy on the current computer.
