

Conditional access is a feature of Enterprise Mobility + Security (EMS). It provides granular access control to organizational data while allowing users to work from essentially any device and location. Conditional access helps to protect your company’s email and data from the security risks posed by devices that are noncompliant.

Intune and Azure AD work together to enable conditional access for mobile devices. Intune provides information about device compliance with Azure AD. When Azure AD receives a request to access resources, it compares this information to conditional access policies.

 -  If the conditional access policy says that noncompliant devices can't access a resource, the access request is denied.
 -  If access is denied, the user is prompted to enroll the device and fix the compliance problems.

You can also set policies in Azure AD that allow only domain-joined or Intune-enrolled devices to access resources.

A conditional access policy is a definition of an access scenario using the **When this happens**: **Then do this** pattern.

 -  **When this happens**. Defines the reason for triggering the conditional access policy. This reason is characterized by a group of conditions that have been satisfied. In conditional access, the two assignment conditions play a special role:
    
     -  **Users**. The users performing an access attempt (Who).
     -  **Cloud apps**. The targets of an access attempt (What).

These two conditions are mandatory in a conditional access policy. In addition to the two mandatory conditions, you can also include other conditions that describe how the access attempt is performed. Common examples are using mobile devices or locations that are outside your company network.

 -  **Then do this**. Defines the response of the policy. With a conditional access policy, you control how authorized users (users that have been granted access to a cloud app) can access cloud apps under specific conditions. In your response, you enforce other requirements such as multi-factor authentication, a managed device, and others. In the context of conditional access, the requirements the policy enforces are called access controls. In the most restrictive form, your policy can block access.

Conditional access is especially beneficial in certain scenarios.

 -  **Supporting apps that require multi-factor authentication (MFA)**. Some applications require more protection than others. Conditional access allows you to add a layer of protection for them by requiring MFA when users access them.
 -  **Requiring MFA for untrusted networks**. In this scenario, it isn't the application itself that requires extra security. Instead, the location from where the access is requested is the concern. In this case, you can require a user accessing data from an untrusted location to provide MFA.
 -  **Allowing Microsoft 365 access only to trusted devices**. You might decide that you want to allow access to Microsoft 365 services only from devices enrolled in Intune and from PCs joined to the on-premises domain. Conditional access allows you to limit access, by Microsoft 365 app, from devices that don't meet these requirements.
