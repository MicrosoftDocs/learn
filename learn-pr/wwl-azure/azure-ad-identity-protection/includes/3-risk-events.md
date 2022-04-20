To protect your users, you can configure risk-based policies in Azure Active Directory (Azure AD) that automatically respond to risky behaviors. Azure AD Identity Protection policies can automatically block a sign-in attempt or require additional action, such as requiring a password change or prompt for Azure AD Multi-Factor Authentication. These policies work with existing Azure AD Conditional Access policies as an extra layer of protection for your organization. Users may never trigger a risky behavior in one of these policies, but your organization is protected if an attempt to compromise your security is made.

Each day, Microsoft collects and analyses trillions of anonymized signals as part of user sign-in attempts. These signals help build patterns of good user sign-in behavior and identify potential risky sign-in attempts. Azure AD Identity Protection can review user sign-in attempts and take additional action if there's suspicious behavior:

Some of the following actions may trigger Azure AD Identity Protection risk detection:<br>

 -  Users with leaked credentials.
 -  Sign-ins from anonymous IP addresses.
 -  Impossible travel to atypical locations.
 -  Sign-ins from infected devices.
 -  Sign-ins from IP addresses with suspicious activity.

The following three policies are available in Azure AD Identity Protection to protect users and respond to suspicious activity. You can choose to turn the policy enforcement on or off, select users or groups for the policy to apply to, and decide if you want to block access at sign-in or prompt for additional action.

The insight you get for a detected risk detection is tied to your Azure AD subscription.<br>

 -  **User risk policy** \- Identifies and responds to user accounts that may have compromised credentials. Can prompt the user to create a new password.
 -  **Sign-in risk policy** \- Identifies and responds to suspicious sign-in attempts. Can prompt the user to provide additional forms of verification using Azure AD Multi-Factor Authentication.
 -  **MFA registration policy** \- Makes sure users are registered for Azure AD Multi-Factor Authentication. If a sign-in risk policy prompts for MFA, the user must already be registered for Azure AD Multi-Factor Authentication.

When you enable a policy user or sign-in risk policy, you can also choose the threshold for risk level - ***low and above***, *medium and above*, or ***high***. This flexibility lets you decide how aggressive you want to be in enforcing any controls for suspicious sign-in events.
