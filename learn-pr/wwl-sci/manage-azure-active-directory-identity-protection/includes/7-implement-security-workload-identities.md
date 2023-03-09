Azure AD Identity Protection has historically protected users in detecting, investigating, and remediating identity-based risks. Identity protection has extended these capabilities to workload identities to protect applications, service principals, and Managed Identities.<br>

A workload identity is an identity that allows an application or service principal access to resources, sometimes in the context of a user. These workload identities differ from traditional user accounts as they:

 -  Can’t perform multi-factor authentication.
 -  Often have no formal lifecycle process.
 -  Need to store their credentials or secrets somewhere.

These differences make workload identities harder to manage and put them at higher risk for compromise.

### Requirements to use workload identity protection

To make use of workload identity risk, including the new Risky workload identities (preview) blade and the Workload identity detections tab in the Risk detections blade, in the Azure portal you must have the following.

 -  Azure AD Premium P2 licensing
 -  Logged in user must be assigned either:
    
    
     -  Global administrator
     -  Security administrator
     -  Security operator
     -  Security reader

### What types of risks are detected?

| **Detection name**                              | **Detection type** | **Description**                                                                                                                                                                                                                                                                                                                |
| ----------------------------------------------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Azure AD threat intelligence                    | Offline            | This risk detection indicates some activity that is consistent with known attack patterns based on Microsoft's internal and external threat intelligence sources.                                                                                                                                                              |
| Suspicious Sign-ins                             | Offline            | This risk detection indicates sign-in properties or patterns that are unusual for this service principal.                                                                                                                                                                                                                      |
|                                                 |                    | The detection learns the baselines sign-in behavior for workload identities in your tenant in between 2 and 60 days, and fires if one or more of the following unfamiliar properties appear during a later sign-in: IP address / ASN, target resource, user agent, hosting/non-hosting IP change, IP country, credential type. |
| Unusual addition of credentials to an OAuth app | Offline            | This detection is discovered by Microsoft Defender for Cloud Apps. This detection identifies the suspicious addition of privileged credentials to an OAuth app. This can indicate that an attacker has compromised the app, and is using it for malicious activity.                                                            |
| Admin confirmed account compromised             | Offline            | This detection indicates an admin has selected 'Confirm compromised' in the Risky Workload Identities UI or using riskyServicePrincipals API. To see which admin has confirmed this account compromised, check the account’s risk history (via UI or API).                                                                     |
| Leaked Credentials (public preview)             | Offline            | This risk detection indicates that the account's valid credentials have been leaked. This leak can occur when someone checks in the credentials in public code artifact on GitHub, or when the credentials are leaked through a data breach.                                                                                   |

### Add conditional access protection

Using **Conditional Access for workload identities**, you can block access for specific accounts you choose when Identity Protection marks them "at risk." Policy can be applied to single-tenant service principals that have been registered in your tenant. Third-party SaaS, multi-tenanted apps, and managed identities are out of scope.
