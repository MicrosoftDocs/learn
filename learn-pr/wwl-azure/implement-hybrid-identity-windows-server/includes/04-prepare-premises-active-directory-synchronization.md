
Before IT staff at Contoso deploys Microsoft Entra Connect, it's essential that they check the on-premises AD DS and related technologies for potential issues, and any issues that are discovered are remediated. This is especially important if they implement directory synchronization as an identity service for Microsoft 365.

## Pre-deployment checks

Pre-deployment checks should include:

- Analyzing the on-premises environment for invalid characters in AD DS object attributes, and for incorrect user principal names (UPNs).
- Performing domain email discovery and user counts.
- Identifying domain-functional levels and schema extensions, and identifying custom attributes in use.
- Identifying proxy servers used for Microsoft Exchange or Skype for Business, if you deploy Microsoft Entra Connect as a part of a Microsoft 365 deployment.
- Identifying Microsoft SharePoint domains, if you deploy Microsoft Entra Connect as part of a Microsoft 365 deployment.
- Evaluating client for SSO readiness.
- Recording network port use, and DNS records related to Office 365 (if you deploy Microsoft Entra Connect as part of a Office 365 deployment).

After you complete these checks, key remediation tasks include:
- Removing duplicate `proxyAddress` and `userPrincipalName` attributes.
- Updating blank and invalid `userPrincipalName` attributes and replacing with valid `userPrincipalName` attributes.
- Removing invalid characters in the following attributes: `givenName`, `surname (sn)`, `sAMAccountName`, `displayName`, `mail`, `proxyAddresses`, `mailNickname`, and `userPrincipalName`.

UPNs that are used for SSO can contain letters, numbers, periods, dashes, and underscores; no other character types are allowed.

If you're deploying Microsoft 365 and your deployment includes plans for SSO, you should ensure that UPN names meet this requirement before SSO is rolled out. Domains used for SSO and directory synchronization must be routable, which means that you cannot use local domain names, such as Contoso.local.

## Active Directory health-check tools

To have directory synchronization work properly, you must ensure that on-premises Active Directory is well-prepared and error free. You can use the following AD DS health check tools can be used to identify and remediate issues.

### IdFix tool

The Microsoft 365 IdFix tool enables you to identify and remediate the majority of object synchronization errors in Active Directory, including common issues such as duplicate or malformed `proxyAddresses` and `userPrincipalName`.

You can select the OUs that you want IdFix to check, and you can fix common errors within the tool itself. Common errors might include problems such as invalid characters that might have been introduced during scripted user imports to attributes such as `proxyAddresses` and `mailNickname`.

For distinguished names that contain format and duplicate errors, IdFix might not be able to suggest an automatic remediation. Such errors can either be fixed outside IdFix or can be manually remediated within IdFix.

### `ADModify.NET` tool

For errors such as format issues, you can make changes to specific attributes object-by-object by using either ADSIEdit or Advanced Mode in Active Directory Users and Computers. However, to make attribute changes to multiple objects, `ADModify.NET` is a better tool. This is because the batch mode operation provided by `ADModify.NET` is particularly useful for making changes to attributes such as UPNs across OUs or domains.

### Additional reading
To learn more, review the following document.

- [Prerequisites for Microsoft Entra Connect](https://aka.ms/connect-install-prerequisites?azure-portal=true).
