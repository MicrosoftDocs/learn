Smart lockout helps lock out bad actors who try to guess your users' passwords or use brute-force methods to get in. Smart lockout can recognize sign-ins that come from valid users and treat them differently than ones of attackers and other unknown sources. Attackers get locked out, while your users continue to access their accounts and be productive.

## How smart lockout works

By default, smart lockout locks the account from sign-in attempts for one minute after 10 failed attempts. The account locks again after each subsequent failed sign-in attempt, for one minute at first and then longer in subsequent attempts. To minimize the ways an attacker could work around this behavior, we don't disclose the rate at which the lockout period grows over additional unsuccessful sign-in attempts.

Smart lockout tracks the last three bad-password hashes to avoid incrementing the lockout counter for the same password. If someone enters the same bad password multiple times, this behavior won't cause the account to lock out.

Federated deployments that use AD FS 2016 and AD DS 2019 can enable similar benefits using AD FS Extranet Lockout and Extranet Smart Lockout.

Smart lockout is always on, for all Azure AD customers, with these default settings that offer the right mix of security and usability. Customization of the smart lockout settings, with values specific to your organization, requires Azure AD Premium P1 or higher licenses for your users.

Using smart lockout doesn't guarantee that a genuine user is never locked out. When smart lockout locks a user account, we try our best to not lock out the genuine user. The lockout service attempts to ensure that bad actors can't gain access to a genuine user account. The following considerations apply:

 -  Each Azure AD data center tracks lockouts independently. A user has (`threshold\_limit * datacenter\_count`) number of attempts, if the user hits each data center.
 -  Smart lockout uses *familiar location* versus *unfamiliar location* to differentiate between a bad actor and the genuine user. Unfamiliar and familiar locations both have separate lockout counters.

Smart lockout can be integrated with hybrid deployments that use password hash sync or pass-through authentication to protect on-premises Active Directory Domain Services (AD DS) accounts from being locked out by attackers. By setting smart lockout policies in Azure AD appropriately, attacks can be filtered out before they reach on-premises AD DS.

When the admin configures pass-through authentication, the following considerations apply:

 -  The Azure AD lockout threshold is less than the AD DS account lockout threshold. Set the values so that the AD DS account lockout threshold is at least two or three times greater than the Azure AD lockout threshold.
 -  The Azure AD lockout duration must be set longer than the AD DS account lockout duration. The Azure AD duration is set in seconds, while the AD duration is set in minutes.

For example, if you want your Azure AD smart lockout duration to be higher than AD DS, then Azure AD would be 120 seconds (2 minutes) while your on-premises AD is set to 1 minute (60 seconds). If you want your Azure AD lockout threshold to be 5, then you want your on-premises AD lockout threshold to be 10. This configuration would ensure smart lockout prevents your on-premises AD accounts from being locked out by brute force attacks on your Azure AD accounts.
