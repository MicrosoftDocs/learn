You can create domain-based GPOs in AD DS and store them on domain controllers. You can use these GPOs to manage configuration centrally for the domain’s users and computers. When you install AD DS, Windows Server creates two default GPOs:

 -  Default Domain Policy
 -  Default Domain Controllers Policy

> [!NOTE]
> Windows computers also have local GPOs, which are primarily used when computers aren't connected to domain environments.

## Default Domain Policy

The Default Domain Policy GPO is linked to the domain, and it applies to Authenticated Users. This GPO doesn't have any WMI filters. Therefore, it affects all users and computers in the domain. This GPO contains policy settings that specify password, account lockout, and Kerberos version 5 authentication protocol policies.

These settings are of critical importance to the AD DS environment, and thus, make the Default Domain Policy a critical component of Group Policy. You shouldn't add unrelated policy settings to this GPO. If you need to configure other settings to apply broadly in your domain, create additional GPOs that link to the domain.

## Default Domain Controllers Policy

The Default Domain Controllers Policy GPO links to the OU of the domain controllers. Because computer accounts for domain controllers are kept exclusively in the Domain Controllers OU, and other computer accounts should be kept in other OUs, this GPO affects only domain controllers or other computer objects that are in the Domain Controllers OU.

You should modify GPOs linked to the Domain Controllers OU to implement your auditing policies and to assign user rights that are required on domain controllers.
