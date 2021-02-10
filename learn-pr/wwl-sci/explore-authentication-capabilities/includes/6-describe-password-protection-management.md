Password Protection is a feature of Azure AD that reduces the risk of users setting weak passwords.  Azure AD Password Protection detects and blocks known weak passwords and their variants, and can also block other weak terms that are specific to your organization.

With Azure AD Password Protection, default global banned password lists are automatically applied to all users in an Azure AD tenant. To support your own business and security needs, you can define entries in a custom banned password list. When users change or reset their passwords, these lists are checked to enforce the use of strong passwords.

You should use extra features like Azure Active Directory multifactor authentication, not just rely on strong passwords enforced by Azure AD Password Protection.

## Global banned password list

A global banned password list with known weak passwords is automatically updated and enforced by Microsoft. This list is maintained by the Azure AD Identity Protection team, who analyze security telemetry data to find weak or compromised passwords. Examples of passwords that might be blocked are P@$$w0rd or Passw0rd1 and all variations.

Variations are created using an algorithm that transposes text case and letters to numbers such as "1" to an "l". Variations on Password1 might include Passw0rd1, Pass0rd1, and others. These passwords are then checked and added to the global banned password list and made available to all Azure AD users. The global banned password list is automatically applied and can't be disabled.

If an Azure AD user tries to set their password to one of these weak passwords, they receive a notification to choose a more secure one. The global banned list is sourced from real-world, actual password spray attacks. This approach improves the overall security and effectiveness, and the password validation algorithm also uses smart fuzzy-matching techniques. Azure AD Password Protection efficiently detects and blocks millions of the most common weak passwords from being used in your enterprise.

## Custom banned password lists

Admins can also create custom banned password lists to support specific business security needs. The custom banned password list prohibits passwords such as the organization name or location. Passwords added to the custom banned password list should be focused on organizational-specific terms such as:

- Brand names
- Product names
- Locations, such as company headquarters
- Company-specific internal terms
- Abbreviations that have specific company meaning

The custom banned password list is combined with the global banned password list to block variations of all the passwords.

Banned password lists are a feature of Azure AD Premium 1 or 2.

## Protecting against password spray

Azure AD Password Protection helps you defend against password spray attacks.  Most password spray attacks submit a few of the known weakest passwords against each of the accounts in an enterprise. This technique allows the attacker to quickly search for an easily compromised account and avoid potential detection thresholds.

Azure AD Password Protection efficiently blocks all known weak passwords likely to be used in password spray attacks. This protection is based on real-world security telemetry data from Azure AD, which is used to build the global banned password list.

## Hybrid security

For hybrid security, admins can integrate Azure AD Password Protection within an on-premises Active Directory environment. A component installed in the on-premises environment receives the global banned password list and custom password protection policies from Azure AD. Domain controllers then use them to process password change events. This hybrid approach makes sure that, wherever a user changes their password, Azure AD Password Protection is applied.

Although password protection improves the strength of passwords, you should still use best practice features like Azure Active Directory multifactor authentication. Passwords alone, even strong ones, are not as secure as multiple layers of security.
